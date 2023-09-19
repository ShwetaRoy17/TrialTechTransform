import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trialtechtransform_app/constants/colors.dart';
import 'package:trialtechtransform_app/constants/global.var.dart';
import 'package:trialtechtransform_app/constants/size.config.dart';
import 'package:trialtechtransform_app/models/slot.model.dart';
import 'package:trialtechtransform_app/services/mssg.service.dart';
import 'package:trialtechtransform_app/services/utp.services.dart';
import 'package:trialtechtransform_app/state_manage/cubits/slot.cubit.dart';
import 'package:trialtechtransform_app/state_manage/state/slot.state.dart';
import 'package:trialtechtransform_app/views/widgets/custom.widgets.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class ConnectLawyer extends StatefulWidget {
  const ConnectLawyer({super.key});

  @override
  State<ConnectLawyer> createState() => _ConnectLawyerState();
}

class _ConnectLawyerState extends State<ConnectLawyer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SlotCubit slotCub = BlocProvider.of<SlotCubit>(context);
    slotCub.fetchSlot(currentDate);
  }

  String lawyerId = "";
  DateTime currentDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0);

  void changeToDateNextDay() {
    setState(() {
      currentDate = currentDate.add(const Duration(days: 1));
    });
  }

  void changeToPrevDay() {
    setState(() {
      currentDate = currentDate.add(const Duration(days: -1));
    });
  }

  @override
  Widget build(BuildContext context) {
    SlotCubit slotCub = BlocProvider.of<SlotCubit>(context);
    slotCub.fetchSlot(currentDate);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: darkBlue,
          centerTitle: true,
          title: Text(
            "Connect With Lawyer",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    color: greybg, borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        changeToPrevDay();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: darkBlue,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(
                          Icons.chevron_left_sharp,
                          color: palletWhite,
                          size: 50,
                        ),
                      ),
                    ),
                    Text(
                        "${currentDate.day}-${currentDate.month}-${currentDate.year}"),
                    InkWell(
                      onTap: () {
                        changeToDateNextDay();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: darkBlue,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(
                          Icons.chevron_right_sharp,
                          color: palletWhite,
                          size: 50,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            StreamBuilder(
                stream: GlobalVars.store
                    .collection("UnderTrial")
                    .doc(GlobalVars.auth.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.get("bookedslot") == false) {
                      return BlocConsumer<SlotCubit, SlotStates>(
                          builder: (context, state) {
                            if (state is FetchedSlotsState) {
                              return Expanded(
                                child: ListView.builder(
                                  itemCount: UtpService.slotsList.length,
                                  itemBuilder: (context, index) {
                                    if (UtpService.slotsList[index].date
                                            .toDate()
                                            .day ==
                                        currentDate.day) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Card(
                                          elevation: 4,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            extraLightBlue,
                                                        child: SvgPicture.asset(
                                                          "assets/svgs/lawyer.icon.svg",
                                                          height: 60,
                                                          width: 60,
                                                        ),
                                                        radius: 50,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: SizedBox(
                                                        child: Row(
                                                          children: [
                                                            StreamBuilder(
                                                                stream: GlobalVars
                                                                    .store
                                                                    .collection(
                                                                        "lawyer")
                                                                    .doc(UtpService
                                                                        .slotsList[
                                                                            index]
                                                                        .lawyerid)
                                                                    .snapshots(),
                                                                builder: (context,
                                                                    snapshot2) {
                                                                  if (snapshot2
                                                                      .hasData) {
                                                                    return Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(snapshot2.data!.get("name")),
                                                                              Text(
                                                                                snapshot2.data!.get("courtname"),
                                                                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15),
                                                                              ),
                                                                              Text(
                                                                                "Experience : " + snapshot2.data!.get("exp") + "yr",
                                                                                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 14),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  }

                                                                  if (snapshot2
                                                                          .connectionState ==
                                                                      ConnectionState
                                                                          .none) {
                                                                    return Center(
                                                                      child: Text(
                                                                          "None"),
                                                                    );
                                                                  }

                                                                  return const Center(
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      color:
                                                                          darkBlue,
                                                                    ),
                                                                  );
                                                                })
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                        child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color:
                                                              extraLightBlue),
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 15),
                                                        child: Center(
                                                          child: Text(
                                                            "Rs. ${UtpService.slotsList[index].slotAmt} ",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                        ),
                                                      ),
                                                    ))
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                SizedBox(
                                                  width: SizeConfig.width,
                                                  child: ElevatedButton(
                                                      style: ButtonStyle(
                                                          shape: MaterialStateProperty.all(
                                                              RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          20))),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(
                                                                      darkBlue)),
                                                      onPressed: () {
                                                        try {
                                                          print(UtpService
                                                              .slotsList[index]
                                                              .lawyerid);
                                                          print(UtpService
                                                              .slotsList[index]
                                                              .slotID);

                                                          UtpService
                                                                  .slotsList[index]
                                                                  .clientID =
                                                              snapshot.data!.id;
                                                          print(UtpService
                                                              .slotsList[index]
                                                              .clientID);

                                                          UtpService()
                                                              .updateFirebaseForBookingSlot(
                                                                  UtpService
                                                                      .slotsList[
                                                                          index]
                                                                      .lawyerid,
                                                                  UtpService
                                                                      .slotsList[
                                                                          index]
                                                                      .clientID,
                                                                  UtpService
                                                                      .slotsList[
                                                                          index]
                                                                      .slotID);
                                                          CustomWidget().snackBar(
                                                              "Slot is Booked Successfully",
                                                              context,
                                                              1000);
                                                        } catch (e) {
                                                          CustomWidget()
                                                              .snackBar(
                                                                  e.toString(),
                                                                  context,
                                                                  1000);
                                                        }
                                                      },
                                                      child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 20),
                                                          child: Text(
                                                              "Book Slot"))),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              );
                            }

                            if (state is ErrorInFetchedState) {
                              return Center(
                                child: Text(state.err.toString()),
                              );
                            }

                            return const Center(
                              child: CircularProgressIndicator(
                                color: darkBlue,
                              ),
                            );
                          },
                          listener: (context, state) {});
                    } else {
                      return BookedSlot(
                        lawyerId: snapshot.data!.get("lawyer").toString(),
                        slotId: snapshot.data!.get("slotid").toString(),
                      );
                    }
                  }

                  if (snapshot.connectionState == ConnectionState.none) {
                    return Center(
                      child: Text("Error Occured"),
                    );
                  }

                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.blueAccent,
                    ),
                  );
                }),
          ],
        ));
  }
}

class BookedSlot extends StatefulWidget {
  String lawyerId;
  String slotId;
  BookedSlot({super.key, required this.lawyerId, required this.slotId});

  @override
  State<BookedSlot> createState() => _BookedSlotState();
}

class _BookedSlotState extends State<BookedSlot> {
  Widget rowForDetails(String label, String val, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20),
        ),
        Text(
          val,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 20),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: GlobalVars.store
            .collection("lawyer")
            .doc(widget.lawyerId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.5),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: extraLightBlue,
                                radius: 50,
                                child: SvgPicture.asset(
                                  "assets/svgs/lawyer.icon.svg",
                                  height: 60,
                                  width: 60,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data!.get("name"),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(),
                                  ),
                                  Text(
                                    snapshot.data!.get("courtname"),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontSize: 20),
                                  ),
                                  Text(
                                    '${"Experience : " + snapshot.data!.get("exp")}yrs',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          StreamBuilder(
                              stream: GlobalVars.store
                                  .collection("lawyer")
                                  .doc(widget.lawyerId)
                                  .collection("slots")
                                  .doc(widget.slotId)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  DateTime date =
                                      snapshot.data!.get("date").toDate();

                                  return Column(
                                    children: [
                                      rowForDetails(
                                          "Date",
                                          "${date.day}-${date.month}-${date.year}",
                                          context),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      rowForDetails(
                                          "Time",
                                          "${date.hour} : ${date.minute}",
                                          context),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      rowForDetails("Day",
                                          snapshot.data!.get("day"), context),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      rowForDetails(
                                          "Amount",
                                          "Rs. " + snapshot.data!.get("fees"),
                                          context),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Image.asset(
                                        "assets/images/verify.png",
                                        height: 80,
                                        width: 80,
                                      ),
                                      Text(
                                        "Your Slot has been booked successfully",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontSize: 20,
                                                color: Colors.green),
                                      )
                                    ],
                                  );
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.none) {
                                  return Center(
                                    child: Text("Error"),
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
                    ),
                  ),
                ],
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.none) {
            return Center(
              child: Row(
                children: [
                  Icon(Icons.error),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Error Occured",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 20),
                  )
                ],
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
