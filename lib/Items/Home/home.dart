import 'package:fluent_ui/fluent_ui.dart';
const factor = 15.0;

class TheSweetHome extends StatefulWidget {
  const TheSweetHome({Key? key}) : super(key: key);

  @override
  State<TheSweetHome> createState() => _TheSweetHomeState();
}

class _TheSweetHomeState extends State<TheSweetHome> {

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
                onPressed: () {},
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
        ),              // Classes +
        const SizedBox(
            height: factor + 20
        ),   // Some Space
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: factor),
            itemCount: 5,
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
                  title: "Class $index",
                  subtitle: "Class $index Description"
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
