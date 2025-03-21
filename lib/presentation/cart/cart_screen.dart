import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:laundry_application/presentation/cart/components/bottom_nav_bar.dart';
import 'package:laundry_application/themes.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../data/address/data/address.dart';
import '../../data/coupons/model/coupon.dart';
import '../../order_placed.dart';
import '../../utils/api_status.dart';
import '../address/address_view_model.dart';
import '../product/cart_view_model.dart';
import 'components/cart_list.dart';
import 'components/location_input.dart';
import 'components/order_summary.dart';
import 'components/payment_method_selector.dart';
import 'components/payment_screen.dart';
import 'components/pickup_date_selector.dart';
import 'components/pickup_time_selector.dart';
import 'coupon/coupon_list_screen.dart';
import 'coupon/coupon_view_model.dart';
import 'order_create_view_model.dart';
import 'razor_pay_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DateTime selectedDate = DateTime.now();
  String? selectedTime;
  final List<String> availableTimes = [
    '08:00 am',
    '09:30 am',
    '11:00 am',
    '01:30 pm',
    '03:00 pm',
    '04:30 pm',
  ];

  final double deliveryFee = 0.0;
  double discountAmount = 0.0;
  double totalAmount = 0.0;
  bool isCOD = false;
  bool isOnlinePayment = false;
  final TextEditingController locationController = TextEditingController();
  late CartViewModel cartViewModel;
  late AddressViewModel addressViewModel;

  late OrderCreateViewModel orderCreateViewModel;
  late Razorpay _razorpay;
  bool isDateSelected = true;
  bool isTimeSelected = true;
  @override
  void initState() {
    super.initState();
    cartViewModel = Provider.of<CartViewModel>(context, listen: false);
    addressViewModel = Provider.of<AddressViewModel>(context, listen: false);

    orderCreateViewModel =
        Provider.of<OrderCreateViewModel>(context, listen: false);
    _razorpay = Razorpay();

    // Adding listeners to handle payment success, failure, and external wallet response
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // cartViewModel.fetchCart();
      addressViewModel.getAddress();
      addressViewModel.getActiveAddress();
      await cartViewModel.getCart(); // Ensure cart is updated before order
      print("Cart Items After Fetch: ${cartViewModel.cartItems.length}");
    });

    totalAmount = cartViewModel.totalPrice + deliveryFee;
  }

  @override
  void dispose() {
    super.dispose();
    // Dispose the Razorpay instance to avoid memory leaks
    _razorpay.clear();
  }

  // Handle payment success
  // Handle payment success
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Address? activeAddress;

    for (var address in addressViewModel.address) {
      if (address.activeStatus == 1) {
        activeAddress = address;
        break; // Stop the loop once the active address is found
      }
    }
    print('Payment Success: ${response.paymentId}');

    // Prepare order data
    final pickupLocation = locationController.text;
    final paymentMode = isCOD ? "COD" : "Online";
    final products = cartViewModel.cartItems.map((item) {
      return {
        'product_id': item.productId,
        'quantity': item.quantity,
      };
    }).toList(); // Mapping over the cartList's data

    // Call ViewModel to create order after payment success
    await orderCreateViewModel.createOrder(
      pickupLocation: _getFullAddress(activeAddress!),
      paymentMode: 'Online',
      products: products,
      timeSlot: selectedTime ?? '',
      pickupDate: selectedDate.toIso8601String(),
    );

    if (orderCreateViewModel.orderResponse?.status == ApiStatus.success) {
      // If order is successfully created
      cartViewModel.clearCart();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OrderPlaced()),
      );
    } else {
      // Handle error or show a message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                orderCreateViewModel.errorMessage ?? "Order creation failed")),
      );
    }

    // Show success message
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Payment Successful!")));
  }

  // Handle payment error
  void _handlePaymentError(PaymentFailureResponse response) {
    print('Payment Error: ${response.code}');
    // Handle error (e.g., show an error message to the user)
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: const Text("Payment Failed!")));
  }

  // Handle external wallet (e.g., PayTM, Google Pay, etc.)
  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External Wallet: ${response.walletName}');
    // Handle external wallet callback
  }

  void _startPayment() async {
    ApiServices apiServices = ApiServices();

    // Generate Razorpay order before opening payment gateway
    var response = await apiServices.razorPayApi(
        totalAmount, "order_${DateTime.now().millisecondsSinceEpoch}");

    if (response["status"] == "success") {
      String orderId = response["body"]["id"]; // Extract order ID from response

      var options = {
        'key': dotenv.env['RZP_KEY'] ?? '', // Use dotenv key
        'amount':
            (totalAmount * 100).toString(), // Razorpay accepts amount in paise
        'name': 'Ironing Master',
        'description': 'Order Payment',
        'order_id': orderId, // Pass the generated order ID
        'prefill': {
          'contact': '1234567890',
          'email': 'test@example.com',
        },
        'theme': {
          'color': '#FF5733',
        },
      };

      try {
        _razorpay.open(options); // Open Razorpay payment gateway
      } catch (e) {
        print('Error: $e');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(response["message"] ?? "Payment initiation failed")),
      );
    }
  }

  void _applyCoupon(Coupon coupon) async {
    final couponViewModel =
        Provider.of<CouponViewModel>(context, listen: false);

    await couponViewModel.applyCoupon(
      couponCode: coupon.code ?? '',
      cartTotal: cartViewModel.totalPrice,
    );

    // Print the API response to verify discount value
    print("Coupon Response: ${couponViewModel.couponResponse.data?.discount}");

    if (couponViewModel.couponResponse.status == ApiStatus.success) {
      setState(() {
        discountAmount = (couponViewModel.couponResponse.data?.discount ?? 0);
        totalAmount = cartViewModel.totalPrice - discountAmount;
      });

      print("Discount Applied: $discountAmount");
      print("Updated Total Amount: $totalAmount");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Coupon Applied! Discount: ₹$discountAmount")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(couponViewModel.errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final aviewModel = Provider.of<AddressViewModel>(context);
    Address? activeAddress;

    for (var address in aviewModel.address) {
      if (address.activeStatus == 1) {
        activeAddress = address;
        break; // Stop the loop once the active address is found
      }
    }
    final double height = MediaQuery.of(context).size.height;
    final double bottomHeight = height * 0.22;
    for (var address in addressViewModel.address) {
      if (address.activeStatus == 1) {
        activeAddress = address;
        break; // Stop the loop once the active address is found
      }
    }
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Schedule Appointment',
          ),
          elevation: 0,
        ),
        body: Consumer<AddressViewModel>(
            builder: (context, addressViewModel, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PickupDateSelector(
                    selectedDate: selectedDate,
                    onDateSelected: (date) => setState(() {
                      selectedDate = date;
                      isDateSelected = true;
                    }),
                  ),
                  if (!isDateSelected)
                    const Text("Please select a date",
                        style: TextStyle(color: Colors.red)),
                  const SizedBox(height: 20),
                  PickupTimeSelector(
                    selectedTime: selectedTime,
                    onTimeSelected: (time) {
                      setState(() {
                        selectedTime = time;
                      });
                    },
                  ),
                  if (!isTimeSelected)
                    const Text("Please select a time",
                        style: TextStyle(color: Colors.red)),
                  const SizedBox(height: 20),
                  Consumer<CartViewModel>(
                    builder: (context, cartViewModel, child) {
                      return Container(
                        height:
                            300, // Set a fixed height to avoid unbounded errors
                        child: Stack(
                          children: [
                            CartList(
                              cart: cartViewModel.cartItems,
                              onAddToCart: (productId) {
                                cartViewModel.addToCart(productId);
                              },
                              onRemoveFromCart: (cartId) {
                                cartViewModel.removeFromCart(cartId);
                              },
                            ),
                            if (cartViewModel.loadingCart)
                              const Positioned.fill(
                                child: Center(
                                  child: SizedBox.shrink(),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Rounded edges for the card
                    ),
                    elevation: 4, // Adds shadow effect
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Have a coupon?",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final Coupon? selectedCoupon =
                                  await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CouponScreen(
                                      cartTotal: cartViewModel.totalPrice),
                                ),
                              );

                              if (selectedCoupon != null) {
                                _applyCoupon(selectedCoupon);
                              }
                            },
                            child: const Text("Apply Coupon"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Consumer<CartViewModel>(
                    builder: (context, cartViewModel, child) {
                      return OrderSummary(
                        itemPrice: cartViewModel.totalPrice.toInt(),
                        deliveryFee: deliveryFee,
                        discount: discountAmount, // Include discount here

                        totalAmount: cartViewModel.totalPrice.toDouble() -
                            discountAmount,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        }),
        bottomNavigationBar: Consumer<CartViewModel>(
          builder: (context, cartViewModel, child) {
            return BottomNavBar(
              bottomHeight: bottomHeight,
              addressList: addressViewModel.address,
              totalAmount: cartViewModel.totalPrice.toDouble() - discountAmount,
              isTimeSelected: isTimeSelected,
              isDateSelected: isDateSelected,
              onOnlinePayment: _startPayment,
              onCOD: () async {
                await cartViewModel.getCart(); // Ensure latest cart data
                print(
                    "Cart Items After Fetch: ${cartViewModel.cartItems.length}");

                final products = cartViewModel.cartItems.map((item) {
                  return {
                    'product_id': item.productId,
                    'quantity': item.quantity,
                  };
                }).toList();

                await orderCreateViewModel.createOrder(
                  pickupLocation: _getFullAddress(activeAddress!),
                  paymentMode: 'COD',
                  products: products,
                  timeSlot: selectedTime ?? '',
                  pickupDate: selectedDate.toIso8601String(),
                );

                if (orderCreateViewModel.orderResponse?.status ==
                    ApiStatus.success) {
                  cartViewModel.clearCart();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderPlaced()),
                    (Route<dynamic> route) => false,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(orderCreateViewModel.errorMessage ??
                          "Order creation failed"),
                    ),
                  );
                }
              },
              activeStatus: activeAddress != null,
              address: activeAddress,
            );
          },
        ));
  }

  String _getFullAddress(Address address) {
    List<String> addressParts = [];

    if (address.name != null) addressParts.add(address.name!);
    if (address.houseOrBuildingNo != null)
      addressParts.add(address.houseOrBuildingNo!);
    if (address.addressLine1 != null) addressParts.add(address.addressLine1!);
    if (address.addressLine2 != null) addressParts.add(address.addressLine2!);
    if (address.pincode != null)
      addressParts.add("Pincode: ${address.pincode}");
    if (address.landmark != null)
      addressParts.add("Landmark: ${address.landmark}");

    return addressParts.join(', ');
  }
}
