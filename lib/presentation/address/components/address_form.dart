import 'package:flutter/material.dart';

class AddressForm extends StatelessWidget {
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
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _buildTextField(nameController, 'Full Name', Icons.person),
                _buildTextField(
                    houseNoController, 'House/Building No', Icons.home),
                _buildTextField(addressLine1Controller, 'Address Line 1',
                    Icons.location_on),
                _buildTextField(addressLine2Controller, 'Address Line 2',
                    Icons.location_on),
                _buildTextField(landmarkController, 'Landmark', Icons.map),
                _buildTextField(pincodeController, 'Pincode', Icons.pin_drop),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: onTap,
                    icon: const Icon(Icons.save),
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
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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
