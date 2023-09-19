import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trialtechtransform_app/constants/app.theme.dart';
import 'package:trialtechtransform_app/services/pref.service.dart';
import 'package:trialtechtransform_app/state_manage/cubits/auth.cubit.dart';
import 'package:trialtechtransform_app/state_manage/cubits/slot.cubit.dart';
import 'package:trialtechtransform_app/views/authview/auth.view.dart';
import 'package:trialtechtransform_app/views/lawyer.view.dart/lawyer.home.dart';
import 'package:trialtechtransform_app/views/utp.view.dart/home.view.utp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String role = "";

  void getData(String r) async {
    String val = await SharedPrefService().getValue(r);
    setState(() {
      role = val;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData("role");
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => SlotCubit())
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: AppTheme().appTheme(),
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (role == "UnderTrial") {
                    return HomeViewUTP();
                  } else {
                    return LawyerHome();
                  }
                }
                return AuthView();
              })),
    );
  }
}
