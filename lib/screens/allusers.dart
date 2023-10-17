import 'package:adaptive_navbar/adaptive_navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crewdogadmin/screens/loginscreen.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AdaptiveNavBar(
          automaticallyImplyLeading: false,
          screenWidth: sw,
          centerTitle: false,
          title: const Text("CrewDog TV Admin"),
          navBarItems: [
            NavBarItem(
              text: "Home",
              onTap: () {
                // Get.to(() => const Dashboard());
                Get.toNamed('/dashboard');
              },
            ),
            NavBarItem(
              text: "All Users",
              onTap: () {
                // Get.to(() => const AllUsersScreen());
                Get.toNamed('/allusers');
              },
            ),
            NavBarItem(
              text: "All Jobs",
              onTap: () {
                // Get.to(() => const Jobs());
                Get.toNamed('/jobs');
              },
            ),
            NavBarItem(
              text: "Logout",
              onTap: () async {
                FirebaseAuth.instance.signOut();
                await Get.offAll(() => const LoginScreen());
              },
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.work), text: "Job Hunters"),
              Tab(icon: Icon(Icons.business_outlined), text: "I am Hiring")
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            JobSeekers(),
            Companies(),
          ],
        ),
      ),
    );
  }
}

class JobSeekers extends StatefulWidget {
  const JobSeekers({super.key});

  @override
  State<JobSeekers> createState() => _JobSeekersState();
}

class _JobSeekersState extends State<JobSeekers> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('users').get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot users = snapshot.data!.docs[index];
              if (users['userType'] == 'jobSeeker') {
                return Card(
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(06.0)),
                    trailing: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  title: const Text("Delete User"),
                                  content: const Text(
                                      "Are you sure you want to delete this user?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel")),
                                    TextButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(users.id)
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
                    tileColor: Theme.of(context).primaryColor,
                    title: Text(
                      "Name: ${users['name']}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      "Email: ${users['email']}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class Companies extends StatefulWidget {
  const Companies({super.key});

  @override
  State<Companies> createState() => _CompaniesState();
}

class _CompaniesState extends State<Companies> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('users').get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot users = snapshot.data!.docs[index];
              if (users['userType'] == 'company') {
                return Card(
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(06.0)),
                    trailing: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  title: const Text("Delete User"),
                                  content: const Text(
                                      "Are you sure you want to delete this user?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel")),
                                    TextButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(users.id)
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
                    tileColor: Theme.of(context).primaryColor,
                    title: Text(
                      "Name: ${users['name']}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      "Email: ${users['email']}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
