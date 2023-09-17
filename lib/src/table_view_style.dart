import 'dart:ui';

import 'package:flutter/material.dart';

T _binaryLerp<T>(T a, T b, double t) => t > .5 ? b : a;

/// Defines a display style of a table.
@immutable
class TableViewStyle extends ThemeExtension<TableViewStyle> {
  /// Display style of dividers in a table.
  final TableViewDividersStyle? dividers;

  /// Display style of scrollbars in a table;
  final TableViewScrollbarsStyle? scrollbars;

  /// Padding for the scrollable part of the table.
  /// Primarily used to leave space for vertical scrollbars when using
  /// [SliverTableView].
  final EdgeInsets? scrollPadding;

  /// Minimum scrollable width ratio in relation to the width of a table.
  /// Minimum scrollable width limits the space that can be taken up by
  /// frozen columns. If a resulting scrollable width is less than
  /// the minimum width, columns will be unfrozen according to freeze priority
  /// until scrollable width is greater than or equal the minimum.
  final double? minScrollableWidthRatio;

  const TableViewStyle({
    this.dividers,
    this.scrollbars,
    this.scrollPadding,
    this.minScrollableWidthRatio,
  });

  @override
  TableViewStyle copyWith({
    TableViewDividersStyle? dividers,
    TableViewScrollbarsStyle? scrollbars,
    EdgeInsets? scrollPadding,
    double? minScrollableWidthRatio,
  }) =>
      TableViewStyle(
        dividers: dividers ?? this.dividers,
        scrollbars: scrollbars ?? this.scrollbars,
        scrollPadding: scrollPadding ?? this.scrollPadding,
        minScrollableWidthRatio:
            minScrollableWidthRatio ?? this.minScrollableWidthRatio,
      );

  @override
  TableViewStyle lerp(TableViewStyle other, double t) => TableViewStyle(
        dividers: dividers == null || other.dividers == null
            ? other.dividers
            : dividers!.lerp(other.dividers!, t),
        scrollbars: scrollbars == null || other.scrollbars == null
            ? other.scrollbars
            : scrollbars!.lerp(other.scrollbars!, t),
        scrollPadding: EdgeInsets.lerp(scrollPadding, other.scrollPadding, t),
        minScrollableWidthRatio: lerpDouble(
            minScrollableWidthRatio, other.minScrollableWidthRatio, t),
      );
}

/// Defines a display style of dividers in a table.
@immutable
class TableViewDividersStyle {
  /// Display style of horizontal dividers.
  final TableViewHorizontalDividersStyle? horizontal;

  /// Display style of vertical dividers.
  final TableViewVerticalDividersStyle? vertical;

  const TableViewDividersStyle({
    this.horizontal,
    this.vertical,
  });

  TableViewDividersStyle copyWith({
    TableViewHorizontalDividersStyle? horizontal,
    TableViewVerticalDividersStyle? vertical,
  }) =>
      TableViewDividersStyle(
        horizontal: horizontal ?? this.horizontal,
        vertical: vertical ?? this.vertical,
      );

  TableViewDividersStyle lerp(TableViewDividersStyle other, double t) =>
      TableViewDividersStyle(
        horizontal: horizontal == null || other.horizontal == null
            ? other.horizontal
            : horizontal!.lerp(other.horizontal!, t),
        vertical: vertical == null || other.vertical == null
            ? other.vertical
            : vertical!.lerp(other.vertical!, t),
      );
}

/// Defines a display style of horizontal dividers of a table.
@immutable
class TableViewHorizontalDividersStyle {
  /// Display style of a divider between a header row and the rest of a table.
  final TableViewHorizontalDividerStyle? header;

  /// Display style of a divider between a footer row and the rest of a table.
  final TableViewHorizontalDividerStyle? footer;

  const TableViewHorizontalDividersStyle({
    this.header,
    this.footer,
  });

  /// Initializes [header] and [footer] using
  /// the same [TableViewHorizontalDividerStyle].
  const TableViewHorizontalDividersStyle.symmetric(
    TableViewHorizontalDividerStyle style,
  )   : header = style,
        footer = style;

  TableViewHorizontalDividersStyle copyWith({
    TableViewHorizontalDividerStyle? header,
    TableViewHorizontalDividerStyle? footer,
  }) =>
      TableViewHorizontalDividersStyle(
        header: header ?? this.header,
        footer: footer ?? this.footer,
      );

  TableViewHorizontalDividersStyle lerp(
          TableViewHorizontalDividersStyle other, double t) =>
      TableViewHorizontalDividersStyle(
        header: header == null || other.header == null
            ? other.header
            : header!.lerp(other.header!, t),
        footer: footer == null || other.footer == null
            ? other.footer
            : footer!.lerp(other.footer!, t),
      );
}

/// Defines a display style of a particular horizontal divider of a table.
@immutable
class TableViewHorizontalDividerStyle {
  /// Color of the divider displayed.
  final Color? color;

  /// Thickness of the divider displayed. Affects layout.
  final double? thickness;

  const TableViewHorizontalDividerStyle({
    this.color,
    this.thickness,
  }) : assert(thickness == null || thickness >= 0);

  TableViewHorizontalDividerStyle copyWith({
    Color? color,
    double? thickness,
  }) =>
      TableViewHorizontalDividerStyle(
        color: color ?? this.color,
        thickness: thickness ?? this.thickness,
      );

  TableViewHorizontalDividerStyle lerp(
          TableViewHorizontalDividerStyle other, double t) =>
      TableViewHorizontalDividerStyle(
        color: Color.lerp(color, other.color, t),
        thickness: lerpDouble(thickness, other.thickness, t),
      );
}

/// Defines a display style of vertical dividers of a table.
@immutable
class TableViewVerticalDividersStyle {
  /// Display style of a divider separating
  /// frozen on the leading (left in left-to-right) edge columns
  /// from the rest of the columns.
  final TableViewVerticalDividerStyle? leading;

  /// Display style of a divider separating
  /// frozen on the trailing (right in left-to-right) edge columns
  /// from the rest of the columns.
  final TableViewVerticalDividerStyle? trailing;

  const TableViewVerticalDividersStyle({
    this.leading,
    this.trailing,
  });

  /// Initializes [leading] and [trailing] using
  /// the same [TableViewVerticalDividerStyle].
  const TableViewVerticalDividersStyle.symmetric(
    TableViewVerticalDividerStyle style,
  )   : leading = style,
        trailing = style;

  TableViewVerticalDividersStyle copyWith({
    TableViewVerticalDividerStyle? leadingDividerStyle,
    TableViewVerticalDividerStyle? trailingDividerStyle,
  }) =>
      TableViewVerticalDividersStyle(
        leading: leadingDividerStyle ?? this.leading,
        trailing: trailingDividerStyle ?? this.trailing,
      );

  TableViewVerticalDividersStyle lerp(
          TableViewVerticalDividersStyle other, double t) =>
      TableViewVerticalDividersStyle(
        leading: leading == null || other.leading == null
            ? other.leading
            : leading!.lerp(other.leading!, t),
        trailing: trailing == null || other.trailing == null
            ? other.trailing
            : trailing!.lerp(other.trailing!, t),
      );
}

/// Defines a display style of a particular vertical divider of a table.
@immutable
class TableViewVerticalDividerStyle {
  /// Color of the divider displayed.
  final Color? color;

  /// Thickness of the divider displayed. Affects clipping.
  final double? thickness;

  /// The amount of times per row the divider displayed is going to wiggle.
  /// Increasing this value might worsen the performance.
  /// Prefer setting it to 0 when not using wiggling dividers.
  final int? wigglesPerRow;

  /// The amount of logical pixels the divider will wiggle horizontally.
  final double? wiggleOffset;

  const TableViewVerticalDividerStyle({
    this.color,
    this.thickness,
    this.wigglesPerRow,
    this.wiggleOffset,
  })  : assert(thickness == null || thickness >= 0),
        assert(wigglesPerRow == null || wigglesPerRow >= 0),
        assert(wiggleOffset == null || wiggleOffset >= 0);

  TableViewVerticalDividerStyle copyWith({
    Color? color,
    double? thickness,
    int? wigglesPerRow,
    double? wiggleOffset,
  }) =>
      TableViewVerticalDividerStyle(
        color: color ?? this.color,
        thickness: thickness ?? this.thickness,
        wigglesPerRow: wigglesPerRow ?? this.wigglesPerRow,
        wiggleOffset: wiggleOffset ?? this.wiggleOffset,
      );

  TableViewVerticalDividerStyle lerp(
          TableViewVerticalDividerStyle other, double t) =>
      TableViewVerticalDividerStyle(
        color: Color.lerp(color, other.color, t),
        thickness: lerpDouble(thickness, other.thickness, t),
        wigglesPerRow: // not sure about that
            lerpDouble(wigglesPerRow, other.wigglesPerRow, t)?.toInt(),
        wiggleOffset: lerpDouble(wiggleOffset, other.wiggleOffset, t),
      );
}

/// Defines a display style of scrollbars of a table.
@immutable
class TableViewScrollbarsStyle {
  /// Display style of a horizontal scrollbar.
  final TableViewScrollbarStyle? horizontal;

  /// Display style of a vertical scrollbar.
  final TableViewScrollbarStyle? vertical;

  const TableViewScrollbarsStyle({
    this.horizontal,
    this.vertical,
  });

  /// Initializes both [horizontal] and [vertical] styles using
  /// the same [TableViewScrollbarStyle].
  const TableViewScrollbarsStyle.symmetric(TableViewScrollbarStyle style)
      : horizontal = style,
        vertical = style;

  TableViewScrollbarsStyle copyWith({
    TableViewScrollbarStyle? horizontal,
    TableViewScrollbarStyle? vertical,
  }) =>
      TableViewScrollbarsStyle(
        horizontal: horizontal ?? this.horizontal,
        vertical: vertical ?? this.vertical,
      );

  TableViewScrollbarsStyle lerp(TableViewScrollbarsStyle other, double t) =>
      TableViewScrollbarsStyle(
        horizontal: horizontal == null || other.horizontal == null
            ? other.horizontal
            : horizontal!.lerp(other.horizontal!, t),
        vertical: vertical == null || other.vertical == null
            ? other.vertical
            : vertical!.lerp(other.vertical!, t),
      );
}

/// Defines a need to add a scrollbar.
enum TableViewScrollbarEnabled {
  /// Scrollbar is always displayed.
  always,

  /// Scrollbar is displayed only when the target platform is set to
  /// a desktop one.
  auto,

  /// Scrollbar is never displayed.
  never,
}

@immutable
class TableViewScrollbarStyle extends ScrollbarThemeData {
  /// Controls whether or not the scrollbar is displayed.
  /// Note that changing this property for a currently alive widget will lead
  /// to state loss and possibly to runtime errors.
  final TableViewScrollbarEnabled? enabled;

  /// If true, the corresponding scrollPadding value will be increased to allow
  /// the content to scroll out from underneath the scrollbar when it's shown.
  final bool? scrollPadding;

  /// Shorthand constructor for disabled scrollbar.
  /// Note that enabling/disabling scrollbar for a currently alive widget
  /// will lead to state loss and possibly to runtime errors.
  const TableViewScrollbarStyle.disabled()
      : enabled = TableViewScrollbarEnabled.never,
        scrollPadding = null,
        super();

  const TableViewScrollbarStyle({
    this.enabled,
    this.scrollPadding,
    super.crossAxisMargin,
    super.interactive,
    super.mainAxisMargin,
    super.minThumbLength,
    super.radius,
    super.showTrackOnHover,
    super.thickness,
    super.thumbColor,
    super.thumbVisibility,
    super.trackBorderColor,
    super.trackColor,
    super.trackVisibility,
  }) : assert(showTrackOnHover == null);

  @override
  TableViewScrollbarStyle copyWith({
    TableViewScrollbarEnabled? enabled,
    bool? scrollPadding,
    MaterialStateProperty<bool?>? thumbVisibility,
    MaterialStateProperty<double?>? thickness,
    MaterialStateProperty<bool?>? trackVisibility,
    bool? interactive,
    Radius? radius,
    MaterialStateProperty<Color?>? thumbColor,
    MaterialStateProperty<Color?>? trackColor,
    MaterialStateProperty<Color?>? trackBorderColor,
    double? crossAxisMargin,
    double? mainAxisMargin,
    double? minThumbLength,
    @Deprecated(
      'Use ScrollbarThemeData.trackVisibility to resolve based on the current state instead. '
      'This feature was deprecated after v3.4.0-19.0.pre.',
    )
    bool? showTrackOnHover,
  }) =>
      TableViewScrollbarStyle(
        enabled: enabled ?? this.enabled,
        scrollPadding: scrollPadding ?? this.scrollPadding,
        thumbVisibility: thumbVisibility ?? this.thumbVisibility,
        thickness: thickness ?? this.thickness,
        trackVisibility: trackVisibility ?? this.trackVisibility,
        interactive: interactive ?? this.interactive,
        radius: radius ?? this.radius,
        thumbColor: thumbColor ?? this.thumbColor,
        trackColor: trackColor ?? this.trackColor,
        trackBorderColor: trackBorderColor ?? this.trackBorderColor,
        crossAxisMargin: crossAxisMargin ?? this.crossAxisMargin,
        mainAxisMargin: mainAxisMargin ?? this.mainAxisMargin,
        minThumbLength: minThumbLength ?? this.minThumbLength,
      );

  TableViewScrollbarStyle lerp(TableViewScrollbarStyle other, double t) =>
      TableViewScrollbarStyle(
        enabled: _binaryLerp(enabled, other.enabled, t),
        thumbVisibility: MaterialStateProperty.lerp<bool?>(
            thumbVisibility, other.thumbVisibility, t, _binaryLerp),
        thickness: MaterialStateProperty.lerp<double?>(
            thickness, other.thickness, t, lerpDouble),
        trackVisibility: MaterialStateProperty.lerp<bool?>(
            trackVisibility, other.trackVisibility, t, _binaryLerp),
        interactive: _binaryLerp(interactive, other.interactive, t),
        radius: Radius.lerp(radius, other.radius, t),
        thumbColor: MaterialStateProperty.lerp<Color?>(
            thumbColor, other.thumbColor, t, Color.lerp),
        trackColor: MaterialStateProperty.lerp<Color?>(
            trackColor, other.trackColor, t, Color.lerp),
        trackBorderColor: MaterialStateProperty.lerp<Color?>(
            trackBorderColor, other.trackBorderColor, t, Color.lerp),
        crossAxisMargin: lerpDouble(crossAxisMargin, other.crossAxisMargin, t),
        mainAxisMargin: lerpDouble(mainAxisMargin, other.mainAxisMargin, t),
        minThumbLength: lerpDouble(minThumbLength, other.minThumbLength, t),
      );
}
