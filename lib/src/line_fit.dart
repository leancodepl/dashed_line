/// How a line should be inscribed in a parent.
enum LineFit {
  /// As large as possible while still containing the line entirely
  /// within the parent.
  contain,

  /// Fill the parent by distorting the line's aspect ratio.
  fill,
}
