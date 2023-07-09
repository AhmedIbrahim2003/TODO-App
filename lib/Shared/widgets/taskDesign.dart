// ignore_for_file: file_names

import 'package:flutter/material.dart';

Widget? taskDesign(Map taskData) {
  return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text('${taskData['time']}'),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${taskData['title']}',
                style: const TextStyle(fontSize: 25),
              ),
              Text('${taskData['date']}',style: const TextStyle(fontSize: 15),)
            ],
          )
        ],
      ),
    );
}