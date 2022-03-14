import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swapi/src/providers/character_provider.dart';
import 'package:swapi/src/providers/login_provider.dart';
import 'package:swapi/src/screens/login/widgets/background/background.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _visible = false;

  @override
  void initState() {
    startAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const BackGround(),
              AnimatedOpacity(
                opacity: _visible ? 1.0 : 0.0,
                duration: Duration(seconds: 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: form(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card card() {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: form(),
        ));
  }

  startAnimation() {
    Future.delayed(const Duration(seconds: 5), () {
      _visible = !_visible;
      setState(() {});
    });
  }
}

class form extends StatefulWidget {
  @override
  State<form> createState() => _formState();
}

class _formState extends State<form> {
  final _formKey = GlobalKey<FormState>();

  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    final _loginProvider = Provider.of<LoginProvider>(context);
    late String user;
    late String pass;
    final TextEditingController _userController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    return Column(
      children: [
        Text("Identifíquese", style: TextStyle(color: Colors.white)),
        SizedBox(
          height: 20,
        ),
        Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: "Personaje",
                    labelStyle: TextStyle(color: Colors.white)),
                controller: _userController,
                onChanged: (value) {
                  user = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Ingrese el usuario");
                  }
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "****",
                    labelText: "Contraseña",
                    labelStyle: TextStyle(color: Colors.white),
                    suffixIcon: Container(
                      margin: EdgeInsets.only(right: 20),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _visible = !_visible;
                          });
                        },
                        child: !_visible
                            ? const Icon(Icons.remove_red_eye)
                            : const Icon(Icons.remove_red_eye_outlined),
                      ),
                    )),
                obscureText: _visible,
                controller: _passwordController,
                enableInteractiveSelection: true,
                onChanged: (value) {},
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Ingrese la contraseña");
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              _loginProvider.isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.black)),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Ir al lado oscuro ",
                          style: TextStyle(
                              color: Color.fromRGBO(239, 219, 0, 1),
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (await _loginProvider.validateLogin(
                              _userController.text, _passwordController.text)) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              'home',
                              (route) => false,
                            );
                          } else {
                            _showToast(context);
                          }
                        }
                      },
                    )
            ]))
      ],
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      const SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          'Usuario o contraseña incorrectos',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
