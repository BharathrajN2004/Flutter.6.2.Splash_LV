import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../login_page/auth.dart';
import '../theme/theme.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final User? user = Auth().currentUser;
  String? name;
  String? phone_no;

  @override
  void initState() {
    // TODO: implement initState
    getname();
    super.initState();
  }

  Future getname() async {
    final userdata = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.email)
        .get();
    final username = await userdata
        .data()!
        .entries
        .firstWhere((element) => element.key == 'name')
        .value;
    final phno = await userdata
        .data()!
        .entries
        .firstWhere((element) => element.key == 'phone number')
        .value;
    setState(() {
      name = username;
      phone_no = phno;
    });
  }

  @override
  Widget build(BuildContext context) {
    var scrWidth = MediaQuery.of(context).size.width;
    var scrHeight = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final data = !themeProvider.isDark ? Colors.black : Colors.white;

    return Scaffold(
      body: Column(children: [
        const SizedBox(
          height: 70,
        ),
        const Center(
          child: Text(
            "Profile",
            style: TextStyle(
              fontFamily: 'SF-Pro',
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        const Center(
          child: Image(
            image: AssetImage("assets/images/profile1.png"),
            height: 100,
            width: 100,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 25.0, bottom: 5),
            child: Text(
              "Name",
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff938D8D),
                fontFamily: 'SF-Pro',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          height: scrHeight / 15,
          width: scrWidth / 1.12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: data,
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.0, 16.0, 0, 0),
            child: Text(
              name == null ? "" : name!,
              style: TextStyle(
                fontFamily: 'SF-Pro',
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 25.0, bottom: 5),
            child: Text(
              "Email",
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff938D8D),
                fontFamily: 'SF-Pro',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          height: scrHeight / 15,
          width: scrWidth / 1.12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: data,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 16.0, 0, 0),
            child: Text(
              user?.email ?? 'User email',
              style: const TextStyle(
                fontFamily: 'SF-Pro',
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 25.0, bottom: 5),
            child: Text(
              "Phone Number",
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff938D8D),
                fontFamily: 'SF-Pro',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          height: scrHeight / 15,
          width: scrWidth / 1.12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: data,
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.0, 16.0, 0, 0),
            child: Text(
              phone_no == null ? "" : phone_no!,
              style: TextStyle(
                fontFamily: 'SF-Pro',
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
        SizedBox(
          height: scrHeight / 12,
        ),
        Container(
          height: 41,
          width: scrWidth / 2.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Color.fromARGB(255, 157, 157, 180),
          ),
          child: MaterialButton(
            onPressed: signOut,
            child: Text(
              "Logout",
              style: TextStyle(
                fontFamily: 'SF-Pro',
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
