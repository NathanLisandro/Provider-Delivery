import 'package:flutter/material.dart';
import '../components/prestador_card.dart';
import '../models/prestador.dart';
import '../services/api_service.dart';
import 'prestador_detail_page.dart';
import 'add_prestador_page.dart';
import 'home_page.dart';

class PrestadoresListPage extends StatefulWidget {
  @override
  _PrestadoresListPageState createState() => _PrestadoresListPageState();
}

class _PrestadoresListPageState extends State<PrestadoresListPage> {
  late Future<List<Prestador>> futurePrestadores;
  late ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    futurePrestadores = apiService.getPrestadores();
  }

  void _navigateToAddPrestador() async {
    bool? prestadorAdicionado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPrestadorPage(),
      ),
    );

    if (prestadorAdicionado == true) {
      setState(() {
        futurePrestadores = apiService.getPrestadores();
      });
    }
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text('Menu de Navegação', style: TextStyle(color: Colors.white, fontSize: 24)),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Início'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Lista de Prestadores'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Adicionar Prestador'),
            onTap: () {
              Navigator.pop(context);
              _navigateToAddPrestador();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Prestadores'),
      ),
      drawer: _buildDrawer(),
      body: FutureBuilder<List<Prestador>>(
        future: futurePrestadores,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final prestadores = snapshot.data!;
            return ListView.builder(
              itemCount: prestadores.length,
              itemBuilder: (context, index) {
                return PrestadorCard(
                  prestador: prestadores[index],
                  onTap: () async {
                    bool? updated = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PrestadorDetailPage(prestador: prestadores[index]),
                      ),
                    );
                    if (updated == true) {
                      setState(() {
                        futurePrestadores = apiService.getPrestadores();
                      });
                    }
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddPrestador,
        child: Icon(Icons.add),
        tooltip: 'Adicionar Prestador',
      ),
    );
  }
}
