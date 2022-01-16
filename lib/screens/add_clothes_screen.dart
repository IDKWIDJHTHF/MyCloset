import 'package:flutter/material.dart';
import 'package:flutter_travel_ui/models/category_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'dart:html' as html;
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';


class AddClothesScreen extends StatefulWidget {
  final Category categories;

  AddClothesScreen({this.categories});

  @override
  _AddClothesScreenState createState() => _AddClothesScreenState();
}

class _AddClothesScreenState extends State<AddClothesScreen> {
  Color _currentColor = Colors.blue;

  final _controller = CircleColorPickerController(
    initialColor: Colors.blue,
  );

  var imageFile;

  int _selectedIndex = 0;


  Widget _buildIcon(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          color: _selectedIndex == index
              ? Theme.of(context).accentColor
              : Color(0xFFE7EBEE),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Icon(
          categories[index].icon,
          size: 25.0,
          color: _selectedIndex == index
              ? Theme.of(context).primaryColor
              : Color(0xFFB4C1C4),
        ),
      ),
    );
  }

  _openGallary(BuildContext context) async {
    final pickedFile = await FilePicker.platform.pickFiles();

    this.setState(() {
      imageFile = pickedFile.files.single;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    ImagePicker picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    this.setState(() {
      //imageFile = File(pickedFile.path);
      imageFile = Null;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Please select one"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallary(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _decideImageView() {
    if (imageFile == null) {
      return Text('Add Image');
    } else {
      return Image.file(imageFile, height: 400);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text(
                'Add Clothes',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 300,
              child: OutlinedButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  _showChoiceDialog(context);
                },
                child: _decideImageView(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 100.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index){
                    return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column (
                            children: <Widget> [
                              _buildIcon(index),
                              SizedBox(height: 5.0),
                              Text(categories[index].categoryName)
                            ]
                        )
                    );
                  }),
            ),
            SizedBox(height: 30.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Color',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 300,
              child: Center(
                child: CircleColorPicker(
                  controller: _controller,
                  onChanged: (color) {
                    setState(() => _currentColor = color);
                  },
                  size: const Size(240,240),
                  strokeWidth: 4,
                  thumbSize: 36,
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Tags',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.0),

            Column (
              children: <Widget> [
                TextButton(
                    onPressed: () {
                      Fluttertoast.showToast(
                          msg: "Clothing Added!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.orange,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    },
                    // onPressed: () => Navigator.pop(context) //to navigate back
                    child: const Text(
                      'Add',
                    ),
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                        backgroundColor: MaterialStateProperty.all(Color(0xFF3EBACE)),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(vertical: 20, horizontal: 63)),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 20)))
                ),
                SizedBox(height: 20.0),

            ]
            ),

        ],
        ),
      ),
    );
  }
}
