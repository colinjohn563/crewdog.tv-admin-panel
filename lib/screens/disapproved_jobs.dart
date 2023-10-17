// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crewdogadmin/video_player.dart';
import 'package:show_network_image/show_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class DisapprovedJobs extends StatefulWidget {
  const DisapprovedJobs({super.key});

  @override
  State<DisapprovedJobs> createState() => _DisapprovedJobsState();
}

class _DisapprovedJobsState extends State<DisapprovedJobs> {
  @override
  Widget build(BuildContext context) {
    // final sw = MediaQuery.of(context).size.width;

    // return Scaffold(
    //   appBar: AdaptiveNavBar(
    //     automaticallyImplyLeading: false,
    //     screenWidth: sw,
    //     centerTitle: false,
    //     title: const Text("Crewdog Admin"),
    //     navBarItems: [
    //       NavBarItem(
    //         text: "Home",
    //         onTap: () {
    //           Get.to(() => const Dashboard());
    //         },
    //       ),
    //       NavBarItem(
    //         text: "All Users",
    //         onTap: () {
    //           Get.to(() => const AllUsersScreen());
    //         },
    //       ),
    //       NavBarItem(
    //         text: "All Jobs",
    //         onTap: () {
    //           Get.to(() => const AllJobs());
    //         },
    //       ),
    //       NavBarItem(
    //         text: "Logout",
    //         onTap: () async {
    //           FirebaseAuth.instance.signOut();
    //           await Get.offAll(() => const LoginScreen());
    //         },
    //       ),
    //     ],
    //   ),
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('jobs')
          .where('status', isEqualTo: 'reject')
          .get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot details = snapshot.data!.docs[index];
              return Card(
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(06.0)),
                  trailing: Wrap(
                    spacing: 12,
                    children: <Widget>[
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    title:
                                        const Text("Approve or Disaprove Job"),
                                    content: const Text(
                                        "Mark this job are approved or disapproved"),
                                    actions: [
                                      TextButton(
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
                                                .collection('jobs')
                                                .doc(details.id)
                                                .update({'status': 'reject'});
                                            Get.back();
                                          },
                                          child: const Text("Disapprove")),
                                      TextButton(
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
                                                .collection('jobs')
                                                .doc(details.id)
                                                .update({'status': 'accept'});
                                            Get.back();
                                          },
                                          child: const Text("Approve"))
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(
                            Icons.approval,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () {
                            setState(() {});
                            showBottomSheet(
                              backgroundColor: Colors.white,
                              context: context,
                              builder: (context) => SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          color: Colors.black,
                                          child: IconButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              icon: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          height: 400,
                                          child: Center(
                                            child: AspectRatio(
                                              aspectRatio: 16 / 9,
                                              child: CustomVideoPlayer(
                                                videoUrl: details['videoUrl'],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                              "If the video doesn't works in the video player below, click the link below to open the video in your browser",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey)),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Text(
                                            "Job Video:",
                                            style: TextStyle(
                                                background: Paint()
                                                  ..shader =
                                                      const LinearGradient(
                                                    colors: <Color>[
                                                      Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      Color.fromARGB(
                                                          255, 84, 87, 89)
                                                    ],
                                                  ).createShader(
                                                          const Rect.fromLTWH(
                                                              0.0,
                                                              0.0,
                                                              200.0,
                                                              70.0)),
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ),
                                        ListTile(
                                          onTap: () {
                                            // URL Launcher
                                            final Uri url = Uri.parse(
                                                '${details['videoUrl']}');
                                            launch(url.toString());
                                          },
                                          title: Text(
                                            "${details['videoUrl']}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                          subtitle: const Text(
                                            "Tap to open video",
                                            style: TextStyle(
                                                fontSize: 18,
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Text(
                                            "Job Status:",
                                            style: TextStyle(
                                                background: Paint()
                                                  ..shader =
                                                      const LinearGradient(
                                                    colors: <Color>[
                                                      Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      Color.fromARGB(
                                                          255, 84, 87, 89)
                                                    ],
                                                  ).createShader(
                                                          const Rect.fromLTWH(
                                                              0.0,
                                                              0.0,
                                                              200.0,
                                                              70.0)),
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Text(
                                            "${details['status']}" == 'accept'
                                                ? 'Approved'
                                                : 'Disapproved',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Text(
                                            "Title:",
                                            style: TextStyle(
                                                background: Paint()
                                                  ..shader =
                                                      const LinearGradient(
                                                    colors: <Color>[
                                                      Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      Color.fromARGB(
                                                          255, 84, 87, 89)
                                                    ],
                                                  ).createShader(
                                                          const Rect.fromLTWH(
                                                              0.0,
                                                              0.0,
                                                              200.0,
                                                              70.0)),
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Text(
                                            "${details['jobTitle']}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Text(
                                            "Description:",
                                            style: TextStyle(
                                                background: Paint()
                                                  ..shader =
                                                      const LinearGradient(
                                                    colors: <Color>[
                                                      Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      Color.fromARGB(
                                                          255, 84, 87, 89)
                                                    ],
                                                  ).createShader(
                                                          const Rect.fromLTWH(
                                                              0.0,
                                                              0.0,
                                                              200.0,
                                                              70.0)),
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Text(
                                            "${details['description']}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Text(
                                            "Job ID:",
                                            style: TextStyle(
                                                background: Paint()
                                                  ..shader =
                                                      const LinearGradient(
                                                    colors: <Color>[
                                                      Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      Color.fromARGB(
                                                          255, 84, 87, 89)
                                                    ],
                                                  ).createShader(
                                                          const Rect.fromLTWH(
                                                              0.0,
                                                              0.0,
                                                              200.0,
                                                              70.0)),
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Text(
                                            "${details['jobPostId']}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Text(
                                            "Location:",
                                            style: TextStyle(
                                                background: Paint()
                                                  ..shader =
                                                      const LinearGradient(
                                                    colors: <Color>[
                                                      Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      Color.fromARGB(
                                                          255, 84, 87, 89)
                                                    ],
                                                  ).createShader(
                                                          const Rect.fromLTWH(
                                                              0.0,
                                                              0.0,
                                                              200.0,
                                                              70.0)),
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16.0),
                                          child: Text(
                                            "${details['locationAddress']}",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.remove_red_eye,
                            color: Colors.white,
                          )),
                      IconButton(
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    title: const Text("Delete Job"),
                                    content: const Text(
                                        "Are you sure you want to delete this post?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Cancel")),
                                      TextButton(
                                          onPressed: () {
                                            FirebaseFirestore.instance
                                                .collection('jobs')
                                                .doc(details.id)
                                                .delete();
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Delete")),
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  tileColor: Theme.of(context).primaryColor,
                  leading: SizedBox(
                    height: 50,
                    width: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: ShowNetworkImage(
                        imageSrc: details['companyImageurl'],
                        mobileBoxFit: BoxFit.fill,
                        mobileHeight: 50,
                        mobileWidth: 50,
                      ),
                    ),
                  ),
                  title: Text(
                    "Job By Company: ${details['companyName']}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "Description: ${details['description']}",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
