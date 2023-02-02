import 'package:fluent_ui/fluent_ui.dart';

class TheSettings extends StatelessWidget {
  const TheSettings({
    required this.dark_enabled,
    required this.theme_change,
    Key? key
  }) : super(key: key);

  final bool dark_enabled;
  final void Function(bool?) theme_change;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(20),
    child: Column(
      children: [
        ListTile(
          trailing: Checkbox(
            checked: dark_enabled,
            onChanged: theme_change,
          ),
          leading: const Icon(FluentIcons.clear_night),
          title: GestureDetector(
              onTap: () => theme_change(!dark_enabled),
              child: const Text("Dark Mode")
          ),
        ),
      ],
    ),
  );
}