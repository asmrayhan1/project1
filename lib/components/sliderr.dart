import 'package:flutter/cupertino.dart';

class Sliderr extends StatelessWidget {
  int? index;
  String? image,title,description;

//Constructor created
  Sliderr({required this.index, required this.image, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 12),
          Row(
            children: [
              if (index == 0)
                SizedBox(width: 40),
              Expanded(
                child: Container(
                    height: MediaQuery.of(context).size.height / 2.4,
                    width: double.infinity,
                    child: ClipRRect(child: Image.asset(image!, fit: BoxFit.fill,))
                ),
              ),
              if (index == 2)
                SizedBox(width: 40),
            ],
          ),
          SizedBox(height: 40),
          Center(child: Text(title!, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 21.0, right: 21),
            child: Text(description!, style: TextStyle(fontSize: 20,), textAlign: TextAlign.center),
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}