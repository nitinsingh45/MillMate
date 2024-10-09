import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class MyVerify extends StatefulWidget {
  const MyVerify({Key? key}) : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {
  final TextEditingController _pinController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String verificationId = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get the verification ID from the arguments
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    if (args != null) {
      verificationId = args['verificationId'];
    }
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    var code = "";

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img1.png',
                width: 250,
                height: 210,
              ),
              const SizedBox(height: 10),
              const Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "We need to register your phone!",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Pinput(
                length: 6,
                controller: _pinController,
                onChanged: (value) {
                  code = value;
                },
                showCursor: true,
                onCompleted: (pin) {
                  code = pin;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF444444),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    if (code.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter the OTP code."),
                        ),
                      );
                      return;
                    }

                    try {
                      print("Verification ID: $verificationId"); // Debug print
                      print("Entered OTP: $code"); // Debug print

                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                        verificationId: verificationId,
                        smsCode: code,
                      );

                      // Sign in the user with the credential
                      await auth.signInWithCredential(credential);

                      // Navigate to the Guide page upon successful verification
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        'home',
                        (route) => false,
                      );
                    } catch (e) {
                      print(
                          "Error signing in: $e"); // Print the error for debugging
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("Failed to verify OTP. Please try again."),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Verify Phone Number",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        'phone',
                        (route) => false,
                      );
                    },
                    child: const Text(
                      "Edit Phone Number?",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
