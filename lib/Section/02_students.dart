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
  Column get the_content => Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(
          top: factor + 10,
          bottom: factor + 10,
          left: factor + 7,
          right: factor + 10,
        ),
        child: Row(
          children: [
            Flexible(
                child: SessionManager.currentTile(context, update),
            ),        // Session Info
            const SizedBox(
                width: factor + 10
            ),  // Spacing
            Button(
              onPressed: () => addSection(context),
              style: ButtonStyle(
                padding: ButtonState.all(const EdgeInsets.symmetric(
                    vertical: factor,
                    horizontal: factor + 10
                )),
              ),
              child: Row(
                children: const [
                  Icon(FluentIcons.add),
                  SizedBox(width: factor + 10),
                  Text("New Section", style: TextStyle(fontSize: factor)),
                ],
              ),
            ),          // Add Section
          ],
        ),
      ),     // Session Info
      Expanded(
        child: ListView.builder(
          itemCount: SectionManager.sections.length,
          itemBuilder: (context_2, index) => TheDropDown(
            update, index,
            is_expand: index == DearStudents.expanded_menu,
          ),
        ),
      ),    // Section List
    ],
  );

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
          setState(() => SectionManager.sections.add(Section()..title = newSection));
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
  Widget build(BuildContext context) => to_load
  ? FutureBuilder<bool>(
    future: SectionManager.load(),
    builder: (context_2, snapshot) => snapshot.hasData
        ? () {
          to_load = false;
          return the_content;
        }()
        : snapshot.hasError
          ? Text("${snapshot.error}")
          : const Center(child: ProgressRing()),
  ) : the_content;
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
  Section get currentSection => SectionManager.sections[widget.number];
  Student studentAt(int index) => currentSection.students[index];

  material.DataRow makeTableEntry(BuildContext context, final int index) {
    material.DataCell canToggleAttendance({required final List<String> from}) =>
        material.DataCell(
          Show.SmartNativeContextMenu(
            context,
            onTap: () => setState(() => studentAt(index).toggleAttendance(session_id: SessionManager.selected)),
            onEdit: () => studentAt(index).update_with_dialogBox(context, update),
            onDelete: () => Student.delete_with_dialogBox(context, update, widget.number, index),
            on: TheClickable(child: Text(from[index])),
          ),
        );

    final record = studentAt(index).attendance_record
        .where((element) => element)
        .length / studentAt(index).attendance_record.length * 100;

    return material.DataRow(cells: [
      canToggleAttendance(from: currentSection.students.map((e) => e.roll_no).toList()),
      canToggleAttendance(from: currentSection.students.map((e) => e.name).toList()),
      material.DataCell(ProgressBar(
        value: record,
        backgroundColor: FluentTheme.of(context).inactiveBackgroundColor.withOpacity(0.4),
        activeColor: record != 100
            ? FluentTheme.of(context).resources.textFillColorTertiary.withOpacity(0.4)
            : null,
      )),
      material.DataCell(Checkbox(
        onChanged: (value) => setState(() => studentAt(index).updateAttendance(session_id: SessionManager.selected, new_val: value!)),
        autofocus: true,
        checked: studentAt(index).is_currently_present,
        content: TheClickable(
          newFactor: factor - 7,
          child: Text("  ${studentAt(index).is_currently_present ? "Pre" : " Ab"}sent  ")
        ),
      )),
    ]);
  }

  @override
  Widget build(BuildContext context) => Expander(
    onStateChanged: (value) => setState(() => DearStudents.expanded_menu = widget.number),
    initiallyExpanded: widget.is_expand,
    trailing: Padding(
      padding: const EdgeInsets.only(right: factor),
      child: currentSection.students.isNotEmpty
          ? ProgressBar(
              value: (currentSection.students.where((element) => element.is_currently_present).length / currentSection.students.length) * 100,
              activeColor: currentSection.students.where((element) => element.is_currently_present).length != currentSection.students.length
                  ? FluentTheme.of(context).resources.textFillColorTertiary
                  : null,
          )   // Present Count
          : const Icon(FluentIcons.education),   // Education Icon
    ),
    leading: const Icon(FluentIcons.people),                // People Icon
    header: Show.NativeContextMenu(
      context,
      onEdit: () => currentSection.update_with_dialogBox(context, update),
      onDelete: () => Section.delete_with_dialogBox(context, widget.update, widget.number),
      on: TheClickable(child: Text(currentSection.title), newFactor: factor - 2),
    ),     // Worksheet Name
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (currentSection.students.isNotEmpty)
          material.DataTable(
            columns: List.generate(
              Section.top_row.length,
              (index) => material.DataColumn(
                label: GestureDetector(
                  onTap: () => setState(() => currentSection.students.sort(
                    (a, b) =>  index == 0 ? a.roll_no.compareTo(b.roll_no)
                        : index == 1 ? a.name.compareTo(b.name)
                        : index == 2 ? b.attendance_record.where((element) => element).length.compareTo(a.attendance_record.where((element) => element).length)
                        : index == 3 ? a.is_currently_present == b.is_currently_present ? 0 : a.is_currently_present ? -1 : 1
                        : 0
                  )),
                  child: TheClickable(
                      newFactor: factor + 3.5,
                      child: Text(Section.top_row[index])
                  ),
                ),
              ),
            ), // Headers
            rows: List.generate(
            currentSection.students.length,
            (index) => makeTableEntry(context, index),
          ),    // Rows (Elem)
        ),
        my_spacing,                    // Spacing
        Button(
          onPressed: () => Student.adding_with_dialogBox(context, update, widget.number),
          style: ButtonStyle(
            padding: ButtonState.all(const EdgeInsets.symmetric(vertical: factor)),
            backgroundColor: ButtonState.all(Colors.transparent),
            border: ButtonState.all(BorderSide(color: FluentTheme.of(context).resources.dividerStrokeColorDefault)),
          ),
          child: const Text("Add Student"),
        ),                   // Add Student
        my_spacing,                    // Spacing
      ],
    ),                    // Student Fields
  );
}