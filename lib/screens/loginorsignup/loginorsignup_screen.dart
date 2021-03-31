import 'package:flutter/material.dart';
import 'package:freedom/constants.dart';
import 'package:freedom/screens/login/login_screen.dart';

class Loginorsignup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/Logo_light.png",
              height: size.height * 0.3,
            ),
            SizedBox(
              height: 50,
            ),
            Text("Do you have an account ?",
                style: TextStyle(
                  fontSize: 20,
                )),
            SizedBox(
              height: 25,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              padding: EdgeInsets.all(20),
              color: kPrimaryColor,
              minWidth: size.width / 2,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
              child: Text(
                "Log In",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Text("Or are you new to here ?",
                style: TextStyle(
                  fontSize: 20,
                )),
            SizedBox(
              height: 25,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              padding: EdgeInsets.all(20),
              color: kSecondaryColor,
              minWidth: size.width / 2,
              onPressed: () {},
              child: Text(
                "Sign Up",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
