import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final void Function(BottomNavModel data) pressed;
  const BottomNavigation({Key? key, required this.pressed}) : super(key: key);

  @override
  BottomNavigationState createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  ValueNotifier<int> tabSelected = ValueNotifier(2);

  List<BottomNavModel> get dataItems => [
        BottomNavModel(
          id: 1,
          title: 'Đơn hàng',
          assetIcon: Icons.details,
        ),
        BottomNavModel(id: 2, title: 'Nhập hàng', assetIcon: Icons.get_app),
        BottomNavModel(
          id: 3,
          title: 'Sản phẩm',
          assetIcon: Icons.production_quantity_limits,
        ),
      ];

  double get heightInsets {
    double insets = WidgetsBinding.instance!.window.padding.bottom;
    double extraHeight = insets > 0 ? 15 : 0;
    return extraHeight;
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      widget.pressed(dataItems[tabSelected.value]);
      tabSelected.notifyListeners();
    });
  }

  void onPressItem(BottomNavModel item) {
    widget.pressed(item);
    tabSelected.value = item.id - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      child: Container(
        color: Theme.of(context).bottomAppBarTheme.color,
        height: 70 + heightInsets,
        child: ValueListenableBuilder<int>(
            valueListenable: tabSelected,
            builder: (context, indexSelected, _) {
              return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: dataItems
                    .map(
                      (item) => Expanded(
                        child: _ItemBottomNav(
                          model: item,
                          heightInsets: heightInsets,
                          idSelected: dataItems[indexSelected].id,
                          pressed: () => onPressItem(item),
                        ),
                      ),
                    )
                    .toList(),
              );
            }),
      ),
    );
  }
}

class BottomNavModel {
  late int id;
  late String title;

  ///This is Svg file
  late IconData assetIcon;

  BottomNavModel({
    required this.id,
    required this.title,
    required this.assetIcon,
  });
}

///Item bottom nav
class _ItemBottomNav extends StatefulWidget {
  final BottomNavModel model;
  final int idSelected;
  final double heightInsets;
  final void Function() pressed;

  const _ItemBottomNav({
    Key? key,
    required this.model,
    required this.heightInsets,
    required this.idSelected,
    required this.pressed,
  }) : super(key: key);

  @override
  __ItemBottomNavState createState() => __ItemBottomNavState();
}

class __ItemBottomNavState extends State<_ItemBottomNav>
    with SingleTickerProviderStateMixin {
  late AnimationController _animControl;
  late Animation<Offset> animOffset;

  @override
  void initState() {
    _animControl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    animOffset = Tween(begin: const Offset(0, 4.0), end: const Offset(0, 0))
        .animate(_animControl);

    super.initState();
  }

  bool get isSelected => widget.idSelected == widget.model.id;

  @override
  void didUpdateWidget(covariant _ItemBottomNav oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (isSelected) {
      _animControl.forward();
    } else {
      _animControl.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        side: MaterialStateProperty.all<BorderSide>(BorderSide.none),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.only(
            top: 10,
            bottom: 3 + widget.heightInsets,
            left: 2.0,
            right: 2.0,
          ),
        ),
      ),
      onPressed: widget.pressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(widget.model.assetIcon),
          const SizedBox(height: 3),
          Text(
            widget.model.title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 5),
          AnimatedBuilder(
            animation: _animControl,
            builder: (_, child) {
              return SlideTransition(position: animOffset, child: child);
            },
            child: Container(
              height: 5,
              width: MediaQuery.of(context).size.width / 3 * 0.4,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
            ),
          )
        ],
      ),
    );
  }
}
