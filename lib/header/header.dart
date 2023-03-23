//hacer widget header
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prueba/autenticacion.dart';
import 'package:prueba/login/login.dart';

class Header extends StatefulWidget {
  final double ancho_pantalla;
  final bool usuarioLogueado;

  Header(this.ancho_pantalla, this.usuarioLogueado);

  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  var openLogin = false;

  //Colores
  var colorScaffold = Color(0xffffebdcac);
  var colorNaranja = Color.fromARGB(255, 255, 79, 52);
  var colorMorado = Color.fromARGB(0xff, 0x52, 0x01, 0x9b);
  Widget logoMenu() {
    return (Container(
      alignment: Alignment.centerRight,
      child: Image(image: AssetImage('/logo.png')),
    ));
  }

  Widget btnIndexMenu() {
    return (GestureDetector(
      onTap: () {
        print('hola mundo');
      },
      child: Container(
          child: Text(
        'COFFEEMONDO',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Impact',
            fontSize: 22,
            fontWeight: FontWeight.bold),
      )),
    ));
  }

  Widget btnLoginMenu() {
    return (GestureDetector(
      onTap: () {
        setState(() {
          openLogin = !openLogin;
        });
      },
      child: Container(
          child: Text(
        'INGRESO',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Impact',
            fontSize: 22,
            fontWeight: FontWeight.bold),
      )),
    ));
  }

  Future<void> cerrarSesion() async {
    await Auth().signOut();
    print('Usuario ha cerrado sesion');
  }

  Widget btnRegistroMenu() {
    return (GestureDetector(
      onTap: () {
        widget.usuarioLogueado ? cerrarSesion() : print('registrando...');
      },
      child: Container(
          child: Text(
        widget.usuarioLogueado ? 'CERRAR SESION' : 'REGISTRO',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Impact',
            fontSize: 22,
            fontWeight: FontWeight.bold),
      )),
    ));
  }

  Widget btnMenuNavegacion() {
    return (Container(
      child: Container(
          child: Text(
        'MENU DE NAVEGACION',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Impact',
            fontSize: 16,
            fontWeight: FontWeight.bold),
      )),
    ));
  }

  Widget btnCredenciales() {
    return (Container(
      child: Container(
          width: MediaQuery.of(context).size.width * 0.25,
          height: MediaQuery.of(context).size.height * 0.03,
          color: colorNaranja,
          child: Center(
            child: Text(
              'INICIAR SESION',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Impact',
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          )),
    ));
  }

  @override
  Widget build(BuildContext context) {
    //print("ancho pantalla ${widget.ancho_pantalla}");
    return Column(
      children: [
        Container(
          height: (widget.ancho_pantalla > 750)
              ? MediaQuery.of(context).size.height * 0.1
              : MediaQuery.of(context).size.width * 0.1,
          margin: EdgeInsets.only(left: 30, right: 30, top: 50),
          child: (ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.1),
                child: Row(children: [
                  logoMenu(),
                  Expanded(
                    //color: Colors.blue,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: (widget.ancho_pantalla > 750)
                            ? [
                                btnIndexMenu(),
                                btnLoginMenu(),
                                btnRegistroMenu()
                              ]
                            : [btnMenuNavegacion(), btnCredenciales()]),
                  )
                ]),
              ),
            ),
          )),
        ),
        AnimatedOpacity(
            opacity: (openLogin) ? 1 : 0,
            duration: Duration(milliseconds: 500),
            child: Login())
      ],
    );
  }
}
