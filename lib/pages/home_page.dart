import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbase/components/my_card.dart';
import 'package:fbase/components/my_textfield.dart';
import 'package:fbase/pages/login.dart';
import 'package:fbase/pages/newpost_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

void signOut(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.red,
          content: Center(
            child: Text('Could not create User $e'),
          ),
          duration: const Duration(seconds: 4)),
    );
  }
}

class _HomePageState extends State<HomePage> {
  final TextEditingController cont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: NavigationBar(destinations: [
          const Icon(Icons.home),
          const Icon(Icons.bookmark),
          IconButton(
              icon: const Icon(Icons.post_add_sharp),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewPost()),
                );
              }),
          const Icon(Icons.person)
        ]),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Home',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () => signOut(context),
                icon: const Icon(Icons.logout))
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              // print(snapshot.data!.docs[0]['name']);
              return Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Text(
                            "Hey ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${FirebaseAuth.instance.currentUser!.email}",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 109, 70, 109),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Start exploring resources",
                          style: TextStyle(fontSize: 15)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        const Expanded(
                            flex: 2,
                            child: SearchBar(
                              hintText: 'Search by name',
                            )),
                        Expanded(
                            flex: 1,
                            child: Card(
                              elevation: 4,
                              clipBehavior: Clip.hardEdge,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: const Icon(
                                Icons.filter_alt_sharp,
                                size: 58,
                              ),
                            ))
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final DateTime now = DateTime.now();
                        // print(snapshot.data!.docs[index]['createdAt'] as DateTime);
                        // print(now);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              // print(FirebaseAuth.instance.currentUser!.email);
                              // print(snapshot.data!.docs[index]['email']);
                              if (FirebaseAuth.instance.currentUser!.email ==
                                  snapshot.data!.docs[index]['email']) {
                                final TextEditingController name =
                                    TextEditingController();
                                final TextEditingController title =
                                    TextEditingController();
                                final TextEditingController description =
                                    TextEditingController();
                                showModalBottomSheet(
                                  scrollControlDisabledMaxHeightRatio: 0.8,
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      children: [
                                        const SizedBox(height: 30),
                                        MyTextField(
                                            controller: name,
                                            hintText: 'Name',
                                            hide: false),
                                        MyTextField(
                                            controller: title,
                                            hintText: 'Title',
                                            hide: false),
                                        MyTextField(
                                            controller: description,
                                            hintText: 'Description',
                                            hide: false),
                                        ElevatedButton(
                                          onPressed: () {
                                            final String id =
                                                snapshot.data!.docs[index].id;
                                            final docRef = FirebaseFirestore
                                                .instance
                                                .collection("posts")
                                                .doc(id);
                                            final update = {
                                              "Title": title.text,
                                              "description": description.text,
                                              "uploader": name.text
                                            };
                                            try {
                                              docRef.update(update);
                                              print(
                                                  "data updated successfully");
                                              Navigator.pop(context);
                                            } catch (e) {
                                              print("Error updating: $e");
                                            }
                                          },
                                          style: ButtonStyle(
                                              shape:
                                                  const MaterialStatePropertyAll(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(5),
                                                  ),
                                                ),
                                              ),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      const Color.fromARGB(
                                                          255, 109, 70, 109))),
                                          child: const Text(
                                            'Edit Post',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Center(
                                        child: Text(
                                            'You can only edit your own posts'),
                                      ),
                                      duration: Duration(seconds: 4)),
                                );
                              }
                            },
                            child: MyPostCard(
                              title: snapshot.data!.docs[index]['Title'],
                              name: snapshot.data!.docs[index]['uploader'],
                              description: snapshot.data!.docs[index]
                                  ['description'],
                              pfp: snapshot.data!.docs[index]['image'],
                              elapsedTime: Helper.timeAgo(
                                  ((snapshot.data!.docs[index]['createdAt'] !=
                                              null)
                                          ? (snapshot.data!.docs[index]
                                              ['createdAt'] as Timestamp)
                                          : Timestamp.now())
                                      .toDate())!,
                            ),
                          ),
                        );
                      },
                      itemCount: snapshot.data!.size,
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                  child: Card(
                      child: Text('Couldnt fetch data because $snapshot')));
            }
          },
          stream: FirebaseFirestore.instance
              .collection("posts")
              .orderBy('createdAt', descending: true)
              .snapshots(),
        ),
      ),
    );
  }
}

class Helper {
  static String? timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 0) return "just now";

    final seconds = difference.inSeconds;
    if (seconds < 60) {
      return '${seconds}s';
    }

    final minutes = difference.inMinutes;
    if (minutes < 60) {
      return '${minutes}m';
    }

    final hours = difference.inHours;
    if (hours < 24) {
      return '${hours}h';
    }

    final days = difference.inDays;
    if (days < 7) {
      return '${days}d';
    }
  }
}
