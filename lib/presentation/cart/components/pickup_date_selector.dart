import 'package:flutter/material.dart';

class PickupDateSelector extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const PickupDateSelector({
    Key? key,
    required this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Pickup Date", style: TextStyle(fontSize: 18, color: Colors.black)),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,  // Horizontal scrolling
          child: Row(
            children: List.generate(265, (index) {
              // Ensure that we show dates starting from today and next days (14 days)
              final day = DateTime.now().add(Duration(days: index));  // Start from today (not the selectedDate)
              final isSelected = selectedDate.day == day.day && selectedDate.month == day.month && selectedDate.year == day.year;
              
              return Padding(
                padding: const EdgeInsets.only(right: 10),  // Add right padding for spacing between containers
                child: GestureDetector(
                  onTap: () => onDateSelected(day),
                  child: Container(
                    width: 60,  // Adjust container width for better spacing
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? const LinearGradient(
                              colors: [Color(0xFFFDC846), Color(0xFFD32943)],
                            )
                          : null,
                      color: isSelected ? null : Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,  // Center text vertically
                      crossAxisAlignment: CrossAxisAlignment.center,  // Center text horizontally
                      children: [
                        Text(
                          ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][day.weekday % 7],
                          style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black, fontSize: 10),
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
                        const SizedBox(height: 2),
                        Text(
                          ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'][day.month - 1],  // Show month
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
