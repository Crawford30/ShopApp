import 'package:flutter/material.dart';
import 'package:shopapp/pages/product_details.dart';

//==================Product Detail Class==================
class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var product_list = [
    //=====We Create maps(maps and list are used to group things together)====
    {
      "name": "Blazer",
      "picture": "images/products/blazer1.jpeg",
      "old_price": "120",
      "price": "85"
    },
    {
      "name": "Dress",
      "picture": "images/products/dress1.jpeg",
      "old_price": "50",
      "price": "90"
    },

    {
      "name": "Hills",
      "picture": "images/products/hills1.jpeg",
      "old_price": "20",
      "price": "80"
    },
    {
      "name": "Pants",
      "picture": "images/products/pants1.jpg",
      "old_price": "230",
      "price": "250"
    },

    {
      "name": "Shoe",
      "picture": "images/products/shoe1.jpg",
      "old_price": "40",
      "price": "150"
    },

    {
      "name": "Skirt",
      "picture": "images/products/skt1.jpeg",
      "old_price": "15",
      "price": "20"
    },

    {
      "name": "Blazer 2",
      "picture": "images/products/blazer2.jpeg",
      "old_price": "120",
      "price": "85"
    },
    {
      "name": "Red Dress",
      "picture": "images/products/dress2.jpeg",
      "old_price": "50",
      "price": "90"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return SingleProduct(
            prod_name: product_list[index]['name'],
            prod_picture: product_list[index]['picture'],
            prod_old_price: product_list[index]['old_price'],
            prod_price: product_list[index]['price'],
          );
        });
  }
}

class SingleProduct extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_old_price;
  final prod_price;

  SingleProduct({
    this.prod_name,
    this.prod_picture,
    this.prod_old_price,
    this.prod_price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: Text("Hero 1"),
        child: Material(
          child: InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                //========We are passing the value of product to product details page=======
                builder: (context) => ProductDetails(
                      product_detail_name: prod_name,
                      product_detail_new_price: prod_price,
                      product_detail_old_price: prod_old_price,
                      product_detail_picture: prod_picture,
                    ))),
            child: GridTile(
              footer: Container(
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          prod_name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                      ),
                      Text(
                        "\$${prod_price}",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
              child: Image.asset(
                prod_picture,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
