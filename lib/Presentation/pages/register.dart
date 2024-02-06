import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  // Define controllers for text fields
  TextEditingController nameController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  int maleCount = 2;
  int femaleCount = 2;
  bool additionalTreatmentsAdded = false;
  bool cashSelected = false;
  bool cardSelected = false;
  bool upiSelected = false;
  double advanceAmount = 0.0;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  // Define variables for dropdowns and checkboxes
  String? selectedBranch;
  bool maleSelected = false;
  bool femaleSelected = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Registration Form'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Your FullName'),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: whatsappController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: ' Enter Your WhatsApp Number'),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Your Address'),
            ),
            SizedBox(
              height: 10,
            ),
            DropdownButtonFormField(
              value: selectedBranch,
              onChanged: (newValue) {
                setState(() {
                  selectedBranch = newValue!;
                });
              },
              items: ['Chennai', 'Mumbai', 'Kerala']
                  .map((branch) => DropdownMenuItem(
                        value: branch,
                        child: Text(branch),
                      ))
                  .toList(),
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Loation'),
            ),

            SizedBox(
              height: 10,
            ),
            DropdownButtonFormField(
              value: selectedBranch,
              onChanged: (newValue) {
                setState(() {
                  selectedBranch = newValue!;
                });
              },
              items: ['Branch 1', 'Branch 2', 'Branch 3']
                  .map((branch) => DropdownMenuItem(
                        value: branch,
                        child: Text(branch),
                      ))
                  .toList(),
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Branch'),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Treatments',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Container(
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Male: $maleCount'),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            maleCount += 1;
                          });
                        },
                        child: Text('Add Male: $maleCount'),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Female: $femaleCount'),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          femaleCount += 1;
                        });
                      },
                      child: Text('Add Female'),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Checkbox(
                      value: additionalTreatmentsAdded,
                      onChanged: (value) {
                        setState(() {
                          additionalTreatmentsAdded = value!;
                        });
                      },
                    ),
                    Text('Add Additional Treatments'),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  'Payment Option',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CheckboxListTile(
                      title: Text('Cash'),
                      value: cashSelected,
                      onChanged: (value) {
                        setState(() {
                          cashSelected = value!;
                          if (value) {
                            cardSelected = false;
                            upiSelected = false;
                          }
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('Card'),
                      value: cardSelected,
                      onChanged: (value) {
                        setState(() {
                          cardSelected = value!;
                          if (value) {
                            cashSelected = false;
                            upiSelected = false;
                          }
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: Text('UPI'),
                      value: upiSelected,
                      onChanged: (value) {
                        setState(() {
                          upiSelected = value!;
                          if (value) {
                            cashSelected = false;
                            cardSelected = false;
                          }
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  'Advance Amount',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      advanceAmount = double.tryParse(value) ?? 0.0;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter Advance Amount',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.0),
                      Text(
                        'Treatment Date & Time',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Date: ${selectedDate.toString().substring(0, 10)}'),
                          TextButton(
                            onPressed: () => _selectDate(context),
                            child: Text('Select Date'),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Time: ${selectedTime.format(context)}'),
                          TextButton(
                            onPressed: () => _selectTime(context),
                            child: Text('Select Time'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromRGBO(1, 106, 41, 0.98),
                        Color.fromRGBO(1, 106, 41, 0.98)
                      ],
                    ),
                  ),
                  margin: EdgeInsets.all(10),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => RegistrationForm()));
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                            color: Color.fromARGB(255, 243, 240, 240)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ]),
        ));
  }
  
}
