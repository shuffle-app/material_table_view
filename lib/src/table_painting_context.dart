import 'package:flutter/rendering.dart';
import 'package:material_table_view/src/table_placeholder_shade.dart';

/// Storage class that holds a pair of layers to be used for cell painting.
class TablePaintingLayerPair {
  final PaintingContext fixed, scrolled;

  TablePaintingLayerPair({
    required this.fixed,
    required this.scrolled,
  }) {
    fixed.setIsComplexHint();
    fixed.setWillChangeHint();

    scrolled.setIsComplexHint();
    scrolled.setWillChangeHint();
  }
}

/// A subclass of a [PaintingContext] used to implement custom painting
/// composition of a table.
class TablePaintingContext extends PaintingContext {
  TablePaintingContext({
    required ContainerLayer mainLayer,
    required PaintingContext context,
    required Path scrolledClipPath,
    required TablePlaceholderShade? placeholderShade,
    required Offset offset,
    required Size size,
  }) : super(mainLayer, context.estimatedBounds) {
    final regularFixed = mainLayer;
    final regularScrolled = ClipPathLayer(clipPath: scrolledClipPath);

    context.addLayer(regularFixed);
    context.addLayer(regularScrolled);

    regular = TablePaintingLayerPair(
        fixed: PaintingContext(regularFixed, context.estimatedBounds),
        scrolled: PaintingContext(regularScrolled, context.estimatedBounds));

    if (placeholderShade == null) {
      placeholderShaderContext = null;
      _placeholder = regular;
    } else {
      final layer = ShaderMaskLayer()
        ..blendMode = placeholderShade.blendMode
        ..maskRect = offset & size
        ..shader = placeholderShade.shaderCallback(Offset.zero & size);

      final placeholderFixed = ContainerLayer();
      final placeholderScrolled = ClipPathLayer(clipPath: scrolledClipPath);

      placeholderShaderContext = PaintingContext(layer, context.estimatedBounds)
        ..addLayer(placeholderFixed)
        ..addLayer(placeholderScrolled);

      context.addLayer(layer);

      _placeholder = TablePaintingLayerPair(
          fixed: PaintingContext(placeholderFixed, context.estimatedBounds),
          scrolled:
              PaintingContext(placeholderScrolled, context.estimatedBounds));
    }
  }

  late final TablePaintingLayerPair regular, _placeholder;
  late final PaintingContext? placeholderShaderContext;
  var _placeholderLayersUsed = false;

  TablePaintingLayerPair get placeholder {
    _placeholderLayersUsed = true;
    return _placeholder;
  }

  bool get placeholderLayersUsed => _placeholderLayersUsed;

  @override
  VoidCallback addCompositionCallback(CompositionCallback callback) =>
      throw UnimplementedError();

  @override
  void addLayer(Layer layer) => throw UnimplementedError();

  @override
  void appendLayer(Layer layer) => throw UnimplementedError();

  @override
  void clipPathAndPaint(
          Path path, Clip clipBehavior, Rect bounds, VoidCallback painter) =>
      throw UnimplementedError();

  @override
  void clipRRectAndPaint(
          RRect rrect, Clip clipBehavior, Rect bounds, VoidCallback painter) =>
      throw UnimplementedError();

  @override
  void clipRectAndPaint(
          Rect rect, Clip clipBehavior, Rect bounds, VoidCallback painter) =>
      throw UnimplementedError();

  @override
  PaintingContext createChildContext(ContainerLayer childLayer, Rect bounds) =>
      throw UnimplementedError();

  @override
  void paintChild(RenderObject child, Offset offset) {
    assert(!child.isRepaintBoundary);
    assert(!child.needsCompositing);

    super.paintChild(child, offset);
  }

  @override
  ClipPathLayer? pushClipPath(bool needsCompositing, Offset offset, Rect bounds,
          Path clipPath, PaintingContextCallback painter,
          {Clip clipBehavior = Clip.antiAlias, ClipPathLayer? oldLayer}) =>
      throw UnimplementedError();

  @override
  ClipRRectLayer? pushClipRRect(bool needsCompositing, Offset offset,
          Rect bounds, RRect clipRRect, PaintingContextCallback painter,
          {Clip clipBehavior = Clip.antiAlias, ClipRRectLayer? oldLayer}) =>
      throw UnimplementedError();

  @override
  ClipRectLayer? pushClipRect(bool needsCompositing, Offset offset,
          Rect clipRect, PaintingContextCallback painter,
          {Clip clipBehavior = Clip.hardEdge, ClipRectLayer? oldLayer}) =>
      throw UnimplementedError();

  @override
  ColorFilterLayer pushColorFilter(Offset offset, ColorFilter colorFilter,
          PaintingContextCallback painter,
          {ColorFilterLayer? oldLayer}) =>
      throw UnimplementedError();

  @override
  void pushLayer(ContainerLayer childLayer, PaintingContextCallback painter,
          Offset offset,
          {Rect? childPaintBounds}) =>
      throw UnimplementedError();

  @override
  OpacityLayer pushOpacity(
          Offset offset, int alpha, PaintingContextCallback painter,
          {OpacityLayer? oldLayer}) =>
      throw UnimplementedError();

  @override
  TransformLayer? pushTransform(bool needsCompositing, Offset offset,
          Matrix4 transform, PaintingContextCallback painter,
          {TransformLayer? oldLayer}) =>
      throw UnimplementedError();

  @override
  void setIsComplexHint() {}

  @override
  void setWillChangeHint() {}

  @override
  void stopRecordingIfNeeded() {
    super.stopRecordingIfNeeded(); // this is unnecessary but whatever

    regular.fixed.stopRecordingIfNeeded();
    regular.scrolled.stopRecordingIfNeeded();
    _placeholder.fixed.stopRecordingIfNeeded();
    _placeholder.scrolled.stopRecordingIfNeeded();
    placeholderShaderContext?.stopRecordingIfNeeded();
  }
}
