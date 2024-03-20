import 'package:cflash/core/firebase_services/get_current_username.dart';
import 'package:cflash/core/utility/pageRoutes.dart';
import 'package:cflash/core/utility/toast.dart';
import 'package:cflash/core/widgets/add_new_button.dart';
import 'package:cflash/features/card/presentation/pages/each_card_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/search_widget.dart';
import '../../../subject/presentation/widget/form_item.dart';
import '../../../subject/presentation/widget/mbs_text_form.dart';
import '../bloc/flashCard.dart';
import '../bloc/flash_services.dart';

class CardsPage extends StatefulWidget {
  CardsPage({super.key, required this.subjectName});

  final String subjectName;

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  TextEditingController searchController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  bool isLoading = false;
  FlashcardService flashcardService = FlashcardService();

  void addCard() async {
    // Add a new flashcard
    try {
      Flashcard newFlashcard = Flashcard(
          question: questionController.text,
          answer: answerController.text,
          review: 0,
          flashCardId: '',
          favorite: 'no');

      await flashcardService.addFlashcard(
          widget.subjectName, getCurrentUser()!.uid.toString(), newFlashcard);

      Utility().toastMessage("Card added successfully");
    } catch (e) {
      Utility().toastMessage(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subjectName),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(10),
                SearchBarWidget(
                  searchController: searchController,
                  hintText: "Search Cards",
                  onChanged: (string) {
                    setState(() {});
                  },
                ),
                const Gap(10),
                const Text("Cards",style: TextStyle(fontWeight: FontWeight.bold),),
                StreamBuilder<List<Flashcard>>(
                  stream: flashcardService.getFlashcards(
                      widget.subjectName, getCurrentUser()!.uid),
                  builder: (context, snapshot) {
                    List<Flashcard> flashcards = snapshot.data ?? [];
                    // Filter flashcards based on search text
                    List<Flashcard> filteredFlashcards =
                        flashcards.where((flashcard) {
                      String query = searchController.text.toLowerCase();
                      return flashcard.question.toLowerCase().contains(query);
                    }).toList();

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: SizedBox());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (filteredFlashcards.isEmpty) {
                      return const Text("No Cards Found");
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: filteredFlashcards.length,
                          itemBuilder: (context, index) {
                            Flashcard flashcard = filteredFlashcards[index];

                            if(filteredFlashcards.length -1 == index){
                              return const SizedBox(height: 50,);
                            }

                            return Dismissible(direction: DismissDirection.endToStart,
                              key: Key(flashcard.flashCardId),
                              background: Container(clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xffA4CAE8),
                                ),
                                child: const Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 20.0),
                                    child:
                                        Icon(Icons.delete, color: Colors.white),
                                  ),
                                ),
                              ),
                              confirmDismiss: (direction) async {
                                // Show a confirmation dialog
                                return await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Delete Flashcard'),
                                      content: const Text(
                                          'Are you sure you want to delete this flashcard?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(false),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: const Text('Delete',
                                              style:
                                                  TextStyle(color: Colors.red)),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              onDismissed: (direction) {
                                // Delete the flashcard
                                flashcardService.deleteFlashcard(
                                    getCurrentUser()!.uid,
                                    flashcard.flashCardId);
                              },
                              child: Card(
                                elevation: 4,
                                margin: const EdgeInsets.only(top: 13),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 10, bottom: 7),
                                        child: Text(
                                          flashcard.question,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.clip,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: IconButton(
                                          onPressed: () {
                                            flashcardService.likeCard(
                                                getCurrentUser()!.uid,
                                                flashcard.flashCardId,
                                                flashcard.favorite);
                                          },
                                          icon: Icon(
                                            Icons.favorite,
                                            size: 30,
                                            color: flashcard.favorite == 'yes'
                                                ? Colors.red
                                                : Colors.grey,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
                const Gap(10),
              ],
            ),
          ),
          Positioned(
              bottom: 25,
              left: 20,
              child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SingleChildScrollView(
                          child: StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Column(
                                children: [
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Gap(10),
                                        formItemName("Question"),
                                        MBSTextFormField(
                                          height: 50,
                                          controller: questionController,
                                          hintText: "Enter Your Question",
                                          errorText: "Enter  Question",
                                          textInputType:
                                              TextInputType.multiline,
                                        ),
                                        const Gap(20),
                                        formItemName("Answer"),
                                        MBSTextFormField(
                                          height: 150,
                                          controller: answerController,
                                          hintText: "Enter Your Answer",
                                          errorText: "Enter Answer",
                                          textInputType:
                                              TextInputType.multiline,
                                        ),
                                        const Gap(20),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  CustomButton(
                                      width: MediaQuery.of(context).size.width -
                                          30,
                                      backGroundColor: const Color(0xff253262),
                                      borderColor: const Color(0xff253262),
                                      text: "Submit",
                                      textColor: Colors.white,
                                      onTap: () {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        if (_formKey.currentState!.validate()) {
                                          addCard();
                                          Navigator.pop(context);
                                          questionController.clear();
                                          answerController.clear();
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }
                                      },
                                      isLoading: isLoading),
                                  const Gap(20),
                                ],
                              ),
                            );
                          }),
                        );
                      },
                    );
                  },
                  child: const AddNewButton(
                    text: "Add New",
                    icons: Icon(
                      Icons.add,
                      size: 27,
                      color: Colors.white,
                    ),
                  ))),
          Positioned(
              right: 20,
              bottom: 25,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      CustomPageRouteLR(
                          child: EachCardPage(
                            subjectName: widget.subjectName,
                          ),
                          direction: AxisDirection.left));
                },
                child: const AddNewButton(
                  text: "Start",
                  icons: Icon(
                    Icons.arrow_forward_ios,
                    size: 27,
                    color: Colors.white,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
