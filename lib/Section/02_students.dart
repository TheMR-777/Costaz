import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:contextmenu/contextmenu.dart';
import 'src/commons.dart';
import '01_home.dart';

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

class DearStudents extends StatefulWidget {
  const DearStudents({Key? key}) : super(key: key);

  @override
  State<DearStudents> createState() => _DearStudentsState();
}

class _DearStudentsState extends State<DearStudents> {
  final int expanded_menu = 0;

  @override
  Widget build(BuildContext context) => ScaffoldPage(
    header: PageHeader(
      title: const Text("Students"),
      commandBar: CommandBar(
        mainAxisAlignment: MainAxisAlignment.end,
        primaryItems: [
          CommandBarButton(
            icon: const Icon(FluentIcons.add),
            label: const Text("Add Section"),
            onPressed: () => showDialog(
              context: context,
              builder: (context) {
                const my_spacing = SizedBox(height: factor);
                String newSection = "";
                void cancelSection() {
                  showInfoBar(
                    context,
                    type: InfoBarSeverity.warning,
                    title: "Cancelled",
                    detail: "Section was not added",
                  );
                  Navigator.pop(context);
                }
                void returnSection() {
                  if (newSection.isNotEmpty) {
                    showInfoBar(
                      context,
                      title: "Added",
                      detail: "New section added!",
                    );
                    setState(() => API.dropdown_sections.add(newSection));
                    Navigator.pop(context);
                  }
                  else {
                    cancelSection();
                  }
                }

                return ContentDialog(
                  title: const Text("Add a New Section"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      my_spacing,
                      TextBox(
                        autofocus: true,
                        onChanged: (val) => newSection = val,
                        onSubmitted: (val) => returnSection(),
                        placeholder: "Section Name",
                      ),    // Ask Name
                    ],
                  ),
                  actions: [
                    FilledButton(
                      style: button_pad,
                      onPressed: returnSection,
                      child: const Text("Add"),
                    ),
                    Button(
                      style: button_pad,
                      onPressed: cancelSection,
                      child: const Text("Cancel"),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    ),
    content: ListView.builder(
      itemCount: API.dropdown_sections.length,
      itemBuilder: (context, index) => TheDropDown(
        index,
        expand: index == expanded_menu,
      ),
    ),
  );
}

class TheDropDown extends StatefulWidget {
  const TheDropDown(this.number, {
    this.expand = false,
    super.key
  });

  final int number;
  final bool expand;

  @override
  State<TheDropDown> createState() => _TheDropDownState();
}

class _TheDropDownState extends State<TheDropDown> {
  static const my_spacing = SizedBox(height: factor);
  void toggleAttendance(int index) => setState(() => API.is_present[index] = !API.is_present[index]);
  void updateAttendance(int index, bool value) => setState(() => API.is_present[index] = value);

  void dialogBox4UpdatingDetails(int index) => showDialog<material.DataRow>(
      context: context,
      builder: (context) {
        bool is_present = API.is_present[index];
        void returnClass() {
          showInfoBar(
            context,
            title: "Updated",
            detail: "New details applied!",
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
        void cancelClass() {
          showInfoBar(
            context,
            type: InfoBarSeverity.warning,
            title: "Cancelled",
            detail: "All changes discarded!",
          );
          Navigator.pop(context);
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
            ),  // Update Button
            Button(
              onPressed: cancelClass,
              style: button_pad,
              child: const Text("Cancel"),
            ),        // Cancel Button
          ],
        );
      },
    );
  void dialogBox4AddingDetails() {
    final TextEditingController name = TextEditingController();
    final TextEditingController roll_no = TextEditingController();
    final TextEditingController cgpa = TextEditingController();
    showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text("Add Student"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            my_spacing,
            TextBox(
              autofocus: true,
              onChanged: (val) => name.text = val,
              placeholder: "Name",
            ),    // Ask Name
            my_spacing,
            TextBox(
              onChanged: (val) => roll_no.text = val,
              onSubmitted: (val) => Navigator.pop(context, true),
              placeholder: "Roll Number",
            ),    // Ask Roll No
            my_spacing,
            TextBox(
              onChanged: (val) => cgpa.text = val,
              onSubmitted: (val) => Navigator.pop(context, true),
              placeholder: "CGPA",
            ),    // Ask CGPA
          ],
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: button_pad,
            child: const Text("Add"),
          ),  // Add Button
          Button(
            onPressed: () => Navigator.pop(context, false),
            style: button_pad,
            child: const Text("Cancel"),
          ),        // Cancel Button
        ],
      ),
    ).then((value) {
      if (value! && name.text.isNotEmpty && roll_no.text.isNotEmpty && cgpa.text.isNotEmpty) {
        setState(() {
          API.names.add(name.text);
          API.roll_no.add(roll_no.text);
          API.cgpa_s.add(cgpa.text);
          API.is_present.add(false);
        });
        showInfoBar(
          context,
          title: "Added",
          detail: "Student added!",
        );
      }
      else {
        showInfoBar(
          context,
          type: InfoBarSeverity.warning,
          title: "Cancelled",
          detail: "Addition cancelled!",
        );
      }
    });
  }
  void dialogBox4DeletingDetails(int index) => showDialog<bool>(
    context: context,
    builder: (context) => ContentDialog(
      title: const Text("Delete Student"),
      content: const Text("Are you sure you want to delete this student?"),
      actions: [
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          style: button_pad,
          child: const Text("Delete"),
        ),
        Button(
          onPressed: () => Navigator.pop(context, false),
          style: button_pad,
          child: const Text("Cancel"),
        ),
      ],
    ),
  ).then((value) {
    if (value!) {
      setState(() {
        API.names.removeAt(index);
        API.roll_no.removeAt(index);
        API.cgpa_s.removeAt(index);
        API.is_present.removeAt(index);
      });
      showInfoBar(
        context,
        title: "Deleted",
        detail: "Student deleted!",
      );
    }
    else {
      showInfoBar(
        context,
        type: InfoBarSeverity.warning,
        title: "Cancelled",
        detail: "Deletion cancelled!",
      );
    }
  });

  void contextMenuEdit({required final int of}) {
    Navigator.pop(context);
    dialogBox4UpdatingDetails(of);
  }
  void contextMenuDelete({required final int of}) {
    Navigator.pop(context);
    dialogBox4DeletingDetails(of);
  }

  material.DataRow makeTableEntry(BuildContext context, final int index) {
    material.DataCell canToggleAttendance({required final List<String> from}) =>
        material.DataCell(GestureDetector(
          onTap: () => toggleAttendance(index),
          onSecondaryTapUp: (details) => showContextMenu(
            details.globalPosition,
            context,
            (context) => [
              ListTile(
                onPressed: () => contextMenuEdit(of: index),
                leading: const Icon(FluentIcons.edit_contact, size: factor + 7),
                title: const Text("Edit"),
              ),  // Edit
              ListTile(
                onPressed: () => contextMenuDelete(of: index),
                leading: const Icon(FluentIcons.delete, size: factor + 7),
                title: const Text("Delete"),
              ),  // Delete
            ],
            7.0, 200.0
          ),
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
        content: Text("  ${API.is_present[index] ? "Pre" : "Ab"}sent  "),
      )),
    ]);
  }

  @override
  Widget build(BuildContext context) => Expander(
    initiallyExpanded: widget.expand,
    trailing: Text(
      "Present: ${API.is_present.where((element) => element).length} / ${API.is_present.length}",
    ),          // Present Count
    leading: const Icon(FluentIcons.people),     // People Icon
    header: Text(API.dropdown_sections[widget.number]),            // Worksheet Name
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        material.DataTable(
          columns: List.generate(
            API.top_row.length,
            (index) => material.DataColumn(label: Text(API.top_row[index])),
          ), // Headers
          rows: List.generate(
            API.names.length, (index) => makeTableEntry(context, index),
          ),    // Rows (Elem)
        ),
        my_spacing,                    // Spacing
        Button(
          onPressed: () => dialogBox4AddingDetails(),
          style: button_pad.copyWith(
            backgroundColor: ButtonState.all(Colors.transparent),
            border: ButtonState.all(BorderSide(color: FluentTheme.of(context).cardColor)),
          ),
          child: const Text("Add Student"),
        ),                   // Add Student Button
        const SizedBox(height: 5.0),   // Spacing
      ],
    ),         // Student Fields
  );
}

// Test