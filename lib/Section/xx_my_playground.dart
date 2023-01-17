import 'package:fluent_ui/fluent_ui.dart';
import 'package:native_context_menu/native_context_menu.dart' as ctx;

class ThePlayground extends StatelessWidget {
  const ThePlayground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ScaffoldPage.withPadding(
    content: ctx.ContextMenuRegion(
      menuItems: [
        ctx.MenuItem(
          title: "Copy",
          onSelected: () => print("Copy"),
        ),
        ctx.MenuItem(
          title: "Paste",
          onSelected: () => print("Paste"),
        ),
      ],
      child: Container(
        width: 500,
        height: 300,
        alignment: Alignment.center,
        color: Colors.grey,
      ),
    ),
  );
}
