import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;

class API {
  static const names = [
    "TheMR", "John Wick", "The Doctor", "The Master", "The TARDIS", "The Daleks", "The Cybermen", "The Silence", "The Weeping Angels",
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
  @override
  Widget build(BuildContext context) => ListView(
    children: [
      Expander(
        header: const Text("Section B"),
        content: material.DataTable(
          columns: const [
            material.DataColumn(label: Text("Roll Number")),
            material.DataColumn(label: Text("Name")),
            material.DataColumn(label: Text("CGPA"), numeric: true),
            material.DataColumn(label: Text("Attendance")),
          ],        // Headers
          rows: List.generate(
            API.names.length,
            (index) => makeTableEntry(
              API.roll_no[index],
              API.names[index],
              API.cgpa_s[index],
              API.is_present[index],
            ),
          ),    // Rows (Elem)
        ),
      ),    // DropDown
    ],
  );
}

makeTableEntry(final String roll_no, final String name, final String cgpa, final bool is_present) =>
  material.DataRow(cells: [
      material.DataCell(Text(roll_no)),
      material.DataCell(Text(name)),
      material.DataCell(Text(cgpa)),
      material.DataCell(Row(
          children: [
            const Text("Present"),
            const SizedBox(
              width: 10,
            ),
            Checkbox(
              autofocus: true,
              checked: is_present,
              onChanged: (bool? value) {},
            ),
          ],
        )
      ),
    ]
  );