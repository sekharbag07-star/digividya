import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digividya/features/assignments/models/assignment_model.dart';

class AssignmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addAssignment(AssignmentModel assignment) async {
    await _firestore.collection('assignments').add(assignment.toMap());
  }

  Stream<List<AssignmentModel>> getAssignments() {
    return _firestore.collection('assignments').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return AssignmentModel.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

  Future<void> deleteAssignment(String id) async {
    await _firestore.collection('assignments').doc(id).delete();
  }
}
