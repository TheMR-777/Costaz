import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:window_manager/window_manager.dart';
import 'package:system_theme/system_theme.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'src/commons.dart';

class TheTheme {
  static var is_dark = true;
  static late final WindowsDeviceInfo info;
  static late final WindowEffect m_default;
  static WindowEffect the_current_effect = WindowEffect.solid;

  static const Win10_New = 10240;
  static const Win11_Old = 22000;
  static const Win11_New = 22523;

  static AccentColor get my_accent => SystemTheme.accentColor.accent.toAccentColor();
  static bool get can_acry => TheTheme.info.buildNumber >= TheTheme.Win10_New;
  static bool get can_mica => TheTheme.info.buildNumber >= TheTheme.Win11_Old;
  static bool get can_vibe => TheTheme.info.buildNumber >= TheTheme.Win11_New;

  static Future<void> loadDefault() async {
    // Initialization
    {
      WidgetsFlutterBinding.ensureInitialized();          // Flutter
      await WindowManager.instance.ensureInitialized();   // Title Bar
      await Window.initialize();                          // Flutter Acrylic
      await SystemTheme.accentColor.load();               // Accent
      is_dark = SystemTheme.isDarkMode;                   // Dark Mode
    }

    // Title Bar settings
    {
      const my_size = Size(1280, 720);
      const options = WindowOptions(
        title: 'Costaz',
        center: true,
        size: my_size,
        minimumSize: my_size,
        titleBarStyle: TitleBarStyle.hidden,
        skipTaskbar: false,
      );
      await windowManager.waitUntilReadyToShow(options, () async {
        //await windowManager.setPreventClose(true);
        //await windowManager.show();
        await windowManager.focus();
      });
    }

    // Load Effects
    {
      info = await DeviceInfoPlugin().windowsInfo;      // Caching Build Info

      // High than 22523 is Windows 11 22H2 -> tabbed
      // ↑ Not using it as default, as it's overkill
      // Less than 22523 is Windows 11 22H1 -> mica
      // Less than 22000 is Windows 10 any  -> acrylic
      // Less than 10240 is Deprecated      -> solid
      m_default = can_mica
          ? WindowEffect.mica : can_acry
          ? WindowEffect.acrylic
          : WindowEffect.solid;
      the_current_effect = m_default;

      await Window.setEffect(effect: the_current_effect, dark: is_dark);
    }
  }
}

class TheSettings extends StatelessWidget {
  const TheSettings({
    required this.refresh,
    super.key
  });
  final VoidCallback refresh;

  void _change_dark(bool val) {
    TheTheme.is_dark = val;
    Window.setEffect(effect: TheTheme.the_current_effect, dark: val);
    refresh();
  }
  void _change_vibe(bool val) {
    TheTheme.the_current_effect = val ? WindowEffect.tabbed : TheTheme.m_default;
    Window.setEffect(effect: TheTheme.the_current_effect, dark: TheTheme.is_dark);
    refresh();
  }
  void _change_size(double val) {
    nav_bar_size = val;
    refresh();
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(factor + 5),
    child: ListView(
      children: [
        MySwitch(
          title: "Dark Mode",
          icon: FluentIcons.clear_night,
          checked: TheTheme.is_dark,
          onChanged: _change_dark,
        ),                            // Dark Mode
        if (TheTheme.can_vibe) MySwitch(
          title: "Vibe Mode",
          icon: TheTheme.the_current_effect == WindowEffect.tabbed
              ? FluentIcons.favorite_star_fill
              : FluentIcons.favorite_star,
          checked: TheTheme.the_current_effect == WindowEffect.tabbed,
          onChanged: _change_vibe,
        ),     // Vibe Mode
        if (TheTheme.can_acry) MySwitch(
          title: "Classic Mode",
          icon: FluentIcons.glasses,
          checked: TheTheme.the_current_effect == WindowEffect.acrylic,
          onChanged: (val) {
            TheTheme.the_current_effect = val ? WindowEffect.acrylic : TheTheme.m_default;
            Window.setEffect(
                effect: TheTheme.the_current_effect,
                dark: TheTheme.is_dark
            );
            refresh();
          },
        ),     // Classic Mode
        const Divider(
          style: DividerThemeData(
            horizontalMargin: EdgeInsets.all(factor),
          ),
        ),                       // Divider
        ListTile(
          leading: const Icon(FluentIcons.export_mirrored),
          title: const Text("SideBar Width"),
          trailing: Slider(
            divisions: 5,
            min: 200, max: 300,
            value: nav_bar_size,
            onChanged: _change_size,
          ),
        ),                            // SideBar Width
      ],
    ),
  );
}

class MySwitch extends StatelessWidget {
  const MySwitch({
    required this.title,
    required this.icon,
    required this.checked,
    required this.onChanged,
    Key? key
  }) : super(key: key);

  final String title;
  final IconData icon;
  final bool checked;
  final void Function(bool) onChanged;

  @override
  Widget build(BuildContext context) => ListTile(
    trailing: ToggleSwitch(
      checked: checked,
      onChanged: onChanged,
    ),
    leading: Icon(icon),
    title: GestureDetector(
        onTap: () => onChanged(!checked),
        child: Text(title)
    ),
  );
}
