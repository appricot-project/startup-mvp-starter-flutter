import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/loading_indicator/loading_error_refresh_widget.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/loading_indicator/my_circular_progress_indicator.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/loading_indicator/my_refresh_indicator.dart';

class LoadingIndicator extends StatelessWidget {
  final bool? initialLoading;
  final bool? loadingMoreData;
  final bool? loading;
  final bool? error;
  final Function()? onRefresh;
  final Future<void> Function()? onPullToRefresh;
  final ScrollController? scrollController;
  final Widget child;
  final bool? hasReachedMax;
  final RefreshController? refreshController;
  final Widget? pinnedWidget;
  final Widget? bottomStickyWidget;

  const LoadingIndicator({
    super.key,
    this.initialLoading,
    this.loading,
    this.loadingMoreData,
    this.hasReachedMax,
    this.error,
    this.scrollController,
    this.refreshController,
    this.pinnedWidget,
    this.onRefresh,
    this.onPullToRefresh,
    required this.child,
    this.bottomStickyWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (error == true) {
      return Center(
        child: LoadingErrorRefreshWidget(onRefresh: () => onRefresh?.call()),
      );
    } else if (initialLoading == true) {
      return const MyCircularProgressIndicator();
    } else {
      return Stack(
        children: [
          Opacity(
            opacity: loading == true ? 0.5 : 1.0,
            child: onPullToRefresh == null
                ? child
                : MyRefreshIndicator(
                    loadingMoreData: loadingMoreData,
                    scrollController: scrollController,
                    refreshController: refreshController,
                    hasReachedMax: hasReachedMax,
                    pinnedWidget: pinnedWidget,
                    onRefresh: onPullToRefresh!,
                    child: child,
                    bottomStickyWidget: bottomStickyWidget,
                  ),
          ),
          if (loading == true)
            AbsorbPointer(
              absorbing: true,
              child: Container(color: Colors.transparent),
            ),
          if (loading == true) const MyCircularProgressIndicator(),
        ],
      );
    }
  }
}
