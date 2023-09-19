import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:trialtechtransform_app/constants/colors.dart';

class UtpLaws extends StatelessWidget {
  const UtpLaws({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        title: Text(
          "UTP Laws",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 18, color: palletWhite),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "UTP Laws",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 25),
                ),
              ),
              Text(
                "Rules :",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "1. Right to a speedy trial: they have a constitutional right to a speedy trial as well as a fair trial.",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "2. Right to legal assistance: they can avail legal aid to assist with their case during their time as an undertrial prisoner. If they do not have the means to avail the same, they can get free legal services by making an application to the court.Right to meet family: their family member or friend should be informed of their arrest, and must have the option to visit the prisoner subject to certain security criterion.",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "3. Right against inhuman treatment: they have the right to be treated with dignity, and not be tortured or subjected to any form of inhuman treatment. To this end, they are not allowed to be handcuffed while being transferred from prison to court unless valid reasons can be provided for the same.",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
