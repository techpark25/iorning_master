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
          ? TimeOfDay.now()
          : TimeOfDay(
              hour: int.parse(selectedTime!.split(":")[0]),
              minute: int.parse(selectedTime!.split(":")[1]),
            ),
    );

    if (pickedTime != null) {
      final formattedTime = pickedTime.format(context);
      onTimeSelected(formattedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Pickup Time",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => _selectTime(context),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Text(
                  selectedTime ?? "Select Time",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: selectedTime == null ? Colors.black : Colors.blue,
                  ),
                ),
                const Spacer(),
                Icon(Icons.access_time, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
