import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool obscureText;
  final bool showForgotLink;
  final VoidCallback? onToggleVisibility;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.showForgotLink = false,
    this.onToggleVisibility,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final primaryGreen = const Color(0xFF1A4331);
    final textGrey = const Color(0xFF64748B);
    final inputBorder = const Color(0xFFE2E8F0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
            ),
            if (showForgotLink)
              GestureDetector(
                onTap: () {},
                child: Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(fontSize: 13, color: primaryGreen, fontWeight: FontWeight.w500),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: textGrey.withOpacity(0.7), fontSize: 15),
            prefixIcon: Icon(icon, color: textGrey, size: 20),
            suffixIcon: onToggleVisibility != null
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: textGrey,
                      size: 20,
                    ),
                    onPressed: onToggleVisibility,
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: inputBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: primaryGreen, width: 1.5),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }
}