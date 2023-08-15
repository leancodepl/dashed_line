<div align="center">

# dashed_line

[![pub.dev][pub-badge]][pub-link] [![build status][build-badge]][build-link]

</div>

![][underheader]

Draw dashed lines with any shape and style you want. Just like that.

## Usage

Add the dependency to your `pubspec.yaml` (you can see the newest version in the pub badge):

```yaml
dependencies:
  dashed_line: ^0.1.0
```

Use the widget:

```dart
import 'package:dashed_line/dashed_line.dart';

// ...

DashedLine(
  path: Path()..cubicTo(-40, 53, 14, 86, 61, 102),
  color: Colors.red,
)
```

...you can also use the SVG path commands instead of a `Path`:

```dart
DashedLine.svgPath(
  'C -40 53 14 86 61 102',
  color: Colors.red,
)
```

## Where to obtain path methods/commands?

There are many ways.

You can construct the path yourself using the [`Path` methods][path-methods] like [`lineTo`][path-lineto] or [`cubicTo`][path-cubicto].

You can also use the [path commands][svg-commands] used in the `d` attribute of SVG files. You can do this manually or via export from one of the vector graphics software, like [Inkscape][inkscape] or [Figma][figma]. We found [SvgPathEditor][svgpatheditor] quite useful too.

### Example: Exporting path commands from Figma

|               First step              |             Second step            |
|:-------------------------------------:|:----------------------------------:|
| ![Create path using pen][figma-step1] | ![Export path as SVG][figma-step2] |

And now we have an SVG in the clipboard:

```svg
<svg width="190" height="48" viewBox="0 0 190 48" fill="none" xmlns="http://www.w3.org/2000/svg">
  <path d="M1 16C73 79 100 3 121 0.999997C142 -1 214.5 11.5 179 47" stroke="black"/>
</svg>
```

From here we can just copy the value of the `path`'s `d` attribute and use for the `DashedLine.svgPath` constructor's first argument.

## 🚨 Note about paths

Due to how `Path`s work in Flutter and Skia, the `DashedLine` widget takes NOT as much space as the dashed line needs, but as much it needs to contain all the [control points][control-points]. Table below should help understand the problem.

| Path commands                 |          Path          |          Result line          |
|-------------------------------|:----------------------:|:-----------------------------:|
| ``` C 8 63 14 86 61 102 ```   | ![][path-inside-bbox]  | ![][path-inside-bbox-result]  |
| ``` C -40 53 14 86 61 102 ``` | ![][path-outside-bbox] | ![][path-outside-bbox-result] |

## License

See [`LICENSE`][license].

[underheader]: https://raw.githubusercontent.com/leancodepl/dashed_line/main/art/underheader.png
[pub-badge]: https://img.shields.io/pub/v/dashed_line
[pub-link]: https://pub.dev/packages/dashed_line
[build-badge]: https://img.shields.io/github/actions/workflow/status/leancodepl/dashed_line/test.yml?branch=main
[build-link]: https://github.com/leancodepl/dashed_line/actions/workflows/test.yml

[path-methods]: https://api.flutter.dev/flutter/dart-ui/Path-class.html
[path-lineto]: https://api.flutter.dev/flutter/dart-ui/Path/lineTo.html
[path-cubicto]: https://api.flutter.dev/flutter/dart-ui/Path/cubicTo.html
[svg-commands]: https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/d
[inkscape]: https://inkscape.org/
[figma]: https://www.figma.com/
[svgpatheditor]: https://yqnn.github.io/svg-path-editor/

[figma-step1]: https://raw.githubusercontent.com/leancodepl/dashed_line/main/art/figma-step1.png
[figma-step2]: https://raw.githubusercontent.com/leancodepl/dashed_line/main/art/figma-step2.png

[control-points]: https://en.wikipedia.org/wiki/Control_point_(mathematics)
[path-inside-bbox]: https://raw.githubusercontent.com/leancodepl/dashed_line/main/art/path-inside-bbox.png
[path-inside-bbox-result]: https://raw.githubusercontent.com/leancodepl/dashed_line/main/art/path-inside-bbox-result.png
[path-outside-bbox]: https://raw.githubusercontent.com/leancodepl/dashed_line/main/art/path-outside-bbox.png
[path-outside-bbox-result]: https://raw.githubusercontent.com/leancodepl/dashed_line/main/art/path-outside-bbox-result.png

[license]: LICENSE
