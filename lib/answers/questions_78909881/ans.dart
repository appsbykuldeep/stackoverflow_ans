import 'package:flutter/material.dart';

class Questions78909881 extends StatefulWidget {
  const Questions78909881({super.key});

  @override
  State<Questions78909881> createState() => _Questions78909881State();
}

class _Questions78909881State extends State<Questions78909881> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _familyinformationController =
      TextEditingController();
  final TextEditingController _mamkulController = TextEditingController();
  final TextEditingController _alternatenumberController =
      TextEditingController();
  final TextEditingController _birthplaceController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _gotraController = TextEditingController();
  final TextEditingController _ganController = TextEditingController();
  final TextEditingController _nakshatrController = TextEditingController();
  final TextEditingController _nadiController = TextEditingController();
  final TextEditingController _bloodgroupController = TextEditingController();

  void _register() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration Successful')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Text(
                'Your Details',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _fullnameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  print(("Name $value"));
                  if (value == null || value.isEmpty) {
                    return 'Full name is required';
                  } else if (value.length <= 6) {
                    return 'Full name must be more the 6 character';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _phonenumberController,
                decoration: const InputDecoration(
                  labelText: 'Mobile Number',
                  border: OutlineInputBorder(),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty && value.length < 10) {
                    return 'Mobile Number is required';
                  } else if (value.length != 10) {
                    return 'Provided valid mobile number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _qualificationController,
                decoration: const InputDecoration(
                  labelText: 'Education',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Education is required';
                  } else if (value.length < 2) {
                    return 'Provided valid Education';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                onTap: () async {
                  DateTime? date = DateTime(1900);
                  FocusScope.of(context).requestFocus(FocusNode());
                  date = await showDatePicker(
                      context: context,
                      initialDate: DateTime(DateTime.now().year - 17),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(DateTime.now().year - 17));
                },
                controller: _birthdateController,
                decoration: const InputDecoration(
                  labelText: 'Birth Date',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Birth Date is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _jobController,
                decoration: const InputDecoration(
                  labelText: 'Job',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Job is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Address is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _familyinformationController,
                decoration: const InputDecoration(
                  labelText: 'Family Information',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Family Information is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _mamkulController,
                decoration: const InputDecoration(
                  labelText: 'Mamkul',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mamkul is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _alternatenumberController,
                decoration: const InputDecoration(
                  labelText: 'Alternate Mobile Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _birthplaceController,
                decoration: const InputDecoration(
                  labelText: 'Birth Place',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(
                  labelText: 'Height',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _gotraController,
                decoration: const InputDecoration(
                  labelText: 'Gotra',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _ganController,
                decoration: const InputDecoration(
                  labelText: 'Gan',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nakshatrController,
                decoration: const InputDecoration(
                  labelText: 'Nakshtra',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nadiController,
                decoration: const InputDecoration(
                  labelText: 'Nadi',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _bloodgroupController,
                decoration: const InputDecoration(
                  labelText: 'Blood Group',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  // backgroundColor: Constant.HEADR_BACKGROUBD_COLOUR,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
