import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:system_theme/system_theme.dart';

class TheTheme {
  static var is_dark = true;
  static var do_vibe = false;
  static late final WindowsDeviceInfo info;
  static late final WindowEffect my_effect;

  static const Win10_New = 10240;
  static const Win11_Old = 22000;
  static const Win11_New = 22523;

  static AccentColor get my_accent => SystemTheme.accentColor.accent.toAccentColor();
  static bool get can_acry => TheTheme.info.buildNumber >= TheTheme.Win10_New;
  static bool get can_mica => TheTheme.info.buildNumber >= TheTheme.Win11_Old;
  static bool get can_vibe => TheTheme.info.buildNumber >= TheTheme.Win11_New;

  static Future<void> loadDefault() async {
    await Window.initialize();                        // Initialize Window
    is_dark = SystemTheme.isDarkMode;                 // Dark Mode
    info = await DeviceInfoPlugin().windowsInfo;      // Caching Build Info

    // High than 22523 is Windows 11 22H2 -> tabbed
    // ↑ Not using it as default, as it's overkill
    // Less than 22523 is Windows 11 22H1 -> mica
    // Less than 22000 is Windows 10 any  -> acrylic
    // Less than 10240 is Deprecated      -> solid
    my_effect = can_mica
        ? WindowEffect.mica : can_acry
        ? WindowEffect.acrylic
        : WindowEffect.solid;

    await Window.setEffect(effect: my_effect, dark: is_dark);
  }

  static void change_dark(VoidCallback refresh, bool val) {
    is_dark = val;
    Window.setEffect(effect: WindowEffect.mica, dark: val);
    refresh();
  }
  static void change_vibe(VoidCallback refresh, bool val) {
    do_vibe = val;
    Window.setEffect(effect: val ? WindowEffect.tabbed : my_effect, dark: is_dark);
    refresh();
  }
}

class TheSettings extends StatefulWidget {
  const TheSettings({
    required this.refresh,
    Key? key
  }) : super(key: key);

  final VoidCallback refresh;

  @override
  State<TheSettings> createState() => _TheSettingsState();
}

class _TheSettingsState extends State<TheSettings> {
  void _change_dark(bool val) => TheTheme.change_dark(widget.refresh, val);
  void _change_vibe(bool val) => TheTheme.change_vibe(widget.refresh, val);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(20),
    child: ListView(
      children: [
        ListTile(
          trailing: ToggleSwitch(
            checked: TheTheme.is_dark,
            onChanged: _change_dark,
          ),
          leading: const Icon(FluentIcons.clear_night),
          title: GestureDetector(
              onTap: () => _change_dark(!TheTheme.is_dark),
              child: const Text("Dark Mode")
          ),
        ),    // Dark Mode
        if (TheTheme.can_vibe && TheTheme.is_dark)
          ListTile(
            trailing: ToggleSwitch(
              checked: TheTheme.do_vibe,
              onChanged: _change_vibe,
            ),
            leading: Icon(TheTheme.do_vibe ? FluentIcons.favorite_star_fill : FluentIcons.favorite_star),
            title: GestureDetector(
                onTap: () => _change_vibe(!TheTheme.do_vibe),
                child: const Text("Vibe Mode")
            ),
          ),  // Tabbed Effect
      ],
    ),
  );
}