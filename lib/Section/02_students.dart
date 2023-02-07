import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'src/vertebrae.dart';
import 'src/commons.dart';

final weekDays = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

final monthNames = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

List<DateTime> sessions_all = [
  DateTime(2023, 2, 5),
  DateTime(2023, 2, 3),
  DateTime(2023, 1, 31),
  DateTime(2023, 1, 29),
  DateTime.now().subtract(const Duration(days: 1)),
];

class DearStudents extends StatefulWidget {
  const DearStudents({Key? key}) : super(key: key);
  static int expanded_menu = 0;
  static int selected_session = sessions_all.length - 1;

  @override
  State<DearStudents> createState() => _DearStudentsState();
}

class _DearStudentsState extends State<DearStudents> {
  void update() => setState(() {});
  ListView get the_content => ListView.builder(
    itemCount: API.sections.length,
    itemBuilder: (context_2, index) => TheDropDown(
      update, index,
      is_expand: index == DearStudents.expanded_menu,
    ),
  );

  static bool to_load = true;
  static String the_short_date({required DateTime of}) => "${monthNames[of.month - 1]}, ${of.year}";
  static String the_date({required DateTime of}) => "${of.day} ${the_short_date(of: of)}";
  static ListTile makeDateTile(DateTime date, {required VoidCallback onTap}) => ListTile(
    onPressed: onTap,
    leading: Text(
      date.day < 10 ? "0${date.day}" : "${date.day}",
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    ),
    title: Text(the_short_date(of: date)),
    subtitle: Text(weekDays[date.weekday - 1]),
    trailing: date.day == sessions_all[DearStudents.selected_session].day
        ? null
        : date.day == DateTime.now().day
            ? const Text("Today")
            : date.day == DateTime.now().day - 1
                ? const Text("Yesterday") : null,
  );

  void addSection(BuildContext context) => showDialog(
    context: context,
    builder: (context) {
      String newSection = "";
      void cancelSection() {
        Show.infoBar(
          context,
          type: InfoBarSeverity.warning,
          title: "Cancelled",
          detail: "Section was not added",
        );
        Navigator.pop(context);
      }
      void returnSection() {
        if (newSection.isNotEmpty) {
          Show.infoBar(
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
  Widget build(BuildContext context) => ScaffoldPage(
      header: PageHeader(
        padding: factor + 10,
        title: makeDateTile(sessions_all[DearStudents.selected_session], onTap: () => showDialog(
          context: context,
          builder: (context) => ContentDialog(
            title: const Text("Load a Session"),
            content: ListView.builder(
              shrinkWrap: true,
              itemCount: sessions_all.length,
              itemBuilder: (context_2, index) => makeDateTile(
                sessions_all[index],
                onTap: () {
                  setState(() => DearStudents.selected_session = index);
                  Navigator.pop(context);
                },
              ),
            ),
            actions: [
              FilledButton(
                style: button_pad,
                child: const Text("New Session"),
                onPressed: () {
                  final current_session = DateTime.now();
                  final already_exists = sessions_all.any((session) => the_date(of: session) == the_date(of: current_session));
                  if (already_exists) {
                    Show.infoBar(
                      context,
                      title: "Cancelled",
                      detail: "You can only have one session per day",
                      type: InfoBarSeverity.warning,
                    );
                  }
                  else {
                    Show.infoBar(
                      context,
                      title: "Added",
                      detail: "New session added!",
                    );
                    sessions_all.add(current_session);
                    DearStudents.selected_session = sessions_all.length - 1;
                    update();
                    Navigator.of(context).pop();
                  }
                },
              ),
              Button(
                style: button_pad,
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
            ],
          ),
        )),
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
  Section thisSection() => API.sections[widget.number];
  Student studentAt(int index) => thisSection().students[index];

  material.DataRow makeTableEntry(BuildContext context, final int index) {
    material.DataCell canToggleAttendance({required final List<String> from}) =>
        material.DataCell(
          Show.SmartNativeContextMenu(
            context,
            onTap: () => setState(() => studentAt(index).toggleAttendance()),
            onEdit: () => studentAt(index).dialogBox_Update(context, update),
            onDelete: () => Student.dialogBox_Delete(context, update, widget.number, index),
            on: Text(from[index]),
          ),
        );

    return material.DataRow(cells: [
      canToggleAttendance(from: thisSection().students.map((e) => e.roll_no).toList()),
      canToggleAttendance(from: thisSection().students.map((e) => e.name).toList()),
      canToggleAttendance(from: thisSection().students.map((e) => e.cgpa).toList()),
      material.DataCell(Checkbox(
        onChanged: (value) => setState(() => studentAt(index).updateAttendance(value!)),
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
    trailing: thisSection().students.isNotEmpty
        ? Text(
          "Present: ${thisSection().students.where((element) => element.attendance).length} / ${thisSection().students.length}",
        )               // Present Count
        : const Icon(FluentIcons.people),
    leading: const Icon(FluentIcons.people),     // People Icon
    header: Show.NativeContextMenu(
      context,
      onEdit: () => thisSection().dialogBox_Update(context, update),
      onDelete: () => Section.dialogBox_Delete(context, widget.update, widget.number),
      on: Text(thisSection().title),
    ),                            // Worksheet Name
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (thisSection().students.isNotEmpty)
          material.DataTable(
            columns: List.generate(
              Student.top_row.length,
              (index) => material.DataColumn(label: Text(Student.top_row[index])),
            ), // Headers
            rows: List.generate(
            thisSection().students.length,
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