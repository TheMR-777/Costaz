import 'package:fluent_ui/fluent_ui.dart';
import 'package:contextmenu/contextmenu.dart';

class ThePlayground extends StatelessWidget {
  const ThePlayground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ScaffoldPage.withPadding(
    padding: const EdgeInsets.all(20),
    content: Container(
      alignment: Alignment.centerLeft,
      color: Colors.grey,
      child: ContextMenuArea(
        child: Container(
          width: 50, height: 50,
          color: Colors.black,
        ),
        builder: (context) => [
          ListTile(
            onPressed: () => Navigator.pop(context),
            leading: const Icon(FluentIcons.check_mark),
            title: const Text("Nice it is"),
            trailing: const Icon(FluentIcons.education),
          )
        ],
      ),
    ),
  );
}
