// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import '../components/prestador_card.dart';
import '../models/prestador.dart';
import '../services/api_service.dart';
import 'prestador_detail_page.dart';
import 'add_prestador_page.dart';
import 'prestadores_list_page.dart';
import '../route_observer.dart'; // Importe o routeObserver

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

// Adicione o mixin RouteAware
class _HomePageState extends State<HomePage> with RouteAware {
  late Future<List<Prestador>> futurePrestadores;
  late ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    futurePrestadores = apiService.getPrestadores();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ModalRoute? route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    final ModalRoute? route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.unsubscribe(this);
    }
    super.dispose();
  }

  @override
  void didPopNext() {
    // Recarrega os dados quando retornamos a esta página
    setState(() {
      futurePrestadores = apiService.getPrestadores();
    });
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
              // Já estamos na HomePage
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Lista de Prestadores'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrestadoresListPage(),
                ),
              );
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
        title: const Text('Prestadores em Destaque'),
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
