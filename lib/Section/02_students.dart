import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:my_desktop_project/Section/01_home.dart';

class API {
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

  void updateDetails(BuildContext context, int index) => showDialog<material.DataRow>(
      context: context,
      builder: (context) {
        const my_spacing = SizedBox(height: factor);
        bool is_present = API.is_present[index];
        void returnClass() {
          displayInfoBar(
            context,
            builder: (context, reason) => const InfoBar(
              title: Text("Updated"),
              content: Text("Details Updated."),
              severity: InfoBarSeverity.success,
            ),
          );
          Navigator.pop(context, material.DataRow(
          cells: [
            material.DataCell(Text(API.names[index])),
            material.DataCell(Text(API.roll_no[index])),
            material.DataCell(Text(API.cgpa_s[index])),
            material.DataCell(Checkbox(
              checked: is_present,
              onChanged: (val) => updateAttendance(index, val!),
            )),
          ],
        ));
        }

        return ContentDialog(
          title: const Text("Update Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              my_spacing,
              TextBox(
                autofocus: true,
                onChanged: (val) => API.names[index] = val,
                placeholder: "Name",
                initialValue: API.names[index],
              ),    // Ask Name
              my_spacing,
              TextBox(
                onChanged: (val) => API.roll_no[index] = val,
                onSubmitted: (val) => returnClass(),
                placeholder: "Roll No",
                initialValue: API.roll_no[index],
              ),    // Ask Roll No
              my_spacing,
              TextBox(
                onChanged: (val) => API.cgpa_s[index] = val,
                onSubmitted: (val) => returnClass(),
                placeholder: "CGPA",
                initialValue: API.cgpa_s[index],
              ),    // Ask CGPA
            ],
          ),
          actions: [
            FilledButton(
              onPressed: () => setState(() => returnClass()),
              style: button_pad,
              child: const Text("Update"),
            ),
            Button(
              onPressed: () {
                displayInfoBar(
                  context,
                  builder: (context, close) => const InfoBar(
                    title: Text("Cancelled"),
                    content: Text("No changes were made."),
                    severity: InfoBarSeverity.info,
                  ),
                );
                Navigator.pop(context);
              },
              style: button_pad,
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );

  material.DataRow makeTableEntry(BuildContext context, final int index) {
    material.DataCell canToggleAttendance({required final List<String> from}) =>
        material.DataCell(GestureDetector(
          onTap: () => toggleAttendance(index),
          onSecondaryTap: () => updateDetails(context, index),
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
        API.names.length, (index) => makeTableEntry(context, index),
      ),    // Rows (Elem)
    ),    // Student Fields
  );
}