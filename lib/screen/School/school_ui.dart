import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:rakibsk/extra/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'school_information_cubit.dart';

class SchoolInformationScreen extends StatelessWidget {
  const SchoolInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SchoolInformationCubit(),
      child: const SchoolInformationView(),
    );
  }
}

class SchoolInformationView extends StatelessWidget {
  const SchoolInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SchoolInformationCubit>();
    final genderItems = ['Male', 'Female', 'Other'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('School Information'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(3),
        child: Card(
          color: Colors.blue[100],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<SchoolInformationCubit, SchoolInformationState>(
              builder: (context, state) {
                return Column(
                  children: [
                    TextField(
                      onChanged: cubit.updateSchoolName,
                      decoration: const InputDecoration(
                        labelText: 'Enter school name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      onChanged: cubit.updateDepartment,
                      decoration: const InputDecoration(
                        labelText: 'Enter Department',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: cubit.updateMobile,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Enter Mobile',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Checkbox(
                          value: state.isMale,
                          onChanged: (val) => cubit.updateMale(val!),
                        ),
                        const Text('Male'),
                        const SizedBox(width: 20),
                        Checkbox(
                          value: state.isFemale,
                          onChanged: (val) => cubit.updateFemale(val!),
                        ),
                        const Text('Female'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Select Gender',
                        border: OutlineInputBorder(),
                      ),
                      value: state.genderDropdown,
                      items: genderItems.map((e) {
                        return DropdownMenuItem(value: e, child: Text(e));
                      }).toList(),
                      onChanged: cubit.updateGenderDropdown,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      readOnly: true,
                      onTap: () async {
                        DateTime now = DateTime.now();
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: state.selectedDate ?? now,
                          firstDate: DateTime(now.year, now.month, now.day),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          cubit.updateDate(pickedDate);
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Select Date',
                        hintText: state.selectedDate != null
                            ? DateFormat('dd-MM-yyyy').format(state.selectedDate!)
                            : 'dd-mm-yyyy',
                        suffixIcon: const Icon(Icons.calendar_today),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Submit data to backend or show summary
                        print('School Name: ${state.schoolName}');
                        print('Department: ${state.department}');
                        print('Mobile: ${state.mobile}');
                        print('Gender: ${state.genderDropdown}');
                        print('Date: ${state.selectedDate}');
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
