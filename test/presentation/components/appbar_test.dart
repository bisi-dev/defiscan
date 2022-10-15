import "package:flutter_test/flutter_test.dart";
import 'package:defiscan/presentation/components/appbar.dart';

import "../../material_mock.dart";

void main() {
  const widget = DeFiAppBar(title: "DeFi Scan");

  testWidgets("it should ensure App Bar is visible with correct header",
      (tester) async {
    await tester.pumpWidget(materialWidget(widget));
    final Finder header = find.text("DeFi Scan");

    expect(header, findsOneWidget);
  });
}
