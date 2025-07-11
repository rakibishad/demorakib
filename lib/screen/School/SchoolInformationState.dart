import 'package:rakibsk/screen/School/school_information_cubit.dart';

class SchoolInformationState {
  final String schoolName;
  final String department;
  final String mobile;
  final bool isMale;
  final bool isFemale;
  final String? genderDropdown;
  final DateTime? selectedDate;

  SchoolInformationState({
    this.schoolName = '',
    this.department = '',
    this.mobile = '',
    this.isMale = false,
    this.isFemale = false,
    this.genderDropdown,
    this.selectedDate,
  });

  // 👇✅ copyWith is inside the class
  SchoolInformationState copyWith({
    String? schoolName,
    String? department,
    String? mobile,
    bool? isMale,
    bool? isFemale,
    String? genderDropdown,
    DateTime? selectedDate,
  }) {
    return SchoolInformationState(
      schoolName: schoolName ?? this.schoolName,
      department: department ?? this.department,
      mobile: mobile ?? this.mobile,
      isMale: isMale ?? this.isMale,
      isFemale: isFemale ?? this.isFemale,
      genderDropdown: genderDropdown ?? this.genderDropdown,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
