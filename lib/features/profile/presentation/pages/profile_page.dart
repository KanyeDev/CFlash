import 'package:cflash/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/firebase_services/get_current_username.dart';
import '../../../../core/utility/pageRoutes.dart';
import '../../../../core/utility/toast.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../card/presentation/bloc/card_statistics.dart';
import '../../../card/presentation/bloc/flash_services.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../login/presentation/pages/login_page.dart';
import '../../../subject/presentation/widget/subject_shimmer.dart';

class ProfilePage extends StatelessWidget {
   ProfilePage({super.key});

   CardStatistics cardStatistics = CardStatistics(userId: getCurrentUser()!.uid);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Gap(20),
          SizedBox(
            width: 150,
            child: Image.asset("asset/images/logo.png"),
          ),
          const Gap(20),
          CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              radius: 50,
              child: const Icon(
                Icons.person,
                size: 40,
              )),
          const Gap(10),
          FutureBuilder(
            future: getUserName(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(); // Or any other loading indicator
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text(
                  "${snapshot.data}",
                  style: const TextStyle(fontSize: 18),
                );
              }
            },
          ),
          const Gap(20),
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
          ),


          const Gap(50),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              const Text("Email", style: TextStyle(fontSize: 18),),
              Text(getCurrentUser()!.email.toString(),style: const TextStyle(fontSize: 18),),
            ],
          ),
          const Gap(10),
          FutureBuilder(
            future: Future.wait([
              cardStatistics.getTotalCards(),
              cardStatistics.getTotalSubjects(),
              cardStatistics.getTotalFavorites(),
            ]),
            builder: (context, AsyncSnapshot<List<int>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return  Expanded(
                  child: ListView.builder(
                    itemCount: 3,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: subjectShimmerLoading(30, MediaQuery.of(context).size.width -20),
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                int totalCards = snapshot.data![0];
                int totalSubjects = snapshot.data![1];
                int totalFavorites = snapshot.data![2];

                return Column(

                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Subjects: ',
                          style: TextStyle(fontSize: 18),),
                        const Gap(30),
                        Text('$totalSubjects Subjects',
                          style: const TextStyle(fontSize: 18),),
                      ],
                    ),
                    const Gap(10),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Cards: ',
                          style: TextStyle(fontSize: 18),),
                        const Gap(30),
                        Text('$totalCards Cards',
                          style: const TextStyle(fontSize: 18),),
                      ],
                    ),
                    const Gap(10),

                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Favorites: ',
                          style: TextStyle(fontSize: 18),),
                        const Gap(30),
                        Text('$totalFavorites Cards',
                          style: const TextStyle(fontSize: 18),),
                      ],
                    ),

                     Gap(MediaQuery.of(context).size.height /4),
                    CustomButton(
                        width: MediaQuery.of(context).size.width -
                            30,
                        backGroundColor: const Color(0xff253262),
                        borderColor: const Color(0xff253262),
                        text: "L O G O U T",
                        textColor: Colors.white,
                        onTap: () {
                          FlashcardService().firebaseLogout();
                          Navigator.push(context, FadeRoute(page: const LoginPage()));
                        },
                        isLoading: false),
                  ],
                );
              }
            },
          )
        ],
      ),
    );
  }
}
