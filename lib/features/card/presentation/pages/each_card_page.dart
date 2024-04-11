import 'package:cflash/core/utility/rive_utils.dart';
import 'package:cflash/core/utility/toast.dart';
import 'package:cflash/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';
import 'package:rive/rive.dart';

import '../../../../core/firebase_services/get_current_username.dart';
import '../bloc/flashCard.dart';
import '../bloc/flash_services.dart';

class EachCardPage extends StatefulWidget {
  const EachCardPage({super.key, required this.subjectName});

  final String subjectName;

  @override
  State<EachCardPage> createState() => _EachCardPageState();
}

class _EachCardPageState extends State<EachCardPage>
    with TickerProviderStateMixin {
  bool isLoading = false;
  FlashcardService flashcardService = FlashcardService();
  late SMITrigger trigger;
  bool isQuestion = true;
  PageController controller = PageController();
  bool textVisible = false;
  bool rateVisible = false;
  bool _scrollEnabled = false;

  double _rating = 0;
  late String flashCardID;

  double padding = 15.0;
  late AnimationController _controller;
  late Animation<double> _animation;

  String text = "Next";
  bool ratingClicked = false;

  void startAnimation() {
    _controller.repeat(reverse: true);
  }

  void stopAnimation() {
    _controller.stop();
  }

  void nextPage() {
    if (text == "Next") {
      startAnimation();

      if (ratingClicked == true) {
        flashcardService.rateFlashcard(widget.subjectName,
            getCurrentUser()!.uid, flashCardID, _rating.toInt());
      }
      setState(() {
        _scrollEnabled = true;
        textVisible = false;
        isQuestion = true;
        rateVisible = false;
      });

      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          textVisible = true;
          ratingClicked = false;
          _rating = 0.0;
        });
      });

      controller.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastEaseInToSlowEaseOut);
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          _scrollEnabled = false;
        });
      });
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();

    String text = "Next";
    Future.delayed(const Duration(milliseconds: 1100), () {
      setState(() {
        textVisible = true;
      });
    });

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 10,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInBack,
      ),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const CircleAvatar(
                      backgroundColor: Color(0xffD9D9D9),
                      child: Icon(
                        Icons.arrow_back,
                      ),
                    )),
                StreamBuilder<List<Flashcard>>(
                  stream: flashcardService.getFlashcards(
                      widget.subjectName, getCurrentUser()!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Flashcard> flashcards = snapshot.data!;
                      return Expanded(
                        child: PageView.builder(
                          physics: _scrollEnabled
                              ? AlwaysScrollableScrollPhysics()
                              : NeverScrollableScrollPhysics(),
                          controller: controller,
                          itemCount: flashcards.length,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (value) {
                            if (text == "Next") {
                              setState(() {
                                textVisible = false;
                                isQuestion = false;
                                rateVisible = false;
                              });

                              startAnimation();

                              if (ratingClicked == true) {
                                flashcardService.rateFlashcard(
                                    widget.subjectName,
                                    getCurrentUser()!.uid,
                                    flashCardID,
                                    _rating.toInt());
                              }

                              Future.delayed(const Duration(milliseconds: 1000),
                                  () {
                                setState(() {
                                  textVisible = true;
                                  ratingClicked = false;
                                  _rating = 0.0;
                                });
                              });
                            }
                          },
                          itemBuilder: (context, index) {
                            Flashcard flashcard = flashcards[index];
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(bottom: 10),
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(5),
                              //   border: Border.all(color: const Color(0xff2E3F7A)),
                              // ),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    textVisible = false;
                                  });
                                  trigger.fire();
                                  stopAnimation();

                                  Future.delayed(
                                      const Duration(milliseconds: 1000), () {
                                    setState(() {
                                      isQuestion = false;
                                      textVisible = true;
                                      rateVisible = true;
                                    });
                                  });

                                  if (index == flashcards.length - 1) {
                                    setState(() {
                                      text = "Done";
                                    });
                                  }
                                },
                                child: AnimatedBuilder(
                                    animation: _animation,
                                    builder: (context, child) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            bottom: _animation.value),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Center(
                                              child: RiveAnimation.asset(
                                                "asset/riveAssets/card_flip.riv",
                                                fit: BoxFit.fitWidth,
                                                onInit: (artboard) {
                                                  StateMachineController
                                                      controller = RiveUtils
                                                          .getRiverController(
                                                              artboard);
                                                  trigger = controller
                                                          .findSMI("Trigger 1")
                                                      as SMITrigger;
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 60.0),
                                                  child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            140,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            250,
                                                    child: Center(
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Visibility(
                                                            visible:
                                                                textVisible,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: 10,
                                                                right: 10,
                                                                    bottom: 10
                                                              ),
                                                              child: Text(
                                                                isQuestion
                                                                    ? flashcard
                                                                        .question
                                                                    : flashcard
                                                                        .answer,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: rateVisible,
                                              child: Positioned(
                                                bottom: 1,
                                                child: RatingBar.builder(
                                                  initialRating: _rating,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: false,
                                                  itemCount: 5,
                                                  itemSize: 50.0,
                                                  itemBuilder: (context, _) =>
                                                      Image.asset(
                                                          "asset/images/star.png"),
                                                  onRatingUpdate: (rating) {
                                                    setState(() {
                                                      _rating = rating;
                                                      flashCardID =
                                                          flashcard.flashCardId;
                                                      ratingClicked = true;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                const Gap(30),
                CustomButton(
                    width: MediaQuery.of(context).size.width - 20,
                    backGroundColor: const Color(0xff2E3F7A),
                    borderColor: const Color(0xff2E3F7A),
                    text: text,
                    textColor: Colors.white,
                    onTap: nextPage,
                    isLoading: isLoading),
                const Gap(30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
