import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trialtechtransform_app/constants/colors.dart';
import 'package:trialtechtransform_app/constants/global.var.dart';
import 'package:trialtechtransform_app/constants/size.config.dart';
import 'package:trialtechtransform_app/views/lawyer.view.dart/lawyerbottomviews/edit.profile.dart';

class LawyerProfile extends StatelessWidget {
  const LawyerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: GlobalVars.store
                .collection("lawyer")
                .doc(GlobalVars.auth.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    child: Column(
                      children: [
                        Text(
                          "Profile",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: darkBlue),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: extraLightBlue,
                              radius: 60,
                              child: SvgPicture.asset(
                                "assets/svgs/lawyer.icon.svg",
                                height: 65,
                                width: 65,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data!.get("name")),
                                Text(
                                  snapshot.data!.get("courtname"),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontSize: 20),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: pYellow,
                                    ),
                                    Text(
                                      snapshot.data!.get("rating"),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            height: 2,
                            width: SizeConfig.width,
                            color: greybg,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Contact No.",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 20),
                            ),
                            (snapshot.data!.get("phone") != "")
                                ? Text(
                                    snapshot.data!.get("phone"),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(fontSize: 20),
                                  )
                                : InkWell(
                                    child: Text(
                                      "Add Data",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(fontSize: 20, color: lblue),
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Email Address",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 20),
                            ),
                            (snapshot.data!.get("email") != "")
                                ? Text(
                                    snapshot.data!.get("email"),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(fontSize: 20),
                                  )
                                : InkWell(
                                    child: Text(
                                      "Add Data",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(fontSize: 20, color: lblue),
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Experience (in yr)",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 20),
                            ),
                            (snapshot.data!.get("exp") != "")
                                ? Text(
                                    snapshot.data!.get("exp"),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(fontSize: 18),
                                  )
                                : InkWell(
                                    child: Text(
                                      "Add Data",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(fontSize: 20, color: lblue),
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Law School",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 20),
                            ),
                            (snapshot.data!.get("LawSchool") != "")
                                ? Text(
                                    snapshot.data!.get("LawSchool"),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(fontSize: 18),
                                  )
                                : InkWell(
                                    child: Text(
                                      "Add Data",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(fontSize: 20, color: lblue),
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Practise Area",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 20),
                            ),
                            (snapshot.data!.get("practiseArea") != "")
                                ? Text(
                                    snapshot.data!.get("practiseArea"),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(fontSize: 18),
                                  )
                                : InkWell(
                                    child: Text(
                                      "Add Data",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(fontSize: 20, color: lblue),
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: SizeConfig.width,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(darkBlue)),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditProfileLawyer(
                                          phn: snapshot.data!.get("phone"),
                                          sch: snapshot.data!.get("LawSchool"),
                                          exp: snapshot.data!.get("exp"),
                                          pracArea: snapshot.data!
                                              .get("practiseArea"),
                                          email: snapshot.data!.get("email"),
                                        )));
                              },
                              child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Text("Edit Profile"))),
                        )
                      ],
                    ),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.none) {
                return Center(
                    child: Column(
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.blueGrey[500],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Error Occured",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 20),
                    )
                  ],
                ));
              }

              return const Center(
                child: CircularProgressIndicator(
                  color: darkBlue,
                ),
              );
            }));
  }
}
