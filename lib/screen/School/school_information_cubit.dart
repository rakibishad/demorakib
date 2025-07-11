import 'package:flutter_bloc/flutter_bloc.dart';

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

class SchoolInformationCubit extends Cubit<SchoolInformationState> {
  SchoolInformationCubit() : super(SchoolInformationState());

  void updateSchoolName(String value) => emit(state.copyWith(schoolName: value));
  void updateDepartment(String value) => emit(state.copyWith(department: value));
  void updateMobile(String value) => emit(state.copyWith(mobile: value));
  void updateMale(bool value) => emit(state.copyWith(isMale: value));
  void updateFemale(bool value) => emit(state.copyWith(isFemale: value));
  void updateGenderDropdown(String? value) => emit(state.copyWith(genderDropdown: value));
  void updateDate(DateTime date) => emit(state.copyWith(selectedDate: date));
}
