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
            IconButton(
              onPressed: () => Section.adding_with_dialogBox(context, update),
              style: ButtonStyle(
                padding: ButtonState.all(const EdgeInsets.symmetric(
                    vertical: factor,
                    horizontal: factor + 10
                )),
                border: ButtonState.all(BorderSide(color: FluentTheme.of(context).resources.dividerStrokeColorDefault)),
              ),
              icon: Row(
                children: const [
                  Icon(FluentIcons.add),
                  SizedBox(width: factor + 10),
                  Text("New Section", style: TextStyle(fontSize: factor)),
                ],
              ),
            ),          // New Section
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
    material.DataCell canToggleAttendance({required final List<String> from}) => material.DataCell(
        Show.SmartContextMenu(
          context,
          onTap: () => setState(() => studentAt(index).toggleAttendance(session_id: SessionManager.selected)),
          onEdit: () => studentAt(index).update_with_dialogBox(context, update),
          onDelete: () => Student.delete_with_dialogBox(context, update, widget.number, index),
          on: TheClickable(child: Text(from[index])),
        ),
    );
    FlyoutTarget makeRecordBar() {
      final recordController = FlyoutController();
      final record = studentAt(index).attendance_record
          .where((element) => element)
          .length / studentAt(index).attendance_record.length * 100;

      return FlyoutTarget(
        controller: recordController,
        child: GestureDetector(
          onTap: () => recordController.showFlyout(
            autoModeConfiguration: FlyoutAutoConfiguration(
              preferredMode: FlyoutPlacementMode.bottomRight,
            ),
            builder: (context) => AttendanceRecord(
              state: this,
              index: index,
            ),
          ),
          child: TheClickable(
            child: ProgressBar(
              value: record,
              backgroundColor: FluentTheme.of(context).inactiveBackgroundColor.withOpacity(0.4),
              activeColor: record != 100
                  ? FluentTheme.of(context).resources.textFillColorTertiary.withOpacity(0.4)
                  : null,
            ),
          ),
        ),
      );
    }

    return material.DataRow(cells: [
      canToggleAttendance(from: currentSection.students.map((e) => e.roll_no).toList()),
      canToggleAttendance(from: currentSection.students.map((e) => e.my_name).toList()),
      material.DataCell(makeRecordBar()),     // Attendance Record
      material.DataCell(FocusTheme(
        data: FocusThemeData(
          glowColor: FluentTheme.of(context).accentColor.withOpacity(
              FluentTheme.of(context).brightness == Brightness.dark ? 0.01 : 0.005
          ),
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
      )),     // Attendance
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
    header: Show.TheContextMenu(
      context,
      onEdit: () => currentSection.update_with_dialogBox(context, update),
      onDelete: () => Section.delete_with_dialogBox(context, widget.update, widget.number),
      on: TheClickable(child: Text(currentSection.title)),
    ),        // Worksheet Name
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
                        : index == 1 ? a.my_name.compareTo(b.my_name)
                        : index == 2 ? b.attendance_record.where((element) => element).length.compareTo(a.attendance_record.where((element) => element).length)
                        : index == 3 ? a.is_currently_present == b.is_currently_present ? 0 : a.is_currently_present ? -1 : 1
                        : 0
                  )),
                  child: TheClickable(child: Text(Section.top_row[index]), width: false),
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
          onPressed: () => Student.adding_with_dialogBox(context, update, widget.number),
          style: ButtonStyle(
            padding: ButtonState.all(const EdgeInsets.symmetric(vertical: factor)),
            border: ButtonState.all(BorderSide(color: FluentTheme.of(context).resources.dividerStrokeColorDefault)),
          ),
          icon: const Text("Add Student"),
        ),                   // Add Student
        my_spacing,                    // Spacing
      ],
    ),                    // Student Fields
  );
}


class AttendanceRecord extends StatefulWidget {
  const AttendanceRecord({
    required this.state,
    required this.index,
    Key? key
  }) : super(key: key);

  final _TheDropDownState state;
  final int index;

  @override
  State<AttendanceRecord> createState() => _AttendanceRecordState();
}

class _AttendanceRecordState extends State<AttendanceRecord> {
  Student get currentStudent => widget.state.currentSection.students[widget.index];
  bool get bad_size => SessionManager.the_list.length > 5;

  void updateAttendance(int index, bool value) {
    setState(() => currentStudent.updateAttendance(
        session_id: index, new_val: value
    ));
    widget.state.update();
  }

  @override
  Widget build(BuildContext context) => FlyoutContent(
    useAcrylic: true,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: factor + 10),
      constraints: BoxConstraints(
        maxWidth: bad_size ? 300 : factor * factor,
        maxHeight: factor * 25,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          my_spacing,       // Spacing
          Text(
              "Attendance Record",
              style: FluentTheme.of(context).typography.subtitle
),        // Title
          my_spacing,       // Spacing
          Flexible(
            child: ListView.separated(
              padding: bad_size
                  ? const EdgeInsets.only(right: factor + 5)
                  : null,
              shrinkWrap: true,
              itemCount: SessionManager.the_list.length,
              itemBuilder: (context_2, rec_index) => GestureDetector(
                onTap: () => updateAttendance(rec_index, !currentStudent.attendance_record[rec_index]),
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: factor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        SessionManager.the_list[rec_index].for_records(),
                        style: FluentTheme.of(context_2).typography.body,
                      ),        // Date
                      Checkbox(
                        onChanged: (value) => updateAttendance(rec_index, value!),
                        checked: currentStudent.attendance_record[rec_index],
                      ),    // Checkbox
                    ],
                  ),
                ),
              ),
              separatorBuilder: (context, index) => const Divider(
                style: DividerThemeData(horizontalMargin: EdgeInsets.zero),
              ),
            ),
          ),    // Records List
        ],
      ),
    ),
  );
}
