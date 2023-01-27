import 'package:fluent_ui/fluent_ui.dart';

void showInfoBar(BuildContext context, {
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