import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';
import 'package:startup_mvp_starter_flutter/settings/theme_settings/bloc/theme_settings_bloc.dart';
import 'package:startup_mvp_starter_flutter/utils/extensions/sized_box.dart';
import 'package:startup_mvp_starter_flutter/utils/theme_cubit.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/buttons/custom_button.dart';

class ThemeSettingsWidgets extends StatefulWidget {
  @override
  State<ThemeSettingsWidgets> createState() => _ThemeSettingsWidgetState();
}

class _ThemeSettingsWidgetState extends State<ThemeSettingsWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.settingsChangeTheme,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<ThemeSettingsBloc, ThemeSettingsState>(
          builder: (context, state) {
            return BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, theme) {
                return Padding(
                  padding: EdgeInsetsGeometry.only(left: 8, right: 8, top: 8),
                  child: Column(
                    children: [
                      RadioGroup<ThemeMode>(
                        groupValue: state.theme,
                        onChanged: (value) {
                          context.read<ThemeSettingsBloc>().add(
                            ThemeSettingsOnChangedTheme(newTheme: value!),
                          );
                        },
                        child: InkWell(
                          onTap: () {
                            context.read<ThemeSettingsBloc>().add(
                              ThemeSettingsOnChangedTheme(
                                newTheme: ThemeMode.light,
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Radio<ThemeMode>(
                                value: ThemeMode.light,
                                fillColor:
                                    WidgetStateProperty.resolveWith<Color>((
                                      Set<WidgetState> states,
                                    ) {
                                      if (states.contains(
                                        WidgetState.selected,
                                      )) {
                                        return Colors.green;
                                      }
                                      return Theme.of(context).primaryColor;
                                    }),
                              ),
                              6.w,
                              Text(
                                AppLocalizations.of(
                                  context,
                                )!.settingsLightTheme,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                      RadioGroup<ThemeMode>(
                        groupValue: state.theme,
                        onChanged: (value) {
                          context.read<ThemeSettingsBloc>().add(
                            ThemeSettingsOnChangedTheme(newTheme: value!),
                          );
                        },
                        child: InkWell(
                          onTap: () {
                            context.read<ThemeSettingsBloc>().add(
                              ThemeSettingsOnChangedTheme(
                                newTheme: ThemeMode.dark,
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Radio<ThemeMode>(
                                value: ThemeMode.dark,
                                fillColor:
                                    WidgetStateProperty.resolveWith<Color>((
                                      Set<WidgetState> states,
                                    ) {
                                      if (states.contains(
                                        WidgetState.selected,
                                      )) {
                                        return Colors.green;
                                      }
                                      return Theme.of(context).primaryColor;
                                    }),
                              ),
                              6.w,
                              Text(
                                AppLocalizations.of(context)!.settingsDarkTheme,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                      RadioGroup<ThemeMode>(
                        groupValue: state.theme,
                        onChanged: (value) {
                          context.read<ThemeSettingsBloc>().add(
                            ThemeSettingsOnChangedTheme(newTheme: value!),
                          );
                        },
                        child: InkWell(
                          onTap: () {
                            context.read<ThemeSettingsBloc>().add(
                              ThemeSettingsOnChangedTheme(
                                newTheme: ThemeMode.system,
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Radio<ThemeMode>(
                                value: ThemeMode.system,
                                fillColor:
                                    WidgetStateProperty.resolveWith<Color>((
                                      Set<WidgetState> states,
                                    ) {
                                      if (states.contains(
                                        WidgetState.selected,
                                      )) {
                                        return Colors.green;
                                      }
                                      return Theme.of(context).primaryColor;
                                    }),
                              ),
                              6.w,
                              Text(
                                AppLocalizations.of(
                                  context,
                                )!.settingsSystemTheme,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsetsGeometry.only(left: 32),
        child: CustomButton(
          text: AppLocalizations.of(context)!.commonApply,
          onPressed: () {
            context.read<ThemeSettingsBloc>().add(ThemeSettingsOnApply());
            setState(() {});
          },
        ),
      ),
    );
  }
}
