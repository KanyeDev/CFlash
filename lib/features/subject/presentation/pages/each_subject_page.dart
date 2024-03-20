import 'package:cflash/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/firebase_services/get_current_username.dart';
import '../../../../core/utility/pageRoutes.dart';
import '../../../card/presentation/bloc/flash_services.dart';
import '../../../card/presentation/pages/card_page.dart';

class EachSubjectPage extends StatefulWidget {
  const EachSubjectPage(
      {super.key, required this.subjectName, required this.subjectDescription});

  final String subjectName;
  final String subjectDescription;

  @override
  State<EachSubjectPage> createState() => _EachSubjectPageState();
}

class _EachSubjectPageState extends State<EachSubjectPage> {

  FlashcardService flashcardService = FlashcardService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(30),
              GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back)),
              const Gap(20),
              Text(
                widget.subjectName,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.subjectDescription,
                style: const TextStyle(fontSize: 14),
              ),
              const Gap(50),
              StreamBuilder<double>(
                stream: flashcardService.calculateCompletionProgress(widget.subjectName, getCurrentUser()!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While the stream is loading, display a loading indicator
                    return const SizedBox();
                  } else if (snapshot.hasError) {
                    // If an error occurs, display an error message
                    return Text('Error: ${snapshot.error}');
                  } else {
                    // Once the stream emits a new value, update the UI with the completion progress
                    double completionProgress; // Use default value if data is null

                    if(snapshot.data!.isNaN || snapshot.data!.isInfinite){
                      completionProgress = 0.0;
                    }else{
                       completionProgress= snapshot.data ?? 0.0;
                    }

                    return Column(
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Completion Progress:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${(completionProgress * 100).toStringAsFixed(2)}%',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Gap(10),
                        LinearProgressIndicator(
                          value: completionProgress, // Set the value of the progress indicator
                          backgroundColor: Colors.grey,
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xff253262),),
                        ),
                      ],
                    );
                  }
                },
              ),


              const Expanded(child: SizedBox()),
              Center(
                  child: CustomButton(
                    width: MediaQuery.of(context).size.width -20,
                      backGroundColor: const Color(0xff253262),
                      borderColor: const Color(0xff253262),
                      text: "Continue",
                      textColor: Colors.white,
                      onTap: () {
                        Navigator.push(
                            context,
                            CustomPageRouteLR(
                                child: CardsPage(
                                  subjectName: widget.subjectName,
                                ),
                                direction: AxisDirection.left));
                      },
                      isLoading: false)),
              const Gap(30),
            ],
          ),
        ),
      ),
    );
  }
}
