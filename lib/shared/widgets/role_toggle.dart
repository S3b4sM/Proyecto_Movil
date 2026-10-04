import 'package:flutter/material.dart';

class RoleToggle extends StatelessWidget {
  final bool isClientMode;
  final ValueChanged<bool> onChanged;

  const RoleToggle({
    super.key,
    required this.isClientMode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final primaryGreen = const Color(0xFF1A4331);
    final textGrey = const Color(0xFF64748B);

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(true),
              child: Container(
                decoration: BoxDecoration(
                  color: isClientMode ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: isClientMode 
                      ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))] 
                      : null,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_outline, size: 18, color: isClientMode ? primaryGreen : textGrey),
                      const SizedBox(width: 8),
                      Text('Soy Cliente', style: TextStyle(color: isClientMode ? primaryGreen : textGrey, fontWeight: isClientMode ? FontWeight.bold : FontWeight.normal)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onChanged(false),
              child: Container(
                decoration: BoxDecoration(
                  color: !isClientMode ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: !isClientMode 
                      ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))] 
                      : null,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cut_outlined, size: 18, color: !isClientMode ? primaryGreen : textGrey),
                      const SizedBox(width: 8),
                      Text('Soy Sastre', style: TextStyle(color: !isClientMode ? primaryGreen : textGrey, fontWeight: !isClientMode ? FontWeight.bold : FontWeight.normal)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}