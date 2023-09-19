import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trialtechtransform_app/constants/colors.dart';

class NgoView extends StatelessWidget {
  const NgoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        centerTitle: true,
        title: Text(
          "NGOs",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 18, color: palletWhite),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            Card(
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: extraLightBlue,
                      child: SvgPicture.asset(
                        "assets/svgs/ngo.svg",
                        height: 40,
                        width: 40,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Legal Aid Ngo",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 20),
                        ),
                        Text(
                          "Khandpur, Delhi",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 15),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
