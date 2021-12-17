import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rabble/services/audio_service/audio_service.dart';
import 'package:rabble/services/state_controller/state_controller.dart';
import 'package:rabble/views/main.dart';
import 'package:rabble/views/onboarding.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool? onboardingSeen;
Future<void> main() async {
  Get.put<GetController>(GetController(), permanent: true);
  Get.put<RabbleAudioService>(RabbleAudioService(), permanent: true);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  onboardingSeen = prefs.getBool('onboardingSeen') ?? false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      observers: [MainObserver()],
      child: const AppInit(),
    );
  }
}

class MainObserver implements ProviderObserver {
  @override
  void didAddProvider(
      ProviderBase provider, Object? value, ProviderContainer container) {
    debugPrint('Added: $provider : $value(${value.runtimeType})');
  }

  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    debugPrint('Disposed: $provider');
  }

  @override
  void didUpdateProvider(ProviderBase provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    debugPrint('Update: $provider : $newValue');
  }

  @override
  void providerDidFail(ProviderBase<dynamic> provider, Object error,
      StackTrace stackTrace, ProviderContainer container) {
    debugPrint('Fail: $provider : $error');
  }
}

class AppInit extends HookConsumerWidget {
  static final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  const AppInit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetched = useState<bool>(false);

    useEffect(() {
      SharedPreferences.getInstance().then((value) async {
        fetched.value = true;
      });
    }, []);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rabble',
      home: onboardingSeen! ? MainPage() : OnboardingPage(),
    );
  }
}
