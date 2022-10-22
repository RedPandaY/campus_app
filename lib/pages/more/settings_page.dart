import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:campus_app/core/themes.dart';
import 'package:campus_app/core/settings.dart';
import 'package:campus_app/utils/widgets/campus_icon_button.dart';
import 'package:campus_app/utils/widgets/animated_conditional.dart';
import 'package:campus_app/pages/more/widgets/leading_text_switch.dart';

/// This page displays the app settings
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late Settings _settings;

  final GlobalKey<AnimatedConditionalState> _darkmodeAnimationKey = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _settings = Provider.of<SettingsHandler>(context).currentSettings;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<ThemesNotifier>(context).currentThemeData.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Column(
          children: [
            // Back button & page title
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: SizedBox(
                width: double.infinity,
                child: Stack(
                  children: [
                    CampusIconButton(
                      iconPath: 'assets/img/icons/arrow-left.svg',
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Align(
                      child: Text(
                        'Einstellungen',
                        style: Provider.of<ThemesNotifier>(context).currentThemeData.textTheme.displayMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Imprint
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SectionHeadline(headline: 'Theming'),
                  // System Darkmode
                  LeadingTextSwitch(
                    text: 'System Darkmode',
                    isActive: Provider.of<SettingsHandler>(context).currentSettings.useSystemDarkmode,
                    onToggle: (switchValue) {
                      Provider.of<SettingsHandler>(context, listen: false).currentSettings =
                          _settings.copyWith(useSystemDarkmode: switchValue);

                      if (switchValue) {
                        _darkmodeAnimationKey.currentState?.animateOut();
                      } else {
                        _darkmodeAnimationKey.currentState?.animateIn();
                      }
                    },
                  ),
                  // Darkmode ~  !! Still not ideal, only animates in, not out
                  Offstage(
                    offstage: Provider.of<SettingsHandler>(context).currentSettings.useSystemDarkmode,
                    child: AnimatedConditional(
                      key: _darkmodeAnimationKey,
                      child: LeadingTextSwitch(
                        text: 'Darkmode',
                        isActive: Provider.of<SettingsHandler>(context).currentSettings.useDarkmode,
                        onToggle: (switchValue) {
                          Provider.of<SettingsHandler>(context, listen: false).currentSettings =
                              _settings.copyWith(useDarkmode: switchValue);
                        },
                      ),
                    ),
                  ),
                  const SectionHeadline(headline: 'Verhalten'),
                  // External Browser
                  LeadingTextSwitch(
                    text: 'Verwende externen Browser für Links',
                    isActive: Provider.of<SettingsHandler>(context).currentSettings.useExternalBrowser,
                    onToggle: (switchValue) {
                      Provider.of<SettingsHandler>(context, listen: false).currentSettings =
                          _settings.copyWith(useExternalBrowser: switchValue);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// This widget displays a single section headline in the settings page
class SectionHeadline extends StatelessWidget {
  final String headline;

  const SectionHeadline({
    Key? key,
    required this.headline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      child: Text(
        headline,
        textAlign: TextAlign.left,
        style: Provider.of<ThemesNotifier>(context).currentThemeData.textTheme.headlineSmall,
      ),
    );
  }
}