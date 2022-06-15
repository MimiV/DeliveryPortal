import 'package:deliveryportal/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/style.dart';
import '../../routes/route.dart';
import '../../widgets/custom_text.dart';
import 'auth.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Image.asset("assets/icons/logo.png"),
                  ),
                  Expanded(child: Container()),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text("Login",
                      style: GoogleFonts.roboto(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  CustomText(
                    text: "Welcome back to the admin panel.",
                    color: lightGrey,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "abc@domain.com",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: passController,
                //onChanged: (value) => setState() => password = value,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "123",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(value: true, onChanged: (value) {}),
                      const CustomText(
                        text: "Remeber Me",
                      ),
                    ],
                  ),
                  CustomText(text: "Forgot password?", color: active)
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () async {
                  print("starting login");
                  await signInWithEmailPassword(
                          emailController.text, passController.text)
                      .then((result) {
                    if (result != null) {
                      print("logged in!!");
                      print(result);
                      Get.offAllNamed(rootRoute);
                    } else {
                      void showAlertMethod(BuildContext context) {
                        var alert = AlertDialog(
                          title: const Text('Login Failed'),
                          content: const Text(
                              'Username and/or Password are incorrect'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        );

                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            });
                      }

                      showAlertMethod(context);
                    }
                  }).catchError((error) {
                    print('Registration Error: $error');
                  });
                  // Get.offAllNamed(rootRoute);
                  //Get.offAll(() => SiteLayout());
                  // print("ended test with");
                  // print(emailController.text);
                  // print(passController.text);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: active, borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: const CustomText(
                    text: "Login",
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                // onHover: (value) {
                //   print(value);
                // },
                hoverColor: Colors.black,
                onTap: () async {
                  await signInWithGoogle().then((result) {
                    if (result != null) {
                      print("logged in!!");
                      print(result);
                      //Get.offAllNamed(rootRoute);
                    } else {
                      AlertDialog(
                        title: const Text('Login Failed'),
                        content: const Text(
                            'Username and/or Password are incorrect'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    }
                  }).catchError((error) {
                    print('Registration Error: $error');
                  });
                  // Get.offAllNamed(rootRoute);
                  //Get.offAll(() => SiteLayout());
                  // print("ended test with");
                  // print(emailController.text);
                  // print(passController.text);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: const CustomText(
                    text: "SignIn with google",
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              RichText(
                  text: TextSpan(children: [
                const TextSpan(text: "Do not have admin credentials? "),
                TextSpan(
                    text: "Request Credentials! ",
                    style: TextStyle(color: active))
              ]))
            ],
          ),
        ),
      ),
    );
  }
}
