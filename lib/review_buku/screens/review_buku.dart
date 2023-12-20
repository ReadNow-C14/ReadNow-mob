import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:readnow_mobile/review_buku/models/reviewBuku.dart';
import 'package:readnow_mobile/review_buku/screens/reviewbuku_form.dart';

class ReviewPage extends StatefulWidget {
  
  final int bookid;
  final String bookTitle; // Add this line to hold the book title
  
  const ReviewPage({
    Key? key,
    required this.bookid,
    required this.bookTitle, // Modify the constructor to accept the book title
  }) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int? selectedRating;
  List<Review>? reviews;
  Map<int, bool> expandedMap = {}; // Map to track expanded reviews

  @override
  void initState() {
    super.initState();
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    var fetchedReviews = await fetchReview(selectedRating);
    setState(() {
      reviews = fetchedReviews;
    });
  }

  Future<List<Review>> fetchReview([int? rating]) async {
    var url = Uri.parse('https://readnow-c14-tk.pbp.cs.ui.ac.id/review/get-review-json/${widget.bookid}');
    var response = await http.get(url, headers: {"Content-Type": "application/json"});
    List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    var reviews = data.map((d) => Review.fromJson(d)).toList();
    if (rating != null) {
      reviews = reviews.where((review) => review.rating == rating).toList();
    }
    return reviews;
  }

  Widget _buildStars(int count) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) => Icon(Icons.star, color: Colors.amber, size: 16)),
    );
  }

  Widget _buildRadioButton(int? value, String label) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Theme(
            data: ThemeData(
              unselectedWidgetColor: Colors.red, // Color for unchecked state
              // You can also set the 'toggleableActiveColor' for the Material 3 theme
            ),
            child: Radio<int?>(
              value: value,
              groupValue: selectedRating,
              onChanged: (int? newValue) {
                setState(() {
                  selectedRating = newValue;
                  _loadReviews(); // Refresh reviews on rating selection
                });
              },
              activeColor: Color(0xFF8BD0FC), // Color for checked state
            ),
          ),
          Text(label),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.bookTitle), // Use the book title here
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildRadioButton(null, 'All Reviews'),
                ...List.generate(5, (index) => _buildRadioButton(index + 1, '${index + 1}')),
              ],
            ),
          ),
          Expanded(
            child: reviews == null
                ? const Center(child: CircularProgressIndicator())
                : reviews!.isEmpty
                    ? const Center(child: Text("No Reviews yet"))
                    : ListView.builder(
                        itemCount: reviews!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final review = reviews![index];
                          expandedMap[index] = expandedMap[index] ?? false;

                          String displayText = review.comment;
                          if (displayText.length > 200 && !(expandedMap[index] ?? false)) {
                              displayText = displayText.substring(0, 100) + '...';
                          }
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                expandedMap[index] = !(expandedMap[index] ?? false);
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 6,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          review.user,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      _buildStars(review.rating),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Flexible(
                                    child: Text(
                                      displayText,
                                      style: Theme.of(context).textTheme.bodySmall,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    review.createdAt,
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return DraggableScrollableSheet(
                initialChildSize: 0.5,
                maxChildSize: 0.5,
                builder: (_, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: AddReview(bookId: widget.bookid),
                  );
                },
              );
            },
          ).then((value) {
            if (value == true) {
              _loadReviews();
            }
          });
        },
        child: Icon(Icons.add_comment),
      ),
    );
  }
}