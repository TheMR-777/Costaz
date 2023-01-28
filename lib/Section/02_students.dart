import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'src/vertebrae.dart';
import 'src/commons.dart';

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
        Navigator.pop(context, false);
      }
      void returnSection() {
        if (newSection.isNotEmpty) {
          show.infoBar(
            context,
            title: "Added",
            detail: "New section added!",
          );
          setState(() => API.dropdown_sections.add(newSection));
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
      itemCount: API.dropdown_sections.length,
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
      content: to_load
      ? FutureBuilder<bool>(
        future: API.load(),
        builder: (context_2, snapshot) => snapshot.hasData
            ? () {
              to_load = false;
              return the_content;
            }()
            : snapshot.hasError
            ? Text("${snapshot.error}")
            : const Center(child: ProgressRing()),
      ) : the_content,
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
  static const my_spacing = SizedBox(height: factor);
  void toggleAttendance(int index) {
    setState(() => API.is_present[widget.number][index] = !API.is_present[widget.number][index]);
  }
  void updateAttendance(int index, bool value) => setState(() => API.is_present[widget.number][index] = value);

  void dialogBox4UpdatingDetails(int index) => showDialog<material.DataRow>(
      context: context,
      builder: (context) {
        bool is_present = API.is_present[widget.number][index];
        void returnClass() {
          show.infoBar(
            context,
            title: "Updated",
            detail: "New details applied!",
          );
          Navigator.pop(context, material.DataRow(
          cells: [
            material.DataCell(Text(API.names[widget.number][index])),
            material.DataCell(Text(API.roll_no[widget.number][index])),
            material.DataCell(Text(API.cgpa_s[widget.number][index])),
            material.DataCell(Checkbox(
              checked: is_present,
              onChanged: (val) => updateAttendance(index, val!),
            )),
          ],
        ));
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

        return ContentDialog(
          title: const Text("Update Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              my_spacing,
              TextBox(
                autofocus: true,
                onChanged: (val) => API.names[widget.number][index] = val,
                placeholder: "Name",
                initialValue: API.names[widget.number][index],
              ),    // Ask Name
              my_spacing,
              TextBox(
                onChanged: (val) => API.roll_no[widget.number][index] = val,
                onSubmitted: (val) => returnClass(),
                placeholder: "Roll No",
                initialValue: API.roll_no[widget.number][index],
              ),    // Ask Roll No
              my_spacing,
              TextBox(
                onChanged: (val) => API.cgpa_s[widget.number][index] = val,
                onSubmitted: (val) => returnClass(),
                placeholder: "CGPA",
                initialValue: API.cgpa_s[widget.number][index],
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
          // If widget.number > API.roll_no.length then it will add a new list
          // Otherwise it will add to the existing list
          if (widget.number >= API.roll_no.length) {
            API.roll_no.add([roll_no.text]);
            API.names.add([name.text]);
            API.cgpa_s.add([cgpa.text]);
            API.is_present.add([false]);
          }
          else {
            API.roll_no[widget.number].add(roll_no.text);
            API.names[widget.number].add(name.text);
            API.cgpa_s[widget.number].add(cgpa.text);
            API.is_present[widget.number].add(false);
          }
        });
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
          autofocus: true,
          onPressed: () => Navigator.pop(context, false),
          style: button_pad,
          child: const Text("Cancel"),
        ),
      ],
    ),
  ).then((value) {
    if (value!) {
      setState(() {
        API.names[widget.number].removeAt(index);
        API.roll_no[widget.number].removeAt(index);
        API.cgpa_s[widget.number].removeAt(index);
        API.is_present[widget.number].removeAt(index);
      });
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

  void dialogBox4UpdatingMenu() {
    String name = API.dropdown_sections[widget.number];
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
          API.dropdown_sections[widget.number] = name;
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
        API.dropdown_sections.removeAt(widget.number);
        API.names.removeAt(widget.number);
        API.roll_no.removeAt(widget.number);
        API.cgpa_s.removeAt(widget.number);
        API.is_present.removeAt(widget.number);
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
            onEdit: () => dialogBox4UpdatingDetails(index),
            onDelete: () => dialogBox4DeletingDetails(index),
            child: Text(from[index]),
          ),
        );

    return material.DataRow(cells: [
      canToggleAttendance(from: API.roll_no[widget.number]),
      canToggleAttendance(from: API.names[widget.number]),
      canToggleAttendance(from: API.cgpa_s[widget.number]),
      material.DataCell(Checkbox(
        onChanged: (value) => updateAttendance(index, value!),
        autofocus: true,
        checked: API.is_present[widget.number][index],
        content: Text("  ${API.is_present[widget.number][index] ? "Pre" : "Ab"}sent  "),
      )),
    ]);
  }

  @override
  Widget build(BuildContext context) => Expander(
    onStateChanged: (value) => setState(() => DearStudents.expanded_menu = widget.number),
    initiallyExpanded: widget.is_expand,
    trailing: API.roll_no.length > widget.number
        ? Text(
          "Present: ${API.is_present[widget.number].where((element) => element).length} / ${API.is_present[widget.number].length}",
        )               // Present Count
        : const Icon(FluentIcons.people),
    leading: const Icon(FluentIcons.people),     // People Icon
    header: show.XNativeContextMenu(
      context,
      onEdit: () => dialogBox4UpdatingMenu(),
      onDelete: () => dialogBox4DeletingMenu(),
      child: Text(API.dropdown_sections[widget.number]),
    ), // Worksheet Name
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (API.roll_no.length > widget.number && API.roll_no[widget.number].isNotEmpty) material.DataTable(
          columns: List.generate(
            API.top_row.length,
            (index) => material.DataColumn(label: Text(API.top_row[index])),
          ), // Headers
          rows: List.generate(
            API.roll_no[widget.number].length,
            (index) => makeTableEntry(context, index),
          ),    // Rows (Elem)
        ),
        my_spacing,                    // Spacing
        Button(
          onPressed: () => dialogBox4AddingDetails(),
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