import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인 페이지'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('시작'),
          onPressed:(){
            Navigator.pushNamed(context, '/room');
          },
        ),
      ),
    );
  }
}