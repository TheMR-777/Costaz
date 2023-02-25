import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:system_theme/system_theme.dart';
import 'package:fluent_ui/fluent_ui.dart';

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
    Window.setEffect(effect: TheTheme.do_vibe ? WindowEffect.tabbed : my_effect, dark: val);
    refresh();
  }
  static void change_vibe(VoidCallback refresh, bool val) {
    do_vibe = val;
    Window.setEffect(effect: val ? WindowEffect.tabbed : my_effect, dark: is_dark);
    refresh();
  }
}

class TheSettings extends StatelessWidget {
  const TheSettings({
    required this.refresh,
    super.key
  });
  final VoidCallback refresh;

  void _change_dark(bool val) => TheTheme.change_dark(refresh, val);
  void _change_vibe(bool val) => TheTheme.change_vibe(refresh, val);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(20),
    child: ListView(
      children: [
        MySwitch(
          title: "Dark Mode",
          icon: FluentIcons.clear_night,
          checked: TheTheme.is_dark,
          onChanged: _change_dark,
        ),  // Dark Mode
        if (TheTheme.can_vibe) MySwitch(
          title: "Vibe Mode",
          icon: TheTheme.do_vibe
              ? FluentIcons.favorite_star_fill
              : FluentIcons.favorite_star,
          checked: TheTheme.do_vibe,
          onChanged: _change_vibe,
        ),
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
