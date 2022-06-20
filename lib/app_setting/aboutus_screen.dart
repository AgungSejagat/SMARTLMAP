import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CLARA"),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/images/LOGO BINUS COMPENG.jpg',
          ),
          Text('Kami Mahasiswa Binus University Jurusan Computer Engineering'),
          Text('membuat aplikasi untuk mengontrol sebuah lampu pintar'),
        ],
      ),
    );
  }
}
