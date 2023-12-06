import 'package:dailywork/card/datacard.dart';
import 'package:dailywork/database/Datebase.dart';
import 'package:dailywork/model/model.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  late DB db;

  List<DataModel> datas = [];

  bool fetching = true;
  int currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = DB();
    getData2();
  }

  void getData2() async {
    datas = await db.getData();
    setState(() {
      fetching = false;
    });
  }

  void _reset() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (_, __, ___) => MyHomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Todo"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  _reset();
                },
                icon: Icon(
                  Icons.restart_alt,
                  color: Colors.amber,
                ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showMyDialog();
          },
          child: Icon(
            Icons.add,
            size: 25,
          ),
        ),
        body: fetching
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: datas.length,
                itemBuilder: ((context, index) => DataCard(
                      data: datas[index],
                      edit: edit,
                      index: index,
                      delete: delete,
                    ))));
  }

  void showMyDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(14),
            content: Container(
              height: 260,
              child: Column(
                children: [
                  TextFormField(
                    controller: dateController,
                    decoration: InputDecoration(hintText: "Date"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(hintText: "Title"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(hintText: "Description"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: commentController,
                    decoration: InputDecoration(hintText: "Description"),
                  ),
                ],
              ),
            ),
            actions: [
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    DataModel datalocal = DataModel(title: titleController.text, description: descriptionController.text, date: dateController.text, comment: commentController.text);
                    db.insertDB(datalocal);
                    // One datalocal.id = 1;
                    setState(() {
                      datas.add(datalocal);
                    });
                    titleController.clear();
                    descriptionController.clear();
                    dateController.clear();
                    commentController.clear();

                    Navigator.pop(context);
                  },
                  child: Text("Save"))
            ],
          );
        });
  }

  void showMyDialogUpdate() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(14),
            content: Container(
              height: 260,
              child: Column(
                children: [
                  TextFormField(
                    controller: dateController,
                    decoration: InputDecoration(hintText: "Date"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(hintText: "Title"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(hintText: "Description"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: commentController,
                    decoration: InputDecoration(hintText: "Description"),
                  ),
                ],
              ),
            ),
            actions: [
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    DataModel newData = datas[currentIndex];
                    newData.title = titleController.text;
                    newData.description = descriptionController.text;
                    newData.date = dateController.text;
                    newData.comment = commentController.text;
                    db.updateData(newData, newData.id!);
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: Text("Update"))
            ],
          );
        });
  }

  void edit(index) {
    currentIndex = index;
    titleController.text = datas[index].title;
    descriptionController.text = datas[index].description;
    dateController.text = datas[index].date;
    commentController.text = datas[index].comment;
    showMyDialogUpdate();
  }

  void delete(int index) async {
    db.deleteData(datas[index].id!);
    setState(() {
      datas.removeAt(index);
    });
  }
}
