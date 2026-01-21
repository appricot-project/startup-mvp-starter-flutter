import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';
import 'package:startup_mvp_starter_flutter/settings/language_settings/bloc/language_settings_bloc.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/color_constants.dart';
import 'package:startup_mvp_starter_flutter/utils/constants/custom_text_style.dart';
import 'package:startup_mvp_starter_flutter/utils/extensions/sized_box.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/buttons/custom_button.dart';

class LanguageSettingsWidget extends StatefulWidget {
  @override
  State<LanguageSettingsWidget> createState() => _LanguageSettingsWidgetState();
}

class _LanguageSettingsWidgetState extends State<LanguageSettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.settingsChangeLanguage,
          style: CustomTextStyle.title1(),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<LanguageSettingsBloc, LanguageSettingsState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsetsGeometry.only(left: 8, right: 8, top: 8),
              child: Column(
                children: [
                  RadioGroup<Language>(
                    groupValue: state.language,
                    onChanged: (value) {
                      context.read<LanguageSettingsBloc>().add(
                        LanguageSettingsOnChangedLanguage(newLanguage: value!),
                      );
                    },
                    child: InkWell(
                      onTap: () {
                        context.read<LanguageSettingsBloc>().add(
                          LanguageSettingsOnChangedLanguage(
                            newLanguage: Language.ru,
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Radio<Language>(
                            value: Language.ru,
                            fillColor: WidgetStateProperty.resolveWith<Color>((
                              Set<WidgetState> states,
                            ) {
                              if (states.contains(WidgetState.selected)) {
                                return Colors.green;
                              }
                              return ColorConstants.primary;
                            }),
                          ),
                          6.w,
                          Text('Русский', style: CustomTextStyle.body1()),
                        ],
                      ),
                    ),
                  ),
                  RadioGroup<Language>(
                    groupValue: state.language,
                    onChanged: (value) {
                      context.read<LanguageSettingsBloc>().add(
                        LanguageSettingsOnChangedLanguage(newLanguage: value!),
                      );
                    },
                    child: InkWell(
                      onTap: () {
                        context.read<LanguageSettingsBloc>().add(
                          LanguageSettingsOnChangedLanguage(
                            newLanguage: Language.en,
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Radio<Language>(
                            value: Language.en,
                            fillColor: WidgetStateProperty.resolveWith<Color>((
                              Set<WidgetState> states,
                            ) {
                              if (states.contains(WidgetState.selected)) {
                                return Colors.green;
                              }
                              return ColorConstants.primary;
                            }),
                          ),
                          6.w,
                          Text('English', style: CustomTextStyle.body1()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsetsGeometry.only(left: 32),
        child: CustomButton(
          text: AppLocalizations.of(context)!.commonApply,
          onPressed: () {
            context.read<LanguageSettingsBloc>().add(LanguageSettingsOnApply());
          },
        ),
      ),
    );
  }
}
