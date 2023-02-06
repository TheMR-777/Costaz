import 'package:fluent_ui/fluent_ui.dart';
import 'src/commons.dart';

class ThePlayground extends StatelessWidget {
  const ThePlayground({Key? key}) : super(key: key);
  static const date = "2021-09-01";

  @override
  Widget build(BuildContext context) => ScaffoldPage.withPadding(
    padding: const EdgeInsets.all(20),
    content: Center(
      child: GestureDetector(
        // onTap: Show a Dialog Box with Beautifully formatted Date
        child: Container(
          width: 300, height: 150,
          color: FluentTheme.of(context).accentColor,
        ),
      )
    )
  );
}

class TheDateField extends StatefulWidget {
  const TheDateField({Key? key}) : super(key: key);

  @override
  State<TheDateField> createState() => _TheDateFieldState();
}

class _TheDateFieldState extends State<TheDateField> {
  static DateTime session_detail = DateTime.now();
  @override
  Widget build(BuildContext context) => DatePicker(
    selected: session_detail,
    onChanged: (value) {
      setState(() => session_detail = value);
      final date = session_detail.toString().split(" ").first;
      print(date);
      print(date.split("-").reversed.join("-"));
      print("${value.day}/${value.month}/${value.year}");
    },
  );
}
