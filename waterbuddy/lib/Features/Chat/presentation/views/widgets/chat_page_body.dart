import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:waterbuddy/Core/Utils/assets.dart';
import 'package:waterbuddy/Core/widgets/ShowSnackBar.dart';
import 'package:waterbuddy/Features/Chat/data/massege.dart';
import 'package:waterbuddy/Features/Chat/data/services.dart';
import 'package:waterbuddy/Features/Chat/presentation/views/widgets/chat_bubble.dart';

class ChatPagebody extends StatefulWidget {
  const ChatPagebody({super.key});

  @override
  State<ChatPagebody> createState() => _ChatPagebodyState();
}

class _ChatPagebodyState extends State<ChatPagebody> {
  TextEditingController controller = TextEditingController();
  CollectionReference usermasseges =
      FirebaseFirestore.instance.collection('usermasseges');
  CollectionReference botmasseges =
      FirebaseFirestore.instance.collection('botmasseges');
  final scontroller = ScrollController();

  final chatbotApiClient = ChatbotApiClient();
  String data = "";

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    return StreamBuilder<QuerySnapshot>(
        stream: usermasseges.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Massege> massegelist = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              massegelist.add(Massege.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                  scrolledUnderElevation: 0.0,
                  toolbarHeight: 65,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  elevation: BorderSide.strokeAlignCenter,
                  /*   leading: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.settings),
                ),*/
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        AssetsPath.logo1,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'WaterBuddy Bot',
                            style: TextStyle(
                                color: Colors.blue,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '• online',
                            style: TextStyle(color: Colors.green, fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  )),
              body: Column(
                children: [
                  const Divider(
                    indent: 5,
                    endIndent: 5,
                    thickness: 0.7,
                    color: Colors.grey,
                    height: 0.5,
                  ),
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: scontroller,
                      itemCount: massegelist.length,
                      itemBuilder: (context, index) {
                        if (massegelist[index].id == email) {
                          return ChatBubble(
                            massege: massegelist[index],
                          );
                        } else if (massegelist[index].id == '1$email') {
                          return BotChatBubble(
                            massege: massegelist[index],
                          );
                        }
                        return null;
                      },
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.12),
                              offset: const Offset(20, 10),
                              spreadRadius: 1),
                        ]),
                        height: 50,
                        child: TextField(
                          onChanged: (value) {
                            data = value;
                          },
                          controller: controller,
                          onSubmitted: (data) async {
                            usermasseges.add(
                              {
                                'massege': data,
                                'createdAt': DateTime.now(),
                                'id': email
                              },
                            );
                            controller.clear();
                            scontroller.animateTo(0,
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastOutSlowIn);
                            String history = "...";
                            try {
                              final response =
                                  await getTextResponse(data, history);

                              history += "user: $data\nbot: $response";

                              usermasseges.add({
                                'massege': response,
                                'createdAt': DateTime.now(),
                                'id': '1$email'
                              });
                            } on Exception {
                              showSnackBar(context, 'Something went wrong');
                            }
                            controller.clear();
                            scontroller.animateTo(0,
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastOutSlowIn);
                          },
                          decoration: InputDecoration(
                            focusColor: Colors.white,
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0.2),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            hintText: 'Write your massege',
                            hintStyle: const TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 0.5),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            suffix: IconButton(
                              autofocus: true,
                              onPressed: () async {
                                usermasseges.add(
                                  {
                                    'massege': data,
                                    'createdAt': DateTime.now(),
                                    'id': email
                                  },
                                );
                                controller.clear();
                                scontroller.animateTo(0,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.fastOutSlowIn);
                                String history = "...";
                                try {
                                  final response =
                                      await getTextResponse(data, history);

                                  history += "user: $data\nbot: $response";

                                  usermasseges.add({
                                    'massege': response,
                                    'createdAt': DateTime.now(),
                                    'id': '1$email'
                                  });
                                } on Exception {
                                  showSnackBar(context, 'Something went wrong');
                                }
                                controller.clear();
                                scontroller.animateTo(0,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.fastOutSlowIn);
                              },
                              icon: const Icon(
                                Icons.send_rounded,
                                color: Colors.blue,
                              ),
                              color: Colors.black,
                              alignment: Alignment.center,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  )
                ],
              ),
            );
          } else {
            return Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: const CircularProgressIndicator(),
            );
          }
        });
  }
}
