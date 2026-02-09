import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/platform_components.dart';

class SettingsItemWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const SettingsItemWidget({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed.call,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyLarge),
            PlatformComponents.arrowRightIcon(),
          ],
        ),
      ),
    );
  }
}
