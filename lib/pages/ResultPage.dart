import 'package:flutter/material.dart';
import 'package:quiz_app/pages/MyHomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class ResultPage extends StatefulWidget {
//   const ResultPage({super.key});

//   @override
//   State<ResultPage> createState() => _ResultPageState();

//   Future<void> setUserName(userName) async {
//     final SharedPreferences pref = await SharedPreferences.getInstance();
//     pref.setString('usersname', userName);
//   }
// }

// class _ResultPageState extends State<ResultPage> {
//   String? userNameDisplay;
//   var homePageData = const MyHomePage();

//   @override
//   void initState() {
//     super.initState();
//     getUserName();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text(userNameDisplay??'Take the quiz first'),
//       ),
//     );
//   }

//   void getUserName() async {
//     final SharedPreferences pref = await SharedPreferences.getInstance();
//     userNameDisplay = pref.getString('usersname') ?? '';
//   }
// }



class ResultPage extends StatefulWidget {
  final String userName;

  const ResultPage({Key? key, required this.userName}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late String userNameDisplay;

  @override
  void initState() {
    super.initState();
    userNameDisplay = widget.userName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(userNameDisplay),
      ),
    );
  }
}
