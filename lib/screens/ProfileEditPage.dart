import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileEditPage extends StatefulWidget {
  final List snapData;
  var index;

  ProfileEditPage({required this.snapData, required this.index});

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  TextEditingController controllerStoreName = TextEditingController();
  TextEditingController controllerStoreAddress = TextEditingController();
  TextEditingController controllerPhoneNumber = TextEditingController();

  bool editMode = false;

  insertHawkerData(){
    if(editMode){
      var hawkerUrl = "http://192.168.0.104/flutterhawkerdata/edithawkers.php";
      http.post(Uri.parse(hawkerUrl), body: {
        'hawkerID': widget.snapData[widget.index]['hawkerID'],
        'storeName': controllerStoreName.text,
        'storeAddress': controllerStoreAddress.text,
        'phone': controllerPhoneNumber.text,
      });
    }else{
      var hawkerUrl = "http://192.168.0.104/flutterhawkerdata/inserthawkers.php";
      http.post(Uri.parse(hawkerUrl), body: {
        'storeName': controllerStoreName.text,
        'storeAddress': controllerStoreAddress.text,
        'phone': controllerPhoneNumber.text,
      });
    }

  }

  @override
  void initState(){
    controllerStoreName = TextEditingController(text: '');
    controllerStoreAddress  = TextEditingController(text: '');
    controllerPhoneNumber = TextEditingController(text: '');
    super.initState();
    if(widget.index != null){
      editMode = true;
      controllerStoreName.text = widget.snapData[widget.index]['storeName'];
      controllerStoreAddress.text = widget.snapData[widget.index]['storeAddress'];
      controllerPhoneNumber.text = widget.snapData[widget.index]['phone'];
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile'),),

      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: ListView(
          children: <Widget>[
            Column(
              children: [
                Text('Store Name', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),
                SizedBox(height: 10.0,),
                TextField(
                  controller: controllerStoreName,
                  style: TextStyle(fontSize: 30.0, color: Colors.black),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                ),

                SizedBox(height: 20.0,),

                Text('Address', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),
                SizedBox(height: 10.0,),
                TextField(
                  controller: controllerStoreAddress,
                  style: TextStyle(fontSize: 30.0, color: Colors.black),
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                ),

                SizedBox(height: 20.0,),

                Text('Phone Number', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),
                SizedBox(height: 10.0,),
                TextField(
                  controller: controllerPhoneNumber,
                  style: TextStyle(fontSize: 30.0, color: Colors.black),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                ),

                SizedBox(height: 20.0,),

                RaisedButton(
                  padding: EdgeInsets.all(20.0),
                  onPressed: (){
                    insertHawkerData();
                  },
                  child: Text('Save', style: TextStyle(fontSize: 30.0),),
                ),

              ],
            ),
          ],
        ),
      ),


    );
  }
}
