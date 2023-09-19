import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:trialtechtransform_app/constants/colors.dart';
import 'package:trialtechtransform_app/constants/global.var.dart';
import 'package:trialtechtransform_app/views/utp.view.dart/utpservicesview/connect.lawyer.view.dart';

class BookedSlotNavBar extends StatelessWidget {
  const BookedSlotNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: GlobalVars.store
            .collection("UnderTrial")
            .doc(GlobalVars.auth.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return (snapshot.data!.get("bookedslot") == false)
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error,
                          size: 30,
                          color: Colors.grey[400],
                        ),
                        Text(
                          "No Slot Booked",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.grey),
                        )
                      ],
                    ),
                  )
                : BookedSlot(
                    lawyerId: snapshot.data!.get("lawyer"),
                    slotId: snapshot.data!.get("slotid"));
          }

          if (snapshot.connectionState == ConnectionState.none) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error,
                  size: 30,
                  color: Colors.grey[400],
                ),
                Text(
                  "Error Occured",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.grey),
                )
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: darkBlue,
            ),
          );
        });
  }
}
