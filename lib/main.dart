import 'package:flutter/material.dart';
import 'selectorGenero.dart';
import 'age_screen.dart';
import 'university.dart';
import 'weather_screen.dart';
import 'news_screen.dart';
import 'about.dart';

void main() {
  runApp(ToolBoxApp());
}

class ToolBoxApp extends StatelessWidget {
  const ToolBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tool Box App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black87, fontSize: 16),
          bodySmall: TextStyle(color: Colors.black54, fontSize: 14),
          headlineMedium: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      home: HomeScreen(),
      routes: {
        '/gender': (context) => selectorGenero(),
        '/age': (context) => AgeScreen(),
        '/universities': (context) => UniversitiesScreen(),
        '/weather': (context) => WeatherScreen(),
        '/news': (context) => NewsScreen(),
        '/about': (context) => AboutScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tool Box App')),
      body: Container(
        // Fondo con gradiente
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 19, 193, 114), // verde
              Color.fromARGB(255, 85, 187, 215), // Azul medio
              Color(0xFF8A2BE2), // Violeta acento
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const SizedBox(height: 30), // Espacio superior
              SizedBox(
                height: 200, // Cambia esto a tu preferencia
                child: Image.asset(
                  'assets/m1.png', // Asegúrate de colocar la imagen en la carpeta 'assets'
                  fit: BoxFit
                      .contain, // Asegúrate de que la imagen se ajuste dentro del espacio
                ),
              ),
              const SizedBox(height: 30), // Espacio después de la imagen
              Text(
                'Bienvenido a la caja Magica de Boa',
                style: Theme.of(context).textTheme.headlineMedium, // Ajustado
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                child: ListTile(
                  leading: const Icon(Icons.person,
                      size: 40,
                      color: Color.fromARGB(255, 107, 226, 43)), // Icono en violeta acento
                  title: Text('conozco tu genero',
                      style:
                          Theme.of(context).textTheme.bodyMedium), // Ajustado
                  onTap: () => Navigator.pushNamed(context, '/gender'),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 4,
                child: ListTile(
                  leading: const Icon(Icons.calendar_today,
                      size: 40,
                      color: Color.fromARGB(255, 66, 231, 240)), // Icono en violeta acento
                  title: Text('Conozco tu Edad',
                      style:
                          Theme.of(context).textTheme.bodyMedium), // Ajustado
                  onTap: () => Navigator.pushNamed(context, '/age'),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 4,
                child: ListTile(
                  leading: const Icon(Icons.school,
                      size: 40,
                      color: Color.fromARGB(255, 83, 226, 43)), // Icono en violeta acento
                  title: Text('Busca tu universidad ideal',
                      style:
                          Theme.of(context).textTheme.bodyMedium), // Ajustado
                  onTap: () => Navigator.pushNamed(context, '/universities'),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 4,
                child: ListTile(
                  leading: const Icon(Icons.sunny,
                      size: 40,
                      color: Color.fromARGB(255, 38, 227, 237)), // Icono en violeta acento
                  title: Text('Conoce el estado del tiempo',
                      style:
                          Theme.of(context).textTheme.bodyMedium), // Ajustado
                  onTap: () => Navigator.pushNamed(context, '/weather'),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 4,
                child: ListTile(
                  leading: const Icon(Icons.wordpress,
                      size: 40,
                      color: Color.fromARGB(255, 37, 231, 115)), // Icono en violeta acento
                  title: Text('Conoce una wordpress page',
                      style:
                          Theme.of(context).textTheme.bodyMedium), // Ajustado
                  onTap: () => Navigator.pushNamed(context, '/news'),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                elevation: 4,
                child: ListTile(
                  leading: const Icon(Icons.info,
                      size: 40,
                      color: Color.fromARGB(108, 28, 226, 45)), // Icono en violeta acento
                  title: Text('Conoce al Desarrollador',
                      style:
                          Theme.of(context).textTheme.bodyMedium), // Ajustado
                  onTap: () => Navigator.pushNamed(context, '/about'),
                ),
              ),
              // Otras tarjetas...
            ],
          ),
        ),
      ),
    );
  }
}
