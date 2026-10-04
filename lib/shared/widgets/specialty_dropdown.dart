import 'package:flutter/material.dart';

class SpecialtyDropdown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;

  const SpecialtyDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final primaryGreen = const Color(0xFF1A4331);
    final specialties = [
      'Trajes y Alta Sastrería a Medida',
      'Camisería y Pantalones',
      'Ajustes, Entalles y Arreglos',
      'Uniformes Ejecutivos y Médicos',
      'Vestidos de Gala y Ceremonia'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('ESPECIALIDAD DE CONFECCIÓN', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF64748B)),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.checkroom_outlined, color: Color(0xFF64748B), size: 20),
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: primaryGreen, width: 1.5)),
            filled: true,
            fillColor: Colors.white,
          ),
          hint: const Text('Selecciona una especialidad', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 15)),
          items: specialties.map((String val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(val, style: const TextStyle(fontSize: 14, color: Color(0xFF334155))),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}