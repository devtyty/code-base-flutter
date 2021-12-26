import 'package:beefood_app/routes/routes.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Product Page'),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.productDetailPage);
          },
          child: const Text('Goto Detail'),
        )
      ],
    );
  }
}
