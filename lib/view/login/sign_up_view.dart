import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  String email = "";
  String name = "";
  String password = "";
  Color passwordColor = TColor.gray70;

  bool isLoading = false;
  bool isPasswordVisible = false;
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  final GlobalKey<FormState> _formkeysignup = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    txtPassword.addListener(updatePasswordColor);
  }

  void updatePasswordColor() {
    setState(() {
      // Update the password color based on the current text in the password field
      passwordColor = getUnderlineColor(txtPassword.text);
    });
  }

  @override
  void dispose() {
    // Clean up the listener when the widget is disposed
    txtPassword.removeListener(updatePasswordColor);
    super.dispose();
  }

  Future<void> register() async {
    if (txtPassword.text.isEmpty || txtEmail.text.isEmpty) {
      showSnackBar(
        context,
        "Please fill in all fields...!",
      );
    }

    try {
      setState(() {
        isLoading = true;
      });

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(password: password, email: email);

      // Save user details including name to Firebase or your database
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': name,
        'email': email,

        // Add other user details if needed
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
            backgroundColor: TColor.primary,
            content: const Text(
              "Registered Successfully",
              style: TextStyle(
                fontSize: 20,
              ),
            ))));
      }
      if (mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainTabView()));
      }
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'weak-password':
          if (context.mounted) {
            showSnackBar(context, "Password provided is too weak");
          }
          break;
        case 'email-already-in-use':
          if (context.mounted) {
            showSnackBar(context, "Account already exists!");
          }
          break;
        case 'invalid-email':
          if (context.mounted) {
            showSnackBar(context, " email address is not valid.");
          }
          break;
        case 'operation-not-allowed':
          if (context.mounted) {
            showSnackBar(context,
                "Enable email/password accounts in the Firebase Console, under the Auth tab.");
          }

        default:
          // Handle other FirebaseException codes here
          break;
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Form(
              key: _formkeysignup,
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
                    title: "Name",
                    controller: txtName,
                  ),
                  const SizedBox(
                    height: 15,
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomUnderLine(
                    passwordColor: getUnderlineColor(txtPassword.text),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        txtPassword.text.isEmpty
                            ? "Use 6 or more characters with a mix of letters,\nnumbers & symbols."
                            : getPasswordStrengthMessage(txtPassword.text),
                        style: TextStyle(
                          color: txtPassword.text.isEmpty
                              ? TColor.gray50
                              : getUnderlineColor(txtPassword.text),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PrimaryButton(
                    isLoading: isLoading,
                    title: "Get started, it's free!",
                    onPressed: () async {
                      if (_formkeysignup.currentState!.validate()) {
                        setState(() {
                          name = txtName.text.trim();
                          email = txtEmail.text.trim();
                          password = txtPassword.text.trim();
                        });
                      }
                      register();
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
      ),
    );
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.width * 0.49,
        left: 30,
        right: 30,
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.redAccent,
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    ),
  );
}

Color getUnderlineColor(String password) {
  if (password.isEmpty) {
    return TColor.gray70; // Password is empty, show grey
  } else if (password.length <= 3) {
    return Colors.red; // Password is less than 3 characters, show red
  } else if (password.length >= 3 && password.length <= 5) {
    return Colors.orange; // Password is between 3 to 5 characters, show orange
  } else if (password.length >= 5 && password.length <= 7) {
    return Colors.yellow; // Password is more than 5 characters, show yellow
  } else {
    return Colors.green; // Password is more than 7 characters, show green
  }
}

String getPasswordStrengthMessage(String password) {
  if (password.isEmpty) {
    return "Please enter a password";
  } else if (password.length <= 3) {
    return "Your password is weak";
  } else if (password.length <= 5) {
    return "Your password is fair";
  } else if (password.length <= 7) {
    return "Your password is strong";
  } else {
    return "Your password is very strong";
  }
}
