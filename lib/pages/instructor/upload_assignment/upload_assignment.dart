import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadAssignment extends StatelessWidget {
  Widget buildTextFields(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: TextField(
            decoration: InputDecoration(hintText: "Assignment name"),
          ),
          height: 100,
          width: MediaQuery.of(context).size.width / 2,
        ),
        SizedBox(
          child: TextField(
            decoration: InputDecoration(hintText: "Assignment description"),
            maxLines: 6,
          ),
          height: 300,
          width: MediaQuery.of(context).size.width / 2,
        ),
        Row(
          children: [
            SizedBox(
              child: TextField(
                decoration: InputDecoration(hintText: "Assignment inputs"),
                maxLines: 10,
              ),
              height: 300,
              width: MediaQuery.of(context).size.width / 2,
            ),
            SizedBox(
              child: TextField(
                decoration: InputDecoration(hintText: "Assignment outputs"),
                maxLines: 10,
              ),
              height: 300,
              width: MediaQuery.of(context).size.width / 2,
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Upload Assignment")),
        body: Center(
            child: Column(
          children: [buildTextFields(context)],
        )));
  }
}
