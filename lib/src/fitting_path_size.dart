import 'dart:math' show min;
import 'dart:ui';

import 'package:dashed_line/src/line_fit.dart';

Offset fittingPathScale(Path path, Size containerSize, LineFit fit) {
  final pathSize = path.getBounds().size;

  if (fit == LineFit.contain) {
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

Size fittingPathSize(Path path, Size containerSize, LineFit fit) {
  final pathSize = path.getBounds().size;
  final scale = fittingPathScale(path, containerSize, fit);

  return Size(pathSize.width * scale.dx, pathSize.height * scale.dy);
}
