import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getGatos() async {
  List gatos = [];
  CollectionReference collectionReferenceGatos = db.collection("gatos");
  QuerySnapshot queryGatos = await collectionReferenceGatos.get();
  for (var doc in queryGatos.docs) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final gato = {
      "name": data['name'],
      "edad": data['edad'],
      "color": data['color'],
      "raza": data['raza'],
      "precio": data['precio'],
      "caracteristica": data['caracteristica'],
      "idventa": data['idventa'],
      "idorden": data['idorden'],
       "uid": doc.id};
    gatos.add(gato);
  }

  return gatos;
}

//Guardar name en base de datos
Future<void> addGatos(String name, int edad, String color, String raza, double precio, String caracteristica, String idventa, String idorden) async {
  await db.collection("gatos").add({
    "name": name,
    "edad": edad,
    "color": color,
    "raza": raza,
    "precio": precio,
    "caracteristica": caracteristica,
    "idventa": idventa,
    "idorden": idorden,
    });
}

//Actualizar un name en la base de datos
// Suggested code may be subject to a license. Learn more: ~LicenseLog:4205097586.
Future<void> updateGatos(String uid, String newname, int newedad, String newcolor, String newraza, double newprecio, String newcaracteristica, String newidventa, String newidorden) async {
  await db.collection("gatos").doc(uid).set({
    "name": newname,
    "edad": newedad,
    "color": newcolor,
    "raza": newraza,
    "precio": newprecio,
    "caracteristica": newcaracteristica,
    "idventa": newidventa,
    "idorden": newidorden,
    });
}

//Eliminar un name de la base de datos
Future<void> deleteGatos(String uid) async {
  await db.collection("gatos").doc(uid).delete();
}