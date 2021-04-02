import 'dart:math' show min;
import 'dart:ui';

double fittingPathScale(Path path, Size containerSize) {
  final pathSize = path.getBounds().size;

  return min(
    containerSize.width / pathSize.width,
    containerSize.height / pathSize.height,
  );
}

Size fittingPathSize(Path path, Size containerSize) {
  final pathSize = path.getBounds().size;
  final scale = fittingPathScale(path, containerSize);

  return pathSize * scale;
}
