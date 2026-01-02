import 'package:flutter/material.dart';
import '../../core/theme/app_theme_colors.dart';

class AppBottomSheet extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double? height;
  final bool draggable;
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final bool autoSize;

  const AppBottomSheet({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.height,
    this.draggable = true,
    this.initialChildSize = 0.45,
    this.minChildSize = 0.01,
    this.maxChildSize = 0.50,
    this.autoSize = true,
  });

  @override
  State<AppBottomSheet> createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends State<AppBottomSheet> {
  final GlobalKey _contentKey = GlobalKey();
  final DraggableScrollableController _dragController =
      DraggableScrollableController();
  double? _contentHeight;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measureContent();
    });
  }

  void _measureContent() {
    final context = _contentKey.currentContext;
    if (context == null) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;
    final height = box.size.height;
    if (_contentHeight != height) {
      setState(() {
        _contentHeight = height;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppThemeColors>()!;
    final screenHeight = MediaQuery.of(context).size.height;
    final availableHeight = screenHeight * 0.88;
    final contentSize = _contentHeight ?? (availableHeight * widget.initialChildSize);
    final contentRatio = (contentSize / availableHeight).clamp(0.1, 0.9);
    final resolvedPadding =
        widget.padding.resolve(Directionality.of(context));
    const handleContainerHeight = 24.0;
    final requiredMinHeight = resolvedPadding.vertical + handleContainerHeight;
    final requiredMinRatio =
        (requiredMinHeight / availableHeight).clamp(0.06, 0.3);
    final minRatio = widget.minChildSize > requiredMinRatio
        ? widget.minChildSize
        : requiredMinRatio;
    final maxRatio = widget.autoSize
        ? (contentRatio * 1.05).clamp(0.2, 0.85)
        : widget.maxChildSize;
    final initialRatio = widget.autoSize
        ? contentRatio.clamp(minRatio, maxRatio)
        : widget.initialChildSize;

    void snapToNearest() {
      final size = _dragController.size;
      final snapSizes = [minRatio, initialRatio, maxRatio];
      snapSizes.sort();
      double nearest = snapSizes.first;
      for (final s in snapSizes) {
        if ((size - s).abs() < (size - nearest).abs()) {
          nearest = s;
        }
      }
      _dragController.animateTo(
        nearest,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
      );
    }

    Widget sheetContent(Widget? scrollChild) {
      return Container(
        height: widget.height,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: colors.shadow.withOpacity(0.25),
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => _dragController.animateTo(
                initialRatio,
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
              ),
              onVerticalDragUpdate: (details) {
                final delta = details.primaryDelta ?? 0;
                final next = (_dragController.size -
                        (delta / availableHeight))
                    .clamp(minRatio, maxRatio);
                _dragController.jumpTo(next);
              },
              onVerticalDragEnd: (_) => snapToNearest(),
              child: Container(
                height: 24,
                alignment: Alignment.center,
                child: Container(
                  width: 44,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: colors.shadow.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            if (scrollChild != null)
              Expanded(child: scrollChild)
            else
              KeyedSubtree(
                key: _contentKey,
                child: widget.child,
              ),
          ],
        ),
      );
    }

    if (!widget.draggable) {
      return sheetContent(null);
    }

    return DraggableScrollableSheet(
      controller: _dragController,
      snap: true,
      snapSizes: [
        minRatio,
        initialRatio,
        maxRatio,
      ],
      initialChildSize: initialRatio,
      minChildSize: minRatio,
      maxChildSize: maxRatio,
      builder: (context, scrollController) {
        return sheetContent(
          SingleChildScrollView(
            controller: scrollController,
            child: widget.child,
          ),
        );
      },
    );
  }
}
