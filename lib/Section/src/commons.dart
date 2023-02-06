import 'package:fluent_ui/fluent_ui.dart';
import '../../main.dart' show Costaz;
const factor = 15.0;
const my_spacing = SizedBox(height: factor);
final button_pad = ButtonStyle(padding: ButtonState.all(const EdgeInsets.symmetric(vertical: factor - 5)));

class Show {
  static const borderRadius = Radius.circular(5);
  static button_style_of(BuildContext context, bool is_edit, {bool smart = false}) => ButtonStyle(
    backgroundColor: ButtonState.all(
        (Costaz.is_tabb
            ? FluentTheme.of(context).micaBackgroundColor
            : FluentTheme.of(context).acrylicBackgroundColor
        ).withOpacity(0.9)
    ),
    padding: ButtonState.all(EdgeInsets.zero),
    shape: ButtonState.all(RoundedRectangleBorder(borderRadius: smart
      ? is_edit
          ? const BorderRadius.only(
              topLeft: borderRadius,
              bottomLeft: borderRadius,
            )
          : const BorderRadius.only(
              topRight: borderRadius,
              bottomRight: borderRadius,
            )
      : is_edit
          ? const BorderRadius.only(
              topLeft: borderRadius,
              topRight: borderRadius,
            )
          : const BorderRadius.only(
              bottomLeft: borderRadius,
              bottomRight: borderRadius,
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
      style: button_style_of(context, is_edit, smart: true),
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
      style: button_style_of(context, is_edit),
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

final weekDays = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

final monthNames = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];