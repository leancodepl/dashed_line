import 'dart:typed_data';

import 'package:flutter/rendering.dart';

import 'fitting_path_size.dart';
import 'line_fit.dart';

class DashedLinePainter extends CustomPainter {
  DashedLinePainter({
    required this.path,
    required this.color,
    required this.lineFit,
    required this.alignment,
    required this.dashLength,
    required this.dashSpace,
    required this.strokeCap,
    required this.strokeWidth,
  });

  final Path path;

  /// The color of the dashed line.
  final Color color;

  final LineFit lineFit;
  final Alignment alignment;
  final double dashLength;
  final double dashSpace;

  /// The width of the edges, given in logical pixels measured in the direction
  /// orthogonal to the direction of the path.
  final double strokeWidth;

  /// The kind of finish to place on the end of line.
  final StrokeCap strokeCap;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeCap = strokeCap
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final scale = fittingPathScale(path, size, lineFit);

    final scaledPathSize = fittingPathSize(path, size, lineFit);
    // Offset required to align the dashed line accordingly to the alignment.
    final alignmentOffset = Offset(
      (size.width - scaledPathSize.width) / 2 * (alignment.x + 1),
      (size.height - scaledPathSize.height) / 2 * (alignment.y + 1),
    );

    final pathBounds = path.getBounds();
    // Offset needed to move the path into the painter bounds so
    // that it doesn't overflow.
    final negativeOffset = Offset(
      -pathBounds.left * scale.dx,
      -pathBounds.top * scale.dy,
    );

    final pathMetrics = path.computeMetrics();
    for (final pathMetric in pathMetrics) {
      for (var dist = 0.0;
          dist < pathMetric.length;
          dist += dashLength + dashSpace) {
        final dashPath = pathMetric
            .extractPath(dist, dist + dashLength)
            .transform(_scaleMatrix4(scale))
            .shift(alignmentOffset + negativeOffset);

        canvas.drawPath(dashPath, paint);
      }
    }
  }

  /// https://en.wikipedia.org/wiki/Scaling_(geometry)#Using_homogeneous_coordinates
  static Float64List _scaleMatrix4(Offset scale) {
    final matrix = <List<double>>[
      [scale.dx, 0, 0, 0],
      [0, scale.dy, 0, 0],
      [0, 0, 1, 0],
      [0, 0, 0, 1],
    ];

    return Float64List.fromList(matrix.expand((x) => x).toList());
  }

  @override
  bool shouldRepaint(DashedLinePainter oldDelegate) => path != oldDelegate.path;
}
