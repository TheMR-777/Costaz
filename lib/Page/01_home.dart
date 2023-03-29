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
  BaseButton get add_button {
    void onPressed() => Class.create_with_dialogBox(context, update);
    final m_style = ButtonStyle(padding: ButtonState.all(const EdgeInsets.symmetric(
          vertical: factor + 5,
          horizontal: factor * 2
      )));
    const my_data = Icon(FluentIcons.add, size: factor * 2);

    return !is_dark_mode && Class.classes.isEmpty
        ? IconButton(
            onPressed: onPressed,
            style: m_style.copyWith(
              border: ButtonState.all(BorderSide(color: FluentTheme.of(context).accentColor)),
              foregroundColor: ButtonState.all(FluentTheme.of(context).accentColor)
            ),
            icon: my_data,
        )
        : Button(onPressed: onPressed, style: m_style, child: my_data);
  }
  static const local_factor = factor + 20;

  @override
  Widget build(BuildContext context) => CarouselSlider(
    carouselController: classController,
    options: CarouselOptions(
      height: double.infinity,
      viewportFraction: 1,
      enableInfiniteScroll: false,
      scrollPhysics: const NeverScrollableScrollPhysics(),
    ),
    items: [
      Padding(
        padding: const EdgeInsets.only(
          top: local_factor,
          left: local_factor,
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
                  padding: const EdgeInsets.only(right: local_factor),
                  child: add_button,
                ),     // Add Button
              ],
            ),              // Classes ++
            const SizedBox(
                height: local_factor
            ),   // Some Space
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: factor, right: local_factor),
                itemCount: Class.classes.length,
                itemBuilder: (context, index) => TheClassTile(update, index),
                separatorBuilder: (context, index) => my_spacing,
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

  @override
  Widget build(BuildContext context) => Show.TheContextMenu(
    context,
    onDelete: () => Class.delete_with_dialogBox(context, update, index),
    onEdit: () => currentClass.update_with_dialogBox(context, update),
    on: FocusTheme(
      data: FocusThemeData(
        renderOutside: false,
        primaryBorder: BorderSide(
          color: FluentTheme.of(context).accentColor.defaultBrushFor(
            FluentTheme.of(context).brightness
          ),
        )
      ),
      child: Button(
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
          border: is_dark_mode ? ButtonState.all(const BorderSide(color: Colors.transparent)) : null,
        ),
        child: Row(
          children: [
            Image.asset(
              "Icons/my-class.png",
              width: factor * 2.5,
              color: FluentTheme.of(context).accentColor.defaultBrushFor(
                FluentTheme.of(context).brightness
              ),
            ),     // Custom Icon
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
            Icon(
              FluentIcons.chevron_right,
              size: factor + 3,
              color: FluentTheme.of(context).borderInputColor,
            ),            // Trail Icon
          ],
        ),
      ),
    ),
  );
}
