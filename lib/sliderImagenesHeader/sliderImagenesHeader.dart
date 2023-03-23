import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prueba/header/header.dart';
import 'package:prueba/header/header_logged.dart';

import 'package:prueba/login/login.dart';

class SliderImagenesHeader extends StatefulWidget {
  final List<Widget> imagenes;
  final bool usuario;

  SliderImagenesHeader({required this.imagenes, required this.usuario});

  @override
  _SliderImagenesHeaderState createState() => _SliderImagenesHeaderState();
}

class _SliderImagenesHeaderState extends State<SliderImagenesHeader> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool usuarioLogeado = false;

  @override
  Widget build(BuildContext context) {
    final ancho_pantalla = MediaQuery.of(context).size.width;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          usuarioLogeado = true;
        });
      }
    });
    return Stack(
      children: [
        PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          children: widget.imagenes,
        ),
        (usuarioLogeado)
            ? HeaderLogged(ancho_pantalla, usuarioLogeado)
            : Header(ancho_pantalla, usuarioLogeado),
        //(ancho_pantalla > 1180) ? Login() : Container(),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white70,
                ),
                onPressed: () {
                  _pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                  if (_currentPage == 0) {
                    _pageController.animateToPage(widget.imagenes.length - 1,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  }
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white70,
                ),
                onPressed: () {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                  if (_currentPage == widget.imagenes.length - 1) {
                    _pageController.animateToPage(0,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
