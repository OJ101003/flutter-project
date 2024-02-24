import 'package:flutter/material.dart';

class ColumnDemoPage extends StatefulWidget {
  const ColumnDemoPage({super.key});

  @override
  State<ColumnDemoPage> createState() => _ColumnDemoPageState();
}

class _ColumnDemoPageState extends State<ColumnDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("It come with eggroll"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Title 1"),
            const Text("Title 2"),
            const Text("Title 3"),
            ElevatedButton(onPressed: () =>{}, child: const Text("Test")),
            ElevatedButton(onPressed: () =>{}, child: const Text("West"))


          ],
        ),
      ),
    );
  }
}
