import 'package:flutter/material.dart';

class YojanaChayan extends StatelessWidget {
  final String selectedClass;
  final String selectedPlan;
  final ValueChanged<String?> onPlanChanged;

  const YojanaChayan({
    super.key,
    required this.selectedClass,
    required this.selectedPlan,
    required this.onPlanChanged,
  });

  Map<String, String> getPlans() {
    final classNumber =
        int.tryParse(selectedClass.replaceAll(RegExp(r'[^0-9]'), '')) ?? 1;

    // Class 1-5
    if (classNumber <= 5) {
      return {
        "🚀 Starter Trial (7 Days)": "₹49",
        "⭐ Monthly Plan": "₹299",
        "🔥 Quarterly Plan": "₹799",
        "💎 Half Yearly Plan": "₹1499",
        "👑 Yearly Plan": "₹2499",
      };
    }

    // Class 6-8
    if (classNumber <= 8) {
      return {
        "🚀 Starter Trial (7 Days)": "₹79",
        "⭐ Monthly Plan": "₹399",
        "🔥 Quarterly Plan": "₹1099",
        "💎 Half Yearly Plan": "₹2099",
        "👑 Yearly Plan": "₹3499",
      };
    }

    // Class 9-10
    return {
      "🚀 Starter Trial (7 Days)": "₹99",
      "⭐ Monthly Plan": "₹599",
      "🔥 Quarterly Plan": "₹1599",
      "💎 Half Yearly Plan": "₹3099",
      "👑 Yearly Plan": "₹5999",
    };
  }

  @override
  Widget build(BuildContext context) {
    final plans = getPlans();

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Yojana Chayan",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              initialValue: selectedPlan.isEmpty ? null : selectedPlan,
              decoration: const InputDecoration(
                labelText: "Plan Select Karein",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.workspace_premium),
              ),
              items: plans.entries.map((entry) {
                return DropdownMenuItem(
                  value: entry.key,
                  child: Text("${entry.key} - ${entry.value}"),
                );
              }).toList(),
              onChanged: onPlanChanged,
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade400),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Available Plans",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  const Divider(),

                  ...plans.entries.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              entry.key,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Text(
                            entry.value,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Class: $selectedClass",
                    style: TextStyle(
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}





