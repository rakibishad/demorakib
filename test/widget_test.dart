import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rakibsk/main.dart';
import 'package:rakibsk/appTheme/theme_Prefrences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('MyApp renders correctly with ThemeRepository', (WidgetTester tester) async {
    // 🧪 Mock SharedPreferences
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    // 🧪 Create ThemeRepository
    final themeRepository = ThemeRepository(sharedPreferences: prefs);

    // 🧪 Build and pump the widget
    await tester.pumpWidget(MyApp(themeRepository: themeRepository));

    // Wait for UI to build
    await tester.pumpAndSettle();

    // ✅ Expect MyApp to be in the tree
    expect(find.byType(MyApp), findsOneWidget);
  });
}
