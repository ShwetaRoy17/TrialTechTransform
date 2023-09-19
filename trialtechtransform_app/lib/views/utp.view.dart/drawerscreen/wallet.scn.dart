import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:trialtechtransform_app/constants/colors.dart';
import 'package:trialtechtransform_app/constants/global.var.dart';
import 'package:trialtechtransform_app/views/utp.view.dart/bottomscreen/upi.payement.scrn.dart';
import 'package:trialtechtransform_app/views/widgets/custom.widgets.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: amtController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: greybg,
                                hintText: "Enter Amount",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10))),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(darkBlue)),
                              onPressed: () {
                                if (amtController.text.trim().isEmpty) {
                                  CustomWidget()
                                      .snackBar("Enter Amount", context, 1000);
                                } else {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => AddMoneyInWallet(
                                          prev: double.parse(snapshot.data!
                                              .get("balance")
                                              .toString()),
                                          amt: amtController.text.trim())));
                                }
                              },
                              child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  child: Text(
                                    "Add Money",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontSize: 15, color: palletWhite),
                                  ))))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Balance",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 20),
                          ),
                          Text(
                            "Rs. " + snapshot.data!.get("balance").toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.none) {
            return Center(
              child: Text(
                "Error In Getting Data ",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 18, color: darkBlue),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(
              color: darkBlue,
            ),
          );
        },
      ),
    );
  }
}
