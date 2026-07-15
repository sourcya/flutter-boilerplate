import 'package:flutter_test/flutter_test.dart';
import 'package:boilerplate_ui/app/app.dart';

void main() {
  testWidgets('App renders', (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    expect(find.text('Posts'), findsOneWidget);
  });
}
