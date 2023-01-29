import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'src/vertebrae.dart' hide API;
import 'src/commons.dart';
const my_spacing = SizedBox(height: factor);

class Student {
  static final top_row = [
    "Roll No",
    "Name",
    "CGPA",
    "Attendance",
  ];

  Student(this.roll_no, this.name, this.cgpa, this.attendance);

  String roll_no = "N/A";
  String name = "N/A";
  String cgpa = "0.0";
  bool attendance = false;

  static
  void dialogBox_Adding(BuildContext context, VoidCallback refresh, int section_id) {
    final TextEditingController roll = TextEditingController();
    final TextEditingController name = TextEditingController();
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
              onChanged: (val) => roll.text = val,
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
      if (value! && name.text.isNotEmpty && roll.text.isNotEmpty && cgpa.text.isNotEmpty) {
        API.sections[section_id].students.add(Student(roll.text, name.text, cgpa.text, false));
        refresh();
        show.infoBar(
          context,
          title: "Added",
          detail: "Student added!",
        );
      }
      else {
        show.infoBar(
          context,
          type: InfoBarSeverity.warning,
          title: "Cancelled",
          detail: "Addition cancelled!",
        );
      }
    });
  }
  static
  void dialogBox_Delete(BuildContext context, VoidCallback refresh, int section_id, int index) => showDialog<bool>(
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
          autofocus: true,
          onPressed: () => Navigator.pop(context, false),
          style: button_pad,
          child: const Text("Cancel"),
        ),
      ],
    ),
  ).then((value) {
    if (value!) {
      API.sections[section_id].students.removeAt(index);
      refresh();
      show.infoBar(
        context,
        title: "Deleted",
        detail: "Student deleted!",
      );
    }
    else {
      show.infoBar(
        context,
        type: InfoBarSeverity.warning,
        title: "Cancelled",
        detail: "Deletion cancelled!",
      );
    }
  });
  void dialogBox_Update(BuildContext context, VoidCallback refresh) {
    void returnClass() {
      show.infoBar(
        context,
        title: "Updated",
        detail: "New details applied!",
      );
      Navigator.pop(context);
    }
    void cancelClass() {
      show.infoBar(
        context,
        type: InfoBarSeverity.warning,
        title: "Cancelled",
        detail: "All changes discarded!",
      );
      Navigator.pop(context);
    }

    showDialog(
      context: context,
      builder: (context) =>
          ContentDialog(
            title: const Text("Update Details"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                my_spacing,
                TextBox(
                  autofocus: true,
                  onChanged: (val) => name = val,
                  placeholder: "Name",
                  initialValue: name,
                ), // Ask Name
                my_spacing,
                TextBox(
                  onChanged: (val) => roll_no = val,
                  onSubmitted: (val) => returnClass(),
                  placeholder: "Roll No",
                  initialValue: roll_no,
                ), // Ask Roll No
                my_spacing,
                TextBox(
                  onChanged: (val) => cgpa = val,
                  onSubmitted: (val) => returnClass(),
                  placeholder: "CGPA",
                  initialValue: cgpa,
                ), // Ask CGPA
              ],
            ),
            actions: [
              FilledButton(
                onPressed: () {
                  refresh();
                  returnClass();
                },
                style: button_pad,
                child: const Text("Update"),
              ), // Update Button
              Button(
                onPressed: cancelClass,
                style: button_pad,
                child: const Text("Cancel"),
              ), // Cancel Button
            ],
          ),
    );
  }
}

class Section {
  String title = "N/A";
  List<Student> students = [
    Student("BSCS_F19_M_63", "TheMR", "3.72", true),
    Student("BSCS_F19_M_64", "John Wick", "4.00", true),
    Student("BSCS_F19_M_65", "Dr. Who", "2.71", false),
    Student("BSCS_F19_M_66", "Boogeyman", "3.00", true),
    Student("BSCS_F19_M_67", "Highway Man", "3.50", false),
    Student("BSCS_F19_M_68", "Mr Strange", "2.00", true),
    Student("BSCS_F19_M_69", "Adam Smasher", "3.53", false),
    Student("BSCS_F19_M_70", "The Silence", "3.24", true),
    Student("BSCS_F19_M_71", "Dominic Toretto", "3.11", false),
  ];
}

class API {
  static List<Section> sections = [
    Section()..title = "Morning",
    Section()..title = "Afternoon",
    Section()..title = "Evening",
  ];
}

class DearStudents extends StatefulWidget {
  const DearStudents({Key? key}) : super(key: key);
  static int expanded_menu = 0;

  @override
  State<DearStudents> createState() => _DearStudentsState();
}

class _DearStudentsState extends State<DearStudents> {
  static bool to_load = true;
  void update() => setState(() {});

  void addSection(BuildContext context) => showDialog(
    context: context,
    builder: (context) {
      String newSection = "";
      void cancelSection() {
        show.infoBar(
          context,
          type: InfoBarSeverity.warning,
          title: "Cancelled",
          detail: "Section was not added",
        );
        Navigator.pop(context);
      }
      void returnSection() {
        if (newSection.isNotEmpty) {
          show.infoBar(
            context,
            title: "Added",
            detail: "New section added!",
          );
          setState(() => API.sections.add(Section()..title = newSection));
          Navigator.pop(context, true);
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
  );

  @override
  Widget build(BuildContext context) {
    final the_content = ListView.builder(
      itemCount: API.sections.length,
      itemBuilder: (context_2, index) => TheDropDown(
        update, index,
        is_expand: index == DearStudents.expanded_menu,
      ),
    );
    return ScaffoldPage(
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
      content: the_content,
      // content: to_load
      // ? FutureBuilder<bool>(
      //   future: API.load(),
      //   builder: (context_2, snapshot) => snapshot.hasData
      //       ? () {
      //         to_load = false;
      //         return the_content;
      //       }()
      //       : snapshot.hasError
      //       ? Text("${snapshot.error}")
      //       : const Center(child: ProgressRing()),
      // ) : the_content,
    );
  }
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
  void update() => setState(() {});
  Student studentAt(int index) => API.sections[widget.number].students[index];

  void toggleAttendance(int index) => setState(() => studentAt(index).attendance = !studentAt(index).attendance);
  void updateAttendance(int index, bool value) => setState(() => studentAt(index).attendance = value);

  void dialogBox4UpdatingMenu() {
    String name = API.sections[widget.number].title;
    showDialog<bool>(
      context: context,
      builder: (context) {
        return ContentDialog(
          title: const Text("Edit Section"),
          content: TextBox(
            autofocus: true,
            onChanged: (value) => name = value,
            initialValue: name,
            placeholder: "Section Name",
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              style: button_pad,
              child: const Text("Edit"),
            ),
            Button(
              onPressed: () => Navigator.pop(context, false),
              style: button_pad,
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    ).then((value) {
      if (value!) {
        setState(() {
          API.sections[widget.number].title = name;
        });
        show.infoBar(
          context,
          title: "Edited",
          detail: "Worksheet name edited!",
        );
      }
      else {
        show.infoBar(
          context,
          type: InfoBarSeverity.warning,
          title: "Cancelled",
          detail: "Editing cancelled!",
        );
      }
    });
  }
  void dialogBox4DeletingMenu() => showDialog<bool>(
    context: context,
    builder: (context) => ContentDialog(
      title: const Text("Delete Section"),
      content: const Text("Are you sure you want to delete this section?"),
      actions: [
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          style: button_pad,
          child: const Text("Delete"),
        ),
        Button(
          autofocus: true,
          onPressed: () => Navigator.pop(context, false),
          style: button_pad,
          child: const Text("Cancel"),
        ),
      ],
    ),
  ).then((value) {
    if (value!) {
      widget.update();
      setState(() {
        API.sections.removeAt(widget.number);
      });
      show.infoBar(
        context,
        title: "Deleted",
        detail: "Worksheet deleted!",
      );
    }
    else {
      show.infoBar(
        context,
        type: InfoBarSeverity.warning,
        title: "Cancelled",
        detail: "Deletion cancelled!",
      );
    }
  });

  material.DataRow makeTableEntry(BuildContext context, final int index) {
    material.DataCell canToggleAttendance({required final List<String> from}) =>
        material.DataCell(
          show.NativeContextMenu(
            context,
            onTap: () => toggleAttendance(index),
            onEdit: () => studentAt(index).dialogBox_Update(context, update),
            onDelete: () => Student.dialogBox_Delete(context, update, widget.number, index),
            child: Text(from[index]),
          ),
        );

    return material.DataRow(cells: [
      canToggleAttendance(from: API.sections[widget.number].students.map((e) => e.roll_no).toList()),
      canToggleAttendance(from: API.sections[widget.number].students.map((e) => e.name).toList()),
      canToggleAttendance(from: API.sections[widget.number].students.map((e) => e.cgpa).toList()),
      material.DataCell(Checkbox(
        onChanged: (value) => updateAttendance(index, value!),
        autofocus: true,
        checked: studentAt(index).attendance,
        content: Text("  ${studentAt(index).attendance ? "Pre" : "Ab"}sent  "),
      )),
    ]);
  }

  @override
  Widget build(BuildContext context) => Expander(
    onStateChanged: (value) => setState(() => DearStudents.expanded_menu = widget.number),
    initiallyExpanded: widget.is_expand,
    trailing: API.sections[widget.number].students.isNotEmpty
        ? Text(
          "Present: ${API.sections[widget.number].students.where((element) => element.attendance).length} / ${API.sections[widget.number].students.length}",
        )               // Present Count
        : const Icon(FluentIcons.people),
    leading: const Icon(FluentIcons.people),     // People Icon
    header: show.XNativeContextMenu(
      context,
      onEdit: () => dialogBox4UpdatingMenu(),
      onDelete: () => dialogBox4DeletingMenu(),
      child: Text(API.sections[widget.number].title),
    ),                            // Worksheet Name
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (API.sections[widget.number].students.isNotEmpty)
          material.DataTable(
            columns: List.generate(
              Student.top_row.length,
              (index) => material.DataColumn(label: Text(Student.top_row[index])),
            ), // Headers
            rows: List.generate(
            API.sections[widget.number].students.length,
            (index) => makeTableEntry(context, index),
          ),    // Rows (Elem)
        ),
        my_spacing,                    // Spacing
        Button(
          onPressed: () => Student.dialogBox_Adding(context, update, widget.number),
          style: ButtonStyle(
            padding: ButtonState.all(const EdgeInsets.symmetric(vertical: factor)),
            backgroundColor: ButtonState.all(Colors.transparent),
            border: ButtonState.all(BorderSide(color: FluentTheme.of(context).resources.dividerStrokeColorDefault)),
          ),
          child: const Text("Add Student"),
        ),                   // Add Student
        my_spacing,                    // Spacing
      ],
    ),         // Student Fields
  );
}