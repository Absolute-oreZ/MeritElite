import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:merit_elite/models/events.dart';
import 'package:merit_elite/pages/homepage.dart';

class JoinEvent extends StatelessWidget {
  final Events theEvent;
  JoinEvent(this.theEvent);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 4, 9, 1),
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(theEvent.name),
        centerTitle: true,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(
                  'Club: ${theEvent.club}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Date: ${DateFormat().add_yMd().format(theEvent.date)}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Merit Level: ${theEvent.meritLvl}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Merit Points: ${theEvent.meritPoints}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  theEvent.description,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ]),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                            "Successfully registered for event ${theEvent.name}..!"),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return HomePage();
                                }));
                              },
                              child: const Text('OK'))
                        ],
                      );
                    });
              },
              style: ElevatedButton.styleFrom(
                  alignment: Alignment.center,
                  backgroundColor: const Color.fromRGBO(35, 134, 54, 1),
                  foregroundColor: Colors.white,
                  shadowColor: const Color.fromARGB(255, 31, 123, 49),
                  enabledMouseCursor: MouseCursor.defer,
                  minimumSize: Size(MediaQuery.of(context).size.width, 40),
                  side: const BorderSide(
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: const Text('Register'),
            ),
          ]),
    );
  }
}
