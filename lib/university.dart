import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class UniversitiesScreen extends StatefulWidget {
  const UniversitiesScreen({super.key});

  @override
  _UniversitiesScreenState createState() => _UniversitiesScreenState();
}

class _UniversitiesScreenState extends State<UniversitiesScreen> {
  final _controller = TextEditingController();
  List<dynamic> _universities = [];

  Future<void> _fetchUniversities() async {
    final country = _controller.text.trim();
    if (country.isEmpty) return;

    final response = await http.get(
        Uri.parse('http://universities.hipolabs.com/search?country=$country'));

    if (response.statusCode == 200) {
      setState(() {
        _universities = jsonDecode(response.body);
      });
    } else {
      setState(() {
        _universities = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:
          true, // Para que el gradiente ocupe toda la pantalla
      appBar: AppBar(
        title: const Text('Universidades'),
        backgroundColor: const Color.fromARGB(0, 0, 0, 0), // Fondo transparente
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 19, 193, 114), // verde
              Color.fromARGB(255, 85, 187, 215), // Azul medio
              Color(0xFF8A2BE2), // Violeta acento
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 100), // Para que el contenido esté centrado
            TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'escribe el nombre del país en ingles',
                labelStyle: const TextStyle(color: Colors.white),
                filled: true,
                fillColor: Colors.white24,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: const Icon(Icons.search, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchUniversities,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('click para buscar',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _universities.isEmpty
                  ? const Center(
                      child: Text(
                        'pais no reconocido',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _universities.length,
                      itemBuilder: (context, index) {
                        final university = _universities[index];
                        final domain = university['domain'] ?? 'No disponible';
                        final webPages = university['web_pages'];
                        final hasWebsite =
                            webPages != null && webPages.isNotEmpty;
                        final websiteUrl = hasWebsite ? webPages[0] : null;

                        return Card(
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            title: Text(
                              university['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E3C72),
                              ),
                            ),
                            subtitle: Text(domain),
                            trailing: hasWebsite
                                ? ElevatedButton(
                                    onPressed: () async {
                                      if (await canLaunch(websiteUrl!)) {
                                        await launch(websiteUrl);
                                      } else {
                                        throw 'No se pudo abrir el enlace: $websiteUrl';
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text('Visitar'),
                                  )
                                : const Text('No disponible'),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
