import 'package:flutter/material.dart';
import 'package:hakwermanagnethawker/screens/ProfileEditPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var index;

  getHawkerData()async{
    var hawkerUrl = "http://192.168.0.104/flutterhawkerdata/gethawkers.php";
    var response = await http.get(Uri.parse(hawkerUrl));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile'),),

      body: FutureBuilder(
        future: getHawkerData(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }

          if(snapshot.hasError){
            return Center(child: Text("Error fetching Data"),);
          }

          List snapData = snapshot.data;
          return ListView.builder(
            itemCount: 1,
              itemBuilder: (context, index){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // personal information
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children:[
                            CircleAvatar(
                              radius: 160.0,
                              backgroundColor: Colors.orange,
                              child: Icon(Icons.restaurant, size: 180.0, color: Colors.white,),
                            ),
                            SizedBox(height: 50.0,),
                            Text("${snapData[index]['storeName']}", style: TextStyle(fontSize: 44.0, fontWeight: FontWeight.bold,),),
                            SizedBox(height: 20.0,),
                            Text("${snapData[index]['storeAddress']}", textAlign: TextAlign.center, style: TextStyle(fontSize: 28.0),),
                            SizedBox(height: 30.0,),
                            Text("${snapData[index]['phone']}", style: TextStyle(fontSize: 28.0,),),

                            SizedBox(height: 100.0,),

                            Padding(
                              padding: EdgeInsets.all(20.0),
                              child: RaisedButton(
                                padding: EdgeInsets.all(20.0),
                                child: Text('Edit Profile', style: TextStyle(fontSize: 25.0),),
                                color: Colors.blue,
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileEditPage(snapData: snapData, index: index,),),);
                                },
                              ),
                            ),

                          ],
                        ),
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
