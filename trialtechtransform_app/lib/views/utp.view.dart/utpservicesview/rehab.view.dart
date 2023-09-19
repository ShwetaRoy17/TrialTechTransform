import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:trialtechtransform_app/constants/colors.dart';
import 'package:trialtechtransform_app/views/widgets/custom.widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class RehabView extends StatelessWidget {
  const RehabView({super.key});

  void _launchURL(String url, BuildContext context) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(uri);
    } else {
      CustomWidget().snackBar("Cant Launch Url , for Now", context, 1000);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        centerTitle: true,
        title: Text(
          "Rehabilation",
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
            InkWell(
              onTap: () {
                _launchURL(
                    "https://www.youtube.com/watch?v=llhPBn-mgEs&list=PL3xVDtIjYKEBdLMZWCZwiuYuxlUGtc5Dg",
                    context);
              },
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: extraLightBlue,
                        child: SvgPicture.asset(
                          "assets/svgs/rehab.svg",
                          height: 30,
                          width: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sewing and Tailoring",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 20),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
