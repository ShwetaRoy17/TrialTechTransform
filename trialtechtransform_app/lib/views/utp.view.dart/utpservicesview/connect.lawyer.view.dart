import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trialtechtransform_app/constants/colors.dart';
import 'package:trialtechtransform_app/constants/global.var.dart';
import 'package:trialtechtransform_app/services/utp.services.dart';
import 'package:trialtechtransform_app/state_manage/cubits/slot.cubit.dart';
import 'package:trialtechtransform_app/state_manage/state/slot.state.dart';

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
    slotCub.fetchSlot();
  }

  @override
  Widget build(BuildContext context) {
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
        body: StreamBuilder(
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
                          return ListView.builder(
                            itemCount: UtpService.lawyers.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Card(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: darkBlue,
                                              child: Icon(
                                                Icons.person,
                                                size: 40,
                                              ),
                                              radius: 30,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  UtpService
                                                      .lawyers[index].name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 20),
                                                ),
                                                // SizedBox(
                                                //   height: 5,
                                                // ),
                                                Text(
                                                  UtpService
                                                      .lawyers[index].lawyerUid,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: ElevatedButton.icon(
                                              icon: Icon(Icons.info),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          darkBlue)),
                                              onPressed: () {},
                                              label: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15),
                                                child: Text("Info"),
                                              ),
                                            )),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                                child: ElevatedButton.icon(
                                              icon: Icon(Icons.book_sharp),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          darkBlue)),
                                              onPressed: () async {
                                                UtpService()
                                                    .updateFirebaseForBookingSlot(
                                                        UtpService
                                                            .lawyers[index]
                                                            .lawyerUid,
                                                        GlobalVars.auth
                                                            .currentUser!.uid);
                                              },
                                              label: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15),
                                                child: Text("Book Slot"),
                                              ),
                                            ))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
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
                  return Center(
                    child: Text("You Have Already booked slot"),
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
            }));
  }
}
