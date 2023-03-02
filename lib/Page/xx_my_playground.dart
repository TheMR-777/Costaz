import 'package:fluent_ui/fluent_ui.dart';
import 'package:carousel_slider/carousel_slider.dart';

final CarouselController controller = CarouselController();

class ThePlayground extends StatelessWidget {
  const ThePlayground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CarouselSlider(
    disableGesture: true,
    options: CarouselOptions(
      enableInfiniteScroll: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 1),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
      scrollPhysics: const NeverScrollableScrollPhysics(),
    ),
    items: [
      ScaffoldPage.withPadding(
        padding: const EdgeInsets.all(20),
        content: Column(
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
              "This is a place where you can play with the widgets and see how they work.",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      ScaffoldPage.withPadding(
        padding: const EdgeInsets.all(20),
        content: Column(
          children: const [
            Text(
              "Let's Play",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "This is a place where you can play with the widgets and see how they work.",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}