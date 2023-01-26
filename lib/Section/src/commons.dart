import 'package:fluent_ui/fluent_ui.dart';

class API {
  static var dropdown_sections = [
    "Morning", "Afternoon"
  ];

  static var top_row = [
    "Roll Number", "Name", "CGPA", "Attendance"
  ];
  static var names = [
    "TheMR", "John Wick", "Dr. Who", "Boogeyman", "Highway Man", "Mr Strange", "Adam Smasher", "The Silence", "The Weeping Angel",
  ];
  static var roll_no = [
    "BSCS_F19_M_63", "BSCS_F19_M_64", "BSCS_F19_M_65", "BSCS_F19_M_66", "BSCS_F19_M_67", "BSCS_F19_M_68", "BSCS_F19_M_69", "BSCS_F19_M_70", "BSCS_F19_M_71",
  ];
  static var cgpa_s = [
    "3.72", "4.00", "2.71", "3.00", "3.50", "2.00", "3.53", "3.24", "3.11",
  ];
  static var is_present = [
    true, true, false, true, false, true, false, true, false,
  ];
}

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