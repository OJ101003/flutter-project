import 'package:flutter/material.dart';

class CreateStatus extends StatefulWidget {
  const CreateStatus({super.key});

  @override
  State<CreateStatus> createState() => _CreateStatusState();
}

class _CreateStatusState extends State<CreateStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(5), // Adjust margin for positioning
          decoration: const BoxDecoration(
            color: Color(0xFF6452AE), // Background color
            shape: BoxShape.circle, // Circular background
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28), // Adjust icon size and color
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: const Text(
          'Create Status',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.grey,
      ),
      body: Column(
        children: [
          Row(
              //
              )
        ],
      ),
    );
  }
}
