import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'History',
                style: TextStyle(fontSize: 24, color: Colors.black,fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryTable() {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey[200]),
          children: const [
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Product Name'),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Original Price'),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Winning Bid Price'),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Type'),
              ),
            ),
          ],
        ),
        // Replace the following rows with your actual data
        _buildHistoryRow('Product 1', '100', '150', 'Type A'),
        _buildHistoryRow('Product 2', '200', '250', 'Type B'),
        _buildHistoryRow('Product 3', '300', '350', 'Type C'),
      ],
    );
  }

  TableRow _buildHistoryRow(
    String productName,
    String originalPrice,
    String winningBidPrice,
    String type,
  ) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(productName),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(originalPrice),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(winningBidPrice),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(type),
          ),
        ),
      ],
    );
  }
}
