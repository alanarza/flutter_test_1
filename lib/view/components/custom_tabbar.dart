import 'package:flutter/material.dart';

class TabBarExample extends StatelessWidget {
  const TabBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Número de pestañas
      child: Scaffold(
        appBar: AppBar(
          title: Text('TabBar en un Contenedor'),
        ),
        body: Column(
          children: [
            // Contenedor con TabBar
            Container(
              color: Colors.blueGrey[50],
              child: TabBar(
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.blue,
                tabs: [
                  Tab(icon: Icon(Icons.home), text: 'Inicio'),
                  Tab(icon: Icon(Icons.star), text: 'Favoritos'),
                  Tab(icon: Icon(Icons.settings), text: 'Ajustes'),
                ],
              ),
            ),
            // Contenido de las pestañas
            Expanded(
              child: TabBarView(
                children: [
                  Center(child: Text('Contenido de Inicio')),
                  Center(child: Text('Contenido de Favoritos')),
                  Center(child: Text('Contenido de Ajustes')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}