// ignore_for_file: camel_case_types

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class selectorGenero extends StatefulWidget {
  const selectorGenero({super.key});

  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<selectorGenero> {
  final _controller = TextEditingController();
  String _gender = "";
  Color _color = Colors.white;
  bool _loading = false;
  final Map<String, String> _genderCache = {};

  void _predictGender() async {
    final name = _controller.text.trim();
    if (name.isEmpty) {
      setState(() {
        _gender = "Introduce un nombre";
        _color = Colors.grey;
      });
      return;
    }

    setState(() {
      _loading = true;
    });

    // Verifica si ya tienes el género almacenado en el caché
    if (_genderCache.containsKey(name)) {
      setState(() {
        _gender = _genderCache[name]!;
        _color = _gender == 'male'
            ? Colors.blue
            : (_gender == 'female' ? Colors.pink : Colors.grey);
        _loading = false;
      });
      return;
    }

    try {
      final response =
          await http.get(Uri.parse('https://api.genderize.io/?name=$name'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _gender = data['gender'] ?? 'unknown';
        _genderCache[name] = _gender; // Almacena el género en el caché
        _color = _gender == 'male'
            ? Colors.blue
            : (_gender == 'female' ? Colors.pink : Colors.grey);
      } else {
        _gender = "Error en la respuesta";
        _color = Colors.red;
      }
    } catch (e) {
      _gender = "Error de conexión";
      _color = Colors.red;
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Extiende el gradiente detrás de la AppBar
      appBar: AppBar(
        title: const Text('Conozcamos tu Genero'),
        backgroundColor: Colors.transparent, // Fondo transparente
        elevation: 0, // Sin sombra
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 11, 221, 88), // Azul oscuro
              Color.fromARGB(255, 42, 123, 152), // Azul medio
              Color.fromARGB(255, 147, 72, 222), // Violeta acento
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Introduce tu nombre y te dire tu genero',
                      labelStyle: TextStyle(color: Colors.grey[700]),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _predictGender,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 231, 231, 231), // Azul medio
                      padding:
                          const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _loading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text('Predecir', style: TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: _color,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 6,
                          offset: const Offset(0, 3), // Desplazamiento de la sombra
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _gender,
                        style: const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
