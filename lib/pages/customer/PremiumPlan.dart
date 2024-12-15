import 'package:flutter/material.dart';

class PremiumPlan extends StatefulWidget {
  const PremiumPlan({Key? key}) : super(key: key);

  @override
  _PremiumPlanState createState() => _PremiumPlanState();
}

class _PremiumPlanState extends State<PremiumPlan> {
  String selectedPlan = '';
  double selectedPrice = 0.0;

  // Plan options with details
  final List<Map<String, dynamic>> plans = [
    {"title": "1 Month", "price": 5.00, "discounted": 7.00, "savings": "Save 10%"},
    {"title": "3 Months", "price": 18.00, "discounted": 25.00, "savings": "Save 20%"},
    {"title": "6 Months", "price": 34.00, "discounted": 45.00, "savings": "Save 25%"},
    {"title": "1 Year", "price": 65.00, "discounted": 80.00, "savings": "Save 30%"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Choose a Plan",
          style: TextStyle(fontSize: 24, color: Colors.grey),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              "Don't worry, you can cancel at any time!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: plans.length,
              itemBuilder: (context, index) {
                final plan = plans[index];
                final isSelected = selectedPlan == plan["title"];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPlan = plan["title"];
                      selectedPrice = plan["price"];
                    });
                  },
                  child: Card(
                    color: Colors.grey[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: isSelected ? Colors.orange : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        plan["title"],
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        plan["savings"],
                        style: const TextStyle(fontSize: 14, color: Colors.green),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "\$${plan["discounted"]}",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Text(
                            "\$${plan["price"].toStringAsFixed(2)}",
                            style: const TextStyle(
                              color: Colors.orange,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  if (selectedPlan.isNotEmpty) {
                    // Proceed to the next screen
                    Navigator.pushNamed(context, '/checkout');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Selected Plan: $selectedPlan (\$${selectedPrice.toStringAsFixed(2)})",
                        ),
                      ),
                    );
                  } else {
                    // Alert user to select a plan
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please select a plan before proceeding!"),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Proceed',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
