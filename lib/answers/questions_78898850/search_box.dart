import 'package:flutter/material.dart';

class SearchBoxScreen extends StatelessWidget {
  const SearchBoxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 150, 16, 40),
        child: Column(
          children: [
            ZomatoTextField(),
          ],
        ),
      ),
    );
  }
}

/// Main Widget
class ZomatoTextField extends StatefulWidget {
  const ZomatoTextField({super.key});

  @override
  State<ZomatoTextField> createState() => _ZomatoTextFieldState();
}

class _ZomatoTextFieldState extends State<ZomatoTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> slideAnimation;
  Color iconsColor = const Color(0xffE95161);

  late final ValueNotifier<int> showTextNotifer = ValueNotifier(0);

  final List<String> hintList = ['Ice Cream', 'Samosa', 'Biryani'];
  late final int maxIndex = hintList.length - 1;

  final List<Offset> _offsets = [
    const Offset(0, 1.8),
    const Offset(0, 0),
    const Offset(0, -1.8),
  ];

  void _initAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            repeatAnimation();
          }
        },
      );

    final tweenSequence = TweenSequence<Offset>(
      [
        TweenSequenceItem(
          tween: Tween<Offset>(
            begin: _offsets[0],
            end: _offsets[1],
          ),
          weight: 0.2,
        ),
        TweenSequenceItem(
          tween: ConstantTween<Offset>(_offsets[1]),
          weight: 0.5,
        ),
        TweenSequenceItem(
          tween: Tween<Offset>(
            begin: _offsets[1],
            end: _offsets[2],
          ),
          weight: 0.3,
        ),
      ],
    );

    slideAnimation = tweenSequence.animate(CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    ));

    controller.forward();
  }

  void repeatAnimation() async {
    changeText();
    controller.reset();
    controller.forward();
  }

  void changeText() {
    final i = showTextNotifer.value;
    if (i == maxIndex) {
      showTextNotifer.value = 0;
    } else {
      showTextNotifer.value = i + 1;
    }
  }

  @override
  void initState() {
    _initAnimation();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colors.grey.withOpacity(0.2),
            offset: const Offset(0, 0),
            spreadRadius: 3,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: iconsColor,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: SlideTransition(
              position: slideAnimation,
              child: ValueListenableBuilder(
                valueListenable: showTextNotifer,
                builder: (context, val, _) {
                  return Text(
                    'Search "${hintList[val]}"',
                    style: const TextStyle(
                      color: Color(0xff767C8F),
                      fontSize: 16,
                    ),
                  );
                },
              ),
            ),
          ),
          const VerticalDivider(
            endIndent: 5,
            indent: 5,
          ),
          Icon(
            Icons.mic_none_outlined,
            color: iconsColor,
          ),
        ],
      ),
    );
  }
}

/*


class SearchBoxScreen extends StatelessWidget {
  const SearchBoxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 20, 16, 40),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: InteractiveViewer(
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.search,
                        size: 28,
                        color: Colors.red,
                      ),
                    ),
                    DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey,
                      ),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        pause: const Duration(milliseconds: 500),
                        animatedTexts: ['bread', 'chips', 'buns', 'sweets']
                            .map(
                              (e) => RotateAnimatedText(
                                'Search "$e"',
                                transitionHeight: 55,
                                duration: const Duration(
                                  seconds: 2,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const Spacer(),
                    const VerticalDivider(
                      color: Colors.grey,
                      thickness: 0.5,
                      width: 16,
                      endIndent: 12,
                      indent: 12,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.mic_none_outlined,
                        size: 28,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

 */