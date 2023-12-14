import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInController{
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim()
    );
    if (FirebaseAuth.instance.currentUser != null){
      print("user id: ${FirebaseAuth.instance.currentUser?.uid}");
    }

  }

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  TextEditingController getEmail(){
    return _emailController;
  }

  TextEditingController getPassword(){
    return _passwordController;
  }
}

class SignOutController{

  void signOut(){
    FirebaseAuth.instance.signOut();
  }

}