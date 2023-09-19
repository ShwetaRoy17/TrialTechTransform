import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:trialtechtransform_app/views/utp.view.dart/utpservicesview/case.proceeding.dart';
import 'package:trialtechtransform_app/views/utp.view.dart/utpservicesview/ngo.view.dart';
import 'package:trialtechtransform_app/views/utp.view.dart/utpservicesview/rehab.view.dart';
import 'package:trialtechtransform_app/views/utp.view.dart/utpservicesview/utp.laws.dart';

import '../../widgets/custom.widgets.dart';
import '../utpservicesview/connect.lawyer.view.dart';

class HomeUTP extends StatelessWidget {
  HomeUTP({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Center(
            child: GridView.builder(
                itemCount: labels.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return CustomWidget()
                      .homeCardDetail(context, labels[index], path[index], () {
                    if (index == 0) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ConnectLawyer()));
                    } else if (index == 2) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => UtpLaws()));
                    } else if (index == 3) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CaseProceeding()));
                    } else if (index == 4) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => NgoView()));
                    } else if (index == 5) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => RehabView()));
                    }
                  });
                })),
      ),
    );
  }
}
