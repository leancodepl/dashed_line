import 'dart:math' show min;
import 'dart:ui';

import 'package:dashed_line/src/line_fit.dart';

/// Calculates the scale by which the [path] should be scaled to fit in a
/// container of size [containerSize], taking [lineFit] into account.
///
/// The [Offset] returned should be interpreted as a scale in X and Y axes.
Offset fittingPathScale(Path path, Size containerSize, LineFit lineFit) {
  final pathSize = path.getBounds().size;

  if (lineFit == LineFit.contain) {
    final scale = min(
      containerSize.width / pathSize.width,
      containerSize.height / pathSize.height,
    );

    return Offset(scale, scale);
  } else {
    return Offset(
      containerSize.width / pathSize.width,
      containerSize.height / pathSize.height,
    );
  }
}

/// Calculates the size required to accomodate the [path] in a container of size
/// [containerSize], taking [lineFit] into account.
Size fittingPathSize(Path path, Size containerSize, LineFit lineFit) {
  final pathSize = path.getBounds().size;
  final scale = fittingPathScale(path, containerSize, lineFit);

  return Size(pathSize.width * scale.dx, pathSize.height * scale.dy);
}
