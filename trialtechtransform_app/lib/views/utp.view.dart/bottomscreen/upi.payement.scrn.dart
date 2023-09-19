import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:trialtechtransform_app/constants/colors.dart';
import 'package:trialtechtransform_app/constants/global.var.dart';
import 'package:trialtechtransform_app/services/wallet.service.dart';
import 'package:trialtechtransform_app/views/utp.view.dart/bottomscreen/home.utp.dart';
import 'package:trialtechtransform_app/views/utp.view.dart/bottomscreen/profile.utp.dart';
import 'package:trialtechtransform_app/views/utp.view.dart/home.view.utp.dart';
import 'package:trialtechtransform_app/views/widgets/custom.widgets.dart';
import 'package:upi_india/upi_india.dart';

class AddMoneyInWallet extends StatefulWidget {
  double prev;
  String amt;
  AddMoneyInWallet({super.key, required this.prev, required this.amt});

  @override
  State<AddMoneyInWallet> createState() => _AddMoneyInWalletState();
}

class _AddMoneyInWalletState extends State<AddMoneyInWallet> {
  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  @override
  void initState() {
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        apps = value;
      });
    }).catchError((e) {
      apps = [];
    });
    super.initState();
  }

  Future<UpiResponse> initiateTransaction(
      UpiApp app, double amt, double prev) async {
    final response = await _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "9870252408@ybl",
      receiverName: 'Net Ram Mahawar',
      transactionRefId: 'TestingUpiIndiaPlugin',
      transactionNote: 'Adding Money To Wallet',
      amount: amt,
    );
    if (response.status == UpiPaymentStatus.SUCCESS) {
      WalletService().addMoneyToWalletInUtp(
          GlobalVars.auth.currentUser!.uid, prev.toInt(), amt.toInt());
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeViewUTP()));
      CustomWidget().snackBar("Money Added to Wallet", context, 1000);
    } else if (response.status == UpiPaymentStatus.SUBMITTED) {
      // User submitted the payment but didn't complete it
      // Handle this scenario if necessary
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeViewUTP()));
      CustomWidget().snackBar("You Cancelled the payment", context, 800);
    } else if (response.status == UpiPaymentStatus.FAILURE) {
      // faliure payment
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeViewUTP()));
      CustomWidget().snackBar("Payment Failed", context, 800);
    } else {}

    return response;
  }

  Widget displayUI() {
    if (apps == null) {
      return const Center(
        child: CircularProgressIndicator(
          color: darkBlue,
        ),
      );
    } else if (apps!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error),
            SizedBox(
              height: 20,
            ),
            Text(
              "No App Available to handle transaction",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.bold),
            )
          ],
        ),
      );
    } else {
      // return Align(
      //   child: SingleChildScrollView(
      //     child: Wrap(
      //       children: apps!.map<Widget>((UpiApp app) {
      //         return GestureDetector(
      //           child: ,
      //         );
      //       }),
      //     ),
      //   ),
      // )

      return ListView.builder(
          itemCount: apps!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: InkWell(
                onTap: () async {
                  await initiateTransaction(
                      apps![index], double.parse(widget.amt), widget.prev);
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      children: [
                        Image.memory(
                          apps![index].icon,
                          height: 50,
                          width: 50,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text(
                              apps![index].name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Money",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontWeight: FontWeight.bold, color: palletWhite),
          ),
          backgroundColor: darkBlue,
          centerTitle: true,
        ),
        body: displayUI());
  }
}
