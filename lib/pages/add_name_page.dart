import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

class AddNamePage extends StatefulWidget {
  const AddNamePage({super.key});

  @override
  State<AddNamePage> createState() => _AddNamePageState();
}

class _AddNamePageState extends State<AddNamePage> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController edadController = TextEditingController(text: ""); // Nuevo controlador
  TextEditingController colorController = TextEditingController(text: ""); // Nuevo controlador
  TextEditingController razaController = TextEditingController(text: ""); // Nuevo controlador
  TextEditingController precioController = TextEditingController(text: ""); // Nuevo controlador
  TextEditingController caracteristicaController = TextEditingController(text: ""); // Nuevo controlador
  TextEditingController idventaController = TextEditingController(text: ""); // Nuevo controlador
  TextEditingController idordenController = TextEditingController(text: ""); // Nuevo controlador


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agregar Gato")),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: "Ingrese el nombre:", // Hint text actualizado
              ),
            ),
             TextField( // Nuevo campo para edad
              controller: edadController,
              decoration: const InputDecoration(
                hintText: "Ingrese la edad:",
              ),
              keyboardType: TextInputType.number, // Teclado numérico para edad
            ),
            TextField( // Nuevo campo para color
              controller: colorController,
              decoration: const InputDecoration(
                hintText: "Ingrese el color:",
              ),
            ),
            TextField( // Nuevo campo para raza
              controller: razaController,
              decoration: const InputDecoration(
                hintText: "Ingrese la raza:",
              ),
            ),
            TextField( // Nuevo campo para precio
              controller: precioController,
              decoration: const InputDecoration(
                hintText: "Ingrese el precio:",
              ),
               keyboardType: TextInputType.numberWithOptions(decimal: true), // Teclado numérico con decimal para precio
            ),
            TextField( // Nuevo campo para caracteristica
              controller: caracteristicaController,
              decoration: const InputDecoration(
                hintText: "Ingrese la caracteristica:",
              ),
            ),
            TextField( // Nuevo campo para idventa
              controller: idventaController,
              decoration: const InputDecoration(
                hintText: "Ingrese el idventa:",
              ),
            ),
             TextField( // Nuevo campo para idorden
              controller: idordenController,
              decoration: const InputDecoration(
                hintText: "Ingrese el idorden:",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                 try {
                    // Intentar convertir edad y precio a números
                    int edad = int.parse(edadController.text);
                    double precio = double.parse(precioController.text);

                    // Si la conversión es exitosa, llamar a addGatos
                    await addGatos(
                       nameController.text,
                       edad, // Pasar int
                       colorController.text,
                       razaController.text,
                       precio, // Pasar double
                       caracteristicaController.text,
                       idventaController.text,
                       idordenController.text,
                    ).then((_) {
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    });
                 } catch (e) {
                    // Si ocurre un error al parsear (por ejemplo, texto no numérico), mostrar un mensaje al usuario
                    ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(
                         content: Text('Por favor, ingrese valores numéricos válidos para edad y precio.'),
                         backgroundColor: Colors.redAccent,
                       ),
                    );
                    print('Error al parsear edad o precio al agregar: $e'); // Imprimir error
                 }
              },
              child: const Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
