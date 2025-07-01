import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:rakibsk/extra/colors.dart';

class SchoolInformationScreen extends StatefulWidget {
  const SchoolInformationScreen({super.key});

  @override
  State<SchoolInformationScreen> createState() => _SchoolInformationScreenState();
}

class _SchoolInformationScreenState extends State<SchoolInformationScreen> {
  TextInputType tvname = TextInputType.text;
  TextInputType tv_Depatment = TextInputType.text;
  TextInputType tv_mobile = TextInputType.text;
  bool isMaleChecked = false;
  bool isFemaleChecked = false;
  String? selectedValue;
  List<String> items = ['Male', 'Female', 'Other'];
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.cyan,
        title: const Text('School Information'),
      ),
      body:SingleChildScrollView( child: Padding(
    padding: const EdgeInsets.all(1.0),
    child: Card(
        color: Colors.blue[100],
        shadowColor: Colors.grey,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,  // optional: center vertically
              children: [
                TextField(
                  keyboardType: tvname,
                  decoration: const InputDecoration(
                    labelText: 'Enter school name',
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20), // spacing between fields
                TextField(
                  keyboardType: tv_Depatment,
                  decoration: const InputDecoration(
                    labelText: 'Enter Department',
                    border: OutlineInputBorder(),
                  ),
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20), // spacing between fields
                TextField(
                  keyboardType: TextInputType.number,

                  decoration: const InputDecoration(
                    labelText: 'Enter Mobile',
                    border: OutlineInputBorder(),

                  ),
                  style: const TextStyle(fontSize: 18),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10)

                  ],
                ),

          const SizedBox(height: 20), // spacing between fields

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: isMaleChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isMaleChecked = value!;
                  });
                },
              ),
              const Text('Male'),
              const SizedBox(width: 20), // spacing between Male and Female
              Checkbox(
                value: isFemaleChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isFemaleChecked = value!;
                  });
                },
              ),
              const Text('Female'),
            ],
          ),

                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Select Gender",
                    border: OutlineInputBorder(),
                  ),
                  value: selectedValue,
                  items: items.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  readOnly: true,
                  onTap: () async {
                    DateTime now = DateTime.now();
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate ?? now,
                      firstDate: DateTime(now.year, now.month, now.day), // 👈 only today & future
                      lastDate: DateTime(2100),
                    );

                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Select Date',
                    hintText: selectedDate != null
                        ? DateFormat('dd-MM-yyyy').format(selectedDate!)
                        : 'dd-mm-yyyy',
                    suffixIcon: const Icon(Icons.calendar_today),
                    border: const OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  child: const Text('Submit'),

            ),
    ],
          ),
        ),
      ),
    ),
      ),
      ),
    );
  }
}
