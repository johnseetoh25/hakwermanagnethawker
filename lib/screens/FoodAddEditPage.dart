import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FoodAddEditPage extends StatefulWidget {
  final List snapData;
  var index;

  FoodAddEditPage({required this.snapData, required this.index});

  @override
  _FoodAddEditPageState createState() => _FoodAddEditPageState();
}

class _FoodAddEditPageState extends State<FoodAddEditPage> {
  TextEditingController controllerFoodName = TextEditingController();
  TextEditingController controllerFoodPrice = TextEditingController();
  TextEditingController controllerCookingTime = TextEditingController();

  bool editMode = false;

  addUpdateFoodData(){
    if(editMode){
      var hawkerUrl = "http://192.168.0.104/flutterhawkerdata/editfoods.php";
      http.post(Uri.parse(hawkerUrl), body: {
        'foodID': widget.snapData[widget.index]['foodID'],
        'foodName': controllerFoodName.text,
        'price': controllerFoodPrice.text,
        'cookingTime': controllerCookingTime.text,
      });

    }else{
      var hawkerUrl = "http://192.168.0.104/flutterhawkerdata/insertfoods.php";
      http.post(Uri.parse(hawkerUrl), body: {
        'foodName': controllerFoodName.text,
        'price': controllerFoodPrice.text,
        'cookingTime': controllerCookingTime.text,
      });
    }

  }

  @override
  void initState(){
    controllerFoodName = TextEditingController(text: '');
    controllerFoodPrice  = TextEditingController(text: '');
    controllerCookingTime = TextEditingController(text: '');
    super.initState();
    if(widget.index != null){
      editMode = true;
      controllerFoodName.text = widget.snapData[widget.index]['foodName'];
      controllerFoodPrice.text = widget.snapData[widget.index]['price'];
      controllerCookingTime.text = widget.snapData[widget.index]['cookingTime'];
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu Edit'),),

      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: ListView(
          children: <Widget>[
            Column(
              children: [
                Text('Food Name', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),
                SizedBox(height: 10.0,),
                TextField(
                  controller: controllerFoodName,
                  style: TextStyle(fontSize: 30.0, color: Colors.black),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                ),

                SizedBox(height: 20.0,),

                Text('Price', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),
                SizedBox(height: 10.0,),
                TextField(
                  controller: controllerFoodPrice,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 30.0, color: Colors.black),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(20.0),
                  ),
                ),

                SizedBox(height: 20.0,),

                Text('Cooking Time', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),
                SizedBox(height: 10.0,),
                TextField(
                  controller: controllerCookingTime,
                  style: TextStyle(fontSize: 30.0, color: Colors.black),
                  keyboardType: TextInputType.number,
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
                    addUpdateFoodData();
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
