// Update file ini agar tidak menyebabkan error build karena UI berubah
import 'package:flutter_test/flutter_test.dart';
import 'package:tubes/main.dart';

void main() {
  testWidgets('Login screen loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TheKomarsApp());

    // Verify that The Komars text is present and Masuk button
    expect(find.text('The Komars'), findsOneWidget);
    expect(find.text('Masuk'), findsOneWidget);
  });
}