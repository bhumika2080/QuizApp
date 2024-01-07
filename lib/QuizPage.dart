// import 'package:flutter/material.dart';
// import 'models/question_model.dart';

// class QuizPage extends StatefulWidget {
//   const QuizPage({super.key});

//   @override
//   State<QuizPage> createState() => _QuizPageState();
// }

// class _QuizPageState extends State<QuizPage> {
//   late Future<List<Trivia>> futureList;

//   @override
//   void initState() {
//     super.initState();
//     futureList = ApiCalling().getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//       ),
//       body: Center(
//         child: FutureBuilder<List<Trivia>>(
//           future: futureList,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else if (!snapshot.hasData) {
//               return Text('No data available');
//             } else {
//               List<Trivia> list = snapshot.data!;
//               print('Number of items in the list: ${list.length}');
//               print('First item: ${list.isNotEmpty ? list[0] : 'None'}');
//               return ListView.builder(
//                 itemBuilder: (context, index) {
//                   return Column(
//                     children: [
//                       Text("id: ${list[index].id!}"),
//                       Text("category: ${list[index].category!}")
//                     ],
//                   );
//                 },
//                 itemCount: list.length,
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
