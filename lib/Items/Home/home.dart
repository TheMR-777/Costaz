import 'package:fluent_ui/fluent_ui.dart';

class TheSweetHome extends StatefulWidget {
  const TheSweetHome({Key? key}) : super(key: key);

  @override
  State<TheSweetHome> createState() => _TheSweetHomeState();
}

class _TheSweetHomeState extends State<TheSweetHome> {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(35),
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
              padding: const EdgeInsets.only(right: 15),
              child: Button(
                onPressed: () {},
                style: ButtonStyle(
                  padding: ButtonState.all(const EdgeInsets.symmetric(vertical: 20, horizontal: 47)),
                  iconSize: ButtonState.all(30),
                ),
                child: const Icon(FluentIcons.add),
              ),
            ),     // Add Button
          ],
        ),              // Classes +
        const SizedBox(
            height: 35
        ),   // Some Space
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 15),
            itemCount: 3,
            itemBuilder: (context, index) => Button(
              onPressed: () {},
              style: ButtonStyle(
                padding: ButtonState.all(const EdgeInsets.all(15)),
                iconSize: ButtonState.all(18),
              ),
              child: TheClassTile(
                  title: "Class $index",
                  subtitle: "Class $index Description"
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 15),
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
  Widget build(BuildContext context) => ListTile(
    leading: const Padding(
      padding: EdgeInsets.only(
          top: 5, bottom: 5, right: 20
      ),
      child: Icon(FluentIcons.bookmark_report, size: 27),
    ),
    title: Text(title),
    subtitle: Text(subtitle),
    trailing: const Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Icon(FluentIcons.chevron_right),
    ),
  );
}
