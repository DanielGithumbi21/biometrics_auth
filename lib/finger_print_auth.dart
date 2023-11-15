import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class FingerprintAuth extends StatefulWidget {
  const FingerprintAuth({Key?key}):super(key: key);
  @override
  _fingerPrintAuthState createState () => _fingerPrintAuthState();

}

class _fingerPrintAuthState extends State<FingerprintAuth> {
  final auth = LocalAuthentication();
  String authorized = "Not Authorized";
  bool _canCheckBiometric = false;
  late List<BiometricType> _availableBiometric;

  Future <void> _authenticate () async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your finger to continue',
        options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
            useErrorDialogs: true,
            sensitiveTransaction: false),
      );
    } on PlatformException catch (e) {
print(e);
    }

    setState(() {
      authorized = authenticated? "Authorized successfully":"Failed to authorize";
    });
  }
Future <void> _checkBiometric () async {
    bool canCheckBiometric = false;
    try {
      canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
}

Future _getAvailableBiometrics () async {
    List<BiometricType> availableBiometrics = [];
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    setState(() {
      _availableBiometric = availableBiometrics;
    });
}
@override
  void initState () {
    _checkBiometric();
    _getAvailableBiometrics();

    super.initState();
}

@override
  Widget build (BuildContext build) {
    return Scaffold(
      backgroundColor: Colors.blue.shade600,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 50.0),
              child: Column (
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15.0),
                    child: const Text("Authenticate with your fingerprint instead of password", textAlign: TextAlign.center,style: TextStyle(color: Colors.white, height: 1.5),),

                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15.0),
                    width: double.infinity,
                      child: FloatingActionButton(
                        onPressed: _authenticate,
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                          child: Text("Authenticate",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
}

}