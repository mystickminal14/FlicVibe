

import 'package:flick/pages/premiumpage.dart';
import 'package:flutter/material.dart';

class SelectPlan extends StatelessWidget {
  const SelectPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50), // Add spacing from top
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Choose a plan",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20), // Space below the title
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
            const SizedBox(height: 50), // Space before the plan options
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Mobile plan
                Column(
                  children: [
                    Icon(Icons.phone_android, color: Colors.white, size: 50),
                    SizedBox(height: 10),
                    Text(
                      "Mobile",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
                // Standard plan
                Column(
                  children: [
                    Icon(Icons.tv, color: Colors.white, size: 50),
                    SizedBox(height: 10),
                    Text(
                      "Standard",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
                // Premium plan
                Column(
                  children: [
                    Icon(Icons.desktop_mac, color: Colors.white, size: 50),
                    SizedBox(height: 10),
                    Text(
                      "Premium",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30), // Space below the row
            
             
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Monthly price plan",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey, // Light grey text
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // Action for $3 plan
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "\$3.00",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Action for $5 plan
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "\$5.00",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to the login page for the $7 plan
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PremiumPlan(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // color: Colors.orange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "\$7.00",
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Video Quality",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey, // Light grey text
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // Action for $3 plan
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Good",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Action for $5 plan
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Better",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to the login page for the $7 plan
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PremiumPlan(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // color: Colors.orange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Best",
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            
             // Space before the button
              const SizedBox(height: 20), // Space below the row
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Resolution",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey, // Light grey text
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // Action for $3 plan
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "480p",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Action for $5 plan
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "1080p",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to the login page for the $7 plan
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PremiumPlan(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // color: Colors.orange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "4K+HDR",
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),

           
             // Space before the button
               const SizedBox(height: 20), // Space below the row
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Number of device at the same time",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey, // Light grey text
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // Action for $3 plan
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "1",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Action for $5 plan
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "2",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to the login page for the $7 plan
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PremiumPlan(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      // color: Colors.orange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "4",
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 50),
             // Space before the button
             
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add navigation or action logic here
                },
                style: ElevatedButton.styleFrom(
                  //primary: Colors.orange, // Orange background color
                  //onPrimary: Colors.white, // White text color
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50, vertical: 15), // Button size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded edges
                  ),
                ),
                child: const Text(
                  "Select Plan",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
