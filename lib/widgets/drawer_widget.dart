import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menu'),
          ),
          ListTile(
            title: const Text('Cursos'),
            onTap: () {
              Navigator.pushNamed(context, '/curso');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Aulas'),
            onTap: () {
              Navigator.pushNamed(context, '/aula');
            },
          ),
          ListTile(
            title: const Text('Horarios'),
            onTap: () {
              Navigator.pushNamed(context, '/horario');
            },
          ),
          ListTile(
            title: const Text('Profesores'),
            onTap: () {
              Navigator.pushNamed(context, '/profesor');
            },
          ),
          ListTile(
            title: const Text('Materias'),
            onTap: () {
              Navigator.pushNamed(context, '/materia');
            },
          ),
        ],
      ),
    );
  }
}
