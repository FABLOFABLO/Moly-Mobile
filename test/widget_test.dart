import 'package:flutter_test/flutter_test.dart';

import 'package:moly_mobile/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('moly_mobile'), findsOneWidget);
  });
}
