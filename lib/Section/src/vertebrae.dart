import 'package:fluent_ui/fluent_ui.dart';
import 'package:gsheets/gsheets.dart';
import 'commons.dart';

class src {
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
  static const def_sheet_ID = "1hgf72DPliAk59721Eezl6AoZPRkL7XyZDvHoXuq9GFI";
  static final gsheet_handle = GSheets(src.credentials);
  static final default_sheet = gsheet_handle.spreadsheet(src.def_sheet_ID);
  static final default_works = default_sheet.then((value) => value.worksheetByIndex(1));
}

class Student {
  static var top_row = [
    "Roll No",
    "Name",
    "CGPA",
    "Attendance",
  ];

  Student(this.roll_no, this.name, this.cgpa, this.attendance);

  String roll_no = "N/A";
  String name = "N/A";
  String cgpa = "0.0";
  bool attendance = false;

  void toggleAttendance() => attendance = !attendance;
  void updateAttendance(bool val) => attendance = val;

  static
  void dialogBox_Adding(BuildContext context, VoidCallback refresh, int section_id) {
    final TextEditingController roll = TextEditingController();
    final TextEditingController name = TextEditingController();
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
              onChanged: (val) => roll.text = val,
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
      if (value! && name.text.isNotEmpty && roll.text.isNotEmpty && cgpa.text.isNotEmpty) {
        API.sections[section_id].students.add(Student(roll.text, name.text, cgpa.text, false));
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
  void dialogBox_Delete(BuildContext context, VoidCallback refresh, int section_id, int index) => showDialog<bool>(
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
      API.sections[section_id].students.removeAt(index);
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
  void dialogBox_Update(BuildContext context, VoidCallback refresh) {
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
                my_spacing,
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
                my_spacing,
                TextBox(
                  onChanged: (val) => cgpa = val,
                  onSubmitted: (val) => returnClass(),
                  placeholder: "CGPA",
                  initialValue: cgpa,
                ), // Ask CGPA
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
    // Student("BSCS_F19_M_71", "Dominic Toretto", "3.11", false),
  ];

  void dialogBox_Update(BuildContext context, VoidCallback refresh) {
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
  static
  void dialogBox_Delete(BuildContext context, VoidCallback refresh, int index) => showDialog<bool>(
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
      API.sections.removeAt(index);
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
}

class API {
  static List<Section> sections = [
    // Section()..title = "Morning",
    // Section()..title = "Afternoon",
    // Section()..title = "Evening",
  ];

  static List<String> sessions_all = [
    "2023-02-05",
    "2023-02-03",
    "2023-01-31",
    "2023-01-29",
  ];

  static Future<bool> load() async {
    final my_sheet = await src.default_sheet;
    final cache_sections = <Section>[];

    for (var i = 0; i < my_sheet.sheets.length - 1; i++) {
      final worksheet = my_sheet.sheets[i];
      final rows_data = await worksheet.values.allRows().then((value) => value.skip(1).toList());
      print(worksheet.title);
      final mySection = Section()..title = worksheet.title;

      if (i == 0) Student.top_row = await worksheet.values.row(1);

      for (final row in rows_data) {
        print(row);
        mySection.students.add(Student(row[0], row[1], row[2], row.length == Student.top_row.length));
      }
      cache_sections.add(mySection);
    }
    API.sections = cache_sections;

    return true;
  }
}

Future<List<Text>> getRow(int row) async {
  final sheet = await src.default_works;
  final row_data = await sheet?.values.row(row);
  return row_data!.map((e) => Text(e)).toList();
}