import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final CountdownController _controller = new CountdownController(autoStart: false);

  getOrderData()async{
    var orderUrl = "http://192.168.0.104/flutterhawkerdata/getorders.php";
    var response = await http.get(Uri.parse(orderUrl));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hawker Management System'),),

      body: FutureBuilder(
        future: getOrderData(),
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
                margin: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin:  EdgeInsets.all(25.0),
                          width: 678.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    Text('${snapData[index]['foodName']}', textAlign: TextAlign.start, style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold, ),),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15.0,),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  children: [
                                    Text('${snapData[index]['quality']}' + ' plate, ' + '${snapData[index]['selectName']}', textAlign: TextAlign.end, style: TextStyle(fontSize: 35.0),),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.0,),
                              Container(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  children: [
                                    Text('Table NO: ' + '${snapData[index]['numberTable']}', textAlign: TextAlign.end, style: TextStyle(fontSize: 35.0),),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15.0,),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Countdown(
                                      controller: _controller,
                                      seconds: 1,
                                      build: (_, double time)=>Text(time.toString() + ' min', style: TextStyle(fontSize: 40.0),),
                                      interval: Duration(milliseconds: 100),
                                      onFinished: (){
                                        Text('Done Cooking');
                                      },
                                    ),
                                    RaisedButton(
                                        padding: EdgeInsets.all(15.0),
                                        child: Text('Get It', style: TextStyle(fontSize: 30.0),),
                                        onPressed: (){_controller.resume();}
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),

                  ],
                ),
              );
            },
          );
        },

      ),

    );
  }
}
