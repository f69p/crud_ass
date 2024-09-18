import 'dart:convert';

import 'package:crudapp2/add_new_product.dart';
import 'package:crudapp2/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'edit_product_Screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product>prducts=[];


bool inProgress=true;
  @override
  void initState() {
    super.initState();
    getProduct();
  }

  void getProduct() async {
inProgress=true;
setState(() {});
Response response=await
    get(Uri.parse('http://164.68.107.70:6060/api/v1/ReadProduct'));
final Map<String,dynamic>decodeRespons=jsonDecode(response.body);
if(response.statusCode==200 && decodeRespons['status']=='success'){
  prducts.clear();
  for(var e in decodeRespons['data']){
    prducts.add(Product.tojson(e));
  }
}
inProgress=false;
setState(() {

});
  }

  void deleteProduct(String id)async{
    inProgress=true;
    Response response=await
        get(Uri.parse('http://164.68.107.70:6060/api/v1/DeleteProduct/$id'));
    final Map<String,dynamic>decodeRespons=jsonDecode(response.body);
    if(response.statusCode==200 && decodeRespons['status']=='success'){
      getProduct();
    }else{
      inProgress=false;
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        centerTitle: true,
        actions: [
        IconButton(onPressed: getProduct, icon: Icon(
          Icons.refresh
      ),),
        ],
        title: Text('CRUD'),


      ),
      body:inProgress?Center(child: CircularProgressIndicator(),): Padding(
        padding: EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: prducts.length,
          itemBuilder: (context, index) {
            return ListTile(
              onLongPress: (){
                showDialog(context: context, builder: (_){
                  return AlertDialog(
                    title: Row(
                      children: [
                        Text('choose an action'),

                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(Icons.close,color: Colors.red,))
                      ],
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProductScreen()));
                           setState(() {

                           });
                          },
                          leading: Icon(Icons.edit),
                          title: Text('Edit'),
                        ),
                        Divider(height: 0,),
                        ListTile(
                          onTap: (){
                           deleteProduct(prducts[index].id);
                           Navigator.pop(context);
                          },
                          leading: Icon(Icons.delete),
                          title: Text('Delete'),
                        ),
                      ],
                    ),
                  );
                });
              },
              title: Text(prducts[index].productName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Product Code:${prducts[index].productCode}'),
                  Text('Total Price:${prducts[index].TotalPrice}'),
                  Text('Product Units:${prducts[index].quantity}'),
                ],
              ),
              leading: Image.network(prducts[index].ProductImage,width: 60,errorBuilder: (_,__,___){
                return Icon(
                  Icons.image,
                  size: 34,
                );
              },),
              trailing: Text('${prducts[index].unitPrice}'),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>AddNewListScreen ()));
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}



