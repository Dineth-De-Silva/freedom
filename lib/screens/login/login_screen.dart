import 'package:flutter/material.dart';
import 'package:freedom/constants.dart';
import 'package:freedom/screens/loginorsignup/loginorsignup_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:country_code_picker/country_code_picker.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool codeSent = false;
  bool invalidAccount = false;
  bool invalidOtp = false;
  String contryCode = "+94";
  String number = "";
  var phoneIn = TextEditingController();
  var otpIn = TextEditingController();
  String phoneNo;
  String otp = "";
  String verificationId;

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified =
        (AuthCredential authResult) async {
      await FirebaseAuth.instance.signInWithCredential(authResult).then((user) {
        if (user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Loginorsignup(),
            ),
          );
        }
      });
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phoneNo,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Log In",
                  style: GoogleFonts.pacifico(
                      textStyle: Theme.of(context).textTheme.headline5)),
              SizedBox(
                height: 25,
              ),
              Image.asset(
                "assets/images/Logo_light.png",
                height: size.height * 0.3,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                codeSent
                    ? invalidOtp
                        ? "Otp you entered is incorect !"
                        : "* We sent an otp to your phone number ($phoneNo)"
                    : invalidAccount
                        ? "Can't find your phone number !"
                        : "* Enter a valid phone number with country code (+94715178998)",
                style: TextStyle(
                    fontSize: 15,
                    color: codeSent
                        ? invalidOtp
                            ? kErrorColor
                            : Colors.black87
                        : invalidAccount
                            ? kErrorColor
                            : Colors.black87),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                  codeSent
                      ? "Enter the otp you recieved"
                      : "What is your phone number ?",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor)),
              SizedBox(
                height: 25,
              ),
              codeSent
                  ? Container(
                      width: size.width * 0.5,
                      child: TextField(
                        controller: otpIn,
                        onChanged: (val) {
                          otp = val;
                        },
                        autofocus: true,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                            fontSize: 35,
                            color: invalidOtp ? kErrorColor : Colors.black87),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CountryCodePicker(
                            onChanged: (value) {
                              contryCode = value.toString();
                            },
                            initialSelection: contryCode,
                            favorite: ['US'],
                            textStyle: TextStyle(
                                fontSize: 35,
                                color: invalidAccount
                                    ? kErrorColor
                                    : Colors.black87)),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: size.width * 0.35,
                          child: TextField(
                            controller: phoneIn,
                            onChanged: (val) {
                              number = val;
                              phoneNo = contryCode + val;
                            },
                            autofocus: true,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                                fontSize: 35,
                                color: invalidAccount
                                    ? kErrorColor
                                    : Colors.black87),
                          ),
                        ),
                      ],
                    ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: size.width / 2,
                child: Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.black87,
                      ),
                      onPressed: () {
                        codeSent
                            ? setState(() {
                                codeSent = false;
                                otpIn.text = otp;
                              })
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Loginorsignup(),
                                ),
                              );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Icon(Icons.navigate_before),
                            SizedBox(width: 5),
                            Text("Back"),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        padding: EdgeInsets.all(20),
                        color: kPrimaryColor,
                        onPressed: () async {
                          if (codeSent) {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithCredential(
                                      PhoneAuthProvider.credential(
                                          verificationId: verificationId,
                                          smsCode: otp))
                                  .then((user) {
                                if (user != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Loginorsignup(),
                                    ),
                                  );
                                }
                              });
                            } catch (e) {
                              setState(() {
                                invalidOtp = true;
                              });
                            }
                          } else {
                            verifyPhone(phoneNo);
                          }
                        },
                        child: Text(
                          codeSent ? "Log in" : "Verify",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              codeSent
                  ? Container()
                  : FittedBox(
                      child: Row(
                        children: [
                          Text("Are you new to here ?",
                              style: TextStyle(
                                fontSize: 20,
                              )),
                          SizedBox(width: 5),
                          TextButton(
                            onPressed: () {},
                            child: Text("Sign Up"),
                            style: TextButton.styleFrom(
                              primary: kSecondaryColor,
                            ),
                          )
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
