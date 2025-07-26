import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/providers/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String,Object> product;
  const ProductDetailsPage({
    super.key,
    required this.product,
  }
  );

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {

  int selectedSize=0;
  void onTap(){
    if(selectedSize!=0){
      Provider.of<CartProvider>(context,listen: false).addProduct(
      {
        'id':widget.product['id'],
        'title': widget.product['title'],
        'price': widget.product['price'],
        'imageURL':widget.product['imageURL'],
        'company':widget.product['company'],
        'size':selectedSize,
      }
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content:
        Text('Product added successfully!')
        ),
        );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content:
        Text('Please select a size')
        ),
        );
    }
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details',style: TextStyle(
          fontFamily: 'kranky',
        ),),
      ),
      body: Column(
        children: [
          Text(widget.product['title'] as String,
          style: Theme.of(context).textTheme.titleLarge,),
          const Spacer(),
          Image.asset(widget.product['imageURL'] as String,
          height: 250,
          ),
          const Spacer(),
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 226, 239, 245),
              borderRadius: BorderRadius.circular(40),
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('\$${widget.product['price']}',
                style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10,),

                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (widget.product['sizes'] as List<int>).length,
                    itemBuilder: (context,index){
                      final size=(widget.product['sizes'] as List<int>)[index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap:(){
                            setState(() {
                              selectedSize=size;
                            });
                          },
                          child: Chip(
                            label: Text(size.toString()),
                            backgroundColor: selectedSize== size ? Theme.of(context).colorScheme.primary:null,
                          ),
                        ),
                      );
                    }
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton.icon(
                    onPressed: onTap, 
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                    ),
                   label:const Text('Add to Cart',style: TextStyle(
                    fontFamily: 'kranky',
                    fontSize: 18,
                    color: Colors.black,
                   ),
                   ),
                   style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      fixedSize: Size(350, 50),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}