import 'package:flutter/material.dart';

class DetailsInputScreen extends StatefulWidget {
  @override
  State<DetailsInputScreen> createState() => _DetailsInputScreenState();
}

class _DetailsInputScreenState extends State<DetailsInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _shopController = TextEditingController();
  final _gstController = TextEditingController();
  final _cityController = TextEditingController();
  final _pincodeController = TextEditingController();

  bool isRetailer = false;
  bool isWholesaler = false;
  bool isTrader = false;

  String? selectedQty;

  final List<String> qtyOptions = [
    'Upto 50 pcs',
    '100-200 pcs',
    '200-500 pcs',
    'More than 500 pcs'
  ];

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller,
      {bool mandatory = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) => mandatory && value!.isEmpty ? 'Required' : null,
      ),
    );
  }

  Widget _buildCheckboxTile(
      String label, bool value, Function(bool?) onChanged) {
    return CheckboxListTile(
      title: Text(label),
      value: value,
      onChanged: onChanged,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  Widget _buildRadioOption(String label) {
    return RadioListTile(
      title: Text(label),
      value: label,
      groupValue: selectedQty,
      onChanged: (value) => setState(() => selectedQty = value.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Business Details"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildSectionTitle("Basic Details"),
              _buildInputField("Name", _nameController, mandatory: true),
              _buildInputField("Shop Name", _shopController, mandatory: true),
              _buildInputField("GST No", _gstController),
              _buildInputField("City", _cityController, mandatory: true),
              _buildInputField("Pincode", _pincodeController),
              _buildSectionTitle("Business Type"),
              _buildCheckboxTile("Retailer", isRetailer,
                  (val) => setState(() => isRetailer = val!)),
              _buildCheckboxTile("Wholesaler", isWholesaler,
                  (val) => setState(() => isWholesaler = val!)),
              _buildCheckboxTile(
                  "Trader", isTrader, (val) => setState(() => isTrader = val!)),
              _buildSectionTitle("Purchase Quantity"),
              ...qtyOptions.map(_buildRadioOption).toList(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  textStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                child: Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
