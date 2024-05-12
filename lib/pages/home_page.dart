import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbase/components/my_card.dart';
import 'package:fbase/components/my_textfield.dart';
import 'package:fbase/pages/login.dart';
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
        bottomNavigationBar: NavigationBar(destinations: const [
          Icon(Icons.home),
          Icon(Icons.bookmark),
          Icon(Icons.post_add_sharp),
          Icon(Icons.person)
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
            if (snapshot.connectionState == ConnectionState.waiting) {
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
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        const Expanded(flex: 2, child: SearchBar()),
                        Expanded(
                            flex: 1,
                            child: Card(
                              elevation: 6.0,
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
                          padding: EdgeInsets.all(8.0),
                          child: MyPostCard(
                            title: snapshot.data!.docs[index]['Title'],
                            name: snapshot.data!.docs[index]['uploader'],
                            description: snapshot.data!.docs[index]['description'],
                            pfp:
                                snapshot.data!.docs[index]['image'],
                            elapsedTime: "${now.difference(snapshot.data!.docs[index]['createdAt'].toDate()).inHours}h",
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
                      child: Text('Couldnt fetch data because ${snapshot}')));
            }
          },
          stream: FirebaseFirestore.instance.collection("posts").snapshots(),
        ),
      ),
    );
  }
}
