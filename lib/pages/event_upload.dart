import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:merit_elite/models/events.dart';

class EventUpload extends StatefulWidget {
  late final Function(Events) onEventRegistered;

  EventUpload({required this.onEventRegistered});

  @override
  State<EventUpload> createState() => _EventUploadState();
}

class _EventUploadState extends State<EventUpload> {
  final formKey = GlobalKey<FormState>();
  final clubController = TextEditingController();
  final nameController = TextEditingController();
  String meritLvlValue = 'Club';
  late DateTime _selectedDate = DateTime.now();
  final descriptionController = TextEditingController();
  late final event;

  void _presentDatePicker() {
    showDatePicker(
            fieldLabelText: 'Enter the date of the event',
            context: context,
            initialDate: DateTime.now().add(const Duration(days: 7)),
            firstDate: DateTime.now().add(const Duration(days: 7)),
            lastDate: DateTime(2030))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  void dispose() {
    clubController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(1, 4, 9, 1),
        appBar: AppBar(
            title: const Text('Event Posting'),
            foregroundColor: Colors.white,
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.add_alert),
                tooltip: 'Post The Event',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    String club = clubController.text;
                    String name = nameController.text;
                    String meritLvl = meritLvlValue;
                    DateTime date = _selectedDate;
                    String description = descriptionController.text;

                    event = Events(
                      club,
                      name,
                      meritLvl,
                      date,
                      description,
                    );
                    widget.onEventRegistered(event); // Notify the parent widget

                    Navigator.pop(context); // Close the registration page
                  }
                },
              )
            ]),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: clubController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(22, 27, 34, 1),
                      labelText: 'Club',
                      labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white60),
                      icon: const Icon(
                        Icons.home,
                        color: Colors.white60,
                        size: 30,
                      ),
                      hintText:
                          'Enter the club/clubs that is hosting this event',
                      hintStyle: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                          color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Color.fromRGBO(33, 38, 45, 1),
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(40),
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold);
                      return 'Required!';
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: nameController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(22, 27, 34, 1),
                      labelText: 'Event Name',
                      labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white60),
                      icon: const Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.white60,
                      ),
                      hintText: 'Enter the name of the event',
                      hintStyle: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                          color: Colors.white60),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Color.fromRGBO(33, 38, 45, 1),
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(40),
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold);
                      return 'Required!';
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                //a drow down menu to let user choose from a list of merit level
                /***************************************************************************************
                *    Title        : DowDown Menu
                *    Author       : Benyamin
                *    Date         : 7/1/2023
                *    Code version : 1.0
                *    Availability : https://stackoverflow.com/questions/69067627/using-list-of-options-in-textformfield
                ***************************************************************************************/
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 30,
                      color: Colors.white60,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(33, 38, 45, 1),
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                          color: const Color.fromRGBO(22, 27, 34, 1),
                          borderRadius: BorderRadius.circular(30)),
                      child: DropdownButton<String>(
                        dropdownColor: Colors.grey,
                        value: meritLvlValue,
                        icon: const Icon(
                          Icons.arrow_downward,
                          color: Colors.white60,
                        ),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        onChanged: (String? newValue) {
                          setState(() {
                            meritLvlValue = newValue!;
                          });
                        },
                        items: <String>[
                          'Club',
                          'University',
                          'National',
                          'International'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                //date time picker to ente event date
                /***************************************************************************************
                *    Title        : DatePicker
                *    Author       : Dr. MNor
                *    Date         : 7/1/2023
                *    Code version : 1.0
                *    Availability : Expense App
                ***************************************************************************************/
                //modification is made to _presentDate picker to change the first and last date
                SizedBox(
                  height: 90,
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Colors.white60,
                            size: 30,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            "Enter the date of the event:",
                            style: TextStyle(
                                color: Colors.white60,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              _selectedDate == null
                                  ? 'No Date Chosen'
                                  : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          TextButton(
                              onPressed: _presentDatePicker,
                              child: const Text(
                                "Choose Date",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  //to get a large text field for description
                  /***************************************************************************************
                  *    Title        : Multiple Line Text Field
                  *    Author       : Fellipe Sanches,Philippe Fanaro
                  *    Date         : 7/1/2023
                  *    Code version : 1.0
                  *    Availability : https://stackoverflow.com/questions/69067627/using-list-of-options-in-textformfield
                  ***************************************************************************************/
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: const TextStyle(color: Colors.white),
                  controller: descriptionController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(22, 27, 34, 1),
                      labelText: 'Event Description',
                      labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white60),
                      icon: const Icon(
                        Icons.info,
                        size: 30,
                        color: Colors.white,
                      ),
                      hintText: 'Enter details of the event',
                      hintStyle: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                          color: Colors.white60),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Color.fromRGBO(33, 38, 45, 1),
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(40),
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold);
                      return 'Required!';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
