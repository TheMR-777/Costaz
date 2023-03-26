import 'package:fluent_ui/fluent_ui.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ThePlayground extends StatelessWidget {
  const ThePlayground({Key? key}) : super(key: key);

  static final controller = CarouselController();
  static const my_padding = EdgeInsets.all(20);

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
      const MyIDEAs(),
    ],
  );
}

class MyIDEAs extends StatelessWidget {
  const MyIDEAs({Key? key}) : super(key: key);
  static const my_spacing = SizedBox(height: 20);
  static const my_feature = [
    "Using Table instead of DataTable in 'Student' Page",
    "New Design for Session Management",
    "Result Management System",
    "'analytics_logo' for Report Generation Entry in Context Menu",
  ];

  @override
  Widget build(BuildContext context) => ScaffoldPage(
    padding: ThePlayground.my_padding,
    content: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Upcoming Features",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),        // Title
        my_spacing,
        const Text(
          "Here are some of the features that I am planning to add in the future.",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),        // Subtitle
        const SizedBox(height: 30),
        Flexible(
          child: Card(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: my_feature.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    const Icon(FluentIcons.to_do_logo_outline),
                    const SizedBox(width: 20),
                    Text(my_feature[index]),
                  ],
                ),
              ),
              separatorBuilder: (context, index) => const Divider(
                style: DividerThemeData(
                  horizontalMargin: EdgeInsets.symmetric(vertical: 10)
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
