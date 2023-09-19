import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trialtechtransform_app/constants/colors.dart';
import 'package:trialtechtransform_app/constants/global.var.dart';
import 'package:trialtechtransform_app/constants/size.config.dart';
import 'package:trialtechtransform_app/views/utp.view.dart/bottomscreen/upi.payement.scrn.dart';
import 'package:trialtechtransform_app/views/widgets/custom.widgets.dart';
import 'package:upi_india/upi_india.dart';

class ProfileUtp extends StatefulWidget {
  const ProfileUtp({super.key});

  @override
  State<ProfileUtp> createState() => _ProfileUtpState();
}

class _ProfileUtpState extends State<ProfileUtp> {
  final UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  @override
  void initState() {
    super.initState();
  }

  TextEditingController amtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: GlobalVars.store
              .collection("UnderTrial")
              .doc(GlobalVars.auth.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      child: Text("Profile Of UTP"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: extraLightBlue,
                                    radius: 80,
                                    child: SvgPicture.asset(
                                      "assets/svgs/lawyer.icon.svg",
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name : Ayush",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 17),
                                      ),
                                      Text(
                                        "Father's Name : ABCC",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 17),
                                      ),
                                      Text(
                                        "CaseNo : 122",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 17),
                                      ),
                                      Text(
                                        "Gender : male",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 17),
                                      ),
                                      Text(
                                        "Fir No. : 12221",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 17),
                                      ),
                                      Text(
                                        "Police State(District) : Saket",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 17),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sectional Charges : 102, 301",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontSize: 17),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Date Of Arrest : 15-09-2023",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontSize: 17),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Date Of First Remand : 15-09-2023",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontSize: 17),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Date Of admission(prison) : 15-09-2023",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontSize: 17),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Date Of filling chargesheet : 15-09-2023",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontSize: 17),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.none) {
              return Center(
                child: Text("Error"),
              );
            }

            return Center(
              child: CircularProgressIndicator(color: darkBlue),
            );
          }),
    );
  }
}
