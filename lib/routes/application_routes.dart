import 'package:flutter/material.dart';
import 'package:movil_academico/screens/CursoScreen.dart';
import 'package:movil_academico/screens/HorarioScreen.dart';
import 'package:movil_academico/screens/MateriaScreen.dart';
import 'package:movil_academico/screens/ProfesorScreen.dart';

import '../screens/AulaScreen.dart';

class Routes {
  static const String curso = '/curso';
  static const String aula = '/aula';
  static const String horario = '/horario';
  static const String profesor = '/profesor';
  static const String materia = '/materia';
}

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => const CursoScreen(),
    Routes.curso: (BuildContext context) => const CursoScreen(),
    Routes.aula: (BuildContext context) => const AulaScreen(),
    Routes.horario: (BuildContext context) => const HorarioScreen(),
    Routes.profesor: (BuildContext context) => const ProfesorScreen(),
    Routes.materia: (BuildContext context) => const MateriaScreen()
  };
}
