import 'package:evika/auth/signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool valuefirst = true;
  bool valuesecond = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Center(
            child: SizedBox(
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: 40,
                          color: HexColor('#224957'),
                          fontFamily: 'LexendDeca'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Lets Sign in To Explore",
                      style: TextStyle(
                          fontSize: 16,
                          color: HexColor('#224957').withOpacity(0.7),
                          fontFamily: "LexendDeca-Bold"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      'assets/img1.png',
                      height: 300,
                      width: 250,
                    ),
                    SizedBox(
                      width: 320,
                      height: 60,
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white70),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: HexColor('#224957'),
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Colors.white70,
                            ),
                            hintText: 'Email',
                            hintStyle: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'LexendDeca',
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 320,
                      height: 60,
                      child: TextFormField(
                          style: const TextStyle(color: Colors.white70),
                          obscureText: true,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: HexColor('#224957'),
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.white70,
                              ),
                              hintText: 'Password',
                              hintStyle: const TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'LexendDeca'),
                              focusColor: Colors.red,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          validator: (val) {
                            if (val!.length < 6) {
                              return "Password must be at least 6 characters";
                            } else {
                              return null;
                            }
                          }),
                    ),
                    const SizedBox(
                      height: 5.5,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          checkColor: Colors.white70,
                          activeColor: HexColor('#224957'),
                          value: valuefirst,
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Row(
                            children: [
                              Text(
                                "Remember me",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    fontFamily: 'LexendDeca',
                                    color: HexColor('#224957')),
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              Text(
                                "Forget Password",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'LexendDeca',
                                    fontSize: 15,
                                    color: HexColor('#224957'),
                                    decoration: TextDecoration.underline),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 320,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(249, 82, 255, 82),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                              fontFamily: 'LexendDeca',
                              color: Color.fromARGB(255, 78, 78, 78),
                              fontSize: 20),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 7,
                      ),
                      child: Text.rich(
                        TextSpan(
                          text: "Don't have an account? ",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'LexendDeca'),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Register Here",
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'LexendDeca',
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPage(),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
