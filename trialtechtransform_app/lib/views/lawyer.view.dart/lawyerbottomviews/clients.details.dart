import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trialtechtransform_app/constants/colors.dart';
import 'package:trialtechtransform_app/constants/global.var.dart';
import 'package:trialtechtransform_app/constants/size.config.dart';
import 'package:trialtechtransform_app/models/slot.model.dart';
import 'package:trialtechtransform_app/services/lawyer.services.dart';
import 'package:trialtechtransform_app/services/utp.services.dart';
import 'package:trialtechtransform_app/views/widgets/custom.widgets.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  List<SlotModel> slot = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: GlobalVars.store
          .collection("lawyer")
          .doc(GlobalVars.auth.currentUser!.uid)
          .collection("slots")
          .snapshots(),
      builder: (context, snapshot2) {
        if (snapshot2.hasData) {
          LawyerService.bookedSlot.clear();
          snapshot2.data!.docs.forEach((element) {
            if (element.get("occupied")) {
              LawyerService.bookedSlot.add(SlotModel(
                  slotID: element.id,
                  clientID: element.get("client"),
                  lawyerid: GlobalVars.auth.currentUser!.uid,
                  date: element.get("date"),
                  day: element.get("day"),
                  occupied: true,
                  slotAmt: element.get("fees")));
            }
          });
          if (LawyerService.bookedSlot.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.no_accounts,
                    color: Colors.grey,
                    size: 50,
                  ),
                  Text(
                    "No Client",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 20),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
              itemCount: LawyerService.bookedSlot.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: extraLightBlue,
                              child: SvgPicture.asset(
                                "assets/svgs/lawyer.icon.svg",
                                height: 60,
                                width: 60,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            StreamBuilder(
                                stream: GlobalVars.store
                                    .collection("UnderTrial")
                                    .doc(LawyerService
                                        .bookedSlot[index].clientID)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<dynamic> offence =
                                        snapshot.data!.get("sections");
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data!.get("name"),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(fontSize: 18)),
                                        Text(snapshot.data!.get("courtname"),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(fontSize: 18)),
                                        Text("sections : " + offence.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(fontSize: 18)),
                                        Text(
                                            "Timing : " +
                                                LawyerService
                                                    .bookedSlot[index].date
                                                    .toDate()
                                                    .hour
                                                    .toString() +
                                                " : " +
                                                LawyerService
                                                    .bookedSlot[index].date
                                                    .toDate()
                                                    .minute
                                                    .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(fontSize: 15)),
                                        Text(
                                            "Date : " +
                                                LawyerService
                                                    .bookedSlot[index].date
                                                    .toDate()
                                                    .day
                                                    .toString() +
                                                "-" +
                                                LawyerService
                                                    .bookedSlot[index].date
                                                    .toDate()
                                                    .month
                                                    .toString() +
                                                "-" +
                                                LawyerService
                                                    .bookedSlot[index].date
                                                    .toDate()
                                                    .year
                                                    .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(fontSize: 15)),
                                      ],
                                    );
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.none) {
                                    return Center(
                                      child: Text(
                                        "Error",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(fontSize: 15),
                                      ),
                                    );
                                  }

                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: darkBlue,
                                    ),
                                  );
                                })
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: SizeConfig.width / 2,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red)),
                                    onPressed: () async {
                                      try {
                                        LawyerService().cancelSlot(
                                            GlobalVars.auth.currentUser!.uid,
                                            LawyerService
                                                .bookedSlot[index].slotID,
                                            LawyerService
                                                .bookedSlot[index].clientID);
                                        CustomWidget().snackBar(
                                            "Slot Cancelled", context, 1000);
                                      } catch (e) {
                                        CustomWidget().snackBar(
                                            e.toString(), context, 1000);
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Text(
                                        "Cancel",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontSize: 15,
                                                color: Colors.white),
                                      ),
                                    )),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        }
        return const Center(
          child: CircularProgressIndicator(
            color: darkBlue,
          ),
        );
      },
    ));
  }
}
