import 'package:flutter/material.dart';

class MyPostCard extends StatelessWidget {
  const MyPostCard(
      {super.key,
      required this.name,
      required this.pfp,
      required this.title,
      required this.description,
      required this.elapsedTime});
  final String name;
  final String pfp;
  final String title;
  final String description;
  final String elapsedTime;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(pfp),
                    ),
                  ),
                  Text(name)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(elapsedTime),
            )
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              description,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
      ]),
    );
  }
}
