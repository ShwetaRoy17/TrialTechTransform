import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trialtechtransform_app/constants/colors.dart';
import 'package:trialtechtransform_app/constants/global.var.dart';
import 'package:trialtechtransform_app/constants/size.config.dart';
import 'package:trialtechtransform_app/services/auth.service.dart';
import 'package:intl/intl.dart';
import 'package:trialtechtransform_app/services/lawyer.services.dart';
import 'package:trialtechtransform_app/views/lawyer.view.dart/lawyerbottomviews/clients.details.dart';
import 'package:trialtechtransform_app/views/lawyer.view.dart/lawyerbottomviews/lawyer.addslot.dart';
import 'package:trialtechtransform_app/views/lawyer.view.dart/lawyerbottomviews/lawyer.profile.dart';
import 'package:trialtechtransform_app/views/lawyer.view.dart/slotbook.dart';
import 'package:trialtechtransform_app/views/widgets/custom.widgets.dart';

class LawyerHome extends StatefulWidget {
  const LawyerHome({super.key});

  @override
  State<LawyerHome> createState() => _LawyerHomeState();
}

class _LawyerHomeState extends State<LawyerHome> {
  // String _setTime, _setDate;

  // String _hour, _minute, _time;

  // String dateTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LawyerService().fetchAllSlots(GlobalVars.auth.currentUser!.uid);
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> bottomScreen = [AddSlot(), ClientPage(), LawyerProfile()];

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
              label: 'Clients',
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
        appBar: AppBar(
          backgroundColor: darkBlue,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: InkWell(
                onTap: () {
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
        body: bottomScreen[_selectedIndex]);
  }
}
