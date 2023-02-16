import 'package:carousel_slider/carousel_slider.dart';

import '../base.dart';

class AppCarouselSlider extends StatefulWidget {
  final Function(int)? onPageChanged;
  final List<Widget> items;
  final CarouselController? carouselController;
  const AppCarouselSlider({
    Key? key,
    this.onPageChanged,
    required this.items, this.carouselController,
  }) : super(key: key);

  @override
  State<AppCarouselSlider> createState() => _AppCarouselSliderState();
}

class _AppCarouselSliderState extends State<AppCarouselSlider> {
  // late CarouselController carouselController = widget.carouselController ?? CarouselController();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: widget.carouselController,
      options: CarouselOptions(
          // aspectRatio: 1.0,
          viewportFraction: 1.0,
          height: double.infinity,
          padEnds: false,
          enlargeCenterPage: false,
          autoPlayAnimationDuration: const Duration(milliseconds: 300),
          autoPlayInterval: const Duration(seconds: 10),
          autoPlayCurve: Curves.easeIn,
          autoPlay: true,
          onPageChanged: (index, reason) {
            widget.onPageChanged?.call(index);
          }),
      items: widget.items,
    );
  }
}
