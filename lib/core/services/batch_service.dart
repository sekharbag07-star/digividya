import 'package:cloud_firestore/cloud_firestore.dart';

class BatchService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addBatch({
    required String name,
    required String subject,
    required String teacherId,
    required String teacherName,
  }) async {
    final existing = await _firestore
        .collection('batches')
        .where('name', isEqualTo: name.trim())
        .limit(1)
        .get();

    if (existing.docs.isNotEmpty) {
      throw Exception("Batch already exists");
    }

    await _firestore.collection('batches').add({
      'name': name.trim(),
      'subject': subject.trim(),

      // Teacher Mapping
      'teacherId': teacherId,
      'teacherName': teacherName,

      // Student Support
      'studentCount': 0,

      'active': true,

      'createdAt': Timestamp.now(),
      'updatedAt': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getBatches() {
    return _firestore
        .collection('batches')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> deleteBatch(String docId) async {
    final students = await _firestore
        .collection('students')
        .where('batchId', isEqualTo: docId)
        .get();

    final batch = _firestore.batch();

    for (final student in students.docs) {
      batch.update(student.reference, {
        'batchId': '',
        'batchName': 'Not Assigned',

        'assignedTeacherId': '',
        'assignedTeacherName': '',
      });
    }

    batch.delete(_firestore.collection('batches').doc(docId));

    await batch.commit();
  }
}
