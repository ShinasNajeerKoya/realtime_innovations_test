import 'package:rxdart/rxdart.dart';

class SplashBloC {
  final showPage = PublishSubject<String>();
  SplashBloC() {
    initDetails();
  }

  Future<void> initDetails() async {
    Future.delayed(const Duration(milliseconds: 500)).then((_) {
      showPage.add('Navigate');
    });
  }

  void dispose() {}
}
