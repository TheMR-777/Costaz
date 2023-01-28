import 'package:fluent_ui/fluent_ui.dart';
const factor = 15.0;
final button_pad = ButtonStyle(padding: ButtonState.all(const EdgeInsets.symmetric(vertical: factor - 5)));

class show {
  static Widget NativeContextMenu(BuildContext context, {
    required VoidCallback onTap,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
    required Widget child,
  }) {
    const borderRadius = Radius.circular(5);
    final my_controller = FlyoutController();

    Button makeButton({bool is_edit = true}) => Button(
      onPressed: () {
        Navigator.of(context).pop();
        (is_edit ? onEdit : onDelete)();
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
      onTap: onTap,
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

  static void infoBar(BuildContext context, {
    InfoBarSeverity type = InfoBarSeverity.success,
    required String title,
    required String detail,
  }) => displayInfoBar(
    context,
    builder: (context, reason) => InfoBar(
      title: Text(title),
      content: Text(detail),
      severity: type,
    ),
  );
}