import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:startup_mvp_starter_flutter/utils/extensions/sized_box.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/loading_indicator/my_circular_progress_indicator.dart';

class MyRefreshIndicator extends StatefulWidget {
  final Future<void> Function() onRefresh;
  final Widget child;
  final RefreshController? refreshController;
  final Widget? pinnedWidget;
  final bool? loadingMoreData;
  final bool? hasReachedMax;
  final ScrollController? scrollController;
  final Widget? bottomStickyWidget;

  const MyRefreshIndicator({
    super.key,
    required this.pinnedWidget,
    this.loadingMoreData,
    this.hasReachedMax,
    required this.scrollController,
    required this.refreshController,
    required this.onRefresh,
    required this.child,
    this.bottomStickyWidget,
  });

  @override
  State<StatefulWidget> createState() {
    return _MyRefreshIndicatorState();
  }
}

class _MyRefreshIndicatorState extends State<MyRefreshIndicator> {
  final GlobalKey _widgetKey = GlobalKey();
  double? pinnedWidgetHeight;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _calculateHeight();
        });
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: ClassicHeader(
            idleText: '',
            refreshingText: '',
            failedText: '',
            releaseText: '',
            completeText: '',
          ),
          controller: widget.refreshController ?? RefreshController(),
          onRefresh: widget.onRefresh,
          child: CustomScrollView(
            controller: widget.scrollController,
            slivers: <Widget>[
              if (widget.pinnedWidget != null)
                SliverAppBar(
                  toolbarHeight: pinnedWidgetHeight ?? 60,
                  leading: Container(),
                  leadingWidth: 0,
                  pinned: true,
                  floating: true,
                  backgroundColor: Colors.white,
                  shadowColor: Colors.black.withAlpha(180),
                  title: Container(
                    key: _widgetKey,
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: widget.pinnedWidget ?? Container(),
                  ),
                ),
              widget.child is SliverMultiBoxAdaptorWidget
                  ? SliverPadding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 16,
                      ),
                      sliver: widget.child,
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => widget.child,
                        childCount: 1,
                      ),
                    ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    if (widget.loadingMoreData ?? false)
                      Center(child: MyCircularProgressIndicator()),
                    if (!(widget.hasReachedMax ?? true)) 24.h,
                  ],
                ),
              ),
              if (widget.bottomStickyWidget != null)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: widget.bottomStickyWidget,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _calculateHeight() {
    final RenderBox? renderBox =
        _widgetKey.currentContext?.findRenderObject() as RenderBox?;
    double? calculatedHeight = renderBox?.size.height;
    if (calculatedHeight != pinnedWidgetHeight) {
      setState(() {
        pinnedWidgetHeight = calculatedHeight;
      });
    }
  }
}
