import 'package:dashed_line/dashed_line.dart';
import 'package:dashed_line/src/dashed_line_painter.dart';
import 'package:dashed_line/src/fitting_path_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

/// A dashed line following a path.
///
/// The line follows a specified path, either:
/// 1. A [Path] if using a default constructor.
/// 2. An SVG path definition when using the [DashedLine.svgPath] constructor.
///
/// The `lineFit`, `alignment`, `dashLength`, `dashSpace`, `strokeCap`,
/// and `strokeWidth` are customizable.
class DashedLine extends StatelessWidget {
  /// Creates a dashed line following a `path`.
  const DashedLine({
    super.key,
    required this.path,
    required this.color,
    this.lineFit = LineFit.contain,
    this.alignment = Alignment.center,
    this.dashLength = 4,
    this.dashSpace = 8,
    this.dashCap = StrokeCap.butt,
    this.width = 1,
  });

  /// Creates a dashed line following a path defined using SVG path commands.
  ///
  /// The `svgPath` is a path definition, i.e. a list of path commands
  /// known from the SVG file format.
  ///
  /// See also:
  /// - https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/d#path_commands
  DashedLine.svgPath(
    String svgPath, {
    super.key,
    required this.color,
    this.lineFit = LineFit.contain,
    this.alignment = Alignment.center,
    this.dashLength = 4,
    this.dashSpace = 8,
    this.dashCap = StrokeCap.butt,
    this.width = 1,
  }) : path = parseSvgPath(svgPath);

  /// The path that the dashed line follows.
  ///
  /// Can consist of multiple path metrics.
  final Path path;

  /// The dashed line color.
  final Color color;

  /// The [LineFit] of the line inside the parent.
  final LineFit lineFit;

  /// The alignment of the dashed line relative to the parent.
  final Alignment alignment;

  /// The length of a single dash, i.e. the drawn parts of the whole [path].
  final double dashLength;

  /// The distance between each dash, i.e. the blank spaces on the whole [path].
  final double dashSpace;

  /// The [StrokeCap] of each dash.
  ///
  /// This is the shape that appears on the beginning and end of each dash
  /// on the dashed line.
  final StrokeCap dashCap;

  /// The width of the dashed line.
  final double width;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = fittingPathSize(path, constraints.biggest, lineFit);

        return CustomPaint(
          painter: DashedLinePainter(
            path: path,
            color: color,
            lineFit: lineFit,
            alignment: alignment,
            dashLength: dashLength,
            dashSpace: dashSpace,
            strokeCap: dashCap,
            strokeWidth: width,
          ),
          child: SizedBox.fromSize(size: size),
        );
      },
    );
  }
}
