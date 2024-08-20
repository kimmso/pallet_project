import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool enabled; // 버튼 활성화 여부를 위한 추가 속성

  const CustomElevatedButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 129, 132, 211),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: enabled ? onPressed : null,
      child: Text(text),
    );
  }
}
