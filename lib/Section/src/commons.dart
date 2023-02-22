import 'package:fluent_ui/fluent_ui.dart';
const factor = 15.0;
const my_spacing = SizedBox(height: factor);
final button_pad = ButtonStyle(padding: ButtonState.all(const EdgeInsets.symmetric(vertical: factor - 5)));

Button TheCancelButton(BuildContext context) => Button(
  onPressed: () => Navigator.pop(context, false),
  style: button_pad,
  child: const Text("Cancel"),
);
List<Widget> ActionBar(BuildContext context, {String focus = "Update"}) => [
  FilledButton(
    onPressed: () => Navigator.pop(context, true),
    style: button_pad,
    child: Text(focus),
  ),
  TheCancelButton(context),
];
Container TheClickable({required Widget child, final bool width = true}) => Container(
    color: Colors.transparent,
    height: double.infinity,
    width: width ? double.infinity : null,
    alignment: Alignment.centerLeft,
    child: child
);

class Show {
  static Widget SmartContextMenu(BuildContext context, {
    required VoidCallback onTap,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
    required Widget on,
  }) {
    final my_controller = FlyoutController();

    IconButton makeIconButton(bool is_edit) => IconButton(
      icon: Padding(
        padding: const EdgeInsets.all(factor - 5),
        child: Icon(is_edit ? FluentIcons.edit : FluentIcons.delete, size: factor),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        is_edit ? onEdit() : onDelete();
      },
    );
    return GestureDetector(
      onTap: onTap,
      onSecondaryTapUp: (details) => my_controller.showFlyout(
        position: details.globalPosition,
        builder: (context) => FlyoutContent(
          padding: EdgeInsets.zero,
          useAcrylic: true,
          child: SizedBox(
            width: 94,
            child: Row(
              children: [
                makeIconButton(true),
                makeIconButton(false),
              ],
            ),
          ),
        ),
      ),
      child: FlyoutTarget(
        controller: my_controller,
        child: on,
      ),
    );
  }

  static Widget TheContextMenu(BuildContext context, {
    VoidCallback? onTap,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
    required Widget on,
  }) {
    final my_controller = FlyoutController();

    IconButton makeField(bool is_edit) => IconButton(
      style: ButtonStyle(
        padding: ButtonState.all(EdgeInsets.zero),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        is_edit ? onEdit() : onDelete();
      },
      icon: Row(
        children: [
          Padding(
              padding: const EdgeInsets.all(factor * 1.2),
              child: Icon(is_edit ? FluentIcons.edit : FluentIcons.delete, size: factor + 1)
          ),
          Container(
            width: factor * 4,
            alignment: Alignment.centerLeft,
            child: Text(is_edit ? 'Edit' : 'Delete'),
          ),
        ],
      ),
    );
    return GestureDetector(
      onTap: onTap,
      onSecondaryTapUp: (details) => my_controller.showFlyout(
        position: details.globalPosition,
        builder: (context) => FlyoutContent(
          padding: EdgeInsets.zero,
          useAcrylic: true,
          child: SizedBox(
            height: factor * 7 - 1,
            width: factor * 8,
            child: Column(
              children: [
                makeField(true),
                makeField(false),
              ],
            ),
          ),
        ),
      ),
      child: FlyoutTarget(
        controller: my_controller,
        child: on,
      ),
    );
  }

  static void TheInfoBar(BuildContext context, {
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

class TheMessage {
  static void Success(BuildContext context) => Show.TheInfoBar(
    context,
    title: "Success",
    detail: "New details applied!",
  );

  static void Added(BuildContext context, String name) => Show.TheInfoBar(
    context,
    title: "Added",
    detail: "New $name Created",
  );

  static void Failure(BuildContext context) => Show.TheInfoBar(
    context,
    type: InfoBarSeverity.warning,
    title: "Cancelled",
    detail: "Changes Discarded",
  );

  static void Delete(BuildContext context, String name) => Show.TheInfoBar(
    context,
    title: "Deleted",
    detail: "$name Removed",
  );

  static void DeleteCancel(BuildContext context) => Show.TheInfoBar(
    context,
    type: InfoBarSeverity.warning,
    title: "Cancelled",
    detail: "Deletion Cancelled",
  );

  static void Empty(BuildContext context) => Show.TheInfoBar(
    context,
    type: InfoBarSeverity.error,
    title: "Empty",
    detail: "None of the fields should be empty!",
  );
}