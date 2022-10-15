import "package:flutter_test/flutter_test.dart";
import 'package:defiscan/presentation/components/filterbar_ui.dart';

import "../../material_mock.dart";

void main() {
  const widget = FilterBarUI(info: "Searching...");

  testWidgets("it should ensure info is visible", (tester) async {
    await tester.pumpWidget(materialWidget(widget));
    final Finder header = find.text("Searching...");

    expect(header, findsOneWidget);
  });
}
