part of 'home.dart';

class HomePageLogic with ChangeNotifier {
  final BuildContext context;
  late PageController pageController;
  ValueNotifier<String> title = ValueNotifier('');

  HomePageLogic({required this.context}) {
    pageController = PageController(initialPage: 2);
  }

  void pressBottomItem(BottomNavModel data) {
    title.value = data.title;
    pageController.jumpToPage(data.id - 1);
  }
}
