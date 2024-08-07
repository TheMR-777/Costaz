import 'package:fluent_ui/fluent_ui.dart';
import '../Page/src/commons.dart';

class TheHeader extends StatelessWidget {
  const TheHeader({super.key});
  static bool get over => nav_bar_size > my_bar_lim;
  static const my_name = "TheMR";
  static const my_mail = "m.shahzad.ms72@gmail.com";
  static CircleAvatar get_avatar(double radius) => CircleAvatar(
    backgroundImage: const AssetImage("Icons/Costaz-v1.png"),
    radius: radius,
  );

  @override
  Widget build(BuildContext context) {
    final account_controller = FlyoutController();
    return Padding(
      padding: const EdgeInsets.only(right: factor - 9),
      child: FlyoutTarget(
        controller: account_controller,
        child: IconButton(
          onPressed: () => account_controller.showFlyout(
            autoModeConfiguration: FlyoutAutoConfiguration(
              preferredMode: FlyoutPlacementMode.bottomRight,
            ),
            builder: (context) => FlyoutContent(
              useAcrylic: true,
              padding: const EdgeInsets.symmetric(
                horizontal: factor,
                vertical: factor + 5,
              ),
              constraints: BoxConstraints(
                  minWidth: nav_bar_size - factor,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  get_avatar(factor * 2 + (over ? factor : 5)),
                  my_spacing,
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
                  if (over) Divider(
                    size: nav_bar_size * 0.5,
                    style: const DividerThemeData(
                      horizontalMargin: EdgeInsets.symmetric(
                        vertical: factor,
                      )
                    ),
                  )
                  else my_spacing,
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: nav_bar_size * 0.8,
                    ),
                    child: Button(
                      onPressed: () {},
                      style: const ButtonStyle(
                        padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
                          vertical: factor - 5,
                        )),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
          style: const ButtonStyle(
            padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
              horizontal: factor,
              vertical: factor * 2 - 11,
            )),
          ),
          icon: Row(
            mainAxisAlignment: nav_bar_size > my_bar_lim
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              get_avatar(factor * 2 + (over ? 2 : 5)),
              if (nav_bar_size > my_bar_lim) const Padding(
                padding: EdgeInsets.only(left: factor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      my_name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: factor
                      ),
                    ),    // My Name
                    Text(
                      my_mail,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: factor - 3),
                    ),    // My Email
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
