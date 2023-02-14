import 'package:fluent_ui/fluent_ui.dart';
import 'package:gsheets/gsheets.dart';
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
  Student(this.roll_no, this.name) {
    attendance_record = List.generate(SessionManager.the_list.length, (index) => false);
  }

  Student.withRecord(this.roll_no, this.name, this.attendance_record);

  String roll_no = "N/A";
  String name = "N/A";

  List<bool> attendance_record = [];

  void toggleAttendance({required int session_id}) => attendance_record[session_id] = !attendance_record[session_id];
  void updateAttendance({required int session_id, required new_val}) => attendance_record[session_id] = new_val;

  static
  void adding_with_dialogBox(BuildContext context, VoidCallback refresh, int section_id) {
    final TextEditingController roll = TextEditingController();
    final TextEditingController name = TextEditingController();
    showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text("Add Student"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
      if (value! && name.text.isNotEmpty && roll.text.isNotEmpty) {
        SectionManager.sections[section_id].students.add(Student(roll.text, name.text));
        refresh();
        Show.infoBar(
          context,
          title: "Added",
          detail: "Student added!",
        );
      }
      else {
        Show.infoBar(
          context,
          type: InfoBarSeverity.warning,
          title: "Cancelled",
          detail: "Addition cancelled!",
        );
      }
    });
  }
  static
  void delete_with_dialogBox(BuildContext context, VoidCallback refresh, int section_id, int index) => showDialog<bool>(
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
      SectionManager.sections[section_id].students.removeAt(index);
      refresh();
      Show.infoBar(
        context,
        title: "Deleted",
        detail: "Student deleted!",
      );
    }
    else {
      Show.infoBar(
        context,
        type: InfoBarSeverity.warning,
        title: "Cancelled",
        detail: "Deletion cancelled!",
      );
    }
  });
  void update_with_dialogBox(BuildContext context, VoidCallback refresh) {
    void returnClass() {
      Show.infoBar(
        context,
        title: "Updated",
        detail: "New details applied!",
      );
      Navigator.pop(context);
    }
    void cancelClass() {
      Show.infoBar(
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
  static var top_row = [
    "Roll No",
    "Name",
    "Record",
    "Attendance",
  ];
  Section();
  Section.specified(this.title, this.students);

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
  void delete_with_dialogBox(BuildContext context, VoidCallback refresh, int index) => showDialog<bool>(
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
      refresh();
      SectionManager.sections.removeAt(index);
      Show.infoBar(
        context,
        title: "Deleted",
        detail: "Worksheet deleted!",
      );
    }
    else {
      Show.infoBar(
        context,
        type: InfoBarSeverity.warning,
        title: "Cancelled",
        detail: "Deletion cancelled!",
      );
    }
  });
  void update_with_dialogBox(BuildContext context, VoidCallback refresh) {
    String name = title;
    showDialog<bool>(
      context: context,
      builder: (context) => ContentDialog(
        
        title: const Text("Edit Section"),
        content: TextBox(
          autofocus: true,
          onChanged: (value) => name = value,
          onSubmitted: (value) => Navigator.pop(context, true),
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
      ),
    ).then((value) {
      if (value!) {
        title = name; refresh();
        Show.infoBar(
          context,
          title: "Edited",
          detail: "Section title edited!",
        );
      }
      else {
        Show.infoBar(
          context,
          type: InfoBarSeverity.warning,
          title: "Cancelled",
          detail: "Editing cancelled!",
        );
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
      // Top Row Loading
      if (row[0] == "TopRow:")
      {
        Section.top_row = row.skip(1).where((element) => element.isNotEmpty).toList();
        print(Section.top_row);
      }

      // Session Loading
      else if (row[0] == "Sessions:")
      {
        SessionManager.the_list = row.skip(1).where((element) => element.isNotEmpty).map((e) {
          final date = src.google_epoch.add(Duration(days: int.parse(e)));
          print(date);
          return Session(date);
        }).toList();

        // If no sessions are found, add a new one
        if (SessionManager.the_list.isEmpty) SessionManager.the_list.add(Session(DateTime.now()));
      }
    }
    print("");

    // Section Loading
    final cache_sections = <Section>[];
    for (var i = 0; i < my_sheet.sheets.length - 1; i++) {
      final worksheet = my_sheet.sheets[i];
      final rows_data = await worksheet.values.allRows().then((value) => value.skip(1).toList());
      print(worksheet.title);
      final mySection = Section()..title = worksheet.title;

      // Student Loading
      for (final student_data in rows_data) {
        final myName = student_data[0];
        final myRoll = student_data[1];
        final Record = List.generate(SessionManager.the_list.length, (index) => index < student_data.length - 2 && student_data[index + 2].isNotEmpty);
        mySection.students.add(Student.withRecord(myName, myRoll, Record));
        print("${Record}: ${student_data}");
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
  bool get is_selected => formatted() == SessionManager.currentSession.formatted();
  ListTile makeDateTile({required VoidCallback onTap, bool selected = false}) => ListTile.selectable(
    selected: selected,
    onPressed: onTap,
    leading: Text(
      date.day < 10 ? "0${date.day}" : "${date.day}",
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    ),
    title: Text(formatted_short()),
    subtitle: Text(_weekDays[date.weekday - 1]),
    trailing: is_selected ? null : date.day == DateTime.now().day
        ? const Text("Today") : date.day == DateTime.now().day - 1
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
      ),
    ).then((value) {
      if (value!) {
        date = intermediate; refresh();
        Show.infoBar(
          context,
          title: "Edited",
          detail: "Session date edited!",
        );
      }
      else {
        Show.infoBar(
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
  static int selected = the_list.length - 1;
  static Session get currentSession => the_list[selected];
  static ListTile currentTile(BuildContext context, VoidCallback refresh) => currentSession.makeDateTile(onTap: () => showDialog(
    context: context,
    builder: (context) => ContentDialog(
      
      title: const Text("Load a Session"),
      content: ListView.builder(
        shrinkWrap: true,
        itemCount: SessionManager.the_list.length,
        itemBuilder: (context_2, index) => the_list[index].makeDateTile(
          selected: index == selected,
          onTap: () {
            selected = index;
            refresh();
            Show.infoBar(context, title: "Loaded", detail: the_list[index].formatted());
            Navigator.pop(context);
          },
        ),
      ),
      actions: [
        Button(
          style: button_pad,
          child: const Text("New Session"),
          onPressed: () => addCurrent(context, refresh: refresh),
        ),
        Button(
          style: button_pad,
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
      ],
    ),
  ));

  static void addCurrent(BuildContext context, {VoidCallback? refresh}) {
    final current_session = Session(DateTime.now());
    final already_exists = the_list.any((session) => session.formatted() == current_session.formatted());
    if (already_exists) {
      Show.infoBar(
        context,
        title: "Cancelled",
        detail: "A session for today already exists!",
        type: InfoBarSeverity.warning,
      );
    }
    else {
      Show.infoBar(
        context,
        title: "Added",
        detail: "New session added!",
      );
      the_list.add(current_session);
      selected = the_list.length - 1;
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
  static void removeAt(int index) => the_list.removeAt(index);
}