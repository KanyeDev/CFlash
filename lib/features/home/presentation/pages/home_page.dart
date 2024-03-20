import 'package:awesome_bottom_bar/tab_item.dart';
import 'package:cflash/core/utility/toast.dart';
import 'package:cflash/features/card/presentation/bloc/flash_services.dart';
import 'package:cflash/features/contact/presentation/page/contact_us.dart';
import 'package:cflash/features/favourite/presentation/pages/favourite_page.dart';
import 'package:cflash/features/profile/presentation/pages/profile_page.dart';
import 'package:cflash/features/search/presentation/pages/search_page.dart';
import 'package:cflash/features/subject/presentation/pages/subject_page.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/firebase_services/get_current_username.dart';
import '../../../../core/utility/pageRoutes.dart';
import '../../../login/presentation/pages/login_page.dart';
import '../widget/buttom_nav_bar.dart';

import '../widget/nameShimmerLoading.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

//TODO: Make subject deletable
//TODO: Make the search subject section able to take test too

class _HomePageState extends State<HomePage> {
  int visit = 0;

  List<TabItem> items = const [
    TabItem(icon: Icons.home, title: "Home"),
    TabItem(icon: Icons.search, title: "Search"),
    TabItem(icon: Icons.favorite, title: "Favourite"),
    TabItem(icon: Icons.person, title: "Profile")
  ];

  Widget setWidgetToRender = const SubjectPage();

  String? userName;

  Widget? getWidget() {
    Widget? render;

    render = setWidgetToRender;
    return render;
  }

  void setWidget(int index) {
    if (index == 0) {
      setState(() {
        setWidgetToRender = const SubjectPage();
      });
    } else if (index == 1) {
      setState(() {
        setWidgetToRender = const SearchPage();
      });
    } else if (index == 2) {
      setState(() {
        setWidgetToRender = const FavouritePage();
      });
    } else {
      setState(() {
        setWidgetToRender =  ProfilePage();
      });
    }
  }

  String username = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            const Expanded(child: SizedBox()),
            username == ""?  FutureBuilder(
              future: getUserName(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                userName = snapshot.data;

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(); // Or any other loading indicator
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {

                    username = userName!;

                  return Text(
                    "Hello, $userName",
                    style: const TextStyle(fontSize: 13),
                  );
                }
              },
            ) : Text(
              "Hello, $username",
              style: const TextStyle(fontSize: 13),
            ),
            const Expanded(child: SizedBox()),
            GestureDetector(
              onTap: (){
                setState(() {
                  setWidgetToRender =   ProfilePage();
                });
              },
              child: const CircleAvatar(
                backgroundColor: Color(0xff253262),
                child: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
      body: getWidget(),
      drawer: Drawer(
        child: DrawerData(context),
      ),
      bottomNavigationBar: BottomNavBar(
        onTap: (int index) {
          setState(() {
            visit = index;
            setWidget(visit);
          });
        },
        visit: visit,
        items: items,
      ),
    );
  }

  Column DrawerData(BuildContext context) {
    return Column(
        children: [
          const Gap(90),
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
          const Gap(20),
          FutureBuilder(
            future: getUserName(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              userName = snapshot.data;

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(); // Or any other loading indicator
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text(
                  "$userName",
                  style: const TextStyle(fontSize: 18),
                );
              }
            },
          ),
          const Gap(50),
          CustomDrawerItem(
            onTap: () {
              Navigator.pop(context);
              setState(() {
                setWidgetToRender = const  SubjectPage();
                visit = 0;
              });
            },
            text: 'H O M E',
            icon: Icons.home,
            showDivider: true,
          ),
          CustomDrawerItem(
            onTap: () {
              Navigator.pop(context);
              setState(() {
                setWidgetToRender = const  SearchPage();
                visit = 1;
              });
            },
            text: 'S E A R C H',
            icon: Icons.search,
            showDivider: true,
          ),
          CustomDrawerItem(
            onTap: () {
              Navigator.pop(context);
              setState(() {
                setWidgetToRender = const  FavouritePage();
                visit = 2;
              });
            },
            text: 'F A V O U R I T E',
            icon: Icons.favorite,
            showDivider: true,
          ),
          CustomDrawerItem(
            onTap: () {
              Navigator.pop(context);
              setState(() {
                setWidgetToRender =   ProfilePage();
                visit = 3;
              });
            },
            text: 'P R O F I L E',
            icon: Icons.person_2,
            showDivider: true,
          ),
          CustomDrawerItem(
            onTap: () {
              Navigator.push(context, CustomPageRouteLR(child: const ContactUsPage(), direction: AxisDirection.left));
            },
            text: 'C O N T A C T  U S',
            icon: Icons.phone,
            showDivider: true,
          ),
          const Expanded(child: SizedBox()),
          CustomDrawerItem(
            onTap: () {

              FlashcardService().firebaseLogout().then((value) {
                Navigator.push(context, FadeRoute(page: const LoginPage()));

              }).onError((error, stackTrace) {
                Utility().toastMessage(error.toString());
              });
            },
            text: 'L O G O U T',
            icon: Icons.logout,
            showDivider: false,
          ),
          const Gap(70),
        ],
      );
  }
}

class CustomDrawerItem extends StatelessWidget {
  const CustomDrawerItem({
    super.key,
    required this.onTap,
    required this.text,
    required this.icon,
    required this.showDivider,
  });

  final VoidCallback onTap;
  final String text;
  final IconData icon;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon),
                const Gap(20),
                Text(text),
              ],
            ),
            const Gap(5),
            showDivider
                ? const Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
