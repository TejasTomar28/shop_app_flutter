import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/providers/cart_provider.dart';
// import 'package:shop_app_flutter/global_variable.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart=context.watch<CartProvider>().cart;
    // final cart=Provider.of<CartProvider>(context).cart;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart',
        style: TextStyle(
          fontFamily: 'kranky',
        ),),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context,index){
          final cartitem=cart[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(cartitem['imageURL']as String),
              radius: 30,
            ),
            trailing: IconButton(
              onPressed: (){
                
                showDialog(context: context, 
                builder: (context){
                  return AlertDialog.adaptive(
                    title: Text('Remove Product',
                    style: Theme.of(context).textTheme.titleMedium,
                    ),
                    content: Text('Are you sure that you want to remove product?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        }, 
                        child: const Text('No',style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          context.read<CartProvider>().removeProduct(cartitem);
                          // Provider.of<CartProvider>(context,listen: false).removeProduct(cartitem);
                          Navigator.of(context).pop();
                        }, 
                        child: const Text('Yes',style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      ),  
                    ],
                  );
                },
                );
              },
              icon: 
              Icon(Icons.delete),
              color: Colors.red,
            ),
            title: Text(cartitem['title'].toString(),
            ),
            subtitle: Text('Size: ${cartitem['size']}'),
          );
        },
        ),
    );
  }
}