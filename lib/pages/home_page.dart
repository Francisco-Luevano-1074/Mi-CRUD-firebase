import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi CRUD"),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: FutureBuilder(
        future: getGatos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  onDismissed: (direction) async {
                    await deleteGatos(snapshot.data?[index]['uid']);
                    snapshot.data?.removeAt(index);
                  },
                  confirmDismiss: (direction) async {
                    bool result = false;
                    result = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "¿Estás seguro de eliminar a ${snapshot.data?[index]['name'] ?? 'este gato'}?", // Usar ?? para manejar null
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                return Navigator.pop(context, false);
                              },
                              child: const Text(
                                "Cancelar",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                return Navigator.pop(context, true);
                              },
                              child: const Text("Sí, estoy seguro"),
                            ),
                          ],
                        );
                      },
                    );
                    return result;
                  },
                  background: Container(
                    color: Colors.red,
                    child: const Icon(Icons.delete),
                  ),
                  direction: DismissDirection.endToStart,
                  key: Key(snapshot.data?[index]['uid']),
                  child: ListTile(
                        title: Text(snapshot.data?[index]['name'] ?? ''), // Usar ?? '' para manejar null
                        onTap: (() async {
                          await Navigator.pushNamed(
                            context,
                            '/edit',
                            arguments: {
                              "name": snapshot.data?[index]['name'],
                              "uid": snapshot.data?[index]['uid'],
                              "edad": snapshot.data?[index]['edad'],
                              "color": snapshot.data?[index]['color'],
                              "raza": snapshot.data?[index]['raza'],
                              "precio": snapshot.data?[index]['precio'],
                              "caracteristica": snapshot.data?[index]['caracteristica'],
                              "idventa": snapshot.data?[index]['idventa'],
                              "idorden": snapshot.data?[index]['idorden'],
                            },
                          );
                          setState(() {});
                        }),
                      ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        backgroundColor: Colors.orangeAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
