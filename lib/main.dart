import 'package:flutter/material.dart';
import 'package:portfolio/screens/home.dart';

void main() {
  runApp(const Portfolio());
}

class Portfolio extends StatelessWidget {
  const Portfolio({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Portfolio',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
            children: [
              const CircleAvatar(
                radius: 150.0,
                backgroundImage: AssetImage("images/nunosilva.jpg"),
              ),
              const Text(
                "Nuno Silva",
                style: TextStyle(
                  fontFamily: "Righteous",
                  fontSize: 80.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "FULLSTACK DEVELOPER",
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 40.0,
                  letterSpacing: 2.5,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 50.0,
                width: 450.0,
                child: Divider(
                  color: Colors.white70,
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              const Text(
                "PERSONAL INFORMATION",
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 30.0,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 50.0,
                width: 250.0,
                child: Divider(
                  color: Colors.white70,
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
              Expanded(
                child: Row(
                  children: const [
                    Text(
                      "Nationality: ",
                      style: TextStyle(
                        fontFamily: "Righteous",
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Portuguese",
                      style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 20.0,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: Row(
                  children: const [
                    Text(
                      "Email: ",
                      style: TextStyle(
                        fontFamily: "Righteous",
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "xnunosilva@gmail.com",
                      style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 20.0,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: Row(
                  children: const [
                    Text(
                      "LinkedIn: ",
                      style: TextStyle(
                        fontFamily: "Righteous",
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "linkedin.com/in/nunodiogosilva",
                      style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 20.0,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: Row(
                  children: const [
                    Text(
                      "Phone Number: ",
                      style: TextStyle(
                        fontFamily: "Righteous",
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "+351 936 901 566",
                      style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 20.0,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50.0,
                width: 250.0,
                child: Divider(
                  color: Colors.white70,
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              const Text(
                "Professional Experience",
                style: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 30.0,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 50.0,
                width: 250.0,
                child: Divider(
                  color: Colors.white70,
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
            ]
        ),
      ),
    );
  }
}

