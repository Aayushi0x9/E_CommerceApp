import 'package:e_commerce_app/Views/LogIn/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/spbg.jpg'), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'WallPaper App',
              style: TextStyle(
                shadows: [
                  Shadow(
                      color: Colors.black, offset: Offset(0, 3), blurRadius: 2),
                ],
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
                fontSize: 32,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TweenAnimationBuilder(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 1500),
              builder: (context, value, child) {
                return Column(
                  children: [
                    SizedBox(
                      height: 3,
                      width: 300,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: LinearProgressIndicator(
                          value: value,
                          color: Colors.white,
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      '${(value * 100).toInt().toString()}%',
                      style: TextStyle(
                        shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(0, 3),
                              blurRadius: 2),
                        ],
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
