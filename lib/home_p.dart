import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/team.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
 HomePage({super.key});

  List<Team> teams=[];
/**
 *  TODO : get isteği kısmı  */  

 Future GetTeams() async{
  var response = await http.get(Uri.https('testapi1.herokuapp.com','/teams'));
  var jsonData = jsonDecode(response.body);

  for (var eachteam in jsonData)
  {
    final team = Team(Team_name: eachteam['teams']);
    teams.add(team);

  }
  print(teams.length);
 }
 @override
  
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar
       (
        centerTitle: true,
        title: const Text("NBA Team List"),
        backgroundColor: Color.fromARGB(255, 3, 20, 250),
       ),
      body: SafeArea(
        child: FutureBuilder(
            future: GetTeams(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: teams.length,
                  padding: EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          title: Text(teams[index].Team_name)
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
       
    );
  }
  }
