import 'package:fluent_ui/fluent_ui.dart';
import 'src/commons.dart';

class ThePlayground extends StatelessWidget {
  const ThePlayground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ScaffoldPage.withPadding(
    padding: const EdgeInsets.all(20),
    content: Center(
      child: show.NativeContextMenu(
        context,
        onTap: () {}, onDelete: () {}, onEdit: () {},
        child: Container(
          width: 200,
          height: 200,
          color: Colors.red,
        ),
      ),
    )
  );
}
