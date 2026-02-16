import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:startup_mvp_starter_flutter/main/main_details/bloc/main_details_bloc.dart';
import 'package:startup_mvp_starter_flutter/navigation/route_visibility.dart';
import 'package:startup_mvp_starter_flutter/utils/extensions/sized_box.dart';
import 'package:startup_mvp_starter_flutter/utils/funcs/show_error_alert.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/loading_indicator/loading_indicator.dart';

class MainDetailsWidget extends StatefulWidget {
  const MainDetailsWidget();

  @override
  State<MainDetailsWidget> createState() => _MainDetailsWidgetState();
}

class _MainDetailsWidgetState extends State<MainDetailsWidget>
    with RouteVisibility<MainDetailsWidget> {
  late RefreshController _refreshController;

  @override
  void didBecomeActive() {
    context.read<MainDetailsBloc>().add(MainDetailsOnPullToRefresh());
  }

  @override
  void initState() {
    _refreshController = RefreshController();
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainDetailsBloc, MainDetailsState>(
      listener: (context, state) {
        if (state is MainDetailsError) {
          showErrorAlert(context: context, error: state.error);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            BlocBuilder<MainDetailsBloc, MainDetailsState>(
              builder: (context, state) {
                return Visibility(
                  visible: state.loading != Loading.initial,
                  child: IconButton(
                    onPressed: () {
                      context.read<MainDetailsBloc>().add(
                        MainDetailsOnFavoriteTapped(),
                      );
                    },
                    icon: state.model?.isFavorite == true
                        ? Icon(Icons.favorite, color: Colors.red)
                        : Icon(Icons.favorite_outline, color: Colors.red),
                  ),
                );
              },
            ),
          ],
        ),
        body: SafeArea(
          child: BlocBuilder<MainDetailsBloc, MainDetailsState>(
            builder: (context, state) {
              return LoadingIndicator(
                initialLoading: state.loading == Loading.initial,
                refreshController: _refreshController,
                onPullToRefresh: () async {
                  final bloc = context.read<MainDetailsBloc>();
                  final future = bloc.stream.firstWhere(
                    (state) => state.loading != Loading.refresh,
                  );
                  bloc.add(MainDetailsOnPullToRefresh());
                  await future;
                  _refreshController.refreshCompleted();
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      bottom: 76,
                      left: 16,
                      right: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.model?.imageUrl?.isNotEmpty ?? false)
                          Container(
                            padding: const EdgeInsets.only(bottom: 24),
                            alignment: Alignment.center,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: state.model!.imageUrl!,
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        if (state.model?.name.isNotEmpty ?? false)
                          Text(
                            state.model!.name,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        16.h,
                        if (state.model?.description.isNotEmpty ?? false)
                          Text(
                            state.model!.description,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
