
import 'package:cflash/core/utility/toast.dart';
import 'package:cflash/core/widgets/search_widget.dart';
import 'package:cflash/features/card/presentation/bloc/flash_services.dart';
import 'package:cflash/features/login/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/firebase_services/get_current_username.dart';
import '../../../../core/utility/pageRoutes.dart';
import '../../../../core/widgets/add_new_button.dart';
import '../../../card/presentation/bloc/flashCard.dart';
import '../../../card/presentation/pages/each_card_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FlashcardService flashcardService = FlashcardService();

  TextEditingController searchController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Stack(
        children: [
          Column(
            children: [
              SearchBarWidget(searchController: searchController, hintText: "Search Cards", onChanged: (String ) { setState(() {

              }); },),
              const Gap(20),
              StreamBuilder<List<Flashcard>>(
                stream: flashcardService.getFlashcardsForUser(getCurrentUser()!.uid),
                builder: (context, snapshot) {

                  List<Flashcard> flashcards = snapshot.data ?? [];
                  // Filter flashcards based on search text
                  List<Flashcard> filteredFlashcards = flashcards.where((flashcard) {
                    String query = searchController.text.toLowerCase();
                    return flashcard.question.toLowerCase().contains(query);
                  }).toList();

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child:SizedBox());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  else if(filteredFlashcards.isEmpty){
                    return const Text("No Cards Found");
                  }
                  else {



                    return Expanded(
                      child: ListView.builder(
                        itemCount: filteredFlashcards.length,
                        itemBuilder: (context, index) {
                          Flashcard flashcard = filteredFlashcards[index];

                          return Dismissible(
                            key: Key(flashcard.flashCardId),
                            background: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: const Color(0xffA4CAE8),),
                              child: const Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 20.0),
                                  child: Icon(Icons.delete, color: Colors.white),
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
                                    content: const Text('Are you sure you want to delete this flashcard?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(false),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(true),
                                        child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            onDismissed: (direction) {
                              // Delete the flashcard
                              flashcardService.deleteFlashcard(getCurrentUser()!.uid, flashcard.flashCardId);
                            },
                            child: Card(
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(vertical:5.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0, left: 10, bottom: 7),
                                      child: SingleChildScrollView(
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
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: IconButton(onPressed: (){
                                      flashcardService.likeCard( getCurrentUser()!.uid, flashcard.flashCardId, flashcard.favorite);
                                    }, icon: Icon(Icons.favorite, size: 30, color: flashcard.favorite == 'yes'? Colors.red: Colors.grey,)),
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



          ],),
          Positioned(
              right: 20,
              bottom: 25,
              child: GestureDetector(
                onTap: () {
                  Utility().toastMessage("Coming Soon!, Go To Each Subject Page");
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
