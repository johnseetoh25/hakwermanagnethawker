import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  getCountData()async{
    var countUrl = "http://192.168.0.104/flutterhawkerdata/getorderscount.php";
    var response = await http.get(Uri.parse(countUrl));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Result'),),

      body: FutureBuilder(
        future: getCountData(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }

          if(snapshot.hasError){
            return Center(child: Text("Error fetching Data"),);
          }

          List snapData = snapshot.data;
          return ListView.builder(
              itemCount: snapData.length,
              itemBuilder: (context, index){
                return Card(
                  color: Colors.cyan,
                  margin: EdgeInsets.all(15.0),
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Text("${snapData[index]['foodName']}", style: TextStyle(fontSize: 42.0, fontWeight: FontWeight.bold),),
                        SizedBox(height: 20.0,),
                        Text("Number of Sell: ${snapData[index]['counts']} ", style: TextStyle(fontSize: 32.0),),
                      ],
                    ),
                  ),


                );
              },

          );
        },
      ),



    );
  }
}

