import 'package:fluent_ui/fluent_ui.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '02_students.dart';
import 'src/commons.dart';
import 'src/vertebrae.dart';

final classController = CarouselController();

class TheSweetHome extends StatefulWidget {
  const TheSweetHome({Key? key}) : super(key: key);

  @override
  State<TheSweetHome> createState() => _TheSweetHomeState();
}

class _TheSweetHomeState extends State<TheSweetHome> {
  void update() => setState(() {});

  @override
  Widget build(BuildContext context) => CarouselSlider(
    carouselController: classController,
    options: CarouselOptions(
      height: double.infinity,
      viewportFraction: 1,
      enableInfiniteScroll: false,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      // autoPlay: true,
      // autoPlayInterval: const Duration(seconds: 1),
      // autoPlayAnimationDuration: const Duration(milliseconds: 800),
      // autoPlayCurve: Curves.fastOutSlowIn,
    ),
    items: [
      Padding(
        padding: const EdgeInsets.only(
          top: factor + 20,
          left: factor + 20,
          right: factor + 20,
        ),
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
                Padding(
                  padding: const EdgeInsets.only(right: factor),
                  child: Button(
                    onPressed: () => Class.create_with_dialogBox(context, update),
                    style: ButtonStyle(
                      padding: ButtonState.all(const EdgeInsets.symmetric(
                          vertical: factor + 5,
                          horizontal: factor * 2
                      )),
                      iconSize: ButtonState.all(factor * 2),
                    ),
                    child: const Icon(FluentIcons.add),
                  ),
                ),     // Add Button
              ],
            ),              // Classes ++
            const SizedBox(
                height: factor + 20
            ),   // Some Space
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 10, bottom: 10, right: factor),
                itemCount: Class.classes.length,
                itemBuilder: (context, index) => TheClassTile(update, index),
                separatorBuilder: (context, index) => const SizedBox(height: factor),
              ),
            ),         // Class List
          ],
        ),
      ),              // Classes
      const DearStudents(),      // Students
    ],
  );
}

class TheClassTile extends StatelessWidget {
  const TheClassTile(
    this.update,
    this.index,
    { super.key }
  );

  final VoidCallback update;
  final int index;
  Class get currentClass => Class.classes[index];
  Color accentColor(BuildContext context) => FluentTheme.of(context).accentColor.defaultBrushFor(
      FluentTheme.of(context).brightness
  );

  @override
  Widget build(BuildContext context) => Show.TheContextMenu(
    context,
    onDelete: () => Class.delete_with_dialogBox(context, update, index),
    onEdit: () => currentClass.update_with_dialogBox(context, update),
    on: Button(
      onPressed: () {
        Class.current_class_i = index;
        if (!Class.selected.i_should_fetch) SessionManager.update_selected();
        classController.nextPage(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubicEmphasized
        );
      },
      style: ButtonStyle(
        padding: ButtonState.all(const EdgeInsets.symmetric(
          horizontal: factor * 2,
          vertical: factor + 5,
        )),
        border: FluentTheme.of(context).brightness == Brightness.dark
            ? ButtonState.all(const BorderSide(color: Colors.transparent))
            : null,
      ),
      child: Row(
        children: [
          Icon(
            FluentIcons.bookmark_report,
            size: factor + 12,
            color: Class.current_class_i == index
                ? FluentTheme.of(context).accentColor.defaultBrushFor(
                FluentTheme.of(context).brightness
            ) : null,
          ),            // Icon
          const SizedBox(
            width: factor * 2 + 5,
          ),  // Some Space
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentClass.class_title,
                style: const TextStyle(fontSize: factor + 1),
              ),        // Class Name
              if (currentClass.description.isNotEmpty)
                Text(
                  currentClass.description,
                  style: TextStyle(
                      color: FluentTheme.of(context).borderInputColor,
                      fontSize: factor - 3
                  ),
                ),      // Description
            ],
          ),          // Introduction
          const Spacer(),       // Max Space
          const Icon(
            FluentIcons.chevron_right,
            size: factor + 3,
          ),      // Icon
        ],
      ),
    ),
  );
}
