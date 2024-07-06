import 'dart:convert';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';
import 'commons.dart';

class src {
  static final F1 = FocusNode();
  static final F2 = FocusNode();

  static final google_epoch = DateTime(1899,12,30);

  static Future<GSheets> get get_sheet_handle async {
    var json = await rootBundle.loadString('lib/client_secret.json');
    var cred = jsonDecode(json);
    return GSheets(cred);
  }
}

class Student {
  Student(this.roll_no, this.my_name) {
    attendance_record = List.generate(SessionManager.targeted_sessions.length, (index) => false);
  }
  Student.withRecord(this.roll_no, this.my_name, this.attendance_record);

  String roll_no = "N/A";
  String my_name = "N/A";
  List<bool> attendance_record = [];

  bool get is_currently_present => attendance_record[SessionManager.selected];

  void toggleAttendance({required int session_id}) => attendance_record[session_id] = !attendance_record[session_id];
  void updateAttendance({required int session_id, required new_val}) => attendance_record[session_id] = new_val;

  void update_with_dialogBox(BuildContext context, VoidCallback refresh) {
    final name = TextEditingController(text: my_name);
    final roll = TextEditingController(text: roll_no);
    showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
          title: const Text("Update Student"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextBox(
                controller: name,
                focusNode: src.F1,
                autofocus: true,
                onSubmitted: (val) => src.F2.requestFocus(),
                placeholder: "Name",
              ), // Ask Name
              my_spacing,
              TextBox(
                controller: roll,
                focusNode: src.F2,
                onSubmitted: (val) => Navigator.pop(context, true),
                placeholder: "Roll No",
              ), // Ask Roll No
            ],
          ),
          actions: ActionBar(context),
        ),
    ).then((value) {
      if (name.text == my_name && roll.text == roll_no) return;
      if (name.text.isEmpty || roll.text.isEmpty) {
        if (value!) TheMessage.Empty(context); return;
      }
      if (!value!) {
        TheMessage.Failure(context); return;
      }

      my_name = name.text;
      roll_no = roll.text;
      refresh();
      TheMessage.Success(context);
    });
  }
}

class Section {
  String title = "N/A";
  List<Student> students = [];

  void update_with_dialogBox(BuildContext context, VoidCallback refresh) {
    final name = TextEditingController(text: title);
    showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text("Edit Section"),
        content: TextBox(
          controller: name,
          autofocus: true,
          onSubmitted: (value) => Navigator.pop(context, true),
          placeholder: "Section Name",
        ),
        actions: ActionBar(context),
      ),
    ).then((value) {
      if (name.text == title) return;
      if (name.text.isEmpty) {
        if (value!) TheMessage.Empty(context); return;
      }
      if (!value!) {
        TheMessage.Failure(context); return;
      }

      title = name.text;
      refresh();
      TheMessage.Success(context);
    });
  }
}

class Session {
  static const weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  static const _monthNames = [
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

  DateTime date;
  Session(this.date);

  //String export_details() => date.toString().split(" ").first;
  String for_records() {
    final day = date.day;
    final formatted_day = day < 10 ? "0$day" : day.toString();
    final month = date.month;
    final month_name = _monthNames[month - 1];
    return "$formatted_day $month_name";
  }
  String formatted() {
    final day = date.day;
    final month = date.month;
    final year = date.year;
    final weekday = date.weekday;
    final day_suffix = day == 1 ? "st" : day == 2 ? "nd" : day == 3 ? "rd" : "th";
    final month_name = _monthNames[month - 1];
    final weekday_name = weekDays[weekday - 1];
    return "$weekday_name, $day$day_suffix $month_name $year";
  }
  String formatted_short() {
    final month = date.month;
    final year = date.year;
    final month_name = _monthNames[month - 1];
    return "$month_name, $year";
  }
  static String only_date(DateTime date) => "${date.day}${date.month}${date.year}";
  bool get is_selected => formatted() == SessionManager.currentSession.formatted();
  ListTile makeDateTile({required VoidCallback onTap, bool selected = false}) => ListTile.selectable(
    selected: selected,
    onPressed: onTap,
    leading: Text(
      " ${date.day < 10 ? "0${date.day}" : "${date.day}"}",
      style: const TextStyle(
        fontSize: factor + 11,
        fontWeight: FontWeight.bold,
      ),
    ),
    title: Text(formatted_short()),
    subtitle: Text(weekDays[date.weekday - 1],
      style: TextStyle(
        color: (is_dark_mode ? Colors.white : Colors.black).withOpacity(0.6),
      ),
    ),
    trailing: is_selected ? null : only_date(date) == only_date(DateTime.now())
        ? Italy("Today") : only_date(date) == only_date(DateTime.now().subtract(const Duration(days: 1)))
        ? Italy("Yesterday") : null,
  );
  void update(BuildContext context, VoidCallback refresh) {
    DateTime intermediate = date;
    showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        
        title: const Text("Edit Session"),
        content: DatePicker(
          selected: date,
          onChanged: (value) => intermediate = value,
          onCancel: () => Navigator.pop(context, false),
        ),
        actions: ActionBar(context),
      ),
    ).then((value) {
      if (value!) {
        date = intermediate; refresh();
        Show.TheInfoBar(
          context,
          title: "Edited",
          detail: "Session date edited!",
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
}

class SessionManager {
  static List<Session> get targeted_sessions => Class.selected.sessions;

  static int _selected = targeted_sessions.length - 1;
  static void update_selected({int? to}) => _selected = to ?? targeted_sessions.length - 1;
  static int get selected => _selected;

  static Session get currentSession => targeted_sessions[selected];
  static ListTile currentTile(BuildContext context, VoidCallback refresh) => currentSession.makeDateTile(onTap: () => showDialog(
    context: context,
    builder: (context) => ContentDialog(
      constraints: const BoxConstraints(
        maxHeight: factor * 50,
        maxWidth: factor * 30,
      ),
      title: const Center(
          child: Text("Load a Session")
      ),
      content: ListView.builder(
        shrinkWrap: true,
        itemCount: targeted_sessions.length,
        itemBuilder: (context_2, index) => Row(
          children: [
            SizedBox(
              width: 342,
              child: targeted_sessions[index].makeDateTile(
                selected: index == selected,
                onTap: () {
                  update_selected(to: index);
                  refresh();
                  Show.TheInfoBar(context, title: "Loaded", detail: targeted_sessions[index].formatted());
                  Navigator.pop(context);
                },
              ),
            ),        // Date Tile
            const Spacer(),       // Spacer
            IconButton(
              style: ButtonStyle(
                padding: ButtonState.all(const EdgeInsets.all(factor)),
              ),
              icon: const Icon(FluentIcons.delete, size: factor + 7),
              onPressed: () => SessionManager.removeAt(context, index, refresh: refresh),
            ),      // Delete Button
          ],
        ),
      ),
      actions: [
        Button(
          child: const Text("New Session"),
          onPressed: () => addCurrent(context, refresh: refresh),
        ),
        TheCancelButton(context),
      ],
    ),
  ));

  static void addCurrent(BuildContext context, {VoidCallback? refresh}) {
    final current_session = Session(DateTime.now());
    final already_exists = targeted_sessions.any((session) => session.formatted() == current_session.formatted());
    if (already_exists) {
      Show.TheInfoBar(
        context,
        title: "Cancelled",
        detail: "A session for today already exists!",
        type: InfoBarSeverity.warning,
      );
    }
    else {
      TheMessage.Created(context, "Session");
      targeted_sessions.add(current_session);
      update_selected();
      for (final section in Class.selected.sections) {
        for (final student in section.students) {
          if (student.attendance_record.length < targeted_sessions.length) {
            student.attendance_record.add(false);
          }
        }
      }
      refresh!();
      Navigator.of(context).pop();
    }
  }
  static void removeAt(BuildContext context, int index, {VoidCallback? refresh}) {
    if (targeted_sessions.length == 1) {
      Show.TheInfoBar(
        context,
        title: "Cancelled",
        detail: "There must be at least one session!",
        type: InfoBarSeverity.warning,
      );
    }
    else {
      showDialog<bool>(
        context: context,
        builder: (context) => ContentDialog(
          title: const Text("Remove Session"),
          content: const Text("Removing this session will also remove all attendance records for this session."),
          actions: ActionBar(context, focus: "Remove"),
        ),
      ).then((value) {
        if (value!) {
          TheMessage.Delete(context, "Session");
          targeted_sessions.removeAt(index);
          for (final section in Class.selected.sections) {
            for (final student in section.students) {
              student.attendance_record.removeAt(index);
            }
          }
          update_selected();
          refresh!();
          Navigator.of(context).pop();
        }
      });
    }
  }
}

class Class {
  Class();
  Class.defined(this.class_title, this.description);

  static int current_class_i = 0;
  static List<Class> classes = [
    Class.defined("Programming", "1st Semester")..my_sheet_id = "1Ynpwr8fLrKMKCI7oIUFMiJPueifYGBhorC7F9r8FAKk",
    Class.defined("Physics", "2nd Semester")..my_sheet_id = "1JaoWhLODlQU_lEI0oyFvXdfRDS6a2vyDHKy8f1TrseY",
    Class.defined("Mathematics", "3rd Semester")..my_sheet_id = "1fcFNDsPhAqu7sQaDIPkaKJXyHuaVMu9qIk95t19Ll54",
    Class.defined("Object Oriented Programming", "4th Semester"),
    Class.defined("Data Structures", "5th Semester"),
    Class.defined("Algorithms", "6th Semester"),
    Class.defined("Calculus", "7th Semester"),
    Class.defined("Algebra", "8th Semester"),
  ];
  static Class get selected => classes[current_class_i];
  static String default_one = "1L85rCcuVKXJ0hiaBypqUpnrmSycfe4I-LTsVGquFiRQ";

  String class_title = "";
  String description = "";
  String my_sheet_id = "";

  String prefix_roll = "";
  String prefix_name = "";
  var open_drop_down = 0;
  var i_should_fetch = true;

  List<String> my_column = [];
  List<Section> sections = [];
  List<Session> sessions = [];
  Future<bool> load() async {
    final my_sheet = await (await src.get_sheet_handle).spreadsheet(
      my_sheet_id.isEmpty ? default_one : my_sheet_id,
    );

    // Loading Settings
    for (final row in await my_sheet.sheets.last.values.allRows()) {
      if (row.first == "TopRow:") {
        my_column = row.skip(1)
            .where((element) => element.isNotEmpty)
            .toList();
      }
      else if (row.first == "Sessions:") {
        sessions = row.skip(1)
            .where((element) => element.isNotEmpty)
            .map((e) => Session(src.google_epoch.add(Duration(days: int.parse(e)))))
            .toList();
      }
    }

    // If no sessions are found, add a new one
    if (sessions.isEmpty) sessions.add(Session(DateTime.now()));

    // If no column is found, add a default one
    if (my_column.isEmpty) {
      my_column = ["Roll Number", "Name", "Record", "Attendance"];
    }

    print(my_column);
    print(sessions
        .map((e) => e.date.toString()
        .split(" ").first)
        .toList()
    );

    // Section Loading
    final cache_sections = <Section>[];
    for (var i = 0; i < my_sheet.sheets.length - 1; i++) {
      final worksheet = my_sheet.sheets[i];
      final rows_data = await worksheet.values
          .allRows()
          .then((value) => value.skip(1)
          .toList());

      print("");
      print(worksheet.title);
      final mySection = Section()..title = worksheet.title;

      // Student Loading
      for (final student_data in rows_data) {
        final myName = student_data[0];
        final myRoll = student_data[1];
        final Record = List.generate(sessions.length, (index) => index < student_data.length - 2 && student_data[index + 2].isNotEmpty);
        mySection.students.add(Student.withRecord(myName, myRoll, Record));
        print("$Record: $student_data");
      }
      cache_sections.add(mySection);
    }
    sections = cache_sections;

    // Finalizing
    SessionManager.update_selected();
    i_should_fetch = false;
    return true;
  }

  void create_section_with_dialogBox(BuildContext context, VoidCallback refresh) {
    final newSection = TextEditingController();
    showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text("Add a New Section"),
        content: TextBox(
          autofocus: true,
          controller: newSection,
          onSubmitted: (val) => Navigator.pop(context, true),
          placeholder: "Section Name",
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Add"),
          ),
          Button(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
        ],
      ),
    ).then((value) {
      if (newSection.text.isEmpty) {
        if (value!) TheMessage.Empty(context); return;
      }
      if (!value!) {
        TheMessage.Failure(context); return;
      }

      sections.add(Section()..title = newSection.text);
      open_drop_down = sections.length - 1;
      refresh();
      TheMessage.Created(context, "Section");
    });
  }
  void delete_section_with_dialogBox(BuildContext context, VoidCallback refresh, int index) => Show.DeleteDialog(
    context,
    name: "Section",
    onDelete: () {
      sections.removeAt(index);
      TheMessage.Delete(context, "Section");
      refresh();
    },
  );

  void setting_prefix_with_dialogBox(BuildContext context, TextEditingController roll, TextEditingController name) {
    final Focus3 = FocusNode();
    final Focus4 = FocusNode();
    final p_roll = TextEditingController(text: prefix_roll);
    final p_name = TextEditingController(text: prefix_name);
    showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text("Prefix Settings"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Prefixes are only used while adding a new student",
            ),  // Note
            my_spacing,
            my_spacing,
            const Divider(),
            my_spacing,
            my_spacing,
            TextBox(
              focusNode: Focus3,
              controller: p_name,
              onSubmitted: (value) => FocusScope.of(context).requestFocus(Focus4),
              placeholder: "Prefix for Name",
            ),    // Ask Name Prefix
            my_spacing,
            TextBox(
              focusNode: Focus4,
              autofocus: true,
              controller: p_roll,
              onSubmitted: (val) => Navigator.pop(context, true),
              placeholder: "Prefix for Roll Number",
            ),    // Ask Roll No Prefix
          ],
        ),
        actions: ActionBar(context),
      ),
    ).then((value) {
      if (p_roll.text == prefix_roll && p_name.text == prefix_name) return;
      if (!value!) {
        TheMessage.Failure(context); return;
      }

      roll.text = prefix_roll = p_roll.text;
      name.text = prefix_name = p_name.text;
      TheMessage.Success(context);
    });
  }
  void create_student_with_dialogBox(BuildContext context, VoidCallback refresh, int section_id) {
    final c1_roll = TextEditingController(text: prefix_roll);
    final c2_name = TextEditingController(text: prefix_name);
    showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Add Student"),      // Title Text
            OutlinedButton(
              style: ButtonStyle(
                shape: ButtonState.all(
                  RoundedRectangleBorder(
                    side: BorderSide(color: FluentTheme.of(context).resources.dividerStrokeColorDefault),
                  ),
                ),
                padding: ButtonState.all(const EdgeInsets.symmetric(
                    vertical: factor,
                    horizontal: factor * 2
                )),
              ),
              onPressed: () => setting_prefix_with_dialogBox(
                context,
                c1_roll,
                c2_name,
              ),
              child: const Icon(FluentIcons.increase_indent, size: factor + 5),
            )       // Prefix Button
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextBox(
              focusNode: src.F1,
              autofocus: true,
              controller: c2_name,
              onSubmitted: (value) => FocusScope.of(context).requestFocus(src.F2),
              placeholder: "Name",
            ),    // Ask Name
            my_spacing,
            TextBox(
              focusNode: src.F2,
              controller: c1_roll,
              onSubmitted: (val) => Navigator.pop(context, true),
              placeholder: "Roll Number",
            ),    // Ask Roll No
          ],
        ),
        actions: ActionBar(context, focus: "Add"),
      ),
    ).then((value) {
      if (c2_name.text.isEmpty || c1_roll.text.isEmpty) {
        if (value!) TheMessage.Empty(context); return;
      }
      if (!value!) {
        TheMessage.Failure(context); return;
      }

      sections[section_id].students.add(Student(c1_roll.text, c2_name.text));
      refresh();
      TheMessage.Created(context, "Student");
    });
  }
  void delete_student_with_dialogBox(BuildContext context, VoidCallback refresh, int section_id, int index) => Show.DeleteDialog(
    context,
    name: "Student",
    onDelete: () {
      sections[section_id].students.removeAt(index);
      refresh();
    },
  );

  static
  void create_with_dialogBox(BuildContext context, VoidCallback refresh) {
    Class newClass = Class();
    showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text("Create a New Class"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextBox(
              focusNode: src.F1,
              autofocus: true,
              onChanged: (val) => newClass.class_title = val,
              onSubmitted: (value) => FocusScope.of(context).requestFocus(src.F2),
              placeholder: "Name",
            ),    // Ask Name
            my_spacing,
            TextBox(
              focusNode: src.F2,
              onChanged: (val) => newClass.description = val,
              onSubmitted: (val) => Navigator.pop(context, true),
              placeholder: "Description",
            ),    // Ask Description
          ],
        ),
        actions: ActionBar(context, focus: "Create"),
      ),
    ).then((value) {
      if (newClass.class_title.isEmpty) {
        if (value!) TheMessage.Empty(context); return;
      }
      if (!value!) {
        TheMessage.Failure(context); return;
      }

      classes.add(newClass);
      refresh();
      TheMessage.Created(context, "Class");
    });
  }
  void update_with_dialogBox(BuildContext context, VoidCallback refresh) {
    final c1_name = TextEditingController(text: class_title);
    final c2_subtitle = TextEditingController(text: description);
    showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text("Update Class"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextBox(
              focusNode: src.F1,
              autofocus: true,
              controller: c1_name,
              onSubmitted: (value) => FocusScope.of(context).requestFocus(src.F2),
              placeholder: "Name",
            ), // Ask Name
            my_spacing,
            TextBox(
              focusNode: src.F2,
              controller: c2_subtitle,
              onSubmitted: (val) => Navigator.pop(context, true),
              placeholder: "Description",
            ), // Ask Description
          ],
        ),
        actions: ActionBar(context),
      ),
    ).then((value) {
      if (c1_name.text == class_title && c2_subtitle.text == description) return;
      if (c1_name.text.isEmpty) {
        (value! ? TheMessage.Empty : TheMessage.Failure)(context); return;
      }
      if (!value!) {
        TheMessage.Failure(context); return;
      }

      class_title = c1_name.text;
      description = c2_subtitle.text;
      refresh();
      TheMessage.Success(context);
    });
  }
  static
  void delete_with_dialogBox(BuildContext context, VoidCallback refresh, int index) => Show.DeleteDialog(
    context,
    name: "Class",
    onDelete: () {
      classes.removeAt(index);
      refresh();
      TheMessage.Delete(context, "Class");
    },
  );
}