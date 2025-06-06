import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart';

class EditNamePage extends StatefulWidget {
  const EditNamePage({super.key});

  @override
  State<EditNamePage> createState() => _EditNamePageState();
}

class _EditNamePageState extends State<EditNamePage> {
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
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    nameController.text = arguments['name'];
    edadController.text = arguments['edad']?.toString() ?? ""; // Inicializar con datos existentes
    colorController.text = arguments['color']; // Inicializar con datos existentes
    razaController.text = arguments['raza']; // Inicializar con datos existentes
    precioController.text = arguments['precio']?.toString() ?? ""; // Inicializar con datos existentes
    caracteristicaController.text = arguments['caracteristica']; // Inicializar con datos existentes
    idventaController.text = arguments['idventa']; // Inicializar con datos existentes
    idordenController.text = arguments['idorden']; // Inicializar con datos existentes


    return Scaffold(
      appBar: AppBar(title: const Text("Editar Gato")), // Título más genérico
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: "Ingrese el nuevo nombre:",
              ),
            ),
            TextField( // Nuevo campo para edad
              controller: edadController,
              decoration: const InputDecoration(
                hintText: "Ingrese la nueva edad:",
              ),
              keyboardType: TextInputType.number, // Teclado numérico para edad
            ),
            TextField( // Nuevo campo para color
              controller: colorController,
              decoration: const InputDecoration(
                hintText: "Ingrese el nuevo color:",
              ),
            ),
            TextField( // Nuevo campo para raza
              controller: razaController,
              decoration: const InputDecoration(
                hintText: "Ingrese la nueva raza:",
              ),
            ),
            TextField( // Nuevo campo para precio
              controller: precioController,
              decoration: const InputDecoration(
                hintText: "Ingrese el nuevo precio:",
              ),
               keyboardType: TextInputType.numberWithOptions(decimal: true), // Teclado numérico con decimal para precio
            ),
            TextField( // Nuevo campo para caracteristica
              controller: caracteristicaController,
              decoration: const InputDecoration(
                hintText: "Ingrese la nueva caracteristica:",
              ),
            ),
            TextField( // Nuevo campo para idventa
              controller: idventaController,
              decoration: const InputDecoration(
                hintText: "Ingrese el nuevo idventa:",
              ),
            ),
             TextField( // Nuevo campo para idorden
              controller: idordenController,
              decoration: const InputDecoration(
                hintText: "Ingrese el nuevo idorden:",
              ),
            ),
            ElevatedButton(
  onPressed: () async {
    try {
      // Intentar convertir edad y precio a números
      int edad = int.parse(edadController.text);
      double precio = double.parse(precioController.text);

      // Si la conversión es exitosa, llamar a updateGatos
      await updateGatos(
        arguments["uid"],
        nameController.text,
        edad,
        colorController.text,
        razaController.text,
        precio,
        caracteristicaController.text,
        idventaController.text,
        idordenController.text,
      ).then((_) {
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
      print('Error al parsear edad o precio: $e'); // Imprimir error en consola para depuración
    }
  },
  child: const Text("Actualizar"),
)

          ],
        ),
      ),
    );
  }
}
