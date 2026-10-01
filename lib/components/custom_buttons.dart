import 'package:flutter/material.dart';

class CustomButtons extends StatelessWidget {
  final void Function()? onButtonTap;
  final String label;
  final IconData? buttonIcon;
  const CustomButtons({
    super.key,
    this.onButtonTap,
    this.buttonIcon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    // return Text(
    //   buttonLabel,
    //   style: TextStyle(
    //     color: Colors.white,
    //     fontWeight: FontWeight.bold,
    //     fontSize: 20,
    //   ),
    // );
    return InkWell(
      onTap: onButtonTap,
      child: Container(
        height: 50,
        width: 180,
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(15),
        ),
        child: buttonIcon == null
            ? Center(
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.white, size: 25),
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
