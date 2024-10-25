import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final String _apiKey =
      'bfbb369f8d9f4a649df23010242010'; // Reemplaza con tu clave API
  String _city = 'Santo Domingo';
  String _temperature = '';
  String _description = '';
  String _errorMessage = '';
  final TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    final url =
        'http://api.weatherapi.com/v1/current.json?key=$_apiKey&q=$_city'; // URL de la API

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _temperature = data['current']['temp_c']
              .toString(); // Temperatura en grados Celsius
          _description =
              data['current']['condition']['text']; // Descripción del clima
          _errorMessage = ''; // Limpiar cualquier mensaje de error
        });
      } else {
        setState(() {
          _errorMessage =
              'Error al obtener los datos del clima: ${response.body}'; // Mensaje de error
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error de conexión: $e'; // Mensaje de error de conexión
      });
    }
  }

  void _updateCity() {
    setState(() {
      _city =
          _cityController.text; // Actualizar la ciudad con el texto ingresado
      _temperature = ''; // Limpiar la temperatura anterior
      _description = ''; // Limpiar la descripción anterior
      _errorMessage = ''; // Limpiar el mensaje de error
    });
    _fetchWeather(); // Obtener el clima para la nueva ciudad
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima en $_city'),
        backgroundColor: const Color(0xFF1E3C72), // Azul oscuro
      ),
      body: Container(
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    labelText: 'Ingresa la ciudad',
                    labelStyle: const TextStyle(color: Color(0xFF1E3C72)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _updateCity,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 211, 15, 110),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Actualizar clima',
                    style: TextStyle(fontSize: 18),
                     
                    
                  ),
                ),
                const SizedBox(height: 20),
                _errorMessage.isNotEmpty
                    ? Text(
                        _errorMessage,
                        style: const TextStyle(color: Colors.red, fontSize: 20),
                        textAlign: TextAlign.center,
                      )
                    : Column(
                        children: [
                          Text(
                            'Temperatura: $_temperature °C',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Descripción: $_description',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}