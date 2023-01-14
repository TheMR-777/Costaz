import 'package:fluent_ui/fluent_ui.dart';

import 'AppBar/app_bar.dart';
import 'Section/01_home.dart';
import 'Section/02_students.dart';
import 'Section/98_settings.dart';

void main() => runApp(const Costaz());

class Costaz extends StatefulWidget {
  const Costaz({Key? key}) : super(key: key);
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
      theme: Costaz.is_dark ? ThemeData.dark() : ThemeData.light(),
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
                icon: const Icon(FluentIcons.people),
                title: const Text("Students"),
                body: const DearStudents(),
              )
            ],
            footerItems: [
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
