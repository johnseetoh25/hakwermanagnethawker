import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hakwermanagnethawker/screens/FoodAddEditPage.dart';
import 'package:http/http.dart' as http;


class MenuListPage extends StatefulWidget {
  const MenuListPage({Key? key}) : super(key: key);

  @override
  _MenuListPageState createState() => _MenuListPageState();
}

class _MenuListPageState extends State<MenuListPage> {
  var index;


  getFoodData()async{
    var foodUrl = "http://192.168.0.104/flutterhawkerdata/getfoods.php";
    var response = await http.get(Uri.parse(foodUrl));
    return json.decode(response.body);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu List'),),
      
      body: FutureBuilder(
        future: getFoodData(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          
          if(snapshot.hasError){
            return Center(child: Text("Error fetching Data"),);
          }

          //List snapData = snapshot.data;
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index){
              List snapData = snapshot.data;
              return Card(
                margin: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    //images
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10.0),
                          height: 180.0, width: 280.0,
                          color: Colors.blueAccent,
                          child: Icon(Icons.photo, size: 100.0,)
                        ),

                        //menu information
                        Container(
                          margin:  EdgeInsets.all(10.0),
                          height: 180.0,
                          width: 410.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    Text("${snapData[index]['foodName']}", overflow: TextOverflow.ellipsis, textAlign: TextAlign.start, style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, ),),
                                  ],
                                ),
                              ),

                              ButtonBar(
                                buttonMinWidth: 120.0,
                                buttonPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                children: [
                                  RaisedButton(
                                    onPressed: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context)=> FoodAddEditPage(snapData: snapData, index: index,),
                                        ),
                                      );
                                    },
                                    child: Text('Edit', style: TextStyle(fontSize: 24.0),),
                                  ),
                                  RaisedButton(
                                    color: Colors.deepOrange,
                                    onPressed: (){
                                      setState(() {
                                        var foodUrl = 'http://192.168.0.104/flutterhawkerdata/deletefoods.php';
                                        http.post(Uri.parse(foodUrl), body:{
                                          'foodID': snapData[index]['foodID'],
                                        });
                                      });
                                    },
                                    child: Text('Delete', style: TextStyle(fontSize: 24.0),),
                                  ),
                                ],
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

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.0),
        child:
        //button
        RaisedButton(
          child: Text('Edit New Menu', style: TextStyle(fontSize: 24.0),),
          padding: EdgeInsets.all(20.0),
          color: Colors.blue,
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => FoodAddEditPage(snapData: [], index: index,),),);
          },
        ),

      ),
    );
  }
}

