extension Validators on String {
  bool validateAmount() {
    final amount = double.tryParse(this);
    if (amount == null) {
      return false;
    }
    return amount > 0;
  }
}
