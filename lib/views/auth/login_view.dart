import 'package:flutter/material.dart';
import '../../shared/widgets/widgets.dart';
import 'widgets/auth_logo.dart';
import 'register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _obscurePassword = true;

  final _formKey = GlobalKey<FormState>(); 
  final Color primaryGreen = const Color(0xFF1A4331);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const AuthLogo(),
                    const SizedBox(height: 24),

                    //txts
                    const Text(
                      'Bienvenido',
                      style: TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Ingresa a tu cuenta para gestionar tus prendas\ny pedidos a medida.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Color(0xFF64748B), height: 1.5),
                    ),
                    const SizedBox(height: 32),

                    // campo correo
                    CustomTextField(
                      label: 'Correo electrónico',
                      hint: 'ejemplo@correo.com',
                      icon: Icons.mail_outline,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'El correo es obligatorio';
                        }
                        if (!value.contains('@')) {
                          return 'Por favor ingresa un correo válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // campo clave
                    CustomTextField(
                      label: 'Contraseña',
                      hint: '••••••••',
                      icon: Icons.lock_outline,
                      obscureText: _obscurePassword,
                      showForgotLink: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'La contraseña es obligatoria';
                        }
                        return null;
                      },
                      onToggleVisibility: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    const SizedBox(height: 28),

                    // btn login
                    PrimaryButton(
                      text: 'Iniciar Sesión',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          //TODO enrutamiento
                        }
                      },
                    ),
                    const SizedBox(height: 24),

                    // separador
                    Row(
                      children: const [
                        Expanded(child: Divider(color: Color(0xFFE2E8F0), thickness: 1)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'O continuar con',
                            style: TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: Color(0xFFE2E8F0), thickness: 1)),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // btn sociales
                    SocialButton(
                      text: 'Continuar con Google',
                      icon: const Icon(Icons.g_mobiledata, color: Colors.red, size: 32),
                      onPressed: () {
                        //TODO Google Sign-In
                      },
                    ),
                    const SizedBox(height: 12),
                    
                    SocialButton(
                      text: 'Continuar con Apple',
                      icon: const Icon(Icons.apple, color: Colors.black, size: 24),
                      onPressed: () {
                        //TODO Apple Sign-In
                      },
                    ),
                    const SizedBox(height: 32),

                    // footer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('¿No tienes una cuenta? ', style: TextStyle(color: Color(0xFF64748B), fontSize: 14)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const RegisterView()),
                            );
                          },
                          child: Text(
                            'Regístrate aquí',
                            style: TextStyle(color: primaryGreen, fontWeight: FontWeight.bold, fontSize: 14),
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