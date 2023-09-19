import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trialtechtransform_app/services/getter.values.dart';
import 'package:trialtechtransform_app/views/utp.view.dart/home.view.utp.dart';

import '../../constants/colors.dart';
import '../../services/auth.service.dart';
import '../authview/auth.view.dart';
import 'bottomscreen/home.utp.dart';
import 'bottomscreen/law.utp.dart';
import 'bottomscreen/profile.utp.dart';

class HomeWithBottom extends StatefulWidget {
  HomeWithBottom({super.key});

  @override
  State<HomeWithBottom> createState() => _HomeWithBottomState();
}

class _HomeWithBottomState extends State<HomeWithBottom> {
  static int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      GetterValue.utpHeaderValue = headerValue[selectedIndex];
      print(GetterValue.utpHeaderValue);
    });
  }

  List<String> headerValue = ["Home", "Law", "UTP Profile"];

  List<String> labels = [
    "Connect Lawyer",
    "Legal Clinic",
    "UTP Laws",
    "Case Details",
    "NGO's",
    "Rehabilitation"
  ];

  List<String> path = [
    "assets/svgs/lawyer.icon.svg",
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
        currentIndex: selectedIndex,
        selectedItemColor: pYellow,
        unselectedItemColor: palletWhite,
        onTap: _onItemTapped,
      ),
      body: screenWidget[selectedIndex],
    );
  }
}
