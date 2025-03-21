import 'package:flutter/material.dart';

class PickupTimeSelector extends StatelessWidget {
  final String? selectedTime;
  final Function(String) onTimeSelected;

  const PickupTimeSelector({
    Key? key,
    required this.selectedTime,
    required this.onTimeSelected,
  }) : super(key: key);

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime == null
          ? const TimeOfDay(hour: 9, minute: 0) // Default to 9 AM
          : _parseTime(selectedTime!), // Convert selectedTime to TimeOfDay
    );

    if (pickedTime != null) {
      if (pickedTime.hour >= 9 && pickedTime.hour < 21) {
        final formattedTime = _formatTime(pickedTime);
        onTimeSelected(formattedTime);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a time between 9 AM and 9 PM")),
        );
      }
    }
  }

  // ✅ Helper method to parse time string (e.g., "10:30 AM" -> TimeOfDay)
  static TimeOfDay _parseTime(String time) {
    final parts = time.split(' '); // Split time and AM/PM
    final timeParts = parts[0].split(':'); // Extract hour and minutes
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    if (parts[1] == 'PM' && hour != 12) hour += 12; // Convert PM to 24-hour format
    if (parts[1] == 'AM' && hour == 12) hour = 0; // Handle midnight case

    return TimeOfDay(hour: hour, minute: minute);
  }

  // ✅ Helper method to format TimeOfDay into a readable string
  static String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod; // Convert 0 to 12 for AM
    final minute = time.minute.toString().padLeft(2, '0'); // Ensure two digits
    final period = time.period == DayPeriod.am ? "AM" : "PM";

    return "$hour:$minute $period";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Pickup Time",
          style: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => _selectTime(context),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color.fromARGB(255, 172, 172, 172),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Text(
                  selectedTime ?? "Select Time",
                  style: TextStyle(
                    fontSize: 14,
                    color: selectedTime == null ? Colors.black : Colors.blue,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.access_time, color: Color.fromARGB(255, 172, 172, 172)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
