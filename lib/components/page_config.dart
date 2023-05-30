class PageConfig {
  static const double _defaultZoom = 1;

  const PageConfig(
      {this.zoom = _defaultZoom,
      this.isShowing = true,
      this.enableFg = true,
      this.enableBg = true,
      this.enableMg = true,
      this.enableAnims = true});
  final double zoom;
  final bool isShowing;
  final bool enableFg;
  final bool enableBg;
  final bool enableMg;
  final bool enableAnims;

  factory PageConfig.fg(
          {double zoom = _defaultZoom,
          bool isShowing = true,
          bool enableAnims = true}) =>
      PageConfig(
          zoom: zoom,
          isShowing: isShowing,
          enableAnims: enableAnims,
          enableBg: false,
          enableMg: false);
  factory PageConfig.bg(
          {double zoom = _defaultZoom,
          bool isShowing = true,
          bool enableAnims = true}) =>
      PageConfig(
          zoom: zoom,
          isShowing: isShowing,
          enableAnims: enableAnims,
          enableFg: false,
          enableMg: false);
  factory PageConfig.mg(
          {double zoom = _defaultZoom,
          bool isShowing = true,
          bool enableAnims = true}) =>
      PageConfig(
          zoom: zoom,
          isShowing: isShowing,
          enableAnims: enableAnims,
          enableBg: false,
          enableFg: false);
}
