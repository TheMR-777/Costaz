import 'package:fluent_ui/fluent_ui.dart';
import 'package:window_manager/window_manager.dart';
import 'AppBar/app_bar.dart';
import 'Page/01_home.dart';
import 'Page/02_students.dart';
import 'Page/98_settings.dart';
import 'Page/xx_my_playground.dart';
import 'Page/xx_students_v0_static.dart' as v0;
import 'Page/src/commons.dart';

void main() async {
  await TheTheme.init();           // Load Theme
  runApp(const Costaz());          // Run App
  windowManager.show();            // Show Window
}

class Costaz extends StatefulWidget {
  const Costaz({super.key});

  @override
  State<Costaz> createState() => _CostazState();
}

class _CostazState extends State<Costaz> {
  void update() => setState(() {});

  @override
  Widget build(BuildContext context) => FluentApp(
    theme: FluentThemeData(
      accentColor: TheTheme.my_accent,
      brightness: is_dark_mode ? Brightness.dark : null,
      buttonTheme: const ButtonThemeData(
        defaultButtonStyle: button_pad,
        filledButtonStyle: button_pad,
      ),
      infoBarTheme: const InfoBarThemeData(
        padding: EdgeInsets.only(
          left: factor,
          right: factor + 5,
        ),
      ),
      dialogTheme: ContentDialogThemeData(
        padding: const EdgeInsets.all(factor * 2),
        titlePadding: const EdgeInsets.only(bottom: factor * 2),
        titleStyle: TextStyle(
          color: is_dark_mode ? Colors.white : Colors.black,
          fontSize: factor + 10,
          fontWeight: FontWeight.w500,
        ),
        actionsPadding: const EdgeInsets.symmetric(
          vertical: factor + 5,
          horizontal: factor * 2,
        ),
      ),
      navigationPaneTheme: NavigationPaneThemeData(
        backgroundColor: TheTheme.the_current_effect == TheTheme.no_effect
            ? null
            : Colors.transparent,
      )
    ),
    home: NavigationView(
      appBar: NavigationAppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: IconButton(
            onPressed: current_page == 0 ? () => classController.previousPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutCubic,
            ) : null,
            style: const ButtonStyle(
              padding: WidgetStatePropertyAll(EdgeInsets.all(factor)),
            ),
            icon: const Icon(FluentIcons.back, size: factor - 1),
          ),
        ),              // Back Button
        title: const DragToMoveArea(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text("Costaz"),
          ),
        ),   // Costaz
        actions: SizedBox(
          width: factor * 15,
          child: WindowCaption(
            brightness: is_dark_mode ? Brightness.dark : null,
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
      pane: NavigationPane(
        size: NavigationPaneSize(
          openMaxWidth: nav_bar_size,
        ),
        selected: current_page,
        onChanged: (i) => setState(() => current_page = i),
        header: const TheHeader(),
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
          ),    // Recent Page
        ],
        footerItems: [
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.play),
            title: const Text("Playground"),
            body: const ThePlayground(),
          ),    // Playground
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text("Settings"),
            body: TheSettings(refresh: update),
          ),    // Settings
          PaneItem(
            icon: const Icon(FluentIcons.rewind),
            title: const Text("Souvenir"),
            body: const v0.DearStudents(),
          ),    // Souvenir
        ],
      ),
    ),
  );
}
