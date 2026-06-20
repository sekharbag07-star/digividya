import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/study_material_model.dart';

class StudyMaterialService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Future<void> addMaterial(
    StudyMaterialModel material,
  ) async {
    await _firestore
        .collection('study_materials')
        .add(material.toMap());
  }

  Stream<List<StudyMaterialModel>>
      getMaterials() {
    return _firestore
        .collection('study_materials')
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return StudyMaterialModel.fromMap(
          doc.id,
          doc.data(),
        );
      }).toList();
    });
  }

  Future<void> deleteMaterial(
    String materialId,
  ) async {
    await _firestore
        .collection('study_materials')
        .doc(materialId)
        .delete();
  }
}
