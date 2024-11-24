extension Validators on String {
  bool validateAmount() {
    final amount = double.tryParse(this);
    if (amount == null) {
      return false;
    }
    return amount > 0;
  }

  bool isValidName() {
    return RegExp(
            r'^[a-zA-Z\u0621-\u064A]{3,}( {1,2}[a-zA-Z\u0621-\u064A]{3,}){0,}$')
        .hasMatch(this);
  }

  bool isValidEmail() {
    // return RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$').hasMatch(this);
    return RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
        .hasMatch(this);
  }

  bool isNotValidPassword() {
    return isEmpty || length < 6;
  }
}
