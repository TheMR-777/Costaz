import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:fluent_ui/fluent_ui.dart';

class TheTheme {
  static late final WindowsDeviceInfo info;
  static late final WindowEffect my_effect;

  static const Win10_New = 10240;
  static const Win11_Old = 22000;
  static const Win11_New = 22523;

  static Future<void> loadDefault(void _) async {
    info = await DeviceInfoPlugin().windowsInfo;

    // High than 22523 is Windows 11 22H2 -> tabbed
    // ↑ Not using it as default, as it's overkill
    // Less than 22523 is Windows 11 22H1 -> mica
    // Less than 22000 is Windows 10 any  -> acrylic
    // Less than 10240 is Deprecated      -> solid
    my_effect = info.buildNumber >= Win11_Old
        ? WindowEffect.mica
        : info.buildNumber >= Win10_New
        ? WindowEffect.acrylic
        : WindowEffect.solid;

    await Window.setEffect(effect: my_effect);
  }

  static bool get can_vibe => TheTheme.info.buildNumber > TheTheme.Win11_New;
  static bool get can_mica => TheTheme.info.buildNumber > TheTheme.Win11_Old;
  static bool get can_acry => TheTheme.info.buildNumber > TheTheme.Win10_New;
}

class TheSettings extends StatelessWidget {
  const TheSettings({
    required this.dark_enabled,
    required this.tabb_enabled,
    required this.dark_change,
    required this.tabb_change,
    Key? key
  }) : super(key: key);

  final bool dark_enabled;
  final bool tabb_enabled;
  final void Function(bool?) dark_change;
  final void Function(bool?) tabb_change;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(20),
    child: ListView(
      children: [
        ListTile(
          trailing: ToggleSwitch(
            checked: dark_enabled,
            onChanged: dark_change,
          ),
          leading: const Icon(FluentIcons.clear_night),
          title: GestureDetector(
              onTap: () => dark_change(!dark_enabled),
              child: const Text("Dark Mode")
          ),
        ),    // Dark Mode
        if (TheTheme.can_vibe && dark_enabled)
          ListTile(
            trailing: ToggleSwitch(
              checked: tabb_enabled,
              onChanged: tabb_change,
            ),
            leading: Icon(tabb_enabled ? FluentIcons.favorite_star_fill : FluentIcons.favorite_star),
            title: GestureDetector(
                onTap: () => tabb_change(!tabb_enabled),
                child: const Text("Vibe Mode")
            ),
        ),  // Tabbed Effect
      ],
    ),
  );
}