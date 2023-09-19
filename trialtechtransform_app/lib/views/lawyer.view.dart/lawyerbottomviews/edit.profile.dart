import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:trialtechtransform_app/constants/colors.dart';
import 'package:trialtechtransform_app/constants/global.var.dart';
import 'package:trialtechtransform_app/constants/size.config.dart';
import 'package:trialtechtransform_app/views/widgets/custom.widgets.dart';

class EditProfileLawyer extends StatefulWidget {
  String phn;
  String email;
  String sch;
  String exp;
  String pracArea;
  EditProfileLawyer(
      {super.key,
      required this.email,
      required this.exp,
      required this.phn,
      required this.pracArea,
      required this.sch});

  @override
  State<EditProfileLawyer> createState() => _EditProfileLawyerState();
}

class _EditProfileLawyerState extends State<EditProfileLawyer> {
  TextEditingController email = TextEditingController();
  TextEditingController phn = TextEditingController();
  TextEditingController lawSch = TextEditingController();
  TextEditingController prac = TextEditingController();
  TextEditingController exp = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email.text = widget.email;
    phn.text = widget.phn;
    prac.text = widget.pracArea;
    exp.text = widget.exp;
    lawSch.text = widget.sch;
  }

  Widget infoWidget(
      String label, String val, TextEditingController controller, bool enable) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15),
          enabled: enable,
          controller: controller,
          decoration: InputDecoration(
              filled: true,
              fillColor: extraLightBlue,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none)),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: palletWhite, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              infoWidget("Phone Number", widget.phn, phn, false),
              const SizedBox(
                height: 10,
              ),
              infoWidget("Email Address", widget.email, email, true),
              const SizedBox(
                height: 10,
              ),
              infoWidget("Experience (in yr)", widget.exp, exp, true),
              const SizedBox(
                height: 10,
              ),
              infoWidget("Law School", widget.sch, lawSch, true),
              const SizedBox(
                height: 10,
              ),
              infoWidget("Practise Area", widget.pracArea, prac, true),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: SizeConfig.width,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(darkBlue)),
                  onPressed: () async {
                    await GlobalVars.store
                        .collection("lawyer")
                        .doc(GlobalVars.auth.currentUser!.uid)
                        .set({
                      "email": email.text.trim(),
                      "LawSchool": lawSch.text.trim(),
                      "exp": exp.text.trim(),
                      "practiseArea": prac.text.trim(),
                    }, SetOptions(merge: true));
                    Navigator.pop(context);
                    CustomWidget().snackBar("Updated Profile", context, 800);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Apply Changes",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: palletWhite, fontSize: 15),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
