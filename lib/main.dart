import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppTheme.themeData, // ← all styling comes from here
      home: const LoginScreen(),
    );
  }
}

// void main() {
//   runApp(const LoginApp());
// }

// class LoginApp extends StatelessWidget {
//   const LoginApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Login App',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E3A8A)),
//         useMaterial3: true,
//       ),
//       home: const LoginScreen(),
//     );
//   }
// }

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   // ── Form & controllers ──
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   // ── UI state ──
//   bool _obscurePassword = true;
//   bool _rememberMe = false;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   // ── Validation (Requirement 3) ──
//   String? _validateEmail(String? value) {
//     if (value == null || value.trim().isEmpty) {
//       return 'Email is required';
//     }
//     final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//     if (!emailRegex.hasMatch(value.trim())) {
//       return 'Enter a valid email address';
//     }
//     return null;
//   }

//   String? _validatePassword(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Password is required';
//     }
//     if (value.length < 6) {
//       return 'Password must be at least 6 characters';
//     }
//     return null;
//   }

//   // ── Button actions (Requirement 4) ──
//   void _login() {
//     FocusScope.of(context).unfocus(); // hide keyboard first
//     if (_formKey.currentState!.validate()) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Login successful! (Remember me: ${_rememberMe ? "ON" : "OFF"})',
//           ),
//         ),
//       );
//     }
//   }

//   void _forgotPassword() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Password reset link sent (demo)')),
//     );
//   }

//   void _signUp() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Sign up screen coming soon!')),
//     );
//   }

//   // Shared field styling so both inputs look identical
//   InputDecoration _fieldDecoration({
//     required String label,
//     required String hint,
//     required Widget prefixIcon,
//     Widget? suffixIcon,
//   }) {
//     return InputDecoration(
//       labelText: label,
//       hintText: hint,
//       prefixIcon: prefixIcon,
//       suffixIcon: suffixIcon,
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: Colors.grey.shade400),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(color: Color(0xFF1E3A8A), width: 2),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(color: Colors.red),
//       ),
//       filled: true,
//       fillColor: Colors.white,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF3F5F9),
//       body: SafeArea(
//         child: Center(
//           // SingleChildScrollView prevents overflow when the
//           // keyboard opens or on small screens (Requirement 5)
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(24),
//             child: ConstrainedBox(
//               constraints: const BoxConstraints(maxWidth: 420),
//               child: Form(
//                 key: _formKey,
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     // ── 1. Heading & welcome message ──
//                     CircleAvatar(
//                       radius: 36,
//                       backgroundColor:
//                           const Color(0xFF1E3A8A).withOpacity(0.1),
//                       child: const Icon(Icons.lock_outline,
//                           size: 36, color: Color(0xFF1E3A8A)),
//                     ),
//                     const SizedBox(height: 24),
//                     const Text(
//                       'Welcome Back',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           fontSize: 28, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Sign in to continue to your account',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           fontSize: 15, color: Colors.grey[700]),
//                     ),
//                     const SizedBox(height: 32),

//                     // ── 2. Email field ──
//                     TextFormField(
//                       controller: _emailController,
//                       keyboardType: TextInputType.emailAddress,
//                       decoration: _fieldDecoration(
//                         label: 'Email',
//                         hint: 'Enter your email',
//                         prefixIcon: const Icon(Icons.email_outlined),
//                       ),
//                       validator: _validateEmail,
//                     ),
//                     const SizedBox(height: 16),

//                     // ── 2. Password field with visibility toggle ──
//                     TextFormField(
//                       controller: _passwordController,
//                       obscureText: _obscurePassword,
//                       decoration: _fieldDecoration(
//                         label: 'Password',
//                         hint: 'Enter your password',
//                         prefixIcon: const Icon(Icons.lock_outline),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             _obscurePassword
//                                 ? Icons.visibility_off_outlined
//                                 : Icons.visibility_outlined,
//                           ),
//                           onPressed: () => setState(
//                             () => _obscurePassword = !_obscurePassword,
//                           ),
//                         ),
//                       ),
//                       validator: _validatePassword,
//                     ),
//                     const SizedBox(height: 8),

//                     // ── Remember me + Forgot Password ──
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         GestureDetector(
//                           onTap: () => setState(
//                               () => _rememberMe = !_rememberMe),
//                           child: Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Checkbox(
//                                 value: _rememberMe,
//                                 activeColor: const Color(0xFF1E3A8A),
//                                 onChanged: (value) => setState(
//                                     () => _rememberMe = value ?? false),
//                               ),
//                               const Text('Remember me'),
//                             ],
//                           ),
//                         ),
//                         TextButton(
//                           onPressed: _forgotPassword,
//                           child: const Text('Forgot Password?'),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),

//                     // ── 4. Login button ──
//                     ElevatedButton(
//                       onPressed: _login,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF1E3A8A),
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12)),
//                       ),
//                       child: const Text('Login',
//                           style: TextStyle(fontSize: 16)),
//                     ),
//                     const SizedBox(height: 16),

//                     // ── 1. Sign Up option ──
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text("Don't have an account?"),
//                         TextButton(
//                           onPressed: _signUp,
//                           child: const Text('Sign Up'),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
