import 'package:fluent_ui/fluent_ui.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ThePlayground extends StatelessWidget {
  const ThePlayground({Key? key}) : super(key: key);

  static final controller = CarouselController();
  static const my_padding = EdgeInsets.all(20);
  static const my_spacing = SizedBox(height: 20);
  static const my_feature = [
    "analytics_logo for Report Generation Entry in Context Menu",
    "analytics_logo for Report Generation Entry in Context Menu",
    "analytics_logo for Report Generation Entry in Context Menu",
    "More soon...",
  ];

  @override
  Widget build(BuildContext context) => CarouselSlider(
    carouselController: controller,
    options: CarouselOptions(
      initialPage: 1,
      // autoPlayInterval: const Duration(seconds: 1),
      // autoPlayAnimationDuration: const Duration(milliseconds: 800),
      // autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      enableInfiniteScroll: false,
      scrollDirection: Axis.horizontal,
    ),
    items: [
      ScaffoldPage(
        padding: my_padding,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Welcome to the Playground",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "This is where I, the developer of Costaz, play with the ideas and observe how they work together.",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      ScaffoldPage(
        padding: my_padding,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Upcoming Features",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            my_spacing,
            Text(
              "Here are some of the features that I am planning to add in the future.",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    ],
  );
}