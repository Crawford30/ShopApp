import 'package:flutter/material.dart';

void main(){
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),

    )
  );

}




class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Fashapp'),
        actions: [
          new  IconButton( icon: Icon(Icons.search, color: Colors.white,), onPressed: (){}),
          new  IconButton( icon: Icon(Icons.shopping_cart, color: Colors.white,), onPressed: (){})
        ],
      ),
    );
  }
}
