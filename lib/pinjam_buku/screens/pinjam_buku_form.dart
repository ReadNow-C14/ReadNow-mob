import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:readnow_mobile/main/widgets/bottom_nav.dart';
import 'package:readnow_mobile/models/book.dart';
import 'package:google_fonts/google_fonts.dart';

class BorrowFormPage extends StatefulWidget {
  final Book book;

  const BorrowFormPage({Key? key, required this.book}) : super(key: key);

  @override
  _BorrowFormPageState createState() => _BorrowFormPageState();
}

class _BorrowFormPageState extends State<BorrowFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87), // Modern icon color
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Select Return Date',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 2, color: Colors.black87
          ),
        ),// Modern text style
        backgroundColor: Colors.white, // Modern app bar color
        elevation: 1, // Subtle shadow for app bar
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Return date',
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please pick a date';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30.0),
              Container(
                margin: EdgeInsets.fromLTRB(86, 0, 87, 0),
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xfffce76c),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow (
                      color: Color(0x3f000000),
                      offset: Offset(0, 4),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final response = await request.postJson(
                          'https://readnow-c14-tk.pbp.cs.ui.ac.id/pinjam/borrow-flutter/${widget.book.pk}/',
                          jsonEncode(<String, dynamic>{
                            'return_date' : _dateController.text.toString(),
                          }));

                      if (response['status'] == 'success') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Berhasil meminjam buku ${widget.book.fields.title}!")),
                        );
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const BottomNav(initialIndex: 1,)),
                                (route) => false);
                      } else if (response['status'] == 'error' && response['message'] != null) {
                        print("gagal123");
                        print(response['message']);
                      } else {
                        print("gagal");
                      }
                    } else {
                      print("tidak valid");
                    }
                  },
                  child: Center(
                    child: Text(
                      'Borrow',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        height: 2,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100)
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        _formKey.currentState?.validate();
      });
    }
  }
}

