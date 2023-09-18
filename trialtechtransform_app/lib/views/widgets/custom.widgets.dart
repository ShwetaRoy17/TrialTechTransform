import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trialtechtransform_app/constants/colors.dart';

class CustomWidget {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
      String mssg, BuildContext context, int duration) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(mssg),
      duration: Duration(milliseconds: duration),
    ));
  }

  Widget homeCardDetail(
      BuildContext context, String label, String path, Function function) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: InkWell(
        onTap: () {
          function();
        },
        child: Card(
          color: palletWhite,
          elevation: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                path,
                height: 60,
                width: 60,
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
