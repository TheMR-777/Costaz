import 'package:fluent_ui/fluent_ui.dart';
import 'src/vertebrae.dart' as back;

class ThePlayground extends StatelessWidget {
  const ThePlayground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ScaffoldPage.withPadding(
    padding: const EdgeInsets.all(20),
    content: Center(
      child: FutureBuilder<List<Widget>>(
        future: back.getRow(1),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              scrollDirection: Axis.horizontal,
              children: snapshot.data!,
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const ProgressBar();
        },
      ),
    ),
  );
}
