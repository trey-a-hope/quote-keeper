part of 'splash_view.dart';

class _SplashViewModel extends GetxController {
  @override
  void onInit() async {
    super.onInit();

    // Proceed to main page after 3 seconds.
    Timer(
      const Duration(seconds: 3),
      () => Get.toNamed(Globals.routeMain),
    );
  }
}
