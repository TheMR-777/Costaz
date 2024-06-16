# Cache

This file contains the cache implementations of the components, which may later be used in the application.

## Expanders (Dropdowns)

### Claude AI
```dart
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
  final my_class = Class.selected;
  void update() => setState(() {});
  Section get currentSection => my_class.sections[widget.number];
  Student studentAt(int index) => currentSection.students[index];

  TableRow makeTableEntry(BuildContext context, final int index) {
    TableCell canToggleAttendance({required final List<String> from}) => TableCell(
        child: Show.SmartContextMenu(
          context,
          onTap: () => setState(() => studentAt(index).toggleAttendance(session_id: SessionManager.selected)),
          onEdit: () => studentAt(index).update_with_dialogBox(context, update),
          onDelete: () => my_class.delete_student_with_dialogBox(context, update, widget.number, index),
          on: TheClickable(child: Text(from[index])),
        ),
    );

    return TableRow(children: [
      canToggleAttendance(from: currentSection.students.map((e) => e.roll_no).toList()),
      canToggleAttendance(from: currentSection.students.map((e) => e.my_name).toList()),
      TableCell(child: AttendanceRecord(
        student: studentAt(index),
        update: update,
      )),  // Attendance Record
      TableCell(child: FocusTheme(
        data: FocusThemeData(
          glowColor: FluentTheme.of(context).accentColor.withOpacity(is_dark_mode ? 0.01 : 0.005),
          primaryBorder: BorderSide(color: FluentTheme.of(context).accentColor),
        ),
        child: Checkbox(
          onChanged: (value) => setState(() => studentAt(index).updateAttendance(session_id: SessionManager.selected, new_val: value!)),
          autofocus: true,
          checked: studentAt(index).is_currently_present,
          content: Center(
            child: Text("  ${studentAt(index).is_currently_present ? "Pre" : " Ab"}sent  ")
          ),
        ),
      )),        // Attendance
    ]);
  }

  @override
  Widget build(BuildContext context) => Expander(
    onStateChanged: (value) => setState(() => my_class.open_drop_down = widget.number),
    initiallyExpanded: widget.is_expand,
    trailing: Padding(
      padding: const EdgeInsets.only(right: factor),
      child: currentSection.students.isNotEmpty ? ProgressBar(
              value: (currentSection.students.where((element) => element.is_currently_present).length / currentSection.students.length) * 100,
              activeColor: currentSection.students.where((element) => element.is_currently_present).length != currentSection.students.length
                  ? FluentTheme.of(context).resources.textFillColorTertiary
                  : null,
          ) : null
    ),
    leading: const Icon(FluentIcons.people),                // People Icon
    header: Show.TheContextMenu(
      context,
      onEdit: () => currentSection.update_with_dialogBox(context, update),
      onDelete: () => my_class.delete_section_with_dialogBox(context, widget.update, widget.number),
      on: TheClickable(child: Text(currentSection.title)),
    ),        // Worksheet Name
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (currentSection.students.isNotEmpty)
          Table(
            children: [
              TableRow(
                children: List.generate(
                  my_class.my_column.length,
                  (index) => TableCell(
                    child: GestureDetector(
                      onTap: () => setState(() => currentSection.students.sort(
                        (a, b) =>  index == 0 ? a.roll_no.compareTo(b.roll_no)
                            : index == 1 ? a.my_name.compareTo(b.my_name)
                            : index == 2 ? b.attendance_record.where((element) => element).length.compareTo(a.attendance_record.where((element) => element).length)
                            : index == 3 ? a.is_currently_present == b.is_currently_present ? 0 : a.is_currently_present ? -1 : 1
                            : 0
                      )),
                      child: TheClickable(child: Text(my_class.my_column[index])),
                    ),
                  ),
                ),
              ),
              ...List.generate(
                currentSection.students.length,
                (index) => makeTableEntry(context, index),
              ),    // Rows (Elem)
            ],
          ),
        my_spacing,                    // Spacing
        IconButton(
          onPressed: () => my_class.create_student_with_dialogBox(context, update, widget.number),
          style: ButtonStyle(
            padding: ButtonState.all(const EdgeInsets.symmetric(vertical: factor)),
            shape: ButtonState.all(
              RoundedRectangleBorder(
                side: BorderSide(color: FluentTheme.of(context).resources.dividerStrokeColorDefault),
              ),
            ),
          ),
          icon: const Text("Add Student"),
        ),                   // Add Student
        my_spacing,                    // Spacing
      ],
    ),                    // Student Fields
  );
}
```

### GPT2-Chatbot
```dart
import 'package:fluent_ui/fluent_ui.dart';

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
  final my_class = Class.selected;
  void update() => setState(() {});
  Section get currentSection => my_class.sections[widget.number];
  Student studentAt(int index) => currentSection.students[index];

  // Helper method to create a table-like row
  Widget makeTableEntry(BuildContext context, final int index) {
    Student student = studentAt(index);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Expanded(
            child: Show.SmartContextMenu(
              context,
              onTap: () => setState(() => student.toggleAttendance(session_id: SessionManager.selected)),
              onEdit: () => student.update_with_dialogBox(context, update),
              onDelete: () => my_class.delete_student_with_dialogBox(context, update, widget.number, index),
              on: TheClickable(child: Text(student.roll_no)),
            ),
          ),
          Expanded(
            child: Show.SmartContextMenu(
              context,
              onTap: () => setState(() => student.toggleAttendance(session_id: SessionManager.selected)),
              onEdit: () => student.update_with_dialogBox(context, update),
              onDelete: () => my_class.delete_student_with_dialogBox(context, update, widget.number, index),
              on: TheClickable(child: Text(student.my_name)),
            ),
          ),
          Expanded(
            child: AttendanceRecord(
              student: student,
              update: update,
            ),
          ),
          Expanded(
            child: FocusTheme(
              data: FocusThemeData(
                glowColor: FluentTheme.of(context).accentColor.withOpacity(is_dark_mode ? 0.01 : 0.005),
                primaryBorder: BorderSide(color: FluentTheme.of(context).accentColor),
              ),
              child: Checkbox(
                onChanged: (value) => setState(() => student.updateAttendance(session_id: SessionManager.selected, new_val: value!)),
                checked: student.is_currently_present,
                content: Center(
                  child: Text("  ${student.is_currently_present ? "Pre" : " Ab"}sent  ")
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Expander(
    onStateChanged: (value) => setState(() => my_class.open_drop_down = widget.number),
    initiallyExpanded: widget.is_expand,
    trailing: Padding(
      padding: const EdgeInsets.only(right: factor),
      child: currentSection.students.isNotEmpty ? ProgressBar(
        value: (currentSection.students.where((element) => element.is_currently_present).length / currentSection.students.length) * 100,
        activeColor: currentSection.students.where((element) => element.is_currently_present).length != currentSection.students.length
            ? FluentTheme.of(context).resources.textFillColorTertiary
            : null,
      ) : null
    ),
    leading: const Icon(FluentIcons.people),
    header: Show.TheContextMenu(
      context,
      onEdit: () => currentSection.update_with_dialogBox(context, update),
      onDelete: () => my_class.delete_section_with_dialogBox(context, widget.update, widget.number),
      on: TheClickable(child: Text(currentSection.title)),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (currentSection.students.isNotEmpty)
          Column(
            children: List.generate(
              currentSection.students.length,
              (index) => makeTableEntry(context, index),
            ),
          ),
        my_spacing,
        IconButton(
          onPressed: () => my_class.create_student_with_dialogBox(context, update, widget.number),
          style: ButtonStyle(
            padding: ButtonState.all(const EdgeInsets.symmetric(vertical: factor)),
            shape: ButtonState.all(
              RoundedRectangleBorder(
                side: BorderSide(color: FluentTheme.of(context).resources.dividerStrokeColorDefault),
              ),
            ),
          ),
          icon: const Text("Add Student"),
        ),
        my_spacing,
      ],
    ),
  );
}
```