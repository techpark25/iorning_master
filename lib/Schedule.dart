import 'package:flutter/material.dart';
import 'OrderPlaced.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  _ScheduleState createState() => _ScheduleState();
}

bool isCOD = false; // To track COD selection
bool isOnlinePayment = false; // To track Online Payment selection

class _ScheduleState extends State<Schedule> {
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
  final double itemPrice = 68.00;
  final double deliveryFee = 0.0;
  final double discount = 20.40;
  double totalAmount = 0.0;
  final TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    totalAmount = itemPrice + deliveryFee - discount;
  }

  // Date Picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void checkout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderPlaced()),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pickup Date",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                final day = selectedDate.add(Duration(days: index));
                final isSelected = selectedDate.day == day.day;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = day;
                    });
                  },
                  child: Container(
                    width: 50,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? const LinearGradient(
                              colors: [
                                Color(0xFFFDC846),
                                Color(0xFFD32943),
                              ],
                            )
                          : null,
                      color: isSelected ? null : Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      children: [
                        Text(
                          [
                            'Sun',
                            'Mon',
                            'Tue',
                            'Wed',
                            'Thu',
                            'Fri',
                            'Sat'
                          ][day.weekday % 7],
                          style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          day.day.toString(),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            const Text(
              "Pickup Time",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 2.5,
              ),
              itemCount: availableTimes.length,
              itemBuilder: (context, index) {
                final time = availableTimes[index];
                final isSelected = selectedTime == time;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTime = time;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? const LinearGradient(
                              colors: [
                                Color(0xFFFDC846),
                                Color(0xFFD32943),
                              ],
                            )
                          : null,
                      color: isSelected ? null : Colors.grey[200],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      time,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "Add Location",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                hintText: 'Enter your location',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Payment Method",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(
                        value: isCOD,
                        onChanged: (bool? value) {
                          setState(() {
                            isCOD = value ?? false;
                            isOnlinePayment = !isCOD; // Ensure one is selected
                          });
                        },
                      ),
                      const Text("COD"),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(
                        value: isOnlinePayment,
                        onChanged: (bool? value) {
                          setState(() {
                            isOnlinePayment = value ?? false;
                            isCOD = !isOnlinePayment; // Ensure one is selected
                          });
                        },
                      ),
                      const Text("Online Payment"),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  priceRow("Item", "\₹$itemPrice"),
                  priceRow("Delivery", "\₹$deliveryFee"),
                  priceRow("Discount", "-\₹$discount"),
                  const Divider(color: Colors.grey),
                  priceRow("Total", "\₹${totalAmount.toStringAsFixed(2)}",
                      isBold: true),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedTime == null ? null : checkout,
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
    );
  }

  Widget priceRow(String title, String amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
