import 'package:fluent_ui/fluent_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../main.dart';

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
            Button(
              onPressed: () {},
              style: ButtonStyle(
                padding: ButtonState.all(const EdgeInsets.symmetric(vertical: 20, horizontal: 47)),
                iconSize: ButtonState.all(30),
              ),
              child: const Icon(FluentIcons.add),
            ),      // Add Button
          ],
        ),              // Classes +
        const SizedBox(
            height: 35
        ),   // Some Space
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 15),
            itemCount: 3,
            itemBuilder: (context, index) => Card(
              backgroundColor: Costaz.is_dark ? Colors.grey : Colors.transparent,
              child: ListTile.selectable(
                  leading: const Padding(
                    padding: EdgeInsets.only(
                        top: 5, bottom: 5, right: 20
                    ),
                    child: Icon(FluentIcons.bookmark_report, size: 27),
                  ),
                  title: Text("Class $index"),
                  subtitle: Text("Class $index Description"),
                  trailing: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Icon(FluentIcons.chevron_right),
                  ),
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 10),
          ),
        ),         // Class List
      ],
    ),
  );
}
