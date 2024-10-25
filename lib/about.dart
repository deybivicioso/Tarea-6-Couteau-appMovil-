// about.dart
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  // Aquí puedes definir tus variables para mostrar la información
  final String name = "Deybi vicioso"; //  nombre del desarrollador
  final String matricula = "2022-0030"; //  matrícula del desarrollador
  final String tarea =
      "la caja Magica de Boa";

  const AboutScreen({super.key}); // Cambia esto por el nombre de tu tarea

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
        // botón de acción aquí
        actions: const [],
      ),
      body: Container(
        // Usar un Container para el gradiente
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Ajusta el tamaño del Card
                  children: [
                    Text(
                      'la caja Magica de Boa',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 24), // Aumentar tamaño de texto
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Con esta APP podemos jugar los siguientes juegos: ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 18), // Aumentar tamaño de texto
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text('- Predice Género',
                        style: TextStyle(fontSize: 16)),
                    const Text('- Conozco tu Edad',
                        style: TextStyle(fontSize: 16)),
                    const Text('- la universidad de tus sueños',
                        style: TextStyle(fontSize: 16)),
                    const Text('- Conoce el Clima', style: TextStyle(fontSize: 16)),
                    const Text('- foro sobre Wordpress',
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 20),

                    // Mostrar información estática
                    Text(
                      ' Nombre: $name',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 18), // Aumentar tamaño de texto
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Matrícula: $matricula',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 18), // Aumentar tamaño de texto
                    ),
                    const SizedBox(height: 10),
                    

                    // Imagen
                    CircleAvatar(
                      radius:
                          70, // Aumentar el tamaño de la imagen 
                      backgroundImage: const AssetImage(
                          'assets/yo.jpg'), // Asegúrate de que la imagen esté en la carpeta 'assets'
                      backgroundColor: Colors.grey[200], // Color de fondo
                    ),
                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {
                        // Aquí puedes manejar el evento de regresar
                        Navigator.pop(context);
                      },
                      child: const Text('Regresar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}