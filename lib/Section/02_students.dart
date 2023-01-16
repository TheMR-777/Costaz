import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;

class API {
  static const names = [
    "TheMR", "John Wick", "Dr. Who", "Boogeyman", "Highway Man", "Mr Strange", "Adam Smasher", "The Silence", "The Weeping Angel",
  ];
  static const roll_no = [
    "BSCS_F19_M_63", "BSCS_F19_M_64", "BSCS_F19_M_65", "BSCS_F19_M_66", "BSCS_F19_M_67", "BSCS_F19_M_68", "BSCS_F19_M_69", "BSCS_F19_M_70", "BSCS_F19_M_71",
  ];
  static const cgpa_s = [
    "3.72", "4.00", "2.71", "3.00", "3.50", "2.00", "3.53", "3.24", "3.11",
  ];
  static var is_present = [
    true, true, false, true, false, true, false, true, false,
  ];
}

class DearStudents extends StatefulWidget {
  const DearStudents({Key? key}) : super(key: key);

  @override
  State<DearStudents> createState() => _DearStudentsState();
}

class _DearStudentsState extends State<DearStudents> {
  void update() => setState(() {});

  @override
  Widget build(BuildContext context) => ListView(
    children: const [
      TheDropDown(),
    ],
  );
}

class TheDropDown extends StatefulWidget {
  const TheDropDown({Key? key}) : super(key: key);

  final String title = "Morning";

  @override
  State<TheDropDown> createState() => _TheDropDownState();
}

class _TheDropDownState extends State<TheDropDown> {
  void toggleAttendance(int index) => setState(() => API.is_present[index] = !API.is_present[index]);
  void updateAttendance(int index, bool value) => setState(() => API.is_present[index] = value);

  material.DataRow makeTableEntry(final int index) {
    material.DataCell canToggleAttendance({required final List<String> from}) =>
        material.DataCell(GestureDetector(
      onTap: () => toggleAttendance(index),
      child: Text(from[index]),
    ));

    return material.DataRow(cells: [
      canToggleAttendance(from: API.roll_no),
      canToggleAttendance(from: API.names),
      canToggleAttendance(from: API.cgpa_s),
      material.DataCell(Checkbox(
        onChanged: (value) => updateAttendance(index, value!),
        autofocus: true,
        checked: API.is_present[index],
        content: Text("  ${API.is_present[index] ? "Present" : "Absent"}"),
      )),
    ]);
  }

  @override
  Widget build(BuildContext context) => Expander(
    initiallyExpanded: true,
    trailing: Text(
      "Present: ${API.is_present.where((element) => element).length} / ${API.is_present.length}",
    ),          // Present Count
    leading: const Icon(FluentIcons.people),     // People Icon
    header: Text(widget.title),   // Worksheet Name
    content: material.DataTable(
      columns: const [
        material.DataColumn(label: Text("Roll Number")),
        material.DataColumn(label: Text("Name")),
        material.DataColumn(label: Text("CGPA")),
        material.DataColumn(label: Text("Attendance")),
      ],        // Headers
      rows: List.generate(
        API.names.length, (index) => makeTableEntry(index),
      ),    // Rows (Elem)
    ),    // Student Fields
  );
}