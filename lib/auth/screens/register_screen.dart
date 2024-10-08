import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:izikho/common/utils/snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../providers/auth_methods_provider.dart';
import '../../common/utils/validators/validator.dart';
import '../../common/widgets/my_button.dart';
import '../../common/widgets/my_textfield_widget.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulHookConsumerWidget {
  static const routename = 'register_screen';
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  late  ValueNotifier<bool> _loading;
  late  TextEditingController _usernameController;
  late  TextEditingController _emailController;
  late  TextEditingController _passwordController;

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      try {
        _loading.value = true;
        await ref.read(authMethodsProvider).register(
              _usernameController.text.trim(),
              _emailController.text.trim(),
              _passwordController.text.trim(),
            );
        _loading.value = false;
      } on AuthException catch (e) {
        _loading.value = false;
        if (mounted) {
          context.showSnackBar(e.message);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _loading = useState(false);
    _usernameController = useTextEditingController();
    _emailController = useTextEditingController();
    _passwordController = useTextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Register",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 20),
                    MyTextFieldWidget(
                      controller: _usernameController,
                      labelText: "Username",
                      validator: Validator.required,
                    ),
                    const SizedBox(height: 20),
                    MyTextFieldWidget(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      labelText: "Email",
                      validator: Validator.emailValidator,
                    ),
                    const SizedBox(height: 20),
                    MyTextFieldWidget(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: true,
                      labelText: "Password",
                    ),
                    const SizedBox(height: 20),
                    MyButtonWidget(
                      label: _loading.value ? "Signing Up" : "Sign Up",
                      onPressed: _loading.value
                          ? null
                          : _register,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Have an account?"),
                        TextButton(
                          onPressed: () => context.goNamed(LoginScreen.routename),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
