import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/cubits/product/product_cubit.dart';
import 'package:task/data/models/product_model.dart';
import 'package:task/ui/card/custom_drawer.dart';
import 'package:task/ui/card/widgets/custom_app_bar.dart';
import 'package:task/ui/card/widgets/products_widget.dart';
import 'package:task/ui/detail.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ProductModel> products = [];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer:  const CustomDrawer(),
      appBar: const CustomAppBar(
        onBackTap: null,
        title: "Kitoblar",
        centerTitle: true,
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is GetProductInProgress) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is GetProductInSuccess) {
            products = state.product;
            return ListView(
              children: List.generate(
                products.length,
                    (index) {
                  var product = products[index];
                  return ProductButton(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetail(
                            index: index, productModel: products[index],
                          ),
                        ),
                      );
                    },
                    imageUrl: product.imageUrl,
                    name: product.productName,
                    salary: product.salary,
                  );
                },
              ),
           );
          } else {
            return const Center(child: Text("error"));
          }
        },
      ),
    );
  }
}
