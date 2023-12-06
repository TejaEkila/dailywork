import 'package:dailywork/model/model.dart';
import 'package:flutter/material.dart';

class DataCard extends StatelessWidget {
  const DataCard({Key? key, required this.data, required this.edit, required this.index, required this.delete}) : super(key: key);
  //get the datamodel values
  final DataModel data;
  //edit function
  final Function edit;
  final int index;
  //delete function initialize
  final Function delete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Container(
        height: 160,
        width: 400,
        decoration: BoxDecoration(color: Color.fromARGB(255, 52, 44, 5), borderRadius: BorderRadius.circular(20)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ListTile(
              leading: IconButton(
                onPressed: () {
                  edit(index);
                },
                icon: Icon(Icons.edit,color: Colors.amber,),
              ),
              trailing: IconButton(
                onPressed: () {
                  delete(index);
                },
                icon: Icon(Icons.delete,color: Colors.amber,),
              )),
              Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              data.date,
              style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              data.title,
              style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              data.description,
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              data.comment,
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
          ),
        ]),
      ),
    );
  }
}
