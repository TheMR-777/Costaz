import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;

class API {
  static const names = [
    "TheMR", "John Wick", "The Doctor", "The Master", "Highway Man", "Mr Strange", "Adam Smasher", "The Silence", "The Weeping Angels",
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
    children: [
      Expander(
        initiallyExpanded: true,
        trailing: Text(
          "Present: ${API.is_present.where((element) => element).length} / ${API.is_present.length}",
        ),          // Present Count
        leading: const Icon(FluentIcons.people),     // People Icon
        header: const Text("Section B"),      // Worksheet Name
        content: TheTable(update),    // Student Fields
      ),    // DropDown
    ],
  );
}

class TheTable extends StatefulWidget {
  const TheTable(this.updateCount, {super.key});

  final VoidCallback updateCount;

  @override
  State<TheTable> createState() => _TheTableState();
}

class _TheTableState extends State<TheTable> {
  makeTableEntry(final int index) => material.DataRow(cells: [
      material.DataCell(Text(API.roll_no[index])),
      material.DataCell(Text(API.names[index])),
      material.DataCell(Text(API.cgpa_s[index])),
      material.DataCell(Row(
        children: [
          const Text("Present"),
          const SizedBox(
            width: 10,
          ),
          Checkbox(
            autofocus: true,
            checked: API.is_present[index],
            onChanged: (bool? value) => setState(() {
              API.is_present[index] = value!;
              widget.updateCount();
            }),
          ),
        ],
      )
    ),
  ]);

  @override
  Widget build(BuildContext context) => material.DataTable(
    columns: const [
      material.DataColumn(label: Text("Roll Number")),
      material.DataColumn(label: Text("Name")),
      material.DataColumn(label: Text("CGPA")),
      material.DataColumn(label: Text("Attendance")),
    ],        // Headers
    rows: List.generate(
      API.names.length, (index) => makeTableEntry(index),
    ),    // Rows (Elem)
  );
}