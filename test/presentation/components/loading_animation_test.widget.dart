import "package:flutter_test/flutter_test.dart";
import 'package:defiscan/presentation/components/loading_animation.dart';

import "../../material_mock.dart";

void main() {
  const widget = LoadingAnimation();

  testWidgets("it should ensure loading animation is disposed appropriately",
      (tester) async {
    await tester.pumpWidget(materialWidget(widget));
    tester.verifyTickersWereDisposed();
  });
}
