import 'package:firebase_auth/firebase_auth.dart';
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
  final _formkey = GlobalKey<FormState>();

  String password = "";
  String email = "";
  bool isLoading = false;
  bool isPasswordVisible = false;

  Future<void> login() async {
    if (txtEmail.text.isEmpty || txtPassword.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        dismissDirection: DismissDirection.up,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.width * 0.5,
            left: 26,
            right: 26),
        backgroundColor: Colors.redAccent,
        content: const Text(
          "Please enter both email and password.",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ));
      return; // Stop execution if fields are empty
    }

    try {
      setState(() {
        isLoading = true;
      });

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: txtEmail.text.trim(),
        password: txtPassword.text.trim(),
      );
      if (mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainTabView()));
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
            backgroundColor: TColor.primary,
            content: const Text(
              "Logged In Successfully",
              style: TextStyle(
                fontSize: 20,
              ),
            ))));
      }
    } on FirebaseException catch (e) {
      String errorMessage =
          "Invalid Credentials! Check your email & password again.";

      if (e.code == 'user-not-found') {
        errorMessage = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Wrong password provided by the user.";
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.redAccent,
            content: Text(
              errorMessage,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            )));
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: TColor.gray,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Form(
              key: _formkey,
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
                    title: "Email",
                    controller: txtEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RoundTextField(
                    title: "Password",
                    obscureText: !isPasswordVisible,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 17),
                        child: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: isPasswordVisible
                              ? TColor.secondary
                              : Colors.grey,
                        ),
                      ),
                    ),
                    controller: txtPassword,
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
                              color: isRemember
                                  ? TColor.secondary
                                  : Colors.white30,
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
                          "Forgot password?",
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
                    isLoading: isLoading,
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          email = txtEmail.text.trim();
                          password = txtPassword.text.trim();
                        });
                      }
                      login();
                    },
                  ),
                  SizedBox(
                    height: media.width * 0.15,
                  ),
                  Text(
                    "if you don't have an account yet?",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: TColor.white, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 10,
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
      ),
    );
  }
}
