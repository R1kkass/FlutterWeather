import "package:flutter/material.dart";
import "./button_canel.dart";

class AlertInput extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.green,
      content: Container(
        // SizedBox(
        //   height: 150,
        //   width: 150,
        //   child: Card(child: Text('Hello World!')),
        // ),
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text("Добавьте задачу",
                style: TextStyle(color: Colors.white, fontSize: 20)),
            const TextField(
              style: TextStyle(fontSize: 22.0, color: Color(0xFFbdc6cf)),
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Введите задачу",
                  focusedBorder: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.white)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(text: "Save", onPressed: (){
                  print("Click");
                }),
                const SizedBox(width: 8),
                MyButton(text: "Save", onPressed: (){
                  print("Click");
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
