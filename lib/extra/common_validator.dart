class InputValidation {
  //validates any input field where format is not required
  static String? validateEmptyString(String value, String error) {
    if (value.isEmpty || value.length > 40 || value.length < 2) {
      return error;
    } else {
      return null;
    }
  }

  //validates email
  static String? validateEmail(String value, String error) {
    if (value.isEmpty ||
        !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
      return error;
    } else {
      return null;
    }
  }

  static String? validateCapture(String value, String error) {
    if (value.isEmpty || value.length < 6) {
      return error;
    } else {
      return null;
    }
  }

  //validates phone number
  static String? validateArea(String value, String error) {
    if (value.isEmpty || value.length > 30) {
      return error;
    } else {
      return null;
    }
  }

  //validates password
  static String? validatePassword(String value, String error) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{5,}$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return error;
    } else if (value.length < 6 || !regExp.hasMatch(value)) {
      return error;
    } else {
      return null;
    }
  }
  static String? validateNewPassword(String value, String error) {
    if (value.isEmpty) {
      return error;
    } else {
      return null;
    }
  }
  //validates confirm password
  static String? validateConfirmPassword(
      String? password, String value, String error) {
    if (value.isEmpty) {
      return error;
    } else if (password == null || password != value) {
      return error;
    } else {
      return null;
    }
  }
}
