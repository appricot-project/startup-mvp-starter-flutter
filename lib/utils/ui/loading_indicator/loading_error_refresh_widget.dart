import 'package:flutter/material.dart';

class LoadingErrorRefreshWidget extends StatelessWidget {
  final void Function() onRefresh;
  const LoadingErrorRefreshWidget({required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onRefresh,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SizedBox(
          //   width: 32,
          //   height: 32,
          //   child: PlatformComponents.refreshImage(),
          // ),
          // SizedBox(height: 4),
          Text(
            'Не удалось получить данные',
            textAlign: TextAlign.center,
            style: CustomTextStyle.body3(),
          ),
          SizedBox(height: 4),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // SizedBox(
                  //   width: 20,
                  //   height: 20,
                  //   child: PlatformComponents.refreshIcon(
                  //     color: ColorConstants.greenNormal,
                  //   ),
                  // ),
                  // 6.w,
                  Text(
                    'Попробовать ',
                    style: CustomTextStyle.buttonText(
                      color: ColorConstants.primary,
                    ),
                  ),
                ],
              ),
              Text(
                'еще раз',
                style: CustomTextStyle.buttonText(
                  color: ColorConstants.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
