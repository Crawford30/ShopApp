import 'package:flutter/material.dart';

class CartProducts extends StatefulWidget {
  const CartProducts({Key? key}) : super(key: key);

  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  var products_on_the_cart = [
    //=====We Create maps(maps and list are used to group things together)====

    {
      "name": "Dress",
      "picture": "images/products/dress1.jpeg",
      "price": "90",
      "size": "M",
      "color": "Red",
      "quantity": 1
    },

    {
      "name": "Shoe",
      "picture": "images/products/shoe1.jpg",
      "price": "50",
      "size": "7",
      "color": "Black",
      "quantity": 3
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: products_on_the_cart.length,
        itemBuilder: (context, index) {
          return SingleCartProduct(
            cart_prod_name: products_on_the_cart[index]["name"],
            cart_prod_picture: products_on_the_cart[index]["picture"],
            cart_prod_price: products_on_the_cart[index]["price"],
            cart_prod_size: products_on_the_cart[index]["size"],
            cart_prod_color: products_on_the_cart[index]["color"],
            cart_prod_qty: products_on_the_cart[index]["quantity"],
          );
        });
  }
}

class SingleCartProduct extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_price;
  final cart_prod_size;
  final cart_prod_color;
  final cart_prod_qty;

  SingleCartProduct(
      {this.cart_prod_name,
      this.cart_prod_picture,
      this.cart_prod_price,
      this.cart_prod_size,
      this.cart_prod_color,
      this.cart_prod_qty});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          //============LEADING SECTION==============
          leading: Container(
            width: 80.0,
            height: 80.0,
            child: Image.asset(
              cart_prod_picture,
              fit: BoxFit.fill,
            ),
          ),

          //============TITLE SECTION=========
          title: Text(cart_prod_name),

          //==========SUBTITLE SECTION==========
          subtitle: Column(
            children: [
              //=====ROW INSIDE COLUMN====
              Row(
                children: [
                  //=======This Section is for the size of the product =====
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Text("Size:"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      cart_prod_size,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),

                  //=======This Section is for the color of the product =====
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14.0, 8.0, 8.0, 8.0),
                    child: Text("Color:"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      cart_prod_color,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),

              //==========THIS SECTION IS THE PRODUCT PRICE=====
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "\$${cart_prod_price}",
                  style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ),
            ],
          ),
          trailing: FittedBox(
            fit: BoxFit.fill,
            child: Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_drop_up),
                  iconSize: 68,
                ),
                Text(
                  "${cart_prod_qty}",
                  style: TextStyle(fontSize: 30.0),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 68,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
