import 'dart:math' show min;
import 'dart:typed_data';

import 'package:flutter/rendering.dart';

class DashedLinePainter extends CustomPainter {
  DashedLinePainter({
    required this.path,
    required this.color,
    required this.alignment,
    required this.dashLength,
    required this.dashSpace,
    required this.strokeCap,
    required this.strokeWidth,
  });

  final Path path;
  final Color color;
  final Alignment alignment;
  final double dashLength;
  final double dashSpace;
  final double strokeWidth;
  final StrokeCap strokeCap;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeCap = strokeCap
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final pathSize = path.getBounds().size;
    final scale = min(
      size.width / pathSize.width,
      size.height / pathSize.height,
    );
    final scaledPathSize = pathSize * scale;

    final offset = Offset(
      (size.width - scaledPathSize.width) / 2 * (alignment.x + 1),
      (size.height - scaledPathSize.height) / 2 * (alignment.y + 1),
    );

    final pathMetrics = path.computeMetrics();
    for (final pathMetric in pathMetrics) {
      for (double dist = 0;
          dist < pathMetric.length;
          dist += dashLength + dashSpace) {
        final dashPath = pathMetric
            .extractPath(dist, dist + dashLength)
            .transform(scaleMatrix4(scale))
            .shift(offset);

        canvas.drawPath(dashPath, paint);
      }
    }
  }

  Float64List scaleMatrix4(double scale) {
    final matrix = <List<double>>[
      [scale, 0, 0, 0],
      [0, scale, 0, 0],
      [0, 0, 1, 0],
      [0, 0, 0, 1],
    ];

    return Float64List.fromList(matrix.expand((x) => x).toList());
  }

  @override
  bool shouldRepaint(DashedLinePainter oldDottedLinePainter) =>
      path != oldDottedLinePainter.path;
}
