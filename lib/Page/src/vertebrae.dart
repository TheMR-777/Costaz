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
  static const def_sheet_ID =
      //"1hgf72DPliAk59721Eezl6AoZPRkL7XyZDvHoXuq9GFI"
      "1Ynpwr8fLrKMKCI7oIUFMiJPueifYGBhorC7F9r8FAKk"
  ;
  static final gsheet_handle = GSheets(src.credentials);
  static final default_sheet = gsheet_handle.spreadsheet(src.def_sheet_ID);
  static final default_works = default_sheet.then((value) => value.worksheetByIndex(1));
}

class Student {
  Student(this.roll_no, this.my_name) {
    attendance_record = List.generate(SessionManager.the_list.length, (index) => false);
  }
  Student.withRecord(this.roll_no, this.my_name, this.attendance_record);

  String roll_no = "N/A";
  String my_name = "N/A";
  List<bool> attendance_record = [];

  static String prefix_roll = "BSCS_F19_";
  static String prefix_name = "";

  bool get is_currently_present => attendance_record[SessionManager.selected];

  void toggleAttendance({required int session_id}) => attendance_record[session_id] = !attendance_record[session_id];
  void updateAttendance({required int session_id, required new_val}) => attendance_record[session_id] = new_val;

  static
  void prefix_with_dialogBox(BuildContext context) {
    String prefix_roll = Student.prefix_roll;
    String prefix_name = Student.prefix_name;
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
              initialValue: prefix_name,
              onChanged: (val) => prefix_name = val,
              placeholder: "Prefix for Name",
            ),    // Ask Name Prefix
            my_spacing,
            TextFormBox(
              autofocus: true,
              initialValue: prefix_roll,
              onChanged: (val) => prefix_roll = val,
              placeholder: "Prefix for Roll Number",
            ),    // Ask Roll No Prefix
          ],
        ),
        actions: ActionBar(context),
      ),
    ).then((value) {
      if (prefix_roll != Student.prefix_roll || prefix_name != Student.prefix_name) {
        if (value!) {
          Student.prefix_roll = prefix_roll;
          Student.prefix_name = prefix_name;
          TheMessage.Success(context);
        }
        else {
          TheMessage.Failure(context);
        }
      }
    });
  }
  static
  void create_with_dialogBox(BuildContext context, VoidCallback refresh, int section_id) {
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
              onPressed: () => Student.prefix_with_dialogBox(context),
              child: const Icon(FluentIcons.increase_indent, size: factor + 5),
            )       // Prefix Button
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormBox(
              autofocus: true,
              initialValue: prefix_name,
              onChanged: (val) => name = val,
              placeholder: "Name",
            ),    // Ask Name
            my_spacing,
            TextFormBox(
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
      if (name.isNotEmpty && roll.isNotEmpty) {
        if (value!) {
          SectionManager.sections[section_id].students.add(Student(roll, name));
          refresh();
          TheMessage.Added(context, "Student");
        }
        else {
          TheMessage.Failure(context);
        }
      }
      else if (value!) {
        TheMessage.Empty(context);
      }
    });
  }
  static
  void delete_with_dialogBox(BuildContext context, VoidCallback refresh, int section_id, int index) => Show.DeleteDialog(
    context,
    name: "Student",
    onDelete: () {
      SectionManager.sections[section_id].students.removeAt(index);
      refresh();
    },
  );
  void update_with_dialogBox(BuildContext context, VoidCallback refresh) {
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
                autofocus: true,
                onChanged: (val) => name = val,
                placeholder: "Name",
                initialValue: name,
              ), // Ask Name
              my_spacing,
              TextFormBox(
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
      if (name != my_name || roll != roll_no) {
        if (name.isEmpty || roll.isEmpty) {
          (value! ? TheMessage.Empty : TheMessage.Failure)(context);
        }
        else if (value!) {
          my_name = name;
          roll_no = roll;
          refresh();
          TheMessage.Success(context);
        }
        else {
          TheMessage.Failure(context);
        }
      }
    });
  }
}

class Section {
  static var top_row = [
    // "Roll No",
    // "Name",
    // "Record",
    // "Attendance",
  ];

  String title = "N/A";
  List<Student> students = [
    // Student("BSCS_F19_M_63", "TheMR", "3.72", true),
    // Student("BSCS_F19_M_64", "John Wick", "4.00", true),
    // Student("BSCS_F19_M_65", "Dr. Who", "2.71", false),
    // Student("BSCS_F19_M_66", "Boogeyman", "3.00", true),
    // Student("BSCS_F19_M_67", "Highway Man", "3.50", false),
    // Student("BSCS_F19_M_68", "Mr Strange", "2.00", true),
    // Student("BSCS_F19_M_69", "Adam Smasher", "3.53", false),
    // Student("BSCS_F19_M_70", "The Silence", "3.24", true),
    // Student("BSCS_F19_M_71", "Dominic", "3.11", false),
  ];

  static
  void create_with_dialogBox(BuildContext context, VoidCallback refresh) {
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
      if (newSection.isNotEmpty) {
        if (value!) {
          TheMessage.Added(context, "Section");
          SectionManager.sections.add(Section()..title = newSection);
          refresh();
        }
        else {
          TheMessage.Failure(context);
        }
      }
      else if (value!) {
        TheMessage.Empty(context);
      }
    });
  }
  static
  void delete_with_dialogBox(BuildContext context, VoidCallback refresh, int index) => Show.DeleteDialog(
    context,
    name: "Section",
    onDelete: () {
      SectionManager.sections.removeAt(index);
      TheMessage.Delete(context, "Section");
      refresh();
    },
  );
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
      if (name != title) {
        if (name.isEmpty) {
          (value! ? TheMessage.Empty : TheMessage.Failure)(context);
        }
        else if (value!) {
          title = name;
          refresh();
          TheMessage.Success(context);
        }
        else {
          TheMessage.Failure(context);
        }
      }
    });
  }
}

class SectionManager {
  static List<Section> sections = [
    // Section()..title = "Morning",
    // Section()..title = "Afternoon",
    // Section()..title = "Evening",
  ];
  static Future<bool> load() async {
    final my_sheet = await src.default_sheet;

    // Loading Settings
    for (final row in await my_sheet.sheets.last.values.allRows())
    {
      if (row.first == "TopRow:") {
        Section.top_row = row.skip(1)
            .where((element) => element.isNotEmpty)
            .toList();
      }
      else if (row.first == "Sessions:")
      {
        SessionManager.the_list = row.skip(1)
            .where((element) => element.isNotEmpty)
            .map((e) => Session(src.google_epoch.add(Duration(days: int.parse(e)))))
            .toList();

        // If no sessions are found, add a new one
        if (SessionManager.the_list.isEmpty) SessionManager.the_list.add(Session(DateTime.now()));
      }
    }
    print(Section.top_row);
    print(SessionManager.the_list
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
        final Record = List.generate(SessionManager.the_list.length, (index) => index < student_data.length - 2 && student_data[index + 2].isNotEmpty);
        mySection.students.add(Student.withRecord(myName, myRoll, Record));
        print("$Record: $student_data");
      }
      cache_sections.add(mySection);
    }
    SectionManager.sections = cache_sections;

    return true;
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
  static List<Session> the_list = [
    Session(DateTime(2023, 2, 5)),
    Session(DateTime(2023, 2, 3)),
    Session(DateTime(2023, 1, 31)),
    Session(DateTime(2023, 1, 29)),
    Session(DateTime.now().subtract(const Duration(days: 1))),
  ];

  static int _selected = the_list.length - 1;
  static void update_selected({int? to}) => _selected = to ?? the_list.length - 1;
  static int get selected => _selected;

  static Session get currentSession => the_list[selected];
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
          itemCount: SessionManager.the_list.length,
          itemBuilder: (context_2, index) => Row(
            children: [
              const SizedBox(
                  width: factor - 10
              ),  // Padding
              SizedBox(
                width: 300 - factor,
                child: the_list[index].makeDateTile(
                  selected: index == selected,
                  onTap: () {
                    update_selected(to: index);
                    refresh();
                    Show.TheInfoBar(context, title: "Loaded", detail: the_list[index].formatted());
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
    final already_exists = the_list.any((session) => session.formatted() == current_session.formatted());
    if (already_exists) {
      Show.TheInfoBar(
        context,
        title: "Cancelled",
        detail: "A session for today already exists!",
        type: InfoBarSeverity.warning,
      );
    }
    else {
      TheMessage.Added(context, "Session");
      the_list.add(current_session);
      update_selected();
      for (final section in SectionManager.sections) {
        for (final student in section.students) {
          if (student.attendance_record.length < the_list.length) {
            student.attendance_record.add(false);
          }
        }
      }
      refresh!();
      Navigator.of(context).pop();
    }
  }
  static void removeAt(BuildContext context, int index, {VoidCallback? refresh}) {
    if (the_list.length == 1) {
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
          the_list.removeAt(index);
          for (final section in SectionManager.sections) {
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
  Class.defined(this.name, this.description);

  String name = "";
  String description = "";

  static List<Class> classes = [
    Class.defined("Programming Fundamentals", "1st Semester"),
    Class.defined("Physics", "2nd Semester"),
    Class.defined("Mathematics", "3rd Semester"),
    Class.defined("Object Oriented Programming", "4th Semester"),
    Class.defined("Data Structures", "5th Semester"),
    Class.defined("Algorithms", "6th Semester"),
    Class.defined("Calculus", "7th Semester"),
    Class.defined("Algebra", "8th Semester"),
  ];

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
              autofocus: true,
              onChanged: (val) => newClass.name = val,
              placeholder: "Name",
            ),    // Ask Name
            my_spacing,
            TextBox(
              onChanged: (val) => newClass.description = val,
              onSubmitted: (val) => Navigator.pop(context, true),
              placeholder: "Description",
            ),    // Ask Description
          ],
        ),
        actions: ActionBar(context, focus: "Create"),
      ),
    ).then((value) {
      if (newClass.name.isNotEmpty && newClass.description.isNotEmpty) {
        if (value!) {
          classes.add(newClass);
          refresh();
          TheMessage.Added(context, "Class");
        }
        else {
          TheMessage.Failure(context);
        }
      }
      else if (value!) {
        TheMessage.Empty(context);
      }
    });
  }
  void update_with_dialogBox(BuildContext context, VoidCallback refresh) {
    String name = this.name;
    String description = this.description;
    showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text("Update Class"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormBox(
              autofocus: true,
              onChanged: (val) => name = val,
              placeholder: "Name",
              initialValue: name,
            ), // Ask Name
            my_spacing,
            TextFormBox(
              onChanged: (val) => description = val,
              onFieldSubmitted: (val) => Navigator.pop(context, true),
              placeholder: "Description",
              initialValue: description,
            ), // Ask Description
          ],
        ),
        actions: ActionBar(context),
      ),
    ).then((value) {
      if (name != this.name || description != this.description) {
        if (name.isEmpty) {
          (value! ? TheMessage.Empty : TheMessage.Failure)(context);
        }
        else if (value!) {
          this.name = name;
          this.description = description;
          refresh();
          TheMessage.Success(context);
        }
        else {
          TheMessage.Failure(context);
        }
      }
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