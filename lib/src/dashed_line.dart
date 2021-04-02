import 'package:flutter/widgets.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

import 'dashed_line_painter.dart';

class DashedLine extends StatelessWidget {
  const DashedLine({
    Key? key,
    required this.path,
    required this.color,
    this.alignment = Alignment.center,
    this.dashLength = 4,
    this.dashSpace = 8,
    this.strokeCap = StrokeCap.butt,
    this.strokeWidth = 1,
  }) : super(key: key);

  DashedLine.svgPath(
    String svgPath, {
    Key? key,
    required this.color,
    this.alignment = Alignment.center,
    this.dashLength = 4,
    this.dashSpace = 8,
    this.strokeCap = StrokeCap.butt,
    this.strokeWidth = 1,
  })  : path = parseSvgPath(svgPath),
        super(key: key);

  final Path path;
  final Color color;
  final Alignment alignment;
  final double dashLength;
  final double dashSpace;
  final double strokeWidth;
  final StrokeCap strokeCap;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedLinePainter(
        path: path,
        color: color,
        alignment: alignment,
        dashLength: dashLength,
        dashSpace: dashSpace,
        strokeWidth: strokeWidth,
        strokeCap: strokeCap,
      ),
      child: const SizedBox.expand(),
    );
  }
}
