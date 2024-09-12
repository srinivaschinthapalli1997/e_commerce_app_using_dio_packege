import 'package:dio/dio.dart';
import 'package:e_commerce_app_using_dio_package/model/cart_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // for Dio
  CartModel? cartModel;
  Future<void> getData() async {
    const String apiUrl = "https://dummyjson.com/carts";
    try {
      Response response = await Dio().get(apiUrl);
      if (response.data != null) {
        setState(() {
          cartModel = CartModel.fromJson(response.data);
        });
      } else {
        throw Exception(" Api response is null or in an unexpected format");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(child: Text('Fetch data from API using Dio')),
      ),
      body: cartModel == null ? const Center(child: CircularProgressIndicator(),) :
      GridView.builder(
          itemCount: cartModel!.carts!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12),
          itemBuilder: (context, index) {
            return Material(
              borderRadius: BorderRadius.circular(20),
              elevation: 5,
              child: Column(children: [
                Image.network(cartModel!.carts![index].products![0].thumbnail ?? "",
                height: 140,
                width: 200,),
                Padding(
                  padding: const EdgeInsets.only(left: 5,right: 5),
                  child: Text(cartModel!.carts![index].products![0].title ?? "",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                )
              ],),
            );
          }),
    );
  }
}
