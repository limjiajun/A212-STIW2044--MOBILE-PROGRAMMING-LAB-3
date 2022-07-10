import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:mytutor/views/loginscreen.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../models/user.dart';
import '../models/tutor.dart';

import 'mainscreen.dart';
import 'subjectpage.dart';



class TutorScreen extends StatefulWidget {
  final User user;
  const TutorScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<TutorScreen> createState() => _TutorScreenState();
}

class _TutorScreenState extends State<TutorScreen> {
  List<Tutor> tutorList = <Tutor>[];
final df = DateFormat('dd/MM/yyyy hh:mm a');

  late double screenHeight, screenWidth, resWidth;
  String titlecenter = "";
late int rowcount;
  // ignore: prefer_typing_uninitialized_variables
  var numofpage, curpage = 1;
  // ignore: prefer_typing_uninitialized_variables
  var color;

TextEditingController searchController = TextEditingController();
  String search = "";
  
  

  @override
  void initState() {
    super.initState();
    _loadTutors(1, search);
    
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
      rowcount = 2;
    } else {
      resWidth = screenWidth * 0.75;
      rowcount = 3;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mytutor List'),
      actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _loadSearchDialog();
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.user.name.toString()),
              accountEmail: Text(widget.user.email.toString()),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://pic.onlinewebfonts.com/svg/img_362771.png"),
              ),
            ),
            _createDrawerItem(
              icon: Icons.tv,
              text: 'My Dashboard',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => MainScreen(
                              user: widget.user,
                            )));
              },
            ),
            //Subjects, Tutors, Subscribe, Favourite, and Profile
            _createDrawerItem(
              icon: Icons.list_alt,
              text: 'My Subject',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => SubjectScreen(
                              user: widget.user,
                            )));
              },
            ),
            _createDrawerItem(
              icon: Icons.local_shipping_outlined,
              text: 'Tutors',
               onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => TutorScreen(
                              user: widget.user,
                            )));
              },
            ),
            _createDrawerItem(
              icon: Icons.supervised_user_circle,
              text: 'Subscribe',
              onTap: () {},
            ),
            _createDrawerItem(
              icon: Icons.verified_user,
              text: ' Favourite',
              onTap: () {},
            ),
            _createDrawerItem(
              icon: Icons.file_copy,
              text: 'Profile',
              onTap: () {},
            ),
             _createDrawerItem(
              icon: Icons.exit_to_app,
              text: 'Logout',
              onTap: () =>{ 
                Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                         const LoginScreen ()))
                
              },
            ),
          ],
        ),
      ),
            
    
     
  
    body: tutorList.isEmpty
          ? Center(
              child: Text(titlecenter,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)))
          : Column(children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text("Tutors Available",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Expanded(
                  child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (1 / 1.5),
                      children: List.generate(tutorList.length, (index) {
                        return InkWell(
                          splashColor: Colors.amber,
                          onTap: () => {_loadTutorDetails(index)},
                          child: Card(
                              color: Colors.indigo.shade50,
                              child: Column(
                                children: [
                                  Flexible(
                                    flex: 6,
                                    child: CachedNetworkImage(
                                      imageUrl: CONSTANTS.server +
                                          "/mytutor3/mobile/assets/tutors/" +
                                          tutorList[index].tutorId.toString() +
                                          '.jpg',
                                      fit: BoxFit.cover,
                                      width: resWidth,
                                      placeholder: (context, url) =>
                                          const LinearProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                  Flexible(
                                      flex: 4,
                                      child: Column(
                                        children: [
                                          Text(
                                            tutorList[index].tutorName.toString(),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Email: ${tutorList[index].tutorEmail}",
                                          ),
                                          Text(
                                              "Phone: ${tutorList[index].tutorPhone}"),
                                        ],
                                      ))
                                ],
                              )),
                        );
                      }))),
              SizedBox(
                height: 30,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: numofpage,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if ((curpage - 1) == index) {
                      color = Colors.red;
                    } else {
                      color = Colors.black;
                    }
                    return SizedBox(
                      width: 40,
                      child: TextButton(
                          onPressed: () => {_loadTutors(index + 1, "")},
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(color: color),
                          )),
                    );
                  },
                ),
              ),
            ]),
    );
  }
  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  void _loadTutors(int pageno, String _search) {
    curpage = pageno;
    numofpage ?? 1;
    http.post(
        Uri.parse("${CONSTANTS.server}/mytutor3/mobile/php/load_tutors.php"),
        body: {
          'pageno': pageno.toString(),
          'search': _search,
        }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    ).then((response) {
      var jsondata = jsonDecode(response.body);

      print(jsondata);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {
        var extractdata = jsondata['data'];
        numofpage = int.parse(jsondata['numofpage']);

        if (extractdata['tutors'] != null) {
          tutorList = <Tutor>[];
          extractdata['tutors'].forEach((v) {
            tutorList.add(Tutor.fromJson(v));
          });
        } else {
          titlecenter = "No Tutors Available Now";
        }
        setState(() {});
      } else {
        //do something
      }
    });
  }

  _loadTutorDetails(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Tutor Details",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
                child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: CONSTANTS.server +
                      "/mytutor3/mobile/assets/tutors/" +
                      tutorList[index].tutorId.toString() +
                      '.jpg',
                  fit: BoxFit.cover,
                  width: resWidth,
                  placeholder: (context, url) =>
                      const LinearProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Text(
                  tutorList[index].tutorName.toString(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                   const Icon(Icons.numbers),
                   Text(
                  " ID : " +
                      tutorList[index].tutorId.toString()),
                   const Icon(Icons.message),
                  Text(
                    "Email  :" +
                      tutorList[index].tutorEmail.toString()
                      ), //
                 
                   const Icon(Icons.phone),
                  Text(
                    "PhoneNo  : " +
                      tutorList[index].tutorPhone.toString()
                      ),
                  
                   const Icon(Icons.person),
                  Text(
                    "Name :  " +
                      tutorList[index].tutorName.toString()
                      ),
                   const Icon(Icons.bookmark_add),
                  Text(
                    "Description:  " +
                      tutorList[index].tutorDescription.toString()
                      ),
                      const Icon(Icons.calendar_month),  
                  Text(
                      "Datereg  :"+df.format(DateTime.parse(tutorList[index].tutorDatereg.toString()))
                      ),
                         const Icon(Icons.abc_outlined),
                  Text(
                    "Subject: " +
                      tutorList[index].subjectName.toString()
                      ),
                ]),
              ],
            )),
            actions: [
              TextButton(
                child: const Text(
                  "Close",
                  style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _loadSearchDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return AlertDialog(
                title: const Text(
                  "Search ",
                ),
                content: SizedBox(
                  height: screenHeight / 5,
                  child: Column(
                    children: [
                      TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            labelText: 'Search',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () {
                          search = searchController.text;
                          Navigator.of(context).pop();
                          _loadTutors(1, search);
                        },
                        child: const Text("Search"),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}