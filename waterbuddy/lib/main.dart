import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:waterbuddy/Features/Authentication/data/Presentation/Views/login_page.dart';
import 'package:waterbuddy/Features/Authentication/data/Presentation/Views/signup_page.dart';
import 'package:waterbuddy/Features/Authentication/data/Presentation/view_models/login_cubit/login_cubit.dart';
import 'package:waterbuddy/Features/Authentication/data/Presentation/view_models/signup_cubit/signup_cubit.dart';
import 'package:waterbuddy/Features/Chat/presentation/views/chat_page.dart';
import 'Features/Splash/Presentation/views/splash_view.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  runApp(const WaterBuddy());
}

class WaterBuddy extends StatelessWidget {
  const WaterBuddy({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData().copyWith(scaffoldBackgroundColor: Colors.white),
        home: const SplashView(),
        routes: {
          'login': (context) => LoginPage(),
          'signup': (context) => SignUp(),
          'chat_page': (context) => const ChatPage(),
        },
      ),
    );
  }
}
