import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trialtechtransform_app/constants/colors.dart';
import 'package:trialtechtransform_app/services/auth.service.dart';
import 'package:trialtechtransform_app/views/authview/auth.view.dart';
import 'package:trialtechtransform_app/views/utp.view.dart/bottomscreen/home.utp.dart';
import 'package:trialtechtransform_app/views/utp.view.dart/bottomscreen/law.utp.dart';
import 'package:trialtechtransform_app/views/utp.view.dart/bottomscreen/profile.utp.dart';
import 'package:trialtechtransform_app/views/widgets/custom.widgets.dart';

class HomeViewUTP extends StatefulWidget {
  HomeViewUTP({super.key});

  @override
  State<HomeViewUTP> createState() => _HomeViewUTPState();
}

class _HomeViewUTPState extends State<HomeViewUTP> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<String> labels = [
    "Connect Lawyer",
    "Legal Clinic",
    "UTP Laws",
    "Case Details",
    "NGO's",
    "Rehabilitation"
  ];

  List<String> path = [
    "assets/svgs/lawyer.svg",
    "assets/svgs/legalclinic.svg",
    "assets/svgs/utplaw.svg",
    "assets/svgs/casedetails.svg",
    "assets/svgs/ngo.svg",
    "assets/svgs/rehab.svg"
  ];

  List<Widget> screenWidget = [HomeUTP(), LawUtp(), ProfileUtp()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: darkBlue,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => AuthView()),
                      (route) => false);
                  AuthService().signOut(context);
                },
                child: SvgPicture.asset(
                  "assets/svgs/globe.svg",
                  height: 30,
                  width: 30,
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: darkBlue,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.balance),
              label: 'Law',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: pYellow,
          unselectedItemColor: palletWhite,
          onTap: _onItemTapped,
        ),
        body: screenWidget[_selectedIndex]);
  }
}
