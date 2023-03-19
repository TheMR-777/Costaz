import 'package:fluent_ui/fluent_ui.dart';
import 'package:gsheets/gsheets.dart';
import '../98_settings.dart';
import 'commons.dart';

class src {
  static final google_epoch = DateTime(1899,12,30);
  static const credentials = r'''
  {
    "type": "service_account",
    "project_id": "costaz-desktop-project",
    "private_key_id": "e6d2d4bcb9bfe91962caf520c00ee003f9f05d30",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDhbuAW8ka7YIw3\nJVxDCOJorUBASE4TARkaGE4en1gpRDwoXJrzaXz3A9uKkuCsYxR8oiM6Kiq5kPOB\n1xST6CEoTmuozSgx+RQRKyLXYzl80pcz1KpsHJ7zpXBCuxV9mOHPZunNwD4Gxbvb\nYzNrAwbB5aJfwNhR44nZrdVDXkCPosrijfDxzqEeBUdBFZZz9LyvC5BTQ6FvLbz7\nx9KceuoKSueTXrE9pulQt2nQjZhDstKIAbDeEuNjXTQ7KuQWTx/E4IjkTDP+zZ6b\nrlRpPNTV00VgSP8UHBNvBKIIZiDi8DvscGGE7u9br3KGFLgmXj7Rp/ncFoy2yG94\ngcFs9EKVAgMBAAECggEAcAyasH0awB7kgrJ8scsUMiBPC8SEnfiRQAGtrpXYDabf\nWdZxpCQeG28c67tGlhinQa2bYdk8pECScEp17XBXLsAPzfavEGuz2Da/Ghy1IcBQ\nrE/7p0Hwlbz42ApCS8u2DU8jTgPMMLSOw6SClaGK9cxMUVi6jLVSutIm6tXJtDow\no1Fk85hJCMlVRU7VoYzbpnCCrU5+37HjLM+TeW+4qYoolMgGJYVKtc4xbupVMu5c\n/ho0JTcbS4AGmxopfBtcewpeOKOLXPPnYTyom53arOeIp9fOUpl1ZxuJ2KJduqbm\nhyMZ31ZXhE+P1/a1Tjjjjp+pMPrfxwh+nN2KNlFeHwKBgQD6r1s5bC0KbJ2Ghc7M\nG9C/tQjgkSUCG+BsnBeTVeHcWQ4jEAUrOmxKpdONr6oMpoVWvdICwR0yb/nV3Qjg\nfvzU9OnnBSt84uvDYlF3a9rMML88YvvM+Gyot4UReudtwABvGnoIiyrQ+xbIp+HB\njosBsUB+fXYV32GxdcsQgvhaLwKBgQDmNnWVEJAkDvd020r6zJ8YrkvoNtS2O4zi\nvI0gnTics+gpXvBFCuxf69c9kvt9lXCpf1oo1aRgAM4CXcv4V8eK4wW/MnIjMUer\neOTT1wAV/bykwgaqJ1l8z7hMaSNQQm0k8huvZoof/74XI1VfEedmCzwLEpVgkOmj\nmRCsyghyewKBgG818BBvbyPav594KR/fjyIdHA0UFwjyeQN10/em+AYa8+yWJNTi\nnDwZiNqofZYTIcAzgcF7Dorbpkg8QL3nWB7ZcBLu9jX3LYSGT4HdNTm0voH5n590\n7i+DCuOQVK8ZqJehdVXo91uyqI7n+3000XI0wlnbKtHVQa/KhAWVNLw9AoGBANyl\nyeELtPu6lJceMCldwgdH111EYHAhd5FCIwnlZwNas+QjKKskIxZ01yIfJIhjmU37\n0BBfZGLXopxGBl+K0qhdm357/UWZ0BWbk8cuxNhPEGXhyb2AZZbpCL3D76LXaAEH\nRF3DLBQrbKiEpyit4lm93tjGAQJDIow5AvB528rNAoGBAMP4sEo36hXrIZ7VfWu7\nfJ7JIGHQ8pWQXsqVqcmrPMwwqkB7ki5C3lR8XTBpKcqlOi48dEkNAvOnbxPUXOcu\nEufAOtjBPSr/P0aha/QfYUJnRGF/wPu/Yd/6OSyZCmKHBfhVayo18o0zGS9Jt755\nnTGeqsGDC5Whsmrvi9VwMjHu\n-----END PRIVATE KEY-----\n",
    "client_email": "i-am-testing-it@costaz-desktop-project.iam.gserviceaccount.com",
    "client_id": "117779218770242619646",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/i-am-testing-it%40costaz-desktop-project.iam.gserviceaccount.com"
  }
  ''';

  static const the_sample_sheet = "1Ynpwr8fLrKMKCI7oIUFMiJPueifYGBhorC7F9r8FAKk";

  static final gsheet_handle = GSheets(src.credentials);
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
    final _01 = FocusNode();
    final _02 = FocusNode();
    String name = my_name;
    String roll = roll_no;
    showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
          title: const Text("Update Student"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormBox(
                focusNode: _01,
                autofocus: true,
                onChanged: (val) => name = val,
                onFieldSubmitted: (val) => _02.requestFocus(),
                placeholder: "Name",
                initialValue: name,
              ), // Ask Name
              my_spacing,
              TextFormBox(
                focusNode: _02,
                onChanged: (val) => roll = val,
                onFieldSubmitted: (val) => Navigator.pop(context, true),
                placeholder: "Roll No",
                initialValue: roll,
              ), // Ask Roll No
            ],
          ),
          actions: ActionBar(context),
        ),
    ).then((value) {
      if (name == my_name && roll == roll_no) return;
      if (name.isEmpty || roll.isEmpty) {
        if (value!) TheMessage.Empty(context); return;
      }
      if (!value!) {
        TheMessage.Failure(context); return;
      }

      my_name = name;
      roll_no = roll;
      refresh();
      TheMessage.Success(context);
    });
  }
}

class Section {
  String title = "N/A";
  List<Student> students = [];

  void update_with_dialogBox(BuildContext context, VoidCallback refresh) {
    String name = title;
    showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text("Edit Section"),
        content: TextFormBox(
          autofocus: true,
          onChanged: (value) => name = value,
          onFieldSubmitted: (value) => Navigator.pop(context, true),
          initialValue: name,
          placeholder: "Section Name",
        ),
        actions: ActionBar(context),
      ),
    ).then((value) {
      if (name == title) return;
      if (name.isEmpty) {
        if (value!) TheMessage.Empty(context); return;
      }
      if (!value!) {
        TheMessage.Failure(context); return;
      }

      title = name;
      refresh();
      TheMessage.Success(context);
    });
  }
}

class Session {
  static const _weekDays = [
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

  String export_details() => date.toString().split(" ").first;
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
    final weekday_name = _weekDays[weekday - 1];
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
    subtitle: Text(_weekDays[date.weekday - 1],
      style: TextStyle(
        color: (TheTheme.is_dark ? Colors.white : Colors.black).withOpacity(0.6),
      ),
    ),
    trailing: is_selected ? null : only_date(date) == only_date(DateTime.now())
        ? const Text("Today") : only_date(date) == only_date(DateTime.now().subtract(const Duration(days: 1)))
        ? const Text("Yesterday") : null,
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
      title: const Text("Load a Session"),
      content: Card(
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: targeted_sessions.length,
          itemBuilder: (context_2, index) => Row(
            children: [
              const SizedBox(
                  width: factor - 10
              ),  // Padding
              SizedBox(
                width: 300 - factor,
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
              const SizedBox(
                  width: factor
              ),  // Padding
            ],
          ),
          separatorBuilder: (context, index) => const Divider(),
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
    final my_sheet = await src.gsheet_handle.spreadsheet(
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
    String newSection = "";
    showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text("Add a New Section"),
        content: TextBox(
          autofocus: true,
          onChanged: (val) => newSection = val,
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
      if (newSection.isEmpty) {
        if (value!) TheMessage.Empty(context); return;
      }
      if (!value!) {
        TheMessage.Failure(context); return;
      }

      sections.add(Section()..title = newSection);
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

  void setting_prefix_with_dialogBox(BuildContext context) {
    final _01 = FocusNode();
    final _02 = FocusNode();
    String p_roll = prefix_roll;
    String p_name = prefix_name;
    showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text("Setting Prefix"),
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
            TextFormBox(
              focusNode: _01,
              initialValue: p_name,
              onChanged: (val) => p_name = val,
              onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_02),
              placeholder: "Prefix for Name",
            ),    // Ask Name Prefix
            my_spacing,
            TextFormBox(
              focusNode: _02,
              autofocus: true,
              initialValue: p_roll,
              onChanged: (val) => p_roll = val,
              onFieldSubmitted: (val) => Navigator.pop(context, true),
              placeholder: "Prefix for Roll Number",
            ),    // Ask Roll No Prefix
          ],
        ),
        actions: ActionBar(context),
      ),
    ).then((value) {
      if (p_roll == prefix_roll && p_name == prefix_name) return;
      if (!value!) {
        TheMessage.Failure(context); return;
      }

      prefix_roll = p_roll;
      prefix_name = p_name;
      TheMessage.Success(context);
    });
  }
  void create_student_with_dialogBox(BuildContext context, VoidCallback refresh, int section_id) {
    final _01 = FocusNode();
    final _02 = FocusNode();
    String roll = prefix_roll;
    String name = "";
    showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Add Student"),      // Title Text
            OutlinedButton(
              style: ButtonStyle(
                border: ButtonState.all(BorderSide(color: FluentTheme.of(context).resources.dividerStrokeColorDefault)),
                padding: ButtonState.all(const EdgeInsets.symmetric(
                    vertical: factor,
                    horizontal: factor * 2
                )),
              ),
              onPressed: () => setting_prefix_with_dialogBox(context),
              child: const Icon(FluentIcons.increase_indent, size: factor + 5),
            )       // Prefix Button
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormBox(
              focusNode: _01,
              autofocus: true,
              initialValue: prefix_name,
              onChanged: (val) => name = val,
              onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_02),
              placeholder: "Name",
            ),    // Ask Name
            my_spacing,
            TextFormBox(
              focusNode: _02,
              onChanged: (val) => roll = val,
              initialValue: roll,
              onFieldSubmitted: (val) => Navigator.pop(context, true),
              placeholder: "Roll Number",
            ),    // Ask Roll No
          ],
        ),
        actions: ActionBar(context, focus: "Add"),
      ),
    ).then((value) {
      if (name.isEmpty || roll.isEmpty) {
        if (value!) TheMessage.Empty(context); return;
      }
      if (!value!) {
        TheMessage.Failure(context); return;
      }

      sections[section_id].students.add(Student(roll, name));
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
    final _01 = FocusNode();
    final _02 = FocusNode();
    Class newClass = Class();
    showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text("Create a New Class"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextBox(
              focusNode: _01,
              autofocus: true,
              onChanged: (val) => newClass.class_title = val,
              onSubmitted: (value) => FocusScope.of(context).requestFocus(_02),
              placeholder: "Name",
            ),    // Ask Name
            my_spacing,
            TextBox(
              focusNode: _02,
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
    final _01 = FocusNode();
    final _02 = FocusNode();
    String name = class_title;
    String subtitle = description;
    showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text("Update Class"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormBox(
              focusNode: _01,
              autofocus: true,
              onChanged: (val) => name = val,
              onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_02),
              placeholder: "Name",
              initialValue: name,
            ), // Ask Name
            my_spacing,
            TextFormBox(
              focusNode: _02,
              onChanged: (val) => subtitle = val,
              onFieldSubmitted: (val) => Navigator.pop(context, true),
              placeholder: "Description",
              initialValue: subtitle,
            ), // Ask Description
          ],
        ),
        actions: ActionBar(context),
      ),
    ).then((value) {
      if (name == class_title && subtitle == description) return;
      if (name.isEmpty) {
        (value! ? TheMessage.Empty : TheMessage.Failure)(context); return;
      }
      if (!value!) {
        TheMessage.Failure(context); return;
      }

      class_title = name;
      description = subtitle;
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