import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trialtechtransform_app/constants/colors.dart';
import 'package:trialtechtransform_app/constants/size.config.dart';
import 'package:trialtechtransform_app/services/auth.service.dart';
import 'package:trialtechtransform_app/services/getter.values.dart';
import 'package:trialtechtransform_app/views/authview/auth.view.dart';
import 'package:trialtechtransform_app/views/utp.view.dart/bottomscreen/home.utp.dart';
import 'package:trialtechtransform_app/views/utp.view.dart/bottomscreen/law.utp.dart';
import 'package:trialtechtransform_app/views/utp.view.dart/bottomscreen/profile.utp.dart';
import 'package:trialtechtransform_app/views/utp.view.dart/drawerscreen/bookedslot.dart';
import 'package:trialtechtransform_app/views/utp.view.dart/drawerscreen/payment.history.dart';
import 'package:trialtechtransform_app/views/utp.view.dart/drawerscreen/wallet.scn.dart';
import 'package:trialtechtransform_app/views/utp.view.dart/home.bottom.dart';
import 'package:trialtechtransform_app/views/utp.view.dart/utpservicesview/connect.lawyer.view.dart';
import 'package:trialtechtransform_app/views/widgets/custom.widgets.dart';

class HomeViewUTP extends StatefulWidget {
  HomeViewUTP({super.key});

  @override
  State<HomeViewUTP> createState() => _HomeViewUTPState();
}

class _HomeViewUTPState extends State<HomeViewUTP> {
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

  List<DrawerItem> itm = [
    DrawerItem(
        icon: Icon(
          Icons.home,
          color: Colors.black,
        ),
        label: "Home"),
    DrawerItem(
        icon: Icon(
          Icons.book,
          color: Colors.black,
        ),
        label: "Booked Slot"),
    DrawerItem(
        icon: Icon(
          Icons.payment,
          color: Colors.black,
        ),
        label: "Payment History"),
    DrawerItem(
        icon: Icon(
          Icons.wallet,
          color: Colors.black,
        ),
        label: "Wallet"),
  ];

  List<Widget> navScreen = [
    HomeWithBottom(),
    BookedSlotNavBar(),
    PaymentHistory(),
    WalletScreen()
  ];

  int _index = 0;

  // Widget ApplicationDrawer() {
  //   return
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: darkBlue),
              child: Container(
                width: SizeConfig.width,
                child: Text(
                  "NyayYatra",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: palletWhite),
                ),
              )),
          Expanded(
            child: ListView.builder(
                itemCount: itm.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _index = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: (index == _index)
                                ? extraLightBlue
                                : Colors.transparent),
                        child: ListTile(
                          leading: itm[index].icon,
                          title: Text(
                            itm[index].label,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      )),
      appBar: AppBar(
        centerTitle: true,
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
      body: navScreen[_index],
    );
  }
}

class DrawerItem {
  Icon icon;
  String label;
  DrawerItem({required this.icon, required this.label});
}
