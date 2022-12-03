import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';

var now = DateTime.now();//현재 시각

Widget timeView(BuildContext context) {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TimerBuilder.periodic(
          const Duration(seconds: 1),
          builder: (context) {
            return Text(
              "약속 시각 : ${DateFormat.Hms().format(now)}",
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            );
          },
        ),
      ],
    ),
  );
}

