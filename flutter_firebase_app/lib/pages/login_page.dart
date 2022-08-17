import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/services/auth_service.dart';
import 'package:provider/provider.dart';

const DEFAULT_EMAIL = 'teste@teste.com';
const DEFAULT_PASS = '123456';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController(text: DEFAULT_EMAIL);
  final senha = TextEditingController(text: DEFAULT_PASS);
  bool isLoading = false;
  bool escondeSenha = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    senha.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthService>(context);

    return Scaffold(
        body: SafeArea(
      child: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Login Page'),
                      Padding(
                        padding: EdgeInsets.all(24),
                        child: TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe o email corretamente!';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 24.0),
                        child: TextFormField(
                          controller: senha,
                          obscureText: escondeSenha,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Senha',
                            suffixIcon: InkWell(
                              child: Icon(escondeSenha
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onTap: () {
                                setState(() {
                                  escondeSenha = !escondeSenha;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informa sua senha!';
                            } else if (value.length < 6) {
                              return 'Sua senha deve ter no mínimo 6 caracteres';
                            }
                            return null;
                          },
                        ),
                      ),
                      ElevatedButton(
                          // onPressed: () => auth.login('teste@teste.com', '123456'),
                          onPressed: login,
                          child: const Text('Login'))
                    ],
                  ),
                ),
              ),
      ),
    ));
  }

  login() async {
    setState(() {
      isLoading = true;
    });

    try {
      await context.read<AuthService>().login(email.text, senha.text);
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message),
        backgroundColor: Colors.redAccent,
      ));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
