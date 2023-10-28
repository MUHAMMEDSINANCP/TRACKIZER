
import 'package:flutter/material.dart';
import '../../common/color_extension.dart';
import '../../common_widget/custom_underline.dart';
import '../../common_widget/primary_button.dart';
import '../../common_widget/round_textfield.dart';
import '../../common_widget/secondary_boutton.dart';
import '../main_tab/main_tab_view.dart';
import 'sign_in_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: media.width * 0.3,
                ),
                Image.asset("assets/img/app_logo.png",
                    width: media.width * 0.5, fit: BoxFit.contain),
                SizedBox(
                  height: media.width * 0.25,
                ),
                RoundTextField(
                  title: "E-mail address",
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
                  height: 20,
                ),
                const CustomUnderLine(),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Use 8 or more characters with a mix of letters,\nnumbers & symbols.",
                      style: TextStyle(color: TColor.gray50, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                PrimaryButton(
                  title: "Get started, it's free!",
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainTabView()),
                        (route) => false);
                  },
                ),
                SizedBox(
                  height: media.width * 0.18,
                ),
                Text(
                  "Do you have already an account?",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: TColor.white, fontSize: 14),
                ),
                const SizedBox(
                  height: 20,
                ),
                SecondaryButton(
                  title: "Sign in",
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
      ),
    );
  }
}
