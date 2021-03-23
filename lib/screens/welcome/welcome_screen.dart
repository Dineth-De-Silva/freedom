import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:freedom/screens/loginorsignup/loginorsignup_screen.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            Image.asset(
              "assets/images/welcome_image.png",
              height: size.height / 2,
            ),
            SizedBox(height: 60),
            Text("Welcome to our freedom messaging app",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                )),
            SizedBox(height: 25),
            Text("Freedom talk any person of your mother language",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                )),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: FittedBox(
                child: TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => Loginorsignup(),
                      //   ),
                      // );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text(
                            "Skip",
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.arrow_forward_ios, size: 15)
                        ],
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
