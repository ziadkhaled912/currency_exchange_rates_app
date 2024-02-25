enum Routes {
  homeBasePage("/"),
  homePage("homePage"),
  currencyRates("currencyRates"),
  goldRates("goldRates"),
  currencyCalculator("currencyCalculator");

  final String name;

  const Routes(this.name);
}
