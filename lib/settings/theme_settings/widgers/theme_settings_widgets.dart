import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';
import 'package:startup_mvp_starter_flutter/settings/theme_settings/bloc/theme_settings_bloc.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/color_constants.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/custom_text_style.dart';
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
          style: CustomTextStyle.title1(),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<ThemeSettingsBloc, ThemeSettingsState>(
          builder: (context, state) {
            return BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, theme) {
                return Padding(
                  padding: EdgeInsetsGeometry.only(left: 8, right: 8, top: 8),
                  child: Column(
                    children: [
                      RadioGroup<CustomTheme>(
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
                                newTheme: CustomTheme.light,
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Radio<CustomTheme>(
                                value: CustomTheme.light,
                                fillColor:
                                    WidgetStateProperty.resolveWith<Color>((
                                      Set<WidgetState> states,
                                    ) {
                                      if (states.contains(
                                        WidgetState.selected,
                                      )) {
                                        return Colors.green;
                                      }
                                      return ColorConstants.primary;
                                    }),
                              ),
                              6.w,
                              Text(
                                AppLocalizations.of(
                                  context,
                                )!.settingsLightTheme,
                                style: CustomTextStyle.body1(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      RadioGroup<CustomTheme>(
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
                                newTheme: CustomTheme.dark,
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Radio<CustomTheme>(
                                value: CustomTheme.dark,
                                fillColor:
                                    WidgetStateProperty.resolveWith<Color>((
                                      Set<WidgetState> states,
                                    ) {
                                      if (states.contains(
                                        WidgetState.selected,
                                      )) {
                                        return Colors.green;
                                      }
                                      return ColorConstants.primary;
                                    }),
                              ),
                              6.w,
                              Text(
                                AppLocalizations.of(context)!.settingsDarkTheme,
                                style: CustomTextStyle.body1(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      RadioGroup<CustomTheme>(
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
                                newTheme: CustomTheme.system,
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Radio<CustomTheme>(
                                value: CustomTheme.system,
                                fillColor:
                                    WidgetStateProperty.resolveWith<Color>((
                                      Set<WidgetState> states,
                                    ) {
                                      if (states.contains(
                                        WidgetState.selected,
                                      )) {
                                        return Colors.green;
                                      }
                                      return ColorConstants.primary;
                                    }),
                              ),
                              6.w,
                              Text(
                                AppLocalizations.of(
                                  context,
                                )!.settingsSystemTheme,
                                style: CustomTextStyle.body1(),
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
