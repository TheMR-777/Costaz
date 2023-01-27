import 'package:fluent_ui/fluent_ui.dart';
import 'package:my_desktop_project/Section/01_home.dart';

Widget enabledContextMenu(BuildContext context, {
    required VoidCallback onEdit,
    required VoidCallback onDelete,
    required Widget child,
}) {
  const borderRadius = Radius.circular(5);
  final my_controller = FlyoutController();

  Button makeButton({bool is_edit = true}) => Button(
    onPressed: () {
      Navigator.of(context).pop();
      is_edit ? onEdit : onDelete;
    },
    style: ButtonStyle(
      backgroundColor: ButtonState.all(FluentTheme.of(context).acrylicBackgroundColor.withOpacity(0.9)),
      padding: ButtonState.all(EdgeInsets.zero),
      shape: ButtonState.all(RoundedRectangleBorder(
        borderRadius: is_edit ? const BorderRadius.only(
          topLeft: borderRadius,
          bottomLeft: borderRadius,
        ) : const BorderRadius.only(
          topRight: borderRadius,
          bottomRight: borderRadius,
        ),
      )),
    ),
    child: Padding(
      padding: const EdgeInsets.all(factor),
      child: Icon(is_edit ? FluentIcons.edit : FluentIcons.delete),
    ),
  );
  return GestureDetector(
    onSecondaryTapUp: (details) => my_controller.showFlyout(
      position: details.globalPosition,
      builder: (context) => SizedBox(
        width: factor * 6,
        child: Row(
          children: [
            makeButton(),
            makeButton(is_edit: false),
          ],
        ),
      ),
    ),
    child: FlyoutTarget(
      controller: my_controller,
      child: child,
    ),
  );
}

class ThePlayground extends StatelessWidget {
  const ThePlayground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ScaffoldPage.withPadding(
    padding: const EdgeInsets.all(20),
    content: Center(
      child: enabledContextMenu(
        context,
        onDelete: () {}, onEdit: () {},
        child: Container(
          width: 200,
          height: 200,
          color: Colors.red,
        ),
      ),
    )
  );
}
