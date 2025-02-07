import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../data/address/data/address.dart';
import '../../order_placed.dart';
import '../../utils/api_status.dart';
import '../address/address_view_model.dart';
import '../product/cart_view_model.dart';
import 'components/location_input.dart';
import 'components/order_summary.dart';
import 'components/payment_method_selector.dart';
import 'components/payment_screen.dart';
import 'components/pickup_date_selector.dart';
import 'components/pickup_time_selector.dart';
import 'order_create_view_model.dart';
import 'razor_pay_service.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({super.key});

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
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
  final double discount = 20.40;
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // cartViewModel.fetchCart();
      addressViewModel.getAddress();
    });

    totalAmount = cartViewModel.totalPrice! + deliveryFee - discount;
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
    print('Payment Success: ${response.paymentId}');

    // Prepare order data
    final pickupLocation = locationController.text;
    final paymentMode = isCOD ? "COD" : "Online";
    final products = cartViewModel.cartList.data.map((item) {
      return {
        'product_id': item.productId,
        'quantity': item.quantity,
      };
    }).toList(); // Mapping over the cartList's data

    // Call ViewModel to create order after payment success
    await orderCreateViewModel.createOrder(
      pickupLocation: pickupLocation,
      paymentMode: paymentMode,
      products: products,
      timeSlot: selectedTime!,
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

  void handleSubmit() {
    setState(() {
      isDateSelected = selectedDate != null;
      isTimeSelected = selectedTime != null;
    });

    if (selectedDate == null || selectedTime == null) {
      return;
    }
    checkout();
  }

  void checkout() async {
    if (selectedTime != null) {
      // Prepare order data
      final pickupLocation = locationController.text;
      final paymentMode = isCOD ? "COD" : "Online";
      final products = cartViewModel.cartList.data.map((item) {
        return {
          'product_id': item.productId,
          'quantity': item.quantity,
        };
      }).toList(); // Mapping over the cartList's data

      // Check if the payment is COD
      if (isCOD) {
        // Call ViewModel to create order for COD
        await orderCreateViewModel.createOrder(
          pickupLocation: pickupLocation,
          paymentMode: paymentMode,
          products: products,
          timeSlot: selectedTime!,
          pickupDate: selectedDate.toIso8601String(),
        );

        if (orderCreateViewModel.orderResponse?.status == ApiStatus.success) {
          // If order is successfully created for COD
          cartViewModel.clearCart();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const OrderPlaced()),
            (Route<dynamic> route) => false, // Predicate to remove all routes
          );
        } else {
          // Handle error or show a message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(orderCreateViewModel.errorMessage ??
                    "Order creation failed")),
          );
        }
      } else if (isOnlinePayment) {
        // If payment is Online, navigate to the Razorpay Payment Screen
        _startPayment();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Address? activeAddress;

    for (var address in addressViewModel.address) {
      if (address.activeStatus == 1) {
        activeAddress = address;
        break; // Stop the loop once the active address is found
      }
    }
// Typecast the result to Address?

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Schedule Appointment',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
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
                onTimeSelected: (time) => setState(() {
                  selectedTime = time;
                  isTimeSelected = true;
                }),
              ),
              if (!isTimeSelected)
                const Text("Please select a time",
                    style: TextStyle(color: Colors.red)),
              const SizedBox(height: 20),
              LocationInput(
                controller: locationController,
                address: activeAddress, // Passing the active address or null
                activeStatus:
                    activeAddress != null, // Check if activeAddress exists
              ),
              const SizedBox(height: 20),
              PaymentMethodSelector(
                isCOD: isCOD,
                isOnlinePayment: isOnlinePayment,
                onCODChanged: (value) => setState(() {
                  isCOD = value;
                  isOnlinePayment = !value;
                }),
                onOnlinePaymentChanged: (value) => setState(() {
                  isOnlinePayment = value;
                  isCOD = !value;
                }),
              ),
              const SizedBox(height: 20),
              OrderSummary(
                itemPrice: cartViewModel.totalPrice.toInt(),
                deliveryFee: deliveryFee,
                totalAmount: totalAmount,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed:
                    isTimeSelected && isDateSelected ? handleSubmit : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.white,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFDC846),
                        Color(0xFFD32943),
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: const Center(
                    child: Text(
                      "Place Order",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
