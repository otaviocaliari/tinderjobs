import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tinderjobs/ui/screens/login/login_model.dart';
import 'package:tinderjobs/ui/styles/fonts.dart';
import 'package:tinderjobs/ui/widgets/button.dart';

class Login extends StatelessWidget {
  static const routeName = "/login";

  @override
  Widget build(BuildContext context) {
    return Background(
      imagePath: "assets/images/login_background.jpg",
      overlayColor: Colors.black,
      child: Column(
        children: [
          Expanded(
            child: LoginForm(),
          ),
          Footer()
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: LoginModel(),
      child: Consumer<LoginModel>(
        builder: (context, model, child) => Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Text(
                      "JobTinder",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Righteous",
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                  InputField(
                    placeholder: "Email",
                    controller: emailController,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: InputField(
                      placeholder: "Password",
                      controller: passwordController,
                      obscure: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, right: 30.0, left: 30.0),
                    child: Container(
                      height: 54.0,
                      child: Button(
                        color: Colors.transparent,
                        splashColor: Colors.white24,
                        loading: model.loading,
                        onTap: model.loading
                            ? null
                            : () => model.login(emailController.text,
                                passwordController.text, context),
                        child: Fonts.montserrat(
                          "Login",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, right: 30.0, left: 30.0),
      child: Container(
        alignment: Alignment.center,
        height: 40.0,
        child: Button(
          onTap: () {},
          borderColor: Colors.transparent,
          splashColor: Colors.white24,
          gradient: const LinearGradient(
            colors: [Colors.black26, Colors.transparent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          child: Fonts.montserrat(
            "Não possui uma conta? Crie uma!",
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  final Widget child;
  final Color overlayColor;
  final String imagePath;

  Background({this.child, this.imagePath, this.overlayColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            overlayColor.withOpacity(0.8),
            BlendMode.luminosity,
          ),
        ),
      ),
      child: child,
    );
  }
}

class InputField extends StatelessWidget {
  final String placeholder;
  final bool obscure;
  final TextEditingController controller;

  InputField({this.placeholder, this.controller, this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: placeholder,
          border: InputBorder.none,
        ),
        obscureText: obscure,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: "Montserrat",
        ),
      ),
    );
  }
}
