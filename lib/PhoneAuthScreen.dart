import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneController = TextEditingController(text: '+918051208207');
  final TextEditingController _codeController = TextEditingController();
  String? _verificationId;
  bool _isLoading = false;

  // Retry with backoff for handling too-many-requests errors
  Future<void> retryWithBackoff(Function operation, int maxAttempts, Duration delay) async {
    for (int attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        await operation();
        return;
      } catch (e) {
        if (e is FirebaseAuthException && e.code == 'too-many-requests') {
          if (attempt == maxAttempts) rethrow;
          await Future.delayed(delay * attempt);
        } else {
          rethrow;
        }
      }
    }
  }

  // Initiate phone number verification
  Future<void> _verifyPhoneNumber() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await retryWithBackoff(() async {
        await _auth.verifyPhoneNumber(
          phoneNumber: _phoneController.text,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await _auth.signInWithCredential(credential);
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Phone number automatically verified!')),
              );
            }
          },
          verificationFailed: (FirebaseAuthException e) {
            String message = 'Verification failed: ${e.message}';
            if (e.code == 'billing-not-enabled') {
              message = 'SMS verification requires a billing account. Please enable billing in Google Cloud Console.';
            } else if (e.code == 'too-many-requests') {
              message = 'Too many attempts. Please try again later.';
            }
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            }
          },
          codeSent: (String verificationId, int? resendToken) {
            setState(() {
              _verificationId = verificationId;
            });
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Verification code sent!')),
              );
            }
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            setState(() {
              _verificationId = verificationId;
            });
          },
          timeout: const Duration(seconds: 60),
        );
      }, 3, const Duration(seconds: 5));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Sign in with SMS code
  Future<void> _signInWithCode() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: _codeController.text,
      );
      await _auth.signInWithCredential(credential);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully signed in!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error signing in: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _auth.setLanguageCode('en'); // Avoid X-Firebase-Locale warning
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number (e.g., +918051208207)',
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _verifyPhoneNumber,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Send Verification Code'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _codeController,
              decoration: const InputDecoration(
                labelText: 'Verification Code',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading || _verificationId == null ? null : _signInWithCode,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Verify Code'),
            ),
          ],
        ),
      ),
    );
  }
}