import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:merit_elite/models/events.dart';
import 'package:merit_elite/pages/event_upload.dart';
import 'package:merit_elite/pages/join_event.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Events> upcomingEvents = [];

  @override
  void initState() {
    super.initState();
    //initialize();
  }

  Future<void> initialize() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventUpload(
          onEventRegistered: (eventData) {
            // Add the fetched event data to the list
            setState(() {
              upcomingEvents.add(eventData);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 4, 9, 1),
      appBar: AppBar(
        title: const Text('Upcoming Events'),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: upcomingEvents.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'No upcoming events at this moment..!',
                    // style: Theme.of(context).textTheme.bodyText1,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: SizedBox(
                    height: 200,
                    child: Image.asset(
                      'images/MeritEliteLogo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            )
          : ListView.builder(
              itemCount: upcomingEvents.length,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5, //Step 2 - Enhance spacing..
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                JoinEvent(upcomingEvents[index])),
                      );
                    },
                    //specify height
                    //source: https://stackoverflow.com/questions/53071451/how-to-specify-listtile-height-in-flutter
                    dense: true,
                    visualDensity:
                        const VisualDensity(vertical: 3), // to expand
                    tileColor: const Color.fromRGBO(22, 27, 34, 1),
                    leading: CircleAvatar(
                      backgroundColor: const Color.fromRGBO(230, 237, 243, 1),
                      foregroundColor: Colors.black,
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            upcomingEvents[index].club,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      upcomingEvents[index].name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    subtitle: Text(
                      "Merit level: ${upcomingEvents[index].meritLvl} \nMerit Points: ${upcomingEvents[index].meritPoints}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: Text(
                      DateFormat().add_yMd().format(upcomingEvents[index].date),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.red),
                    ),
                  ),
                );
              },
            ),
      drawer: Drawer(
        elevation: 2,
        shadowColor: Colors.grey,
        backgroundColor: const Color.fromRGBO(22, 27, 34, 1),
        child: ListView(
          children: [
            SizedBox(
                height: 40.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      child: Image.asset(
                        'images/MeritEliteLogo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    )
                  ],
                )),
            ListTile(
                leading: const Icon(
                  Icons.lock_clock,
                  size: 30,
                  color: Colors.white,
                ),
                title: const Text('Upcoming Events'),
                onTap: () {
                  //refresh homepage
                  Navigator.pop(context);
                  setState(() {});
                }),
            ListTile(
              leading: const Icon(
                Icons.upload,
                size: 30,
                color: Colors.white,
              ),
              title: const Text('Upload Event'),
              onTap: () {
                Navigator.pop(context);
                initialize();
              },
            )
          ],
        ),
      ),
    );
  }
}
