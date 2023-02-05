import 'package:fluent_ui/fluent_ui.dart';
import 'src/commons.dart';
DateTime session_detail = DateTime.now();

class ThePlayground extends StatelessWidget {
  const ThePlayground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ScaffoldPage.withPadding(
    padding: const EdgeInsets.all(20),
    content: const Center(
      child: TheDateField(),
    )
  );
}

class TheDateField extends StatefulWidget {
  const TheDateField({Key? key}) : super(key: key);

  @override
  State<TheDateField> createState() => _TheDateFieldState();
}

class _TheDateFieldState extends State<TheDateField> {
  @override
  Widget build(BuildContext context) => DatePicker(
    selected: session_detail,
    onChanged: (value) {
      setState(() => session_detail = value);
      final date = session_detail.toString().split(" ").first;
      print(date);
    },
  );
}
