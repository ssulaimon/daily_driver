class TextFormValidator {
  static String? emailValidator(String? mail) {
    if (mail!.isEmpty) {
      return 'Please enter your email address';
    } else if (!mail.contains("@")) {
      return 'Invalid email';
    } else if (mail.length < 4) {
      return 'email is too short';
    } else {
      return null;
    }
  }

  static String? passwordValidator(String? password) {
    if (password!.isEmpty) {
      return 'Password cannot be empty';
    } else if (password.length < 5) {
      return 'Password is not Strong enough';
    } else {
      return null;
    }
  }

  static String? nameValidator(String? name) {
    if (name!.isEmpty) {
      return 'Please enter your full name';
    } else if (name.length < 4) {
      return 'Please enter first name and last name';
    } else {
      return null;
    }
  }

  static String? phoneNumberValidator(String? phone) {
    if (phone!.isEmpty) {
      return 'Please enter your mobile number';
    } else if (phone.length < 7) {
      return 'Invalid phone number';
    } else {
      return null;
    }
  }

  static String? identityNmuberVerification(String? identityNumber) {
    if (identityNumber!.isEmpty) {
      return 'Identity Number cannot be empty';
    } else if (identityNumber.length < 8) {
      return 'Invalid Card Number';
    } else {
      return null;
    }
  }

  static String? idTypeValidator(String? type) {
    if (type!.isEmpty) {
      return 'Please Select Identity Type';
    } else {
      return null;
    }
  }
}
