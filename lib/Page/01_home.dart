import 'package:fluent_ui/fluent_ui.dart';
import 'src/commons.dart';

class Class {
  Class();
  Class.defined(this.name, this.description);

  String name = "";
  String description = "";
}

class TheSweetHome extends StatefulWidget {
  const TheSweetHome({Key? key}) : super(key: key);

  @override
  State<TheSweetHome> createState() => _TheSweetHomeState();
}

class _TheSweetHomeState extends State<TheSweetHome> {

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

  void add_with_dialogBox(BuildContext context) {
    Class newClass = Class();
    showDialog<bool>(
      context: context,
      builder: (context) {
        return ContentDialog(
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
          actions: ActionBar(context),
        );
      },
    ).then((value) {
      if (newClass.name.isNotEmpty && newClass.description.isNotEmpty) {
        if (value!) {
          setState(() => classes.add(newClass));
          TheMessage.Success(context);
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

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(
        top: factor + 20,
        left: factor + 20,
        right: factor + 20,
    ),
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
                onPressed: () => add_with_dialogBox(context),
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
