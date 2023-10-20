import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('STACK', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Swiper(
          layout: SwiperLayout.STACK,
          itemWidth: 300.0,
          itemHeight: 200.0,
          itemBuilder: (context, index) {
            return ColoredBox(
              color: Colors.grey,
              child: Center(
                child: Text('$index'),
              ),
            );
          },
          itemCount: 10,
        ),
      ),
    );
  });

  testWidgets('TINDER', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Swiper(
          layout: SwiperLayout.TINDER,
          itemWidth: 300.0,
          itemHeight: 200.0,
          itemBuilder: (context, index) {
            return ColoredBox(
              color: Colors.grey,
              child: Center(
                child: Text('$index'),
              ),
            );
          },
          itemCount: 10,
        ),
      ),
    );
  });

  testWidgets('DEFAULT', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Swiper(
          layout: SwiperLayout.DEFAULT,
          viewportFraction: 0.8,
          scale: 0.9,
          itemBuilder: (context, index) {
            return ColoredBox(
              color: Colors.grey,
              child: Center(
                child: Text('$index'),
              ),
            );
          },
          itemCount: 10,
        ),
      ),
    );
  });

  testWidgets('CUSTOM', (tester) async {
    CustomLayoutOption customLayoutOption;
    customLayoutOption = CustomLayoutOption(startIndex: -1, stateCount: 3)
      ..addRotate([-45.0 / 180, 0.0, 45.0 / 180])
      ..addTranslate(
        const [
          Offset(-370.0, -40.0),
          Offset.zero,
          Offset(370.0, -40.0),
        ],
      );
    await tester.pumpWidget(
      MaterialApp(
        home: Swiper(
          layout: SwiperLayout.CUSTOM,
          itemWidth: 300.0,
          itemHeight: 200.0,
          customLayoutOption: customLayoutOption,
          itemBuilder: (context, index) {
            return ColoredBox(
              color: Colors.grey,
              child: Center(
                child: Text('$index'),
              ),
            );
          },
          itemCount: 10,
        ),
      ),
    );
  });
}
