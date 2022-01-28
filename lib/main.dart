import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

//====My Own imports
import 'package:shopapp/components/horizontal_listview.dart';
import 'package:shopapp/components/products.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Widget imageCarousel = SizedBox(
      height: 200.0,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: const [
          AssetImage('images/c1.jpg'),
          AssetImage('images/m1.jpeg'),
          AssetImage('images/m2.jpg'),
          AssetImage('images/w1.jpeg'),
          AssetImage('images/w3.jpeg'),
          AssetImage('images/w4.jpeg'),
        ],
        autoplay: false,
        // animationCurve: Curves.fastLinearToSlowEaseIn,
        // animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
        dotBgColor: Colors.transparent,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: const Text('Fashapp'),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
          IconButton(
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {})
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            //====Header Part of drawer====
            UserAccountsDrawerHeader(
              accountName: Text("Joel Crawford"),
              accountEmail: Text("joelcrawford30@gmail.com"),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: BoxDecoration(color: Colors.pink),
            ),

            //=======Body========
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Home'),
                leading: Icon(Icons.home,  color: Colors.red,),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('My Account'),
                leading: Icon(Icons.person,  color: Colors.red,),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('My Orders'),
                leading: Icon(Icons.shopping_basket,  color: Colors.red,),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Shopping Cart'),
                leading: Icon(Icons.shopping_cart, color: Colors.red,),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Favourites'),
                leading: Icon(Icons.favorite,  color: Colors.red,),
              ),
            ),

            Divider(),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Settings'),
                leading: Icon(
                  Icons.settings,
                ),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('About'),
                leading: Icon(
                  Icons.help,
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          //=======Image Carousel begins here =====
          imageCarousel,

          //========Padding widget=====
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Categories"),
          ),

          //======Horizontal List View begins here =====
          HorizontalList(),

          //========Padding widget=====
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("Recent Products"),
          ),

          //=====Grid View
          Container(
            height: 320.0,
            child: Products(),
          )
        ],
      ),
    );
  }
}
