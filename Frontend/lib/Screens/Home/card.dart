import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:summer_school_23_code/Services/contract.dart';

class CustomCard extends StatefulWidget {
  final BigInt event_id;
  final String postContent;
  final String postTitle;
  final String postDate;
  const CustomCard(
      {Key? key,
      required this.postContent,
      required this.postTitle,
      required this.postDate,
      required this.event_id})
      : super(key: key);
  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    final postContent = widget.postContent;
    final postTitle = widget.postTitle;
    final postDate = widget.postDate;
    return Card(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              //post title
              postTitle,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              //postContent
              postContent,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  //postDate
                  postDate,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                  child: const Text('BUY TICKETS'),
                  onPressed: () async {
                    try {
                      await Provider.of<Contract>(context, listen: false)
                          .transferTicket(widget.event_id);
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
                const SizedBox(width: 8),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
