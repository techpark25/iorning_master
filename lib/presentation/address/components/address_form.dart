import 'package:flutter/material.dart';
import 'package:laundry_application/themes.dart';

class AddressForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController houseNoController;
  final TextEditingController addressLine1Controller;
  final TextEditingController addressLine2Controller;
  final TextEditingController landmarkController;
  final TextEditingController pincodeController;
  final String? latitude;
  final String? longitude;
  final VoidCallback? onTap;

  AddressForm({
    super.key,
    this.latitude,
    this.longitude,
    this.onTap,
    required this.nameController,
    required this.houseNoController,
    required this.addressLine1Controller,
    required this.addressLine2Controller,
    required this.landmarkController,
    required this.pincodeController,
  });

  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Confirm Location",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),
                _buildTextField(
                    widget.nameController, 'Full Name', Icons.person),
                _buildTextField(
                    widget.houseNoController, 'House/Building No', Icons.home),
                _buildTextField(widget.addressLine1Controller, 'Address Line 1',
                    Icons.location_on),
                _buildTextField(widget.addressLine2Controller, 'Address Line 2',
                    Icons.location_on),
                _buildTextField(
                    widget.landmarkController, 'Landmark', Icons.map),
                _buildTextField(
                    widget.pincodeController, 'Pincode', Icons.pin_drop),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: widget.onTap,
                    icon: const Icon(
                      Icons.save,
                      color: AppThemes.backgroundColor,
                    ),
                    label: const Text("Save Address"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          prefixIcon: Icon(
            icon,
            size: 17,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: const Color.fromARGB(255, 213, 213, 213),
                width: 1.0), // Default border color
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: const Color.fromARGB(255, 178, 178, 178),
                width: 1.0), // Border color when focused
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return '$label is required';
          }
          return null;
        },
      ),
    );
  }
}
