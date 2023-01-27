import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:system_theme/system_theme.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'AppBar/app_bar.dart';
import 'Section/01_home.dart';
import 'Section/02_students.dart';
import 'Section/98_settings.dart';
import 'Section/xx_my_playground.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();        // Initialize
  Costaz.is_dark = SystemTheme.isDarkMode;          // Dark Mode
  Window.initialize().then((_) async {
    Future<WindowEffect> adaptiveEffect() async {
      var info = await DeviceInfoPlugin().windowsInfo;

      // High than 22523 is Windows 11 22H2 -> tabbed
      // Less than 22523 is Windows 11 22H1 -> mica
      // Less than 22000 is Windows 10 any  -> acrylic
      // Less than 10240 is Deprecated      -> solid
      return info.buildNumber > 22523
          ? WindowEffect.tabbed
          : info.buildNumber >= 22000
          ? WindowEffect.mica
          : info.buildNumber >= 10240
          ? WindowEffect.acrylic
          : WindowEffect.solid;
    }
    await Window.setEffect(effect: await adaptiveEffect());
  });        // Set Window Effect
  runApp(const Costaz());                           // Run App
}

class Costaz extends StatefulWidget {
  const Costaz({Key? key}) : super(key: key);
  static AccentColor my_accent = Colors.blue;
  static var my_page = 0;
  static var is_dark = true;

  @override
  State<Costaz> createState() => _CostazState();
}

class _CostazState extends State<Costaz> {
  void change_theme(bool? val) => setState(() => Costaz.is_dark = val as bool);

  @override
  Widget build(BuildContext context) => FluentApp(
      debugShowCheckedModeBanner: false,
      theme: (Costaz.is_dark ? ThemeData.dark() : ThemeData.light()).copyWith(
        accentColor: SystemTheme.accentColor.accent.toAccentColor(),
        navigationPaneTheme: NavigationPaneThemeData(
          backgroundColor: Costaz.is_dark
              ? Colors.transparent
              : null,
        )
      ),
      home: NavigationView(
        appBar: const NavigationAppBar(
          title: TheAppBar(),
        ),
        pane: NavigationPane(
            size: const NavigationPaneSize(openMaxWidth: 250),
            selected: Costaz.my_page,
            onChanged: (i) => setState(() => Costaz.my_page = i),
            items: [
              PaneItem(
                icon: const Icon(FluentIcons.home),
                title: const Text("Home"),
                body: const TheSweetHome(),
              ),    // Home Page
              PaneItem(
                icon: const Icon(FluentIcons.education),
                title: const Text("Students"),
                body: const DearStudents(),
              )
            ],
            footerItems: [
              PaneItem(
                icon: const Icon(FluentIcons.play),
                title: const Text("Playground"),
                body: const ThePlayground(),
              ),
              PaneItem(
                icon: const Icon(FluentIcons.settings),
                title: const Text("Settings"),
                body: TheSettings(
                  dark_enabled: Costaz.is_dark,
                  theme_change: change_theme,
                ),
              ),    // Settings
              PaneItem(
                icon: const Icon(FluentIcons.accounts),
                title: const Text("Account"),
                body: Container(),
              ),    // Account
            ],
        ),
      ),
  );
}
