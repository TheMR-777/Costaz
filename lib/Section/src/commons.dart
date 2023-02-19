import 'package:fluent_ui/fluent_ui.dart';
import '../../main.dart' show Costaz;
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
  static const _borderRadius = Radius.circular(factor - 10);
  static _button_style_of(BuildContext context, bool is_edit, {bool smart = false}) => ButtonStyle(
    backgroundColor: ButtonState.all(
        (Costaz.do_vibe
            ? FluentTheme.of(context).micaBackgroundColor
            : FluentTheme.of(context).acrylicBackgroundColor
        ).withOpacity(0.95)
    ),
    padding: ButtonState.all(EdgeInsets.zero),
    shape: ButtonState.all(RoundedRectangleBorder(borderRadius: smart
      ? is_edit
          ? const BorderRadius.only(
              topLeft: _borderRadius,
              bottomLeft: _borderRadius,
            )
          : const BorderRadius.only(
              topRight: _borderRadius,
              bottomRight: _borderRadius,
            )
      : is_edit
          ? const BorderRadius.only(
              topLeft: _borderRadius,
              topRight: _borderRadius,
            )
          : const BorderRadius.only(
              bottomLeft: _borderRadius,
              bottomRight: _borderRadius,
            )
        )
    ),
  );

  static Widget SmartNativeContextMenu(BuildContext context, {
    required VoidCallback onTap,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
    required Widget on,
  }) {
    final my_controller = FlyoutController();

    Button makeButton({bool is_edit = true}) => Button(
      onPressed: () {
        Navigator.of(context).pop();
        (is_edit ? onEdit : onDelete)();
      },
      style: _button_style_of(context, is_edit, smart: true),
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
        child: on,
      ),
    );
  }

  static Widget NativeContextMenu(BuildContext context, {
    VoidCallback? onTap,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
    required Widget on,
  }) {
    final my_controller = FlyoutController();

    Button makeField({bool is_edit = true}) => Button(
      onPressed: () {
        Navigator.of(context).pop();
        (is_edit ? onEdit : onDelete)();
      },
      style: _button_style_of(context, is_edit),
      child: Row(
        children: [
          Padding(
              padding: const EdgeInsets.all(factor),
              child: Icon(is_edit ? FluentIcons.edit : FluentIcons.delete)
          ),
          Text(is_edit ? 'Edit' : 'Delete'),
        ],
      ),
    );
    return GestureDetector(
      onTap: onTap,
      onSecondaryTapUp: (details) => my_controller.showFlyout(
        position: details.globalPosition,
        builder: (context) => SizedBox(
          height: factor * 6,
          width: factor * 7,
          child: Column(
            children: [
              makeField(),
              makeField(is_edit: false),
            ],
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