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
  static const my_name = "TheMR";
  static const my_mail = "m.shahzad.ms72@gmail.com";
  static const my_avatar = CircleAvatar(
    backgroundImage: AssetImage("Icons/Costaz-v1.png"),
    radius: factor * 2 + 5,
  );

  @override
  Widget build(BuildContext context) {
    final account_controller = FlyoutController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: factor - 9),
      child: FlyoutTarget(
        controller: account_controller,
        child: IconButton(
          onPressed: () => account_controller.showFlyout(
            autoModeConfiguration: FlyoutAutoConfiguration(
              preferredMode: FlyoutPlacementMode.bottomLeft,
            ),
            builder: (context) => FlyoutContent(
              useAcrylic: true,
              padding: const EdgeInsets.all(factor),
              constraints: BoxConstraints(
                  minWidth: nav_bar_size - factor,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  my_avatar,
                  const SizedBox(height: factor),
                  const Text(
                    my_name,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: factor,
                    ),
                  ),                  // My Name
                  const Text(
                    my_mail,
                    style: TextStyle(fontSize: factor - 3),
                  ),                  // My Email
                  const SizedBox(height: factor),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: nav_bar_size * 0.8,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        border: ButtonState.all(
                          BorderSide(
                            color: FluentTheme.of(context).resources.dividerStrokeColorDefault,
                          ),
                        ),
                        padding: ButtonState.all(const EdgeInsets.symmetric(
                          vertical: factor - 5,
                        )),
                      ),
                      icon: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(FluentIcons.sign_out),
                          SizedBox(width: factor),
                          Text(
                              "Sign out",
                              style: TextStyle(fontSize: factor - 2),
                          ),
                        ],
                      ),
                    ),
                  ),              // Sign Out
                ],
              ),
            ),
          ),
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
                      my_name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: factor
                      ),
                    ),    // Class Name
                    Text(
                      my_mail,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: factor - 3),
                    ),    // Description
                  ],
                ),
              ),              // Introduction
            ],
          ),
        ),
      ),
    );
  }
}
