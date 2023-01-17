// ignore_for_file: use_build_context_synchronously

import 'package:fluent_ui/fluent_ui.dart';
const factor = 15.0;
final button_pad = ButtonStyle(padding: ButtonState.all(const EdgeInsets.symmetric(vertical: factor - 5)));

class Class {
  Class(this.name, this.description);

  String name = "N/A";
  String description = "N/A";
}

class TheSweetHome extends StatefulWidget {
  const TheSweetHome({Key? key}) : super(key: key);

  @override
  State<TheSweetHome> createState() => _TheSweetHomeState();
}

class _TheSweetHomeState extends State<TheSweetHome> {

  static List<Class> classes = [
    Class("Programming Fundamentals", "1st Semester"),
    Class("Physics", "2nd Semester"),
    Class("Mathematics", "3rd Semester"),
    Class("Object Oriented Programming", "4th Semester"),
    Class("Data Structures", "5th Semester"),
    Class("Algorithms", "6th Semester"),
    Class("Calculus", "7th Semester"),
    Class("Algebra", "8th Semester"),
  ];

  addClassDialogue(BuildContext context) async {
    final result = await showDialog<Class>(
      context: context,
      builder: (context) {
        const my_spacing = SizedBox(height: factor);
        Class newClass = Class("N/A", "N/A");
        void returnClass() => Navigator.pop(context, newClass);

        return ContentDialog(
          title: const Text("Add a New Class"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              my_spacing,
              TextBox(
                autofocus: true,
                onChanged: (val) => newClass.name = val,
                // Shift the focus to the next field when the user presses the Enter key
                // onSubmitted: (val) => FocusScope.of(context).nextFocus(),
                placeholder: "Name",
              ),    // Ask Name
              my_spacing,
              TextBox(
                onChanged: (val) => newClass.description = val,
                onSubmitted: (val) => returnClass(),
                placeholder: "Description",
              ),    // Ask Description
            ],
          ),
          actions: [
            FilledButton(
              onPressed: returnClass,
              style: button_pad,
              child: const Text("Add"),
            ),  // Add Button
            Button(
              onPressed: () => Navigator.pop(context),
              style: button_pad,
              child: const Text("Cancel"),
          ),        // Cancel Button
          ],
        );
      },
    );
    if (result != null) {
      setState(() => classes.add(result));
      displayInfoBar(
        context,
        builder: (context, close) => const InfoBar(
          title: Text("Success"),
          content: Text("Class Added Successfully!"),
          severity: InfoBarSeverity.success,
        )
      );
    }
    else {
      displayInfoBar(
        context,
        builder: (context, close) => const InfoBar(
          title: Text("Cancelled"),
          content: Text("No changes are made!"),
          severity: InfoBarSeverity.warning,
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(factor + 20),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Classes",
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w500
              ),
            ),  // "Classes"
            Padding(
              padding: const EdgeInsets.only(right: factor),
              child: Button(
                onPressed: () => addClassDialogue(context),
                style: ButtonStyle(
                  padding: ButtonState.all(const EdgeInsets.symmetric(
                      vertical: factor + 5,
                      horizontal: factor * 2
                  )),
                  iconSize: ButtonState.all(factor * 2),
                ),
                child: const Icon(FluentIcons.add),
              ),
            ),     // Add Button
          ],
        ),              // Classes ++
        const SizedBox(
            height: factor + 20
        ),   // Some Space
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: factor),
            itemCount: classes.length,
            itemBuilder: (context, index) => GestureDetector(
              onSecondaryTap: () => print("Secondary Tap"),
              child: Button(
                onPressed: () => print("Primary Pressed"),
                style: ButtonStyle(
                  padding: ButtonState.all(const EdgeInsets.symmetric(
                    horizontal: factor * 2,
                    vertical: factor + 5,
                  )),
                ),
                child: TheClassTile(
                  title: classes[index].name,
                  subtitle: classes[index].description,
                ),
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(height: factor),
          ),
        ),         // Class List
      ],
    ),
  );
}

class TheClassTile extends StatelessWidget {
  const TheClassTile({
    required this.title,
    required this.subtitle,
    super.key
  });

  final String title, subtitle;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      const Icon(
        FluentIcons.bookmark_report,
        size: 27,
      ),      // Icon
      const SizedBox(
        width: factor + 20,
      ),  // Some Space
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),    // Class Name
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12),
          ),    // Description
        ],
      ),          // Introduction
      const Spacer(),       // Max Space
      const Icon(
        FluentIcons.chevron_right,
        size: factor + 3,
      ),      // Icon
    ],
  );
}
