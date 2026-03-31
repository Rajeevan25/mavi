import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mavi_security/main.dart';

void main() {
  testWidgets('MAVI Security App build test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: MaviSecurityApp()));

    // Verify that the dashboard is shown.
    expect(find.text('MAVI Security'), findsOneWidget);
  });
}
