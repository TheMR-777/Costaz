import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:contextmenu/contextmenu.dart';
import 'src/commons.dart';

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
  const DearStudents({super.key});
  static int expanded_menu = 0;

  @override
  State<DearStudents> createState() => _DearStudentsState();
}

class _DearStudentsState extends State<DearStudents> {
  void update() => setState(() {});
  void addSection(BuildContext context) => showDialog(
    context: context,
    builder: (context) {
      String newSection = "";
      void cancelSection() {
        Show.TheInfoBar(
          context,
          type: InfoBarSeverity.warning,
          title: "Cancelled",
          detail: "Section was not added",
        );
        Navigator.pop(context);
      }
      void returnSection() {
        if (newSection.isNotEmpty) {
          Show.TheInfoBar(
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
        content: TextBox(
          autofocus: true,
          onChanged: (val) => newSection = val,
          onSubmitted: (val) => returnSection(),
          placeholder: "Section Name",
        ),
        actions: [
          FilledButton(
            onPressed: returnSection,
            child: const Text("Add"),
          ),
          Button(
            onPressed: cancelSection,
            child: const Text("Cancel"),
          ),
        ],
      );
    },
  );

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
              onPressed: () => addSection(context),
            )
          ],
        ),
      ),
      content: ListView.builder(
        itemCount: API.dropdown_sections.length,
        itemBuilder: (context, index) => TheDropDown(
          update, index,
          is_expand: index == DearStudents.expanded_menu,
        ),
      ),
    );
}

class TheDropDown extends StatefulWidget {
  const TheDropDown(this.update, this.number, {
    this.is_expand = false,
    super.key
  });

  final int number;
  final bool is_expand;
  final VoidCallback update;

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
          Show.TheInfoBar(
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
          Show.TheInfoBar(
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
              TextFormBox(
                autofocus: true,
                onChanged: (val) => API.names[index] = val,
                placeholder: "Name",
                initialValue: API.names[index],
              ),    // Ask Name
              my_spacing,
              TextFormBox(
                onChanged: (val) => API.roll_no[index] = val,
                onFieldSubmitted: (val) => returnClass(),
                placeholder: "Roll No",
                initialValue: API.roll_no[index],
              ),    // Ask Roll No
              my_spacing,
              TextFormBox(
                onChanged: (val) => API.cgpa_s[index] = val,
                onFieldSubmitted: (val) => returnClass(),
                placeholder: "CGPA",
                initialValue: API.cgpa_s[index],
              ),    // Ask CGPA
            ],
          ),
          actions: [
            FilledButton(
              onPressed: () => setState(() => returnClass()),
              child: const Text("Update"),
            ),  // Update Button
            Button(
              onPressed: cancelClass,
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
            child: const Text("Add"),
          ),  // Add Button
          Button(
            onPressed: () => Navigator.pop(context, false),
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
        Show.TheInfoBar(
          context,
          title: "Added",
          detail: "Student added!",
        );
      }
      else {
        Show.TheInfoBar(
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
          child: const Text("Delete"),
        ),
        Button(
          autofocus: true,
          onPressed: () => Navigator.pop(context, false),
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
      Show.TheInfoBar(
        context,
        title: "Deleted",
        detail: "Student deleted!",
      );
    }
    else {
      Show.TheInfoBar(
        context,
        type: InfoBarSeverity.warning,
        title: "Cancelled",
        detail: "Deletion cancelled!",
      );
    }
  });

  void contextMenuEditEntry({required final int of}) {
    Navigator.pop(context);
    dialogBox4UpdatingDetails(of);
  }
  void contextMenuDeleteEntry({required final int of}) {
    Navigator.pop(context);
    dialogBox4DeletingDetails(of);
  }

  void contextMenuEditMenu(BuildContext context_2) {
    String name = API.dropdown_sections[widget.number];
    Navigator.pop(context_2);
    showDialog<bool>(
      context: context,
      builder: (context) {
        return ContentDialog(
          title: const Text("Edit Section"),
          content: TextFormBox(
            autofocus: true,
            onChanged: (value) => name = value,
            initialValue: name,
            placeholder: "Section Name",
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Edit"),
            ),
            Button(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    ).then((value) {
      if (value!) {
        setState(() {
          API.dropdown_sections[widget.number] = name;
        });
        Show.TheInfoBar(
          context,
          title: "Edited",
          detail: "Worksheet name edited!",
        );
      }
      else {
        Show.TheInfoBar(
          context,
          type: InfoBarSeverity.warning,
          title: "Cancelled",
          detail: "Editing cancelled!",
        );
      }
    });
  }
  void contextMenuDeleteMenu(BuildContext context_2) {
    Navigator.pop(context_2);
    showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text("Delete Section"),
        content: const Text("Are you sure you want to delete this section?"),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Delete"),
          ),
          Button(
            autofocus: true,
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
        ],
      ),
    ).then((value) {
      if (value!) {
        API.dropdown_sections.removeAt(widget.number);
        widget.update();
        Show.TheInfoBar(
          context,
          title: "Deleted",
          detail: "Worksheet deleted!",
        );
      }
      else {
        Show.TheInfoBar(
          context,
          type: InfoBarSeverity.warning,
          title: "Cancelled",
          detail: "Deletion cancelled!",
        );
      }
    });
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
                onPressed: () => contextMenuEditEntry(of: index),
                leading: const Icon(FluentIcons.edit_contact, size: factor + 7),
                title: const Text("Edit"),
              ),  // Edit
              ListTile(
                onPressed: () => contextMenuDeleteEntry(of: index),
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
    onStateChanged: (value) => setState(() => DearStudents.expanded_menu = widget.number),
    initiallyExpanded: widget.is_expand,
    trailing: Text(
      "Present: ${API.is_present.where((element) => element).length} / ${API.is_present.length}",
    ),          // Present Count
    leading: const Icon(FluentIcons.people),     // People Icon
    header: GestureDetector(
        onSecondaryTapUp: (details) => showContextMenu(
          details.globalPosition, context,
          (context_2) => [
            ListTile(
              onPressed: () => contextMenuEditMenu(context_2),
              leading: const Icon(FluentIcons.edit_contact, size: factor + 7),
              title: const Text("Edit"),
            ),  // Edit
            ListTile(
              onPressed: () => contextMenuDeleteMenu(context_2),
              leading: const Icon(FluentIcons.delete, size: factor + 7),
              title: const Text("Delete"),
            ),  // Delete
          ],
          7.0, 200.0
        ),
        child: Text(API.dropdown_sections[widget.number])
    ), // Worksheet Name
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
          style: ButtonStyle(
            padding: ButtonState.all(const EdgeInsets.symmetric(vertical: factor)),
            backgroundColor: ButtonState.all(Colors.transparent),
            shape: ButtonState.all(
              RoundedRectangleBorder(
                side: BorderSide(color: FluentTheme.of(context).resources.dividerStrokeColorDefault),
              ),
            ),
          ),
          child: const Text("Add Student"),
        ),                   // Add Student
        my_spacing,                    // Spacing
      ],
    ),         // Student Fields
  );
}