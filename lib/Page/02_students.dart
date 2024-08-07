import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'src/vertebrae.dart';
import 'src/commons.dart';

class DearStudents extends StatefulWidget {
  const DearStudents({super.key});

  @override
  State<DearStudents> createState() => _DearStudentsState();
}

class _DearStudentsState extends State<DearStudents> {
  final my_class = Class.selected;
  void update() => setState(() {});
  BaseButton get new_section {
    void onPressed() => my_class.create_section_with_dialogBox(context, update);
    const my_data = Row(
      children: [
        Icon(FluentIcons.add),
        SizedBox(width: factor + 10),
        Text("New Section", style: TextStyle(fontSize: factor)),
      ],
    );
    const m_space = EdgeInsets.symmetric(
      vertical: factor,
      horizontal: factor + 10,
    );
    const m_style = ButtonStyle(padding: WidgetStatePropertyAll(m_space));
    final my_side = RoundedRectangleBorder(borderRadius: BorderRadius.circular(factor - 10));

    return !is_dark_mode ^ my_class.sections.isEmpty
        ? Button(
            onPressed: onPressed,
            style: m_style.copyWith(
              shape: WidgetStatePropertyAll(
                  my_side.copyWith(side: const BorderSide(color: Colors.transparent)),
              ),
            ),
            child: my_data,
        )
        : IconButton(
          onPressed: onPressed,
          style: m_style.copyWith(
            shape: WidgetStatePropertyAll(
              my_side.copyWith(
                side: BorderSide(
                    color: is_dark_mode
                        ? FluentTheme.of(context).resources.dividerStrokeColorDefault
                        : FluentTheme.of(context).accentColor
                ),
              ),
            ),
            foregroundColor: WidgetStatePropertyAll(!is_dark_mode ? FluentTheme.of(context).accentColor : null),
          ),
          icon: my_data,
        );
  }
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
            new_section,          // New Section
          ],
        ),
      ),     // Session Info
      Expanded(
        child: ListView.builder(
          itemCount: my_class.sections.length,
          itemBuilder: (context_2, index) => TheDropDown(
            update, index,
            is_expand: index == my_class.open_drop_down,
          ),
        ),
      ),    // Section List
    ],
  );

  @override
  Widget build(BuildContext context) => my_class.i_should_fetch
  ? FutureBuilder<bool>(
    future: my_class.load(),
    builder: (context, snapshot) => snapshot.hasData
      ? the_content
      : Center(
        child: snapshot.hasError
          ? Text(snapshot.error.toString())
          : const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProgressBar(
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(height: factor + 5),
                Text("Just a Moment..."),
              ],
            ),
      )
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
  final my_class = Class.selected;
  void update() => setState(() {});
  Section get currentSection => my_class.sections[widget.number];
  Student studentAt(int index) => currentSection.students[index];

  material.DataRow makeTableEntry(BuildContext context, final int index) {
    material.DataCell canToggleAttendance({required final List<String> from}) => material.DataCell(
        Show.SmartContextMenu(
          context,
          onTap: () => setState(() => studentAt(index).toggleAttendance(session_id: SessionManager.selected)),
          onEdit: () => studentAt(index).update_with_dialogBox(context, update),
          onDelete: () => my_class.delete_student_with_dialogBox(context, update, widget.number, index),
          on: TheClickable(child: Text(from[index])),
        ),
    );

    return material.DataRow(cells: [
      canToggleAttendance(from: currentSection.students.map((e) => e.roll_no).toList()),
      canToggleAttendance(from: currentSection.students.map((e) => e.my_name).toList()),
      material.DataCell(AttendanceRecord(
        student: studentAt(index),
        update: update,
      )),  // Attendance Record
      material.DataCell(FocusTheme(
        data: FocusThemeData(
          primaryBorder: BorderSide(
            width: factor / 10,
              color: FluentTheme.of(context).accentColor.lighter
          ),
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
    leading: const Icon(FluentIcons.people), // People Icon
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
          material.DataTable(
            dividerThickness: 0.1,
            columns: List.generate(
              my_class.my_column.length,
              (index) => material.DataColumn(
                label: GestureDetector(
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
            ), // Headers
            rows: List.generate(
            currentSection.students.length,
            (index) => makeTableEntry(context, index),
          ),    // Rows (Elem)
        ),
        my_spacing,                    // Spacing
        IconButton(
          onPressed: () => my_class.create_student_with_dialogBox(context, update, widget.number),
          style: ButtonStyle(
            padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: factor)),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(factor - 10),
                side: BorderSide(color: FluentTheme.of(context).resources.dividerStrokeColorDefault),
              ),
            ),
          ),
          icon: const Text("Add Student"),
        ),               // Add Student
        my_spacing,                    // Spacing
      ],
    ),                    // Student Fields
  );
}

class AttendanceRecord extends StatelessWidget {
  const AttendanceRecord({
    required this.student,
    required this.update,
    super.key
  });

  final VoidCallback update;
  final Student student;

  bool get large_size => Class.selected.sessions.length > 5;

  @override
  Widget build(BuildContext context) {
    final recordController = FlyoutController();
    final record = student.attendance_record
        .where((element) => element)
        .length / student.attendance_record.length * 100;

    return FlyoutTarget(
      controller: recordController,
      child: GestureDetector(
        onTap: () => recordController.showFlyout(
          autoModeConfiguration: FlyoutAutoConfiguration(
            preferredMode: FlyoutPlacementMode.left,
          ),
          builder: (_) => StatefulBuilder(
            builder: (_, setState) {
              void updateAttendance(int index, bool value) {
                setState(() => student.updateAttendance(
                    session_id: index, new_val: value
                ));
                update();
              }
              return FlyoutContent(
                useAcrylic: true,
                padding: const EdgeInsets.only(
                  top: factor + 10,
                  bottom: factor - 5,
                ),
                constraints: BoxConstraints(
                  maxWidth: factor * (factor + 1) + 5 + (large_size ? 75 : 0),
                  maxHeight: factor * 25,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Attendance Record",
                      style: FluentTheme.of(context).typography.subtitle
                    ),        // Title
                    my_spacing,       // Spacing
                    Flexible(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: factor * 2 + 5),
                        shrinkWrap: true,
                        itemCount: Class.selected.sessions.length,
                        itemBuilder: (_, rec_idx) => GestureDetector(
                          onTap: () => updateAttendance(rec_idx, !student.attendance_record[rec_idx]),
                          child: Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.symmetric(
                              vertical: factor / (large_size ? 2 : 1),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Class.selected.sessions[rec_idx].for_records()
                                ),                      // The Date
                                if (large_size) Text(
                                    Session.weekDays[Class.selected.sessions[rec_idx].date.weekday - 1]
                                ),      // The Day
                                Checkbox(
                                  onChanged: (value) => updateAttendance(rec_idx, value!),
                                  checked: student.attendance_record[rec_idx],
                                ),                  // Checkbox
                              ],
                            ),
                          ),
                        ),
                        separatorBuilder: (_, __) => const Divider(
                          style: DividerThemeData(horizontalMargin: EdgeInsets.zero),
                        ),
                      ),
                    ),    // Records List
                  ],
                ),
              );
            },
          ),
        ),
        child: TheClickable(
          child: SizedBox(
            width: double.infinity,
            child: ProgressBar(
              value: record,
              backgroundColor: FluentTheme.of(context).inactiveBackgroundColor.withOpacity(0.4),
              activeColor: record != 100
                  ? FluentTheme.of(context).resources.textFillColorTertiary.withOpacity(0.4)
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
