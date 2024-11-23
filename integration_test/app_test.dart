import 'package:integration_test/integration_test.dart';
// import '../test/features/home_page/presentation/pages/home_page_test.dart' as home_page_test;
import 'features/currency_calculator/currency_calculator_page_test.dart' as currency_calculator_page;
import 'features/auth/splash_page_test.dart' as splash_page_test;
import 'features/auth/login_page_test.dart' as login_page_test;
import 'features/auth/register_page_test.dart' as register_page_test;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // home_page_test.main();
  splash_page_test.main();
  login_page_test.main();
  register_page_test.main();
  currency_calculator_page.main();
}
