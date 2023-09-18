import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:trialtechtransform_app/constants/colors.dart';
import 'package:trialtechtransform_app/constants/size.config.dart';
import 'package:trialtechtransform_app/services/pref.service.dart';
import 'package:trialtechtransform_app/state_manage/cubits/auth.cubit.dart';
import 'package:trialtechtransform_app/state_manage/state/auth.state.dart';
import 'package:trialtechtransform_app/views/lawyer.view.dart/lawyer.home.dart';
import 'package:trialtechtransform_app/views/utp.view.dart/home.view.utp.dart';
import 'package:trialtechtransform_app/views/widgets/custom.widgets.dart';

class OtpScreen extends StatefulWidget {
  String role;
  String phn;
  String name;
  bool create;
  OtpScreen(
      {super.key,
      required this.phn,
      required this.role,
      required this.name,
      required this.create});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    authCubit.sendOtp(widget.phn, widget.role, widget.name, widget.create);
  }

  String otp = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/verify.png",
                height: 150,
                width: 150,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Verification",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "You will get otp via sms",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              OtpTextField(
                enabledBorderColor: greybg,
                borderColor: greybg,
                focusedBorderColor: greybg,
                numberOfFields: 6,
                filled: true,
                fillColor: greybg,
                textStyle: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.bold),
                onSubmit: (val) {
                  otp = val;
                },
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                  width: SizeConfig.width / 2,
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthErrorState) {
                        CustomWidget().snackBar(state.err, context, 500);
                      }
                      if (state is AuthDoneState) {
                        if (state.user.role == "UnderTrial") {
                          SharedPrefService().setValue("role", state.user.role);
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomeViewUTP()),
                              (route) => false);
                          CustomWidget()
                              .snackBar("Successfully SignIn", context, 500);
                        } else {
                          SharedPrefService().setValue("role", state.user.role);
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LawyerHome()),
                              (route) => false);
                          CustomWidget()
                              .snackBar("Successfully SignIn", context, 500);
                        }
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoadingState) {
                        return ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(pYellow)),
                            onPressed: () {},
                            child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                )));
                      }
                      return ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(pYellow)),
                          onPressed: () {
                            print(otp);
                            AuthCubit authCubit =
                                BlocProvider.of<AuthCubit>(context);
                            authCubit.verifyOtp(
                                otp, widget.role, widget.name, widget.create);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              "Verify",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20),
                            ),
                          ));
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
