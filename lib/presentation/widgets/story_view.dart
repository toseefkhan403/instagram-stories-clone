import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_stories/domain/story.dart';
import 'package:instagram_stories/presentation/controllers/timer_controller.dart';

class StoryView extends ConsumerStatefulWidget {
  final List<Story> stories;
  final int initialIndex;

  const StoryView(
      {super.key, required this.stories, required this.initialIndex});

  @override
  ConsumerState createState() => _StoryViewState();
}

class _StoryViewState extends ConsumerState<StoryView> {
  late CarouselSliderController _sliderController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _sliderController = CarouselSliderController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startTimer());
  }

  void _startTimer() {
    ref.read(timerProvider(onTimerComplete).notifier).startTimer();
  }

  void onTimerComplete() {
    if (currentIndex < widget.stories.length - 1) {
      currentIndex++;
      _sliderController.nextPage();
    }
  }

  @override
  void dispose() {
    _sliderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = ref.watch(timerProvider(onTimerComplete)).progress;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          onTapUp: (details) {
            final width = MediaQuery.of(context).size.width;
            if (details.globalPosition.dx < width / 4) {
              if (currentIndex > 0) {
                _sliderController.previousPage();
              }
            } else if (details.globalPosition.dx > width * 3 / 4) {
              if (currentIndex < widget.stories.length - 1) {
                _sliderController.nextPage();
              }
            }
          },
          child: CarouselSlider.builder(
            controller: _sliderController,
            slideTransform: const CubeTransform(),
            onSlideChanged: (index) {
              currentIndex = index;
              _startTimer();
            },
            initialPage: currentIndex,
            autoSliderTransitionTime: const Duration(milliseconds: 600),
            itemCount: widget.stories.length,
            slideBuilder: (index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.stories[index].imageUrl,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 20,
                    left: 10,
                    child: Text(
                      widget.stories[index].title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    left: 0,
                    right: 0,
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.black.withOpacity(0.5),
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
