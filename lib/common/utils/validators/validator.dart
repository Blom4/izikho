class Validator {
  static String? emailValidator(String? email) {
    if (email == "") return "Email is required";
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (!emailRegex.hasMatch(email!)) {
      return "please enter a valid email address";
    }
    return null;
  }

  static String? required(String? value) {
    if (value == "") return "Field is required";

    return null;
  }
}
