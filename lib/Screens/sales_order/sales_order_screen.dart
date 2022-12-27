import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';

class SalesOrderScreen extends StatefulWidget {
  const SalesOrderScreen({super.key});

  @override
  State<SalesOrderScreen> createState() => _SalesOrderScreenState();
}

class _SalesOrderScreenState extends State<SalesOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Sales Order Screen'),
      ),
      body: Container(),
     floatingActionButton: DraggableFab(
       child: FloatingActionButton.extended(
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 5,
            icon: const  Icon(
              Icons.add_rounded,
              color: Colors.white,
            ),
            label: const Text(
              'Add lines',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            onPressed: () {
     
            },
          ),
     )
        
    );
  }
}
