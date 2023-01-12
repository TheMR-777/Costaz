import 'package:fluent_ui/fluent_ui.dart';
const my_title = "Costaz Scaffold";

class TheAppBar extends StatelessWidget {
  const TheAppBar({Key? key}) : super(key: key);

  @override
  build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(my_title),
      IconButton(
        onPressed: () {},
        style: ButtonStyle(
          iconSize: ButtonState.all(17),
          padding: ButtonState.all(const EdgeInsets.all(15)),
        ),
        icon: const Icon(FluentIcons.accounts),
      ),
    ],
  );
}
