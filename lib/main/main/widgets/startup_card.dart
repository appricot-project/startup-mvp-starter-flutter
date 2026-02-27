import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/main/main/models/startup_model.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/color_constants.dart';
import 'package:startup_mvp_starter_flutter/utils/extensions/sized_box.dart';

class StartupCard extends StatelessWidget {
  final StartupModel startup;
  final isFavorite;
  final isViewed;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;
  const StartupCard({
    super.key,
    required this.startup,
    required this.isFavorite,
    required this.isViewed,
    required this.onTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: isViewed ? 0.5 : 1,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Builder(
                    builder: (context) {
                      if (startup.imageUrl != null) {
                        return Center(
                          child: SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                              imageUrl: startup.imageUrl!,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: Container(
                            height: 200,
                            color: ColorConstants.border,
                          ),
                        );
                      }
                    },
                  ),
                  8.h,
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      left: 8,
                      right: 8,
                      bottom: 4,
                    ),
                    child: Text(
                      startup.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  4.h,
                  Padding(
                    padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                    child: Text(
                      startup.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: onFavoriteTap,
            icon: isFavorite
                ? Icon(Icons.favorite, color: Colors.red)
                : Icon(Icons.favorite_outline, color: Colors.red),
          ),
        ),
      ],
    );
  }
}
