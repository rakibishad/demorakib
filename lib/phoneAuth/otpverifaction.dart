import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'dart:async';


import 'package:flutter/services.dart';


import 'package:otp_pin_field/otp_pin_field.dart';



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class OtpScreen extends StatefulWidget {
  bool _isInit = true;
  var _contact = '';

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late String smsOTP;
  late String verificationId;
  String errorMessage = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _otpPinFieldKey = GlobalKey<OtpPinFieldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget._isInit) {
      widget._contact = '${ModalRoute.of(context)?.settings.arguments as String}';
      generateOtp(widget._contact);
      widget._isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.05),
                Image.asset('assets/images/logon.png', width: screenWidth * 0.6),
                SizedBox(height: screenHeight * 0.03),
                Image.asset('assets/images/registration.png', height: screenHeight * 0.25),
                SizedBox(height: screenHeight * 0.03),
                const Text(
                  'Verification',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  'Enter the 6-digit code sent to ${widget._contact}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
                SizedBox(height: screenHeight * 0.04),

                // OTP Field
                Container(
                 // width: double.infinity, // Set desired width
                //  height: double.infinity, // Set desired height
                  alignment: Alignment.center, // Optional: to center the child inside Container
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 370),
                      child: OtpPinField(
                        key: _otpPinFieldKey,
                        maxLength: 6,
                        fieldWidth: 46,
                        textInputAction: TextInputAction.done,
                        otpPinFieldStyle: OtpPinFieldStyle(
                          fieldBorderRadius: 4.0,
                          defaultFieldBorderColor: Colors.grey,
                          activeFieldBorderColor: Colors.green,
                          fieldPadding: 7.0,
                        ),
                        onSubmit: (text) {
                          smsOTP = text;
                        },
                        onChange: (text) {},
                      ),
                    ),
                  ),
                ),


                SizedBox(height: screenHeight * 0.04),

                // Verify Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: verifyOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFDBC33),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(36),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Verify',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> generateOtp(String contact) async {
    final PhoneCodeSent smsOTPSent = (verId, forceResendingToken) {
      verificationId = verId;
    };
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: contact,
        codeAutoRetrievalTimeout: (String verId) {
          verificationId = verId;
        },
        codeSent: smsOTPSent,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (AuthCredential phoneAuthCredential) {},
        verificationFailed: (error) {
          print(error);
        },
      );
    } catch (e) {
      handleError(e as PlatformException);
    }
  }

  Future<void> verifyOtp() async {
    if (smsOTP.isEmpty) {
      showAlertDialog(context, 'Please enter the 6-digit OTP');
      return;
    }

    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final UserCredential user = await _auth.signInWithCredential(credential);
      final User? currentUser = _auth.currentUser;
      assert(user.user?.uid == currentUser?.uid);
      Navigator.pushReplacementNamed(context, '/homeScreen');
    } on PlatformException catch (e) {
      handleError(e);
    } catch (e) {
      print('error $e');
    }
  }

  void handleError(PlatformException error) {
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          errorMessage = 'Invalid Code';
        });
        showAlertDialog(context, 'Invalid Code');
        break;
      default:
        showAlertDialog(context, error.message ?? 'Error');
        break;
    }
  }

  void showAlertDialog(BuildContext context, String message) {
    final CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: const Text('Error'),
      content: Text('\n$message'),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Ok'),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) => alert,
    );
  }
}
