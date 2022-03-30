import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/app/services/flutterfire.dart';
import 'package:flutter_time_tracker/app/widgets/w-button.dart';
import 'package:flutter_time_tracker/app/widgets/w-field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void changePage(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // pageController.jumpToPage(index);
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 1000),
      curve: Curves.ease,
    );
  }

  int _selectedIndex = 0;
  PageController pageController = PageController();

  final user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference tasksReference =
      FirebaseFirestore.instance.collection('tasks');

  late Stream<QuerySnapshot> _usersStream;

  void getTasks(uid) {
    setState(() {
      _usersStream = FirebaseFirestore.instance
          .collection('tasks')
          .where('uid', isEqualTo: uid.toString())
          .snapshots();
    });
  }

  final TextEditingController _name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getTasks(user?.uid);
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              await logout(context);
            },
          ),
        ],
        centerTitle: true,
        elevation: 0,
        title: const Text('Home'),
      ),
      body: PageView(
        controller: pageController,
        children: <Widget>[
          _home(),
          _add(),
          _settings(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: changePage,
        backgroundColor: Colors.grey[100],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey[400],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'New',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _home() {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return snapshot.data!.docs.isNotEmpty
            ? ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> task =
                      document.data()! as Map<String, dynamic>;
                  String docId = document.id;
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(value: task['status'], onChanged: (bool? value) {}),
                        Text(task['name']),
                      ],
                    ),
                    onTap: () async {
                      Map<String, dynamic> data = {
                        'status': !task['status'],
                      };
                      tasksReference.doc(docId).update(data).then((value) {
                        print("Task Updated");
                      }).catchError((error) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Something went wrong.'),
                              content: Text(error.toString()),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: const Text('Ok'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      });
                    },
                  );
                }).toList(),
              )
            : const Center(child: Text('No data'));
      },
    );
  }

  Widget _add() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FullField(
            hint: 'Do that . . .',
            controller: _name,
            label: 'Task name',
            password: false,
          ),
          const SizedBox(height: 15),
          FullButton(
            color: Colors.indigo,
            onClick: () {
              Map<String, dynamic> data = {
                'name': _name.text,
                'uid': user?.uid,
                'status': false,
                'created': FieldValue.serverTimestamp(),
              };

              tasksReference.add(data).then((value) {
                print("Task Added");
                _name.clear();
              }).catchError((error) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Something went wrong.'),
                      content: Text(error.toString()),
                      actions: <Widget>[
                        ElevatedButton(
                          child: const Text('Ok'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              });
            },
            text: 'Add task',
          ),
        ],
      ),
    );
  }

  Widget _settings() {
    final user = FirebaseAuth.instance.currentUser;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Colors.indigo,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.indigo,
                    backgroundImage: user?.photoURL != null
                        ? NetworkImage(user!.photoURL.toString())
                        : null,
                    child: user?.photoURL == null
                        ? const Icon(Icons.person, color: Colors.white)
                        : null,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    user?.displayName != null
                        ? user!.displayName.toString()
                        : 'No name',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
