import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_navigation_samoilenko/main.dart';

void main() {
  testWidgets('LibraryApp renders catalog screen', (WidgetTester tester) async {
    await tester.pumpWidget(const LibraryApp());
    await tester.pumpAndSettle();

    expect(find.text('Каталог бібліотеки'), findsOneWidget);
  });
}