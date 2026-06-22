import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:digividya/core/services/parent_link_service.dart';

class ParentStudentLinkScreen extends StatefulWidget {
  const ParentStudentLinkScreen({super.key});

  @override
  State<ParentStudentLinkScreen> createState() =>
      _ParentStudentLinkScreenState();
}

class _ParentStudentLinkScreenState extends State<ParentStudentLinkScreen> {
  final ParentLinkService _linkService = ParentLinkService();

  String? selectedStudentUid;
  String? selectedParentUid;

  bool isLoading = false;

  Future<void> linkParentStudent() async {
    if (selectedStudentUid == null || selectedParentUid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both Student and Parent')),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      await _linkService.linkStudentAndParent(
        studentUid: selectedStudentUid!,
        parentUid: selectedParentUid!,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Parent linked successfully')),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Widget buildStudentDropdown() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'student')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final students = snapshot.data?.docs ?? [];

        return DropdownButtonFormField<String>(
          initialValue: selectedStudentUid,
          decoration: const InputDecoration(
            labelText: 'Select Student',
            border: OutlineInputBorder(),
          ),
          items: students.map((student) {
            final data = student.data() as Map<String, dynamic>;

            return DropdownMenuItem<String>(
              value: student.id,
              child: Text(
                data['fullName'] ?? data['name'] ?? 'Unknown Student',
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedStudentUid = value;
            });
          },
        );
      },
    );
  }

  Widget buildParentDropdown() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'parent')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final parents = snapshot.data?.docs ?? [];

        return DropdownButtonFormField<String>(
          initialValue: selectedParentUid,
          decoration: const InputDecoration(
            labelText: 'Select Parent',
            border: OutlineInputBorder(),
          ),
          items: parents.map((parent) {
            final data = parent.data() as Map<String, dynamic>;

            return DropdownMenuItem<String>(
              value: parent.id,
              child: Text(data['name'] ?? 'Unknown Parent'),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedParentUid = value;
            });
          },
        );
      },
    );
  }

  Widget buildLinkedList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'parent')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }

        final parents = snapshot.data?.docs ?? [];

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: parents.length,
          itemBuilder: (context, index) {
            final data = parents[index].data() as Map<String, dynamic>;

            final parentName = data['name'] ?? '';

            final studentUid = data['studentUid'] ?? '';

            return Card(
              child: ListTile(
                leading: const Icon(Icons.link),
                title: Text(parentName),
                subtitle: Text(
                  studentUid.toString().isEmpty
                      ? 'Not Linked'
                      : 'Student UID: $studentUid',
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parent Student Linking')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildStudentDropdown(),

            const SizedBox(height: 15),

            buildParentDropdown(),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : linkParentStudent,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Link Parent & Student'),
              ),
            ),

            const SizedBox(height: 30),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Existing Links',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            buildLinkedList(),
          ],
        ),
      ),
    );
  }
}
