import 'package:beefood_app/screens/app/bottom_navigation/bottom_navigation.dart';
import 'package:beefood_app/screens/app/goods_receipt/goods_receipt.dart';
import 'package:beefood_app/screens/app/order/order.dart';
import 'package:beefood_app/screens/app/product/product.dart';
import 'package:beefood_app/view_model/app/app.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
part 'home.logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageLogic _logic;

  @override
  void initState() {
    super.initState();
    _logic = HomePageLogic(context: context);
  }

  @override
  void dispose() {
    _logic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: ChangeNotifierProvider.value(
        value: _logic,
        child: Scaffold(
          appBar: AppBar(
            title: ValueListenableBuilder(
              builder: (_, String _state, __) {
                return Text(_state);
              },
              valueListenable: _logic.title,
            ),
            actions: [
              IconButton(
                onPressed: GetIt.instance<AppVM>().logout,
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigation(
            pressed: _logic.pressBottomItem,
          ),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _logic.pageController,
            children: const [
              OrderPage(),
              GoodsReceiptPage(),
              ProductPage(),
            ],
          ),
        ),
      ),
    );
  }
}
