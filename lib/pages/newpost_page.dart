import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fbase/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final TextEditingController name = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            bottomNavigationBar: NavigationBar(destinations: [
              IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              const Icon(Icons.bookmark),
              const Icon(Icons.post_add_sharp),
              const Icon(Icons.person)
            ]),
            appBar: AppBar(
              centerTitle: true,
              title: const Text('New Post'),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                MyTextField(controller: name, hintText: 'Name', hide: false),
                MyTextField(controller: title, hintText: 'Title', hide: false),
                MyTextField(
                    controller: description,
                    hintText: 'Description',
                    hide: false),
                ElevatedButton(
                  onPressed: () {
                    final newPost = {
                      "Title": title.text,
                      "description": description.text,
                      "uploader": name.text,
                      "image":
                          "https://media.istockphoto.com/id/1468192804/photo/concept-of-generating-photo-realistic-image-by-ai-software.jpg?s=2048x2048&w=is&k=20&c=jXS96ktRzIYINHe71XAG1nKqf9BBj965BjDM4-pArYY=",
                      "createdAt": FieldValue.serverTimestamp(),
                      "email": FirebaseAuth.instance.currentUser!.email
                    };
                    try {
                      FirebaseFirestore.instance
                          .collection("posts")
                          .add(newPost);
                      Navigator.pop(context);
                    } catch (e) {
                      print("Error updating: $e");
                    }
                  },
                  style: ButtonStyle(
                      shape: const MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 109, 70, 109))),
                  child: const Text(
                    'Create Post',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            )));
  }
}
