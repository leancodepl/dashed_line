import 'package:dashed_line/dashed_line.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const black = Color(0xFF000000);
  const red = Color(0xFFFF0000);

  group('Path', () {
    final path = Path()
      ..moveTo(1, 52)
      ..cubicTo(67, 128, 125, 11, 155, 22)
      ..cubicTo(189, 34, 172, 75, 143, 76)
      ..cubicTo(114, 77, 102, 36, 123, 16)
      ..cubicTo(156, -16, 235, 11, 255, 29);

    testWidgets('Default arguments', (tester) async {
      final line = DashedLine(path: path, color: black);
      await testDashedLine(tester, line, 'path-default');
    });

    testWidgets('Line fit = fill', (tester) async {
      final line = DashedLine(path: path, color: black, lineFit: LineFit.fill);
      await testDashedLine(tester, line, 'path-fill');
    });

    testWidgets('All custom arguments', (tester) async {
      final line = DashedLine(
        path: path,
        color: red,
        dashLength: 30,
        dashSpace: 10,
        dashCap: StrokeCap.round,
        width: 5,
      );

      await testDashedLine(tester, line, 'path-custom');
    });
  });

  group('SVG path', () {
    const svgPath =
        'M0.999939 51.5989C66.9999 127.599 124.966 10.9987 155 21.5989C189 '
        '33.5989 172 74.5989 143 75.5989C114 76.5989 102 35.5989 123 '
        '15.5989C156 -15.8296 235 10.5989 255 28.5989';

    testWidgets('Default arguments', (tester) async {
      final line = DashedLine.svgPath(svgPath, color: black);
      await testDashedLine(tester, line, 'svg-default');
    });

    testWidgets('All custom arguments', (tester) async {
      final line = DashedLine.svgPath(
        svgPath,
        color: red,
        dashLength: 30,
        dashSpace: 10,
        dashCap: StrokeCap.round,
        width: 5,
      );

      await testDashedLine(tester, line, 'svg-custom');
    });
  });
}

Future<void> testDashedLine(
  WidgetTester tester,
  DashedLine dashedLine,
  String goldenFile,
) async {
  await tester.pumpWidget(Container(
    color: const Color(0xFFFFFFFF),
    alignment: Alignment.center,
    child: Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(border: Border.all()),
      child: dashedLine,
    ),
  ));
  await expectLater(
    find.byType(DashedLine),
    matchesGoldenFile('goldens/$goldenFile.png'),
  );
}
