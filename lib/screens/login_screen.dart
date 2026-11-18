import 'package:flutter/material.dart';
import 'package:responsive_login_screen/controllers/login_controller.dart';
import 'package:responsive_login_screen/widgets/app_logo.dart';
import 'package:responsive_login_screen/widgets/text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controller = LoginController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Snackbar needs context, so it stay in the UI
  void _handleLogin() {
    FocusScope.of(context).unfocus();
    if (_controller.login()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Login successful! (Remember me: ${_controller.rememberMe ? "ON" : "OFF"})',
          ),
        ),
      );
    }
  }

  void _forgotPassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password reset link sent (demo)')),
    );
  }

  void _signUp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sign up screen coming soon!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _controller.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const AppLogo(),
                    const SizedBox(height: 24),
                    const Text(
                      'Welcome Back',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sign in to continue to your account',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 32),
                    AppTextField(
                      controller: _controller.emailController,
                      label: 'Email',
                      hint: 'Enter your email',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: _controller.validateEmail,
                    ),
                    const SizedBox(height: 16),
                    // Rebuilds only this field when visibility toggles
                    ListenableBuilder(
                      listenable: _controller,
                      builder: (context, _) {
                        return AppTextField(
                          controller: _controller.passwordController,
                          label: 'Password',
                          hint: 'Enter your password',
                          prefixIcon: Icons.lock_outline,
                          obscureText: _controller.obscurePassword,
                          validator: _controller.validatePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _controller.obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                            onPressed: _controller.togglePasswordVisibility,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ListenableBuilder(
                          listenable: _controller,
                          builder: (context, _) {
                            return GestureDetector(
                              onTap: _controller.toggleRememberMe,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                    value: _controller.rememberMe,
                                    onChanged: (v) =>
                                        _controller.toggleRememberMe(v),
                                  ),
                                  const Text('Remember me'),
                                ],
                              ),
                            );
                          },
                        ),
                        TextButton(
                          onPressed: _forgotPassword,
                          child: const Text('Forgot Password?'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _handleLogin,
                      child: const Text('Login'), // styled by theme
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: _signUp,
                          child: const Text('Sign Up'),
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
