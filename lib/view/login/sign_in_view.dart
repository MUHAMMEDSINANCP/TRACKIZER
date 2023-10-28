import 'package:flutter/material.dart';
import 'package:trackizer/view/login/social_login.dart';
import '../../common/color_extension.dart';
import '../../common_widget/primary_button.dart';
import '../../common_widget/round_textfield.dart';
import '../../common_widget/secondary_boutton.dart';
import '../main_tab/main_tab_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool isRemember = false;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: media.width * 0.25,
                ),
                Image.asset("assets/img/app_logo.png",
                    width: media.width * 0.5, fit: BoxFit.contain),
                SizedBox(
                  height: media.width * 0.3,
                ),
                RoundTextField(
                  title: "Login",
                  controller: txtEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 15,
                ),
                RoundTextField(
                  title: "Password",
                  controller: txtPassword,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: TColor.secondary),
                      onPressed: () {
                        setState(() {
                          isRemember = !isRemember;
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isRemember
                                ? Icons.check_box_rounded
                                : Icons.check_box_outline_blank_rounded,
                            size: 25,
                            color:
                                isRemember ? TColor.secondary : Colors.white30,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Remember me",
                            style:
                                TextStyle(color: TColor.gray50, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          foregroundColor: TColor.secondary),
                      child: Text(
                        "Forgot password",
                        style: TextStyle(color: TColor.gray50, fontSize: 14),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                PrimaryButton(
                  title: "Sign In",
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainTabView()),
                        (route) => false);
                  },
                ),
                SizedBox(
                  height: media.width * 0.2,
                ),
                Text(
                  "if you don't have an account yet?",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: TColor.white, fontSize: 14),
                ),
                const SizedBox(
                  height: 20,
                ),
                SecondaryButton(
                  title: "Sign up",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SocialLoginView(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
