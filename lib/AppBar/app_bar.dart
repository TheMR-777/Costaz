import 'package:fluent_ui/fluent_ui.dart';
import '../Page/src/commons.dart';
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

class TheHeader extends StatelessWidget {
  const TheHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: factor - 9),
    child: IconButton(
      onPressed: () {},
      style: ButtonStyle(
        padding: ButtonState.all(const EdgeInsets.symmetric(
          horizontal: factor,
          vertical: factor * 2 - 7,
        )),
      ),
      icon: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage("Icons/Costaz-v1.png"),
            radius: factor * 2 + 5,
          ),  // Profile Picture
          const SizedBox(
            width: factor,
          ),      // Some Space
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "TheMR",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: factor
                ),
              ),    // Class Name
              Text(
                "m.shahzad.ms72@gmail.com",
                style: TextStyle(fontSize: factor - 3),
              ),    // Description
            ],
          ),              // Introduction
        ],
      ),
    ),
  );
}
