import 'package:fluent_ui/fluent_ui.dart';
import '../Page/src/commons.dart';

class TheAppBar extends StatelessWidget {
  const TheAppBar({Key? key}) : super(key: key);

  @override
  build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text("Costaz"),
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

  static const my_avatar = CircleAvatar(
    backgroundImage: AssetImage("Icons/Costaz-v1.png"),
    radius: factor * 2 + 5,
  );

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: factor - 9),
    child: IconButton(
      onPressed: () {},
      style: ButtonStyle(
        padding: ButtonState.all(const EdgeInsets.symmetric(
          horizontal: factor,
          vertical: factor * 2 - 11,
        )),
      ),
      icon: Row(
        mainAxisAlignment: nav_bar_size > my_bar_lim
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: [
          my_avatar,
          if (nav_bar_size > my_bar_lim) Padding(
            padding: const EdgeInsets.only(left: factor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "TheMR",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: factor
                  ),
                ),    // Class Name
                Text(
                  "m.shahzad.ms72@gmail.com",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: factor - 3),
                ),    // Description
              ],
            ),
          ),              // Introduction
        ],
      ),
    ),
  );
}
