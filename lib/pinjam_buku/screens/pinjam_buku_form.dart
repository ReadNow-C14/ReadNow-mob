import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:readnow_mobile/models/book.dart';
import 'package:readnow_mobile/pinjam_buku/screens/list_borrowed_book.dart';
import 'package:readnow_mobile/main/widgets/bottom_nav.dart';
import 'package:intl/intl.dart';

class BorrowFormPage extends StatefulWidget {
  final Book book;
  const BorrowFormPage({super.key, required this.book});

  @override
  State<BorrowFormPage> createState() => _BorrowFormPageState();
}

class _BorrowFormPageState extends State<BorrowFormPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _returnDate = DateTime.now();
  TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Book book = widget.book;
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Borrow Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: '${book.fields.numOfPages} pages',
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
              onTap: _selectDate,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Submit'),
            ),
          ],
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
        // Format the date as DD/MM/YYYY
        _dateController.text = DateFormat('dd/MM/yyyy').format(_picked);
      });
    }
  }

  void _submitForm() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNav(initialIndex: 2))
    );
    print("tess");
    print(_dateController.text);
    if (_formKey.currentState!.validate()) {
      // Perform save operation and navigate to another page
      Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNav(initialIndex: 2)));
      // Add your logic here
    }
  }
}
