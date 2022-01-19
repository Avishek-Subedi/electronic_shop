import 'package:electronic_shop/screens/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late final TextEditingController _usernameController;
  late final TextEditingController _deliveryAddressController;
  late final TextEditingController _billingAddressController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _dateController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    final date = DateTime.now();
    _usernameController = TextEditingController();
    _deliveryAddressController = TextEditingController();
    _billingAddressController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _dateController = TextEditingController(text: formatDate(date));
    super.initState();
  }

  String formatDate(DateTime date) => DateFormat('MMM dd,yyyy').format(date);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            size: 35,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextFormField(
                hintText: 'Full Name',
                controller: _usernameController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                hintText: 'Billing Address',
                controller: _billingAddressController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your billing address';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                hintText: 'Delivery Address',
                controller: _deliveryAddressController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your delivery address';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                hintText: 'Contact number',
                controller: _phoneNumberController,
                textInputType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your contact number';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                enabled: false,
                hintText: 'Date',
                controller: _dateController,
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {}
                },
                child: Container(
                  alignment: Alignment.center,
                  width: size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Proceed',
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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
