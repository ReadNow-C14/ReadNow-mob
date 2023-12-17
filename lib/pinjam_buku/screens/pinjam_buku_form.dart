import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class BorrowFormPage extends StatefulWidget {
  const BorrowFormPage({super.key, required int bookid});

  @override
  State<BorrowFormPage> createState() => _BorrowFormPageState();
}

class _BorrowFormPageState extends State<BorrowFormPage>{
  final _formKey = GlobalKey<FormState>();
  DateTime _returnDate = DateTime.now();

  TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(30),
            child: TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: 'RETURN DATE',
                filled: true,
                prefixIcon: Icon(Icons.calendar_today),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)
                ),
              ),
              readOnly: true,
              onTap: (){
                _selectDate();
              },
            ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100)
    );

    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }
}