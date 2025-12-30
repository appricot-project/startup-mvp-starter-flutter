import 'package:flutter/material.dart';
import 'package:startup_mvp_starter_flutter/auth/sign_in/page/sign_in_page.dart';
import 'package:startup_mvp_starter_flutter/l10n/app_localizations.dart';
import 'package:startup_mvp_starter_flutter/utils/extensions/sized_box.dart';
import 'package:startup_mvp_starter_flutter/utils/funcs/custom_modal_bottom_sheet.dart';
import 'package:startup_mvp_starter_flutter/utils/localization_cubit.dart';
import 'package:startup_mvp_starter_flutter/utils/service_locator.dart';
import 'package:startup_mvp_starter_flutter/utils/theme_cubit.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/buttons/custom_button.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/buttons/custom_icon_button.dart';
import 'package:startup_mvp_starter_flutter/utils/ui/text_fields/basic_text_field.dart';

class UiTestingWidget extends StatefulWidget {
  const UiTestingWidget();

  @override
  State<StatefulWidget> createState() => _UiTestingWidgetState();
}

class _UiTestingWidgetState extends State<UiTestingWidget> {
  int selectedItem = 0;
  // List<CheckBoxState> states = [
  //   CheckBoxState.almostOff,
  //   CheckBoxState.off,
  //   CheckBoxState.on,
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  10.h,
                  CustomButton(
                    text: AppLocalizations.of(context)!.settingsChangeLanguage,
                    onPressed: () {
                      if (locator<LocalizationCubit>().state == 'en') {
                        locator<LocalizationCubit>().changeLocalize("ru");
                      } else {
                        locator<LocalizationCubit>().changeLocalize("en");
                      }
                    },
                    color: ButtonColor.primary,
                  ),
                  10.h,
                  CustomButton(
                    text: AppLocalizations.of(context)!.settingsLightTheme,
                    onPressed: () {
                      locator<ThemeCubit>().changeTheme(CustomTheme.light);
                    },
                    color: ButtonColor.secondary,
                  ),
                  10.h,
                  CustomButton(
                    text: AppLocalizations.of(context)!.settingsDarkTheme,
                    onPressed: () {
                      locator<ThemeCubit>().changeTheme(CustomTheme.dark);
                    },
                    color: ButtonColor.secondary,
                  ),
                  10.h,
                  CustomButton(
                    text: AppLocalizations.of(context)!.settingsSystemTheme,
                    onPressed: () {
                      locator<ThemeCubit>().changeTheme(CustomTheme.system);
                    },
                    color: ButtonColor.secondary,
                  ),
                  10.h,
                  CustomButton(
                    text: AppLocalizations.of(context)!.authLogout,
                    onPressed: () {},
                    color: ButtonColor.tertiary,
                  ),
                  10.h,
                  CustomButton(
                    text: AppLocalizations.of(context)!.authSignin,
                    onPressed: () {
                      showMyModalBottomSheet(
                        context: context,
                        widget: SignInPage(),
                      );
                    },
                    color: ButtonColor.primary,
                    size: ButtonSize.small,
                    subtitle: 'Subtitle',
                  ),
                  10.h,
                  CustomIconButton(
                    onPressed: () {},
                    icon: Container(height: 50, width: 50, color: Colors.green),
                  ),
                  10.h,
                  CustomIconButton(
                    onPressed: () {},
                    icon: Container(height: 50, width: 50, color: Colors.green),
                    color: ButtonColor.secondary,
                  ),
                  10.h,
                  CustomIconButton(
                    onPressed: () {},
                    icon: Container(height: 50, width: 50, color: Colors.green),
                    isEnabled: false,
                  ),
                  10.h,
                  CustomButton(
                    text: 'primary',
                    onPressed: () {},
                    isEnabled: false,
                  ),
                  10.h,
                  CustomButton(
                    text: 'secondary',
                    onPressed: () {},
                    color: ButtonColor.secondary,
                    isEnabled: false,
                  ),
                  10.h,
                  CustomButton(
                    text: 'tertiary',
                    onPressed: () {},
                    color: ButtonColor.tertiary,
                    isEnabled: false,
                  ),
                  10.h,
                  Container(
                    padding: EdgeInsets.all(4),
                    child: BasicTextField(
                      hintText: "hintText",
                      onChanged: (value) {},
                      label: "Label",
                      isClearable: true,
                      suggestions: ['one', 'two', 'three'],
                    ),
                  ),
                  10.h,
                  Container(
                    padding: EdgeInsets.all(4),
                    child: BasicTextField(
                      hintText: "hintText",
                      onChanged: (value) {},
                      label: "Label",
                      error: "Error",
                    ),
                  ),
                  10.h,
                  Container(
                    padding: EdgeInsets.all(4),
                    child: BasicTextField(
                      isEnabled: false,
                      hintText: "hintText",
                      onChanged: (value) {},
                      label: "Label",
                      error: "Error",
                    ),
                  ),
                  10.h,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
