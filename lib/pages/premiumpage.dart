import 'package:flick/pages/paymentmethod.dart';
import 'package:flutter/material.dart';

class PremiumPlan extends StatefulWidget {
  const PremiumPlan({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PremiumPlanState createState() => _PremiumPlanState();
}

class _PremiumPlanState extends State<PremiumPlan> {
  String selectedPlan = '';
  double selectedPrice = 0.0; // Variable to store selected price

  void clearSelection() {
    // Clear the selection before updating
    setState(() {
      selectedPlan = '';
      selectedPrice = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
  leading: IconButton(
    icon: const Icon(Icons.arrow_back), // Left arrow icon
    onPressed: () {
      Navigator.pop(context); // Go back to the previous screen
    },
  ),
  title:  const Align(
              alignment: Alignment.center,
              child: Text(
                "Choose a Plan      ",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.grey, // Light grey text
                ),
              ),
            ),
  centerTitle: true,
  backgroundColor: Colors.black,
),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const SizedBox(height: 20), // Add spacing from top
            // const Align(
            //   alignment: Alignment.center,
            //   child: Text(
            //     "Choose a plan",
            //     style: TextStyle(
            //       fontSize: 30,
            //       color: Colors.white,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Don't worry, you can cancel at any time!",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey, // Light grey text
                ),
              ),
            ),
            const SizedBox(height: 40), // Space before the plan options
            GestureDetector(
              onTap: () {
                clearSelection(); // Clear the previous selection
                setState(() {
                  selectedPlan = "1 Month";
                  selectedPrice = 5.00; // Store price when 1 month is selected
                });
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: selectedPlan == "1 Month"
                        ? Colors.orange
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    // Column 1: 1 Month and Save 10%
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "1 Month",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Save 10%",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Column 2: Price with crossed-out price
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "\$7.00",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "\$5.00",
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Column 3: Checkbox
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: selectedPlan == "1 Month",
                            onChanged: (value) {
                              clearSelection(); // Clear previous selection
                              setState(() {
                                selectedPlan = "1 Month";
                                selectedPrice = 5.00; // Update price
                              });
                            },
                            activeColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(50), // Makes it round
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                clearSelection(); // Clear previous selection
                setState(() {
                  selectedPlan = "3 Months";
                  selectedPrice =
                      18.00; // Store price when 3 months is selected
                });
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: selectedPlan == "3 Months"
                        ? Colors.orange
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    // Column 1: 3 Months and Save 15%
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "3 Months",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Save 10%",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Column 2: Price with crossed-out price
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "\$10.00",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "\$8.00",
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Column 3: Checkbox
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: selectedPlan == "3 Months",
                            onChanged: (value) {
                              clearSelection(); // Clear previous selection
                              setState(() {
                                selectedPlan = "3 Months";
                                selectedPrice = 18.00; // Update price
                              });
                            },
                            activeColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(50), // Makes it round
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                clearSelection(); // Clear previous selection
                setState(() {
                  selectedPlan = "6 Months";
                  selectedPrice =
                      34.00; // Store price when 6 months is selected
                });
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: selectedPlan == "6 Months"
                        ? Colors.orange
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    // Column 1: 6 Months and Save 20%
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "6 Months",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Save 10%",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Column 2: Price with crossed-out price
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "\$12.00",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "\$9.00",
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Column 3: Checkbox
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: selectedPlan == "6 Months",
                            onChanged: (value) {
                              clearSelection(); // Clear previous selection
                              setState(() {
                                selectedPlan = "6 Months";
                                selectedPrice = 34.00; // Update price
                              });
                            },
                            activeColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(50), // Makes it round
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                clearSelection(); // Clear the previous selection
                setState(() {
                  selectedPlan = "1 Year";
                  selectedPrice = 11.00; // Store price when 1 year is selected
                });
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: selectedPlan == "1 year"
                        ? Colors.orange
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    // Column 1: 1 Month and Save 10%
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "1 Year",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Save 10%",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Column 2: Price with crossed-out price
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "\$14.00",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "\$11.00",
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Column 3: Checkbox
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: selectedPlan == "1 Year",
                            onChanged: (value) {
                              clearSelection(); // Clear previous selection
                              setState(() {
                                selectedPlan = "1 Year";
                                selectedPrice = 11.00; // Update price
                              });
                            },
                            activeColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(50), // Makes it round
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 90),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (selectedPlan.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentMethod(
                          selectedPlan: selectedPlan,
                          selectedPrice: selectedPrice,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Please select a plan before proceeding!'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                 padding: const EdgeInsets.symmetric(
                      horizontal: 100, vertical: 15), // Button size
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
            
          ],
        ),
      ),
    );
  }
}

// class NextPage extends StatelessWidget {
//   final String plan;
//   final double price;

//   const NextPage({Key? key, required this.plan, required this.price})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Selected Plan'),
//         backgroundColor: Colors.orange,
//       ),
//       body: Center(
//         child: Text(
//           'You selected: $plan\nPrice: \$${price.toStringAsFixed(2)}',
//           style: const TextStyle(fontSize: 18, color: Colors.white),
//         ),
//       ),
//       backgroundColor: Colors.black,
//     );
//   }
// }
