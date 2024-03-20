import 'package:cflash/core/utility/pageRoutes.dart';
import 'package:cflash/core/widgets/custom_button.dart';
import 'package:cflash/core/widgets/custom_text_form_field.dart';
import 'package:cflash/features/card/presentation/bloc/flash_services.dart';
import 'package:cflash/features/subject/presentation/pages/each_subject_page.dart';
import 'package:cflash/features/subject/presentation/bloc/subject_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/firebase_services/get_current_username.dart';
import '../../../../core/utility/toast.dart';
import '../../../../core/widgets/add_new_button.dart';
import '../../../../core/widgets/search_widget.dart';
import '../widget/form_item.dart';
import '../widget/mbs_text_form.dart';
import '../widget/subject_shimmer.dart';

class SubjectPage extends StatefulWidget {
  const SubjectPage({super.key});


  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  bool isLoading = false;
  bool firstExec = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController lecturerController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  TextEditingController searchController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  final subjects = FirebaseFirestore.instance.collection('Subject')
      .where('uid', isEqualTo:  getCurrentUser()!.uid)
      .snapshots();


  void confirmDelete(BuildContext context, String title, String userId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete this flashcard?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                FlashcardService flashCardServices = FlashcardService();
                flashCardServices.deleteSubject(title, userId); // Perform delete action
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }




  void addSubject() {
    BlocProvider.of<SubjectBloc>(context).add(AddSubjectEvent(
        titleController.text,
        descriptionController.text,
        lecturerController.text,
        imageController.text));
  }

  void viewAllSubject() {
    BlocProvider.of<SubjectBloc>(context).add(ViewAllSubjectEvent());
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {

    titleController.clear();
    descriptionController.clear();
    lecturerController.clear();
    imageController.clear();
    super.dispose();
  }

  List<DropdownMenuItem> imageList = [
    const DropdownMenuItem(value: "0", child: Text("Select Image")),
    const DropdownMenuItem(value: "1", child: Text("biology")),
    const DropdownMenuItem(value: "2", child: Text("chemistry")),
    const DropdownMenuItem(value: "3", child: Text("economics")),
    const DropdownMenuItem(value: "4", child: Text("english")),
    const DropdownMenuItem(value: "5", child: Text("math")),
    const DropdownMenuItem(value: "6", child: Text("physics")),
  ];

  String currentItem = "0";

  String getImageName(String value) {
    switch (value) {
      case "1":
        return "biology";
      case "2":
        return "chemistry";
      case "3":
        return "economics";
      case "4":
        return "english";
      case "5":
        return "math";
      case "6":
        return "physics";
      default:
        return "none";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(15),
              SearchBarWidget(searchController: searchController, hintText: "Search Subjects", onChanged: (String ) {setState(() {

              });  },),
              const Gap(15),
              const Text(
                "Subjects",
              ),
              const Gap(10),
              StreamBuilder<QuerySnapshot>(
                stream: subjects,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25.0, right: 25, bottom: 20),
                        child: GridView.builder(
                          itemCount: 8,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: subjectShimmerLoading(218, 171),
                            );
                          },
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 230,
                            crossAxisCount: 2,
                          ),
                        ),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Text("Error");
                  }

                  List<DocumentSnapshot> filteredDocs = snapshot.data!.docs.where((doc) {
                    String title = doc['title'].toString().toLowerCase();
                    String searchQuery = searchController.text.toLowerCase();
                    return title.contains(searchQuery);
                  }).toList();

                  return Expanded(
                    child: GridView.builder(
                      itemCount: filteredDocs.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 30.0, bottom: 15),
                          child: Center(
                            child: SubjectContainer(
                              subjectName: filteredDocs[index]['title'].toString(),
                              image: 'asset/images/${getImageName(filteredDocs[index]['image'])}.png',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CustomPageRouteLR(
                                    child: EachSubjectPage(
                                      subjectName: filteredDocs[index]['title'],
                                      subjectDescription: filteredDocs[index]['description'],
                                    ),
                                    direction: AxisDirection.left,
                                  ),
                                );
                              },
                              onLongPress: () {
                                confirmDelete(
                                    context,
                                    filteredDocs

                                    [index]['title'],
                                    getCurrentUser()!.uid);
                              },
                            ),
                          ),
                        );
                      },
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 230,
                        crossAxisCount: 2,
                      ),
                    ),
                  );
                },
              ),



            ],
          ),
        ),
        Positioned(
          bottom: 25,
          right: 20,
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Column(
                          children: [
                            Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Gap(10),
                                  formItemName("Subject Name"),
                                  MBSTextFormField(
                                    height: 50,
                                    controller: titleController,
                                    hintText: "Enter Subject Name",
                                    errorText: "Enter subject name",
                                    textInputType: TextInputType.text,
                                  ),
                                  const Gap(20),
                                  formItemName("Lecturer Name"),
                                  MBSTextFormField(
                                    height: 50,
                                    controller: lecturerController,
                                    hintText: "Enter Lecturer/author name",
                                    errorText: "Enter Lecturer name",
                                    textInputType: TextInputType.text,
                                  ),
                                  const Gap(20),
                                  formItemName("Description"),
                                  MBSTextFormField(
                                    height: 100,
                                    controller: descriptionController,
                                    hintText: "Enter Description",
                                    errorText: "Enter Description",
                                    textInputType: TextInputType.multiline,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: DropdownButton(
                                        underline: const SizedBox(),
                                        value: currentItem,
                                        items: imageList,
                                        onChanged: (value) {
                                          setState(() {
                                            currentItem = value;
                                            imageController.text = value;
                                          });
                                        }),
                                  ),

                                  //print(value);// send this item to the database the moment the inventory is beign stored
                                ],
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            CustomButton(
                                backGroundColor: const Color(0xff253262),
                                borderColor: const Color(0xff253262),
                                text: "Submit",
                                textColor: Colors.white,
                                onTap: () {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  if (_formKey.currentState!.validate()) {
                                    if (currentItem == "0" ||
                                        currentItem == "Select Image") {
                                      Utility()
                                          .toastMessage("Please Select Picture");
                                      setState(() {
                                        isLoading = false;
                                      });
                                    } else {
                                      addSubject();
                                      Navigator.pop(context);
                                      titleController.clear();
                                      descriptionController.clear();
                                      lecturerController.clear();
                                      imageController.clear();
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
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
            child: const AddNewButton(text: "Add New", icons: Icon(
              Icons.add,
              size: 27,
              color: Colors.white,
            ),),
          ),
        )
      ],
    );
  }
}




class SubjectContainer extends StatelessWidget {
  const SubjectContainer({
    super.key,
    required this.subjectName,
    required this.image,
    required this.onTap, required this.onLongPress,
  });

  final String subjectName;
  final String image;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
        elevation: 10,
        child: Container(
          height: 218,
          width: 171,
          decoration: BoxDecoration(
              color: const Color(0xff2E3F7A),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  subjectName,
                  style: const TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
              const Gap(10),
              ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset(image))
            ],
          ),
        ),
      ),
    );
  }
}
