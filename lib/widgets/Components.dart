// ignore_for_file: file_names

import 'package:flutter/material.dart';

Widget? taskDesign() {
  return const Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text('02:30'),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Task 1',
                style: TextStyle(fontSize: 25),
              ),
              Text('2 jun 14, 2023',style: TextStyle(fontSize: 15),)
            ],
          )
        ],
      ),
    );
}