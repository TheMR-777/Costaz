import 'package:fluent_ui/fluent_ui.dart';
import 'package:system_theme/system_theme.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';

import 'AppBar/app_bar.dart';
import 'Section/01_home.dart';
import 'Section/02_students.dart';
import 'Section/98_settings.dart';
import 'Section/xx_my_playground.dart';
import 'Section/xx_students_v0_static.dart' as v0;
import 'Section/src/commons.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();        // Initialize
  Costaz.is_dark = SystemTheme.isDarkMode;          // Dark Mode
  Window.initialize().then(TheTheme.loadDefault);   // Set Window Effect
  runApp(const Costaz());                           // Run App
}

class Costaz extends StatefulWidget {
  const Costaz({Key? key}) : super(key: key);
  static var my_page = 0;
  static var is_dark = true;
  static var do_vibe = false;

  @override
  State<Costaz> createState() => _CostazState();
}

class _CostazState extends State<Costaz> {
  void change_dark(bool? val) => setState(() => Costaz.is_dark = val!);
  void change_vibe(bool? val) {
    setState(() => Costaz.do_vibe = val!);
    Window.setEffect(effect: val! ? WindowEffect.tabbed : WindowEffect.mica);
  }

  @override
  Widget build(BuildContext context) => FluentApp(
      debugShowCheckedModeBanner: false,
      theme: FluentThemeData(
        brightness: Costaz.is_dark ? Brightness.dark : Brightness.light,
        dialogTheme: ContentDialogThemeData(
          padding: const EdgeInsets.all(factor * 2),
          titlePadding: const EdgeInsets.only(bottom: factor * 2),
          titleStyle: TextStyle(
            color: Costaz.is_dark ? Colors.white : Colors.black,
            fontSize: factor + 10,
            fontWeight: FontWeight.w500,
          ),
          actionsPadding: const EdgeInsets.symmetric(
            vertical: factor + 5,
            horizontal: factor * 2,
          ),
        ),
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
              ),    // Playground
              PaneItem(
                icon: const Icon(FluentIcons.rewind),
                title: const Text("Souvenir"),
                body: const v0.DearStudents(),
              ),
              PaneItem(
                icon: const Icon(FluentIcons.settings),
                title: const Text("Settings"),
                body: TheSettings(
                  dark_enabled: Costaz.is_dark,
                  tabb_enabled: Costaz.do_vibe,
                  dark_change: change_dark,
                  tabb_change: change_vibe,
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
