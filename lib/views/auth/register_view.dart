import 'package:flutter/material.dart';
import '../../shared/widgets/widgets.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool isClientMode = true;
  
  // estados formularios
  bool _acceptTerms = false;
  bool _obscurePassword = true;
  String? _selectedSpecialty;
  
  // llaves para validación
  final _clientFormKey = GlobalKey<FormState>();
  final _tailorFormKey = GlobalKey<FormState>();

  final Color primaryGreen = const Color(0xFF1A4331);
  final Color textGrey = const Color(0xFF64748B);
  final Color bgColor = const Color(0xFFF8FAFC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: isClientMode 
            ? const Text('PASO 1 DE 2', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2))
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF1A4331), shape: BoxShape.circle)),
                  const SizedBox(width: 8),
                  const Text('CUENTA PROFESIONAL', style: TextStyle(color: Color(0xFF1A4331), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                ],
              ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // HEADER
              _buildHeaderIcon(),
              const SizedBox(height: 20),
              
              Text(
                isClientMode ? 'Crear cuenta' : 'Registra tu Taller',
                style: const TextStyle(fontFamily: 'Georgia', fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
              ),
              const SizedBox(height: 12),
              
              Text(
                isClientMode 
                    ? 'Únete para descubrir los mejores sastres, pedir\nprendas a medida y seguir tus encargos.'
                    : 'Publica tus servicios, gestiona clientes, agenda\ncitas y controla pedidos a medida.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: textGrey, height: 1.5),
              ),
              const SizedBox(height: 32),

              RoleToggle(
                isClientMode: isClientMode,
                onChanged: (bool value) {
                  setState(() => isClientMode = value);
                },
              ),
              const SizedBox(height: 32),

              // forms dinamicos
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: isClientMode ? _buildClientForm() : _buildTailorForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderIcon() {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: primaryGreen,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(isClientMode ? Icons.cut : Icons.storefront, color: Colors.white, size: 32),
          Positioned(
            bottom: -2,
            right: -2,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: isClientMode ? const Color(0xFFFBBF24) : const Color(0xFF10B981),
                shape: BoxShape.circle,
                border: Border.all(color: bgColor, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // form cliente
  Widget _buildClientForm() {
    return Form(
      key: _clientFormKey,
      child: Column(
        children: [
          CustomTextField(
            label: 'NOMBRE COMPLETO', 
            hint: 'Ej. Camila Morales', 
            icon: Icons.badge_outlined,
            validator: (value) => value == null || value.isEmpty ? 'Requerido' : null,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'CORREO ELECTRÓNICO', 
            hint: 'ejemplo@correo.com', 
            icon: Icons.mail_outline, 
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Requerido';
              if (!value.contains('@')) return 'Correo inválido';
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'TELÉFONO MÓVIL (WHATSAPP)', 
            hint: '+57 300 123 4567', 
            icon: Icons.phone_outlined, 
            keyboardType: TextInputType.phone,
            validator: (value) => value == null || value.isEmpty ? 'Requerido' : null,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'CIUDAD O DIRECCIÓN', 
            hint: 'Ej. Valledupar, Colombia', 
            icon: Icons.location_on_outlined,
            validator: (value) => value == null || value.isEmpty ? 'Requerido' : null,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'CREAR CONTRASEÑA', 
            hint: 'Mínimo 8 caracteres', 
            icon: Icons.lock_outline,
            obscureText: _obscurePassword,
            onToggleVisibility: () => setState(() => _obscurePassword = !_obscurePassword),
            validator: (value) => value == null || value.length < 8 ? 'Mínimo 8 caracteres' : null,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Checkbox(
                value: _acceptTerms,
                activeColor: primaryGreen,
                onChanged: (val) => setState(() => _acceptTerms = val ?? false),
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Color(0xFF64748B), fontSize: 13),
                    children: [
                      const TextSpan(text: 'Acepto los '),
                      TextSpan(text: 'Términos del Servicio', style: TextStyle(color: primaryGreen, decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
                      const TextSpan(text: ' y la '),
                      TextSpan(text: 'Política de Privacidad', style: TextStyle(color: primaryGreen, decoration: TextDecoration.underline, fontWeight: FontWeight.bold)),
                      const TextSpan(text: '.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            text: 'REGISTRARME COMO CLIENTE',
            onPressed: () {
              if (_clientFormKey.currentState!.validate() && _acceptTerms) {
                //TODO hacer conexion a la base
              } else if (!_acceptTerms) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Debes aceptar los términos y condiciones')),
                );
              }
            },
          ),
          _buildFooterLogin(),
        ],
      ),
    );
  }

  // form admin
  Widget _buildTailorForm() {
    return Form(
      key: _tailorFormKey,
      child: Column(
        children: [
          CustomTextField(
            label: 'NOMBRE DEL MAESTRO / SASTRE', 
            hint: 'Ej. Manuel Antonio Gómez', 
            icon: Icons.person_outline,
            validator: (value) => value == null || value.isEmpty ? 'Requerido' : null,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'NOMBRE DEL TALLER O SASTRERÍA', 
            hint: 'Ej. El Taller de Don Manuel', 
            icon: Icons.storefront_outlined,
            validator: (value) => value == null || value.isEmpty ? 'Requerido' : null,
          ),
          const SizedBox(height: 20),
          
          SpecialtyDropdown(
            value: _selectedSpecialty,
            onChanged: (String? val) {
              setState(() => _selectedSpecialty = val);
            },
          ),
          const SizedBox(height: 20),
          
          CustomTextField(
            label: 'DIRECCIÓN DEL LOCAL / TALLER', 
            hint: 'Calle 12 # 8-45, Valledupar', 
            icon: Icons.location_on_outlined,
            validator: (value) => value == null || value.isEmpty ? 'Requerido' : null,
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomTextField(
                  label: 'WHATSAPP TALLER', 
                  hint: '+57 300 123 4567', 
                  icon: Icons.phone_outlined, 
                  keyboardType: TextInputType.phone,
                  validator: (value) => value == null || value.isEmpty ? 'Requerido' : null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: CustomTextField(
                  label: 'AÑOS EXPERIENCIA', 
                  hint: 'Ej. 15', 
                  icon: Icons.workspace_premium_outlined, 
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty ? 'Requerido' : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'CORREO ELECTRÓNICO', 
            hint: 'contacto@sasteriadonmanuel.com', 
            icon: Icons.alternate_email, 
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Requerido';
              if (!value.contains('@')) return 'Correo inválido';
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: 'CONTRASEÑA', 
            hint: 'Mínimo 8 caracteres', 
            icon: Icons.lock_outline,
            obscureText: _obscurePassword,
            onToggleVisibility: () => setState(() => _obscurePassword = !_obscurePassword),
            validator: (value) => value == null || value.length < 8 ? 'Mínimo 8 caracteres' : null,
          ),
          const SizedBox(height: 32),
          PrimaryButton(
            text: 'REGISTRAR MI TALLER',
            onPressed: () {
              if (_tailorFormKey.currentState!.validate() && _selectedSpecialty != null) {
                //TODO crear en la base
              } else if (_selectedSpecialty == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Por favor selecciona una especialidad')),
                );
              }
            },
          ),
          _buildFooterLogin(),
        ],
      ),
    );
  }

  // footer
  Widget _buildFooterLogin() {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('¿Ya tienes una cuenta registrada? ', style: TextStyle(color: Color(0xFF64748B), fontSize: 14)),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text('Inicia sesión', style: TextStyle(color: Color(0xFF1A4331), fontWeight: FontWeight.bold, fontSize: 14)),
          ),
        ],
      ),
    );
  }
}