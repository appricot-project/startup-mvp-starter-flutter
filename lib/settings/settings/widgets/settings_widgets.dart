import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';
import 'package:startup_mvp_starter_flutter/navigation/app_router.dart';
import 'package:startup_mvp_starter_flutter/settings/settings/bloc/settings_bloc.dart';
import 'package:startup_mvp_starter_flutter/settings/settings/widgets/settings_item_widget.dart';
import 'package:startup_mvp_starter_flutter/utils/extensions/sized_box.dart';

class SettingsWidgets extends StatefulWidget {
  @override
  State<SettingsWidgets> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidgets> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is SettingsShowView) {
          switch (state.key) {
            case ViewKey.language:
              context.pushRoute(LanguageSettingsRoute()).then((_) {
                context.read<SettingsBloc>().add(SettingsOnReturned());
              });
            case ViewKey.theme:
              context.pushRoute(ThemeSettingsRoute()).then((_) {
                context.read<SettingsBloc>().add(SettingsOnReturned());
              });
            case ViewKey.notifications:
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.navigationSettings,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsetsGeometry.only(left: 8, right: 8, top: 8),
                child: Column(
                  children: [
                    SettingsItemWidget(
                      title: AppLocalizations.of(context)!.settingsLanguage,
                      onPressed: () {
                        context.read<SettingsBloc>().add(
                          SettingsOnTapItem(key: ActionKey.language),
                        );
                      },
                    ),
                    8.h,
                    SettingsItemWidget(
                      title: AppLocalizations.of(context)!.settingsTheme,
                      onPressed: () {
                        context.read<SettingsBloc>().add(
                          SettingsOnTapItem(key: ActionKey.theme),
                        );
                      },
                    ),
                    8.h,
                    SettingsItemWidget(
                      title: AppLocalizations.of(
                        context,
                      )!.settingsNotifications,
                      onPressed: () {
                        context.read<SettingsBloc>().add(
                          SettingsOnTapItem(key: ActionKey.notifications),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
