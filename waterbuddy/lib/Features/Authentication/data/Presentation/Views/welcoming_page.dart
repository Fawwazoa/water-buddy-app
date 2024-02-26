import 'package:flutter/material.dart';

import 'package:waterbuddy/Features/Authentication/data/Presentation/Views/widgets/welcoming_page_body.dart';

class WelcomingPage extends StatelessWidget {
  const WelcomingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WelPageBody(),
    );
  }
}
