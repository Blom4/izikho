import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:izikho/auth/providers/auth_provider.dart';
import 'package:izikho/common/utils/snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../common/widgets/my_button.dart';
import '../../common/widgets/my_textfield_widget.dart';
import '../../common/utils/validators/validator.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulHookConsumerWidget {
  static const routename = 'login_screen';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  late ValueNotifier<bool> _loading;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  Future<void> _login() async {
    if (formKey.currentState!.validate()) {
      try {
        _loading.value = true;
        await ref.read(authMethodsProvider).login(
              _emailController.text.trim(),
              _passwordController.text.trim(),
            );
      } on AuthException catch (e) {
        if (mounted) {
          context.showSnackBar(e.message);
        }
      } finally {
        _loading.value = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _loading = useState(false);
    _emailController = useTextEditingController();
    _passwordController = useTextEditingController();

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: Theme.of(context).textTheme.headlineLarge,
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
                    label: _loading.value ? "Logging In" : "Login",
                    onPressed: _loading.value ? null : _login,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have account?"),
                      TextButton(
                        onPressed: () =>
                            context.goNamed(RegisterScreen.routename),
                        child: const Text(
                          "Register",
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
    );
  }
}
