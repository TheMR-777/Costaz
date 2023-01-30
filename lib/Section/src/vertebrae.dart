import 'package:fluent_ui/fluent_ui.dart';
import 'package:gsheets/gsheets.dart';
import 'commons.dart';

class src {
  static const credentials = r'''
  {
    "type": "service_account",
    "project_id": "costaz-desktop-project",
    "private_key_id": "e2964a5af10fdc3c4459022719f879835f5e30e9",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC5uxCov5MCxuZ9\nVyEdbd0w5g7HA0YIizbYBQpG5/zav+bf4SbHj3zagVDpy4wyFKBnBcOfgqWC/WOi\n5Q7/wHPHkseTuMVPrPWmhXah3LB1TbaEwTwLfsuUal7ox3puVERDoVGi7HrM4VeS\nwHwNUJUIACxxj88xE+FkieQHsDnGqEHslmJk+vhPpSBMqd2Txj+Pm/KOPZ84yUkQ\ntvSEgibB2HPMiBcd05TDf6l2PJigEMAgt5ztfA5pMvpIZPgO4dyfSo24Xqg/pJSu\n7FtAJTv1NSJNR8gb9J229sahv4aKNL+8rb/DF07oh9+o0zWn0Rvu6ZqyFPw+uLp+\nrWuk98iNAgMBAAECggEAIzC1oRd9MgFAIh78VABhMLbiNWRiJFPGPitETXd+ke7a\nvnABQj3mXNs0GrwZkdKVKrftnv8ov3clpfNLAnuzJCzkGhHf9q7xc03l0pjHKU6i\nZqhbKV1qkrINzgKfqKBYN80ss9clFEUc694DEx3BwvyPbyvdiLG42q0Css85vzEF\n+cCkjVw81TiqQrl9PpDoQGtD2PpTU7z7GIX36Rk4gLEBMpcbInQWr5lWF/bWsXHr\nTjGcdBaXmSsaCPTJIlnWSaIOukdPm8+xC2KhEf+MOtPhmYQKYtyp3mvuJbSxZgOu\n8K7FswHBZVDDgJsEeqXfRwXh9ms6PJqyFHtxAJVOAQKBgQD+/veK1Ng/d+pkw1Jl\nV5A1glf0kHZwgIhuVnx4uew2rHbVv4cVViNnkDmGW/zyGAIaXcZaJroxzQoixGRs\nPspXSQ3l+gkgbXmlCWAdIzAMrWt0I7jtkYs+r52ILD6uNLjyLBqcFqPfeahZq9xy\nSmrY7KEvQxlwtjdV56L2DFUSAQKBgQC6dkePoH0kVn6727r0g+7Fl91c64i39Qoy\nyRdzzmWkQgayImsPA7v3YIl4w1IVZAhinyDPSgA3tXeg8qDzaGmFIZ3WzICCB8ZS\nAu/Yz7iIDWpEzHy35Y0HHkc9PWTIq+K2Cfh00csf1NbGg+ifp1fx9RcXAgqLpRoV\nyPVEFIDejQKBgGY+ibdLHOJmDMAWaWVlNNefyfCwNC1r/EhxuTsXIZXSlVujjmCJ\nx2xxMf+jxsqzwbQcwbnIKYRqeJP0N2gHzU4uZro+BYbRHqOEHNvSDiQnLRzGbhIj\n97dM51eAlil3zmicMpc/pLmoqE48UQoquKj+SKsQtpSxG4MAfCE4VKwBAoGBALaC\nl8EKAfPThfEzPmefy9M0tsQA96239+eF1aLQ38RLrGooLkpgCVg18dl2tZ2icGK4\nB1FeyZ+9y/6J/ujBxqc9JFXfjdm46nHT1hiOGb1yBBabYWhPFB9nj6ttsHyLYjl0\nwPD3eK8Lkb511viOwBJhJ9ypbtEJJeM09H1S5GDxAoGAcp1BoTTR30dehuDvIqyt\nIru6pUA4hWHuWK8uXzzDOPr8IMqyZQ3aY8wEz6/Uca0hYymns0kHNg+Z9m2dj5lR\nVn4ODHVwbMKCjyyBw27GMS7SLjSraDkU4EBS7XKMYqb6X+LqU/s9kPmu7qICe9BF\nX0EgRq04FYxhqfwxEBAZ97Y=\n-----END PRIVATE KEY-----\n",
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

// class API {
//   static var dropdown_sections = [
//     "Morning", "Afternoon"
//   ];
//   static var top_row = [
//     "Roll Number", "Name", "CGPA", "Attendance"
//   ];
//   static var roll_no = [
//     [
//       "BSCS_F19_M_63", "BSCS_F19_M_64", "BSCS_F19_M_65", "BSCS_F19_M_66", "BSCS_F19_M_67", "BSCS_F19_M_68", "BSCS_F19_M_69", "BSCS_F19_M_70", "BSCS_F19_M_71",
//     ],
//     [
//       "BSCS_F19_A_63", "BSCS_F19_A_64", "BSCS_F19_A_65", "BSCS_F19_A_66", "BSCS_F19_A_67", "BSCS_F19_A_68", "BSCS_F19_A_69", "BSCS_F19_A_70", "BSCS_F19_A_71",
//     ],
//   ];
//   static var names = [
//     [
//       "TheMR", "John Wick", "Dr. Who", "Boogeyman", "Highway Man", "Mr Strange", "Adam Smasher", "The Silence", "The Weeping Angel",
//     ],
//     [
//       "The Doctor", "The Master", "The Rani", "The Valeyard", "The Brigadier", "Cool Man", "The Cybermen", "The Daleks", "The Sontarans"
//     ],
//   ];
//   static var cgpa_s = [
//     [
//       "3.72", "4.00", "2.71", "3.00", "3.50", "2.00", "3.53", "3.24", "3.11",
//     ],
//     // Randomly generate values: 1..4
//     [
//       "1.45", "3.23", "2.54", "3.67", "2.34", "3.45", "2.34", "1.33", "2.77",
//     ]
//   ];
//   static var is_present = [
//     [
//       true, true, false, true, false, true, false, true, false,
//     ],
//     [
//       false, false, true, false, true, false, true, false, true,
//     ]
//   ];
//
//   static Future<bool> load() async {
//     final my_sheet = await src.default_sheet;
//
//     // Dropdowns: Skipping the last one
//     API.dropdown_sections = my_sheet.sheets.map((e) => e.title).toList().sublist(0, my_sheet.sheets.length - 1);
//
//     // Top Row: Located in the last sheet, 1st row
//     API.top_row = await my_sheet.sheets.last.values.row(1);
//
//     // Roll No: 1st column of all sheets, except the last one, and skipping the first row
//     API.roll_no = [];
//     for (var i = 0; i < my_sheet.sheets.length - 1; i++) {
//       API.roll_no.add(await my_sheet.sheets[i].values.column(1, fromRow: 2));
//     }
//
//     // Names: 2nd column of all sheets, except the last one, and skipping the first row
//     API.names = [];
//     for (var i = 0; i < my_sheet.sheets.length - 1; i++) {
//       API.names.add(await my_sheet.sheets[i].values.column(2, fromRow: 2));
//     }
//
//     // CGPA: 3rd column of all sheets, except the last one, and skipping the first row
//     API.cgpa_s = [];
//     for (var i = 0; i < my_sheet.sheets.length - 1; i++) {
//       API.cgpa_s.add(await my_sheet.sheets[i].values.column(3, fromRow: 2));
//     }
//
//     // Attendance: 4th column of all sheets,
//     // except the last one, and skipping the first row
//     // mark true if there is any value in the cell
//     // mark false if the cell is empty
//     API.is_present = [];
//     for (var i = 0; i < my_sheet.sheets.length - 1; i++) {
//       API.is_present.add(await my_sheet.sheets[i].values.column(4, fromRow: 2).then((value) => value.map((e) => e != "").toList()));
//     }
//
//     return true;
//   }
// }

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
        show.infoBar(
          context,
          title: "Added",
          detail: "Student added!",
        );
      }
      else {
        show.infoBar(
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
      show.infoBar(
        context,
        title: "Deleted",
        detail: "Student deleted!",
      );
    }
    else {
      show.infoBar(
        context,
        type: InfoBarSeverity.warning,
        title: "Cancelled",
        detail: "Deletion cancelled!",
      );
    }
  });
  void dialogBox_Update(BuildContext context, VoidCallback refresh) {
    void returnClass() {
      show.infoBar(
        context,
        title: "Updated",
        detail: "New details applied!",
      );
      Navigator.pop(context);
    }
    void cancelClass() {
      show.infoBar(
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
        show.infoBar(
          context,
          title: "Edited",
          detail: "Section title edited!",
        );
      }
      else {
        show.infoBar(
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
      show.infoBar(
        context,
        title: "Deleted",
        detail: "Worksheet deleted!",
      );
    }
    else {
      show.infoBar(
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
  // static Future<bool> load() async {
//     final my_sheet = await src.default_sheet;
//
//     // Dropdowns: Skipping the last one
//     API.dropdown_sections = my_sheet.sheets.map((e) => e.title).toList().sublist(0, my_sheet.sheets.length - 1);
//
//     // Top Row: Located in the last sheet, 1st row
//     API.top_row = await my_sheet.sheets.last.values.row(1);
//
//     // Roll No: 1st column of all sheets, except the last one, and skipping the first row
//     API.roll_no = [];
//     for (var i = 0; i < my_sheet.sheets.length - 1; i++) {
//       API.roll_no.add(await my_sheet.sheets[i].values.column(1, fromRow: 2));
//     }
//
//     // Names: 2nd column of all sheets, except the last one, and skipping the first row
//     API.names = [];
//     for (var i = 0; i < my_sheet.sheets.length - 1; i++) {
//       API.names.add(await my_sheet.sheets[i].values.column(2, fromRow: 2));
//     }
//
//     // CGPA: 3rd column of all sheets, except the last one, and skipping the first row
//     API.cgpa_s = [];
//     for (var i = 0; i < my_sheet.sheets.length - 1; i++) {
//       API.cgpa_s.add(await my_sheet.sheets[i].values.column(3, fromRow: 2));
//     }
//
//     // Attendance: 4th column of all sheets,
//     // except the last one, and skipping the first row
//     // mark true if there is any value in the cell
//     // mark false if the cell is empty
//     API.is_present = [];
//     for (var i = 0; i < my_sheet.sheets.length - 1; i++) {
//       API.is_present.add(await my_sheet.sheets[i].values.column(4, fromRow: 2).then((value) => value.map((e) => e != "").toList()));
//     }
//
//     return true;
//   }

  static Future<bool> load() async {
    final my_sheet = await src.default_sheet;

    // for (var i = 0; i < my_sheet.sheets.length - 1; i++) {
    //   final worksheet = my_sheet.sheets[i];
    //   final rows_data = await worksheet.values.allRows().then((value) => value.skip(1).toList());
    //   print(worksheet.title);
    //   final mySection = Section()..title = worksheet.title;
    //
    //   if (i == 0) Student.top_row = await worksheet.values.row(1);
    //
    //   for (final row in rows_data) {
    //     print(row);
    //     mySection.students.add(Student(row[0], row[1], row[2], row.length == Student.top_row.length));
    //   }
    //   sections.add(mySection);
    // }

    Future<List<Section>> getData() async {
      final my_sheet = await src.default_sheet;
      final sections = <Section>[];
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
        sections.add(mySection);
      }
      return sections;
    }
    sections = await getData();

    return true;
  }

  static Future<List<Section>> load_2() async {
    final my_sheet = await src.default_sheet;
    final sections = <Section>[];
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
      sections.add(mySection);
    }
    return sections;
  }
}

Future<List<Text>> getRow(int row) async {
  final sheet = await src.default_works;
  final row_data = await sheet?.values.row(row);
  return row_data!.map((e) => Text(e)).toList();
}