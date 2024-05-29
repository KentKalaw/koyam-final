// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MyMacroWidget extends StatelessWidget {
  final String title;
  final int value;
  final IconData icon;
  final TextEditingController controller;
  const MyMacroWidget({
    required this.title,
    required this. value,
    required this.icon,
    required this.controller,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return  Expanded(
              child:
              Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1, 1),
                    blurRadius: 2,
                  ),
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    FaIcon(
                      icon,
                      color: Colors.redAccent,
                      ),
                      const SizedBox(height: 4),
                      TextField(
                        controller: controller,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(fontSize: 12),
                        decoration: InputDecoration(
                          isDense: true,
                          suffixText: title == "Calories"
                          ? ''
                          : 'g',
                          contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                      const SizedBox(height: 8),
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            );
  }
}