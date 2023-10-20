import 'package:flutter/material.dart';
import 'package:cp_expenses/view/login/sign_in_view.dart';
import 'package:cp_expenses/view/login/social_login.dart';
import '../../common/color_extension.dart';
import '../../common_widget/primary_button.dart';
import '../../common_widget/secondary_boutton.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({
    super.key,
  });

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Image.asset(
              "assets/img/welcome_screen.png",
              width: media.width,
              height: media.height,
              fit: BoxFit.cover,
            ),
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 3,
                    ),
                    Image.asset("assets/img/app_logo.png",
                        width: media.width * 0.5, fit: BoxFit.contain),
                    SizedBox(
                      height: media.height * 0.58,
                    ),
                    Text(
                      "Master Your Subscriptions: Control, Track, and Save",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: TColor.white.withOpacity(0.4),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.1,
                    ),
                    PrimaryButton(
                      title: "Get started",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SocialLoginView(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SecondaryButton(
                      title: "I have an account",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignInView(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
