import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Leaderboard',
      home: LeaderboardScreen(),
    );
  }
}

class LeaderboardScreen extends StatefulWidget {
  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  // Leaderboard data for subjects
  List<Map<String, dynamic>> subjects = [
    {
      "subject": "Math",
      "ranking": [
        {"username": "Alice", "score": 95},
        {"username": "Bob", "score": 89},
        {"username": "Charlie", "score": 85},
      ],
    },
    {
      "subject": "Science",
      "ranking": [
        {"username": "David", "score": 92},
        {"username": "Eva", "score": 88},
        {"username": "Frank", "score": 84},
      ],
    },
    {
      "subject": "English",
      "ranking": [
        {"username": "George", "score": 91},
        {"username": "Hannah", "score": 87},
        {"username": "Ivy", "score": 83},
      ],
    },
    {
      "subject": "Music",
      "ranking": [
        {"username": "Jack", "score": 94},
        {"username": "Karen", "score": 90},
        {"username": "Liam", "score": 86},
      ],
    },
    {
      "subject": "Filipino",
      "ranking": [
        {"username": "Mia", "score": 93},
        {"username": "Noah", "score": 89},
        {"username": "Olivia", "score": 84},
      ],
    },
    {
      "subject": "History",
      "ranking": [
        {"username": "Paul", "score": 90},
        {"username": "Quinn", "score": 86},
        {"username": "Rachel", "score": 82},
      ],
    },
  ];

  String selectedSubject = "Math";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        centerTitle: true,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subject dropdown
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  Text('Select Subject:', style: TextStyle(fontSize: 18)),
                  SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blueAccent),
                    ),
                    child: DropdownButton<String>(
                      value: selectedSubject,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedSubject = newValue!;
                        });
                      },
                      isExpanded: false,
                      icon:
                          Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
                      underline: SizedBox(),
                      items: subjects
                          .map((subject) => DropdownMenuItem<String>(
                                value: subject["subject"],
                                child: Text(subject["subject"]),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Leaderboard DataTable
            Expanded(
              child: Builder(
                builder: (context) {
                  // Get ranking data for selected subject
                  var subjectData = subjects.firstWhere(
                      (subject) => subject['subject'] == selectedSubject);
                  List<Map<String, dynamic>> leaderboard =
                      List.from(subjectData['ranking']);

                  // Sort by score (descending)
                  leaderboard.sort((a, b) => b["score"].compareTo(a["score"]));

                  // Assign rank
                  for (int i = 0; i < leaderboard.length; i++) {
                    leaderboard[i]["rank"] = i + 1;
                  }

                  // Create table rows with alternating colors
                  List<DataRow> rows = leaderboard.asMap().entries.map((entry) {
                    int index = entry.key;
                    var user = entry.value;
                    Color rowColor =
                        index % 2 == 0 ? Colors.blue[50]! : Colors.blue[100]!;
                    return DataRow(
                      color: WidgetStateProperty.resolveWith<Color>(
                          (states) => rowColor),
                      cells: [
                        DataCell(Text(user["rank"].toString(),
                            style: TextStyle(fontSize: 16))),
                        DataCell(Text(user["username"],
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                        DataCell(Text(user["score"].toString(),
                            style: TextStyle(fontSize: 16))),
                      ],
                    );
                  }).toList();

                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: DataTable(
                      columnSpacing: 30.0,
                      columns: [
                        DataColumn(
                          label: Text('Rank',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        DataColumn(
                          label: Text('Username',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        DataColumn(
                          label: Text('Score',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                      rows: rows,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
