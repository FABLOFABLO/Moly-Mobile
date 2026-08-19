import 'package:flutter_test/flutter_test.dart';

import 'package:moly_mobile/main.dart';

void main() {
  testWidgets('Onboarding smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('로그인'), findsOneWidget);
    expect(find.text('구글로 시작하기'), findsOneWidget);
  });
}
