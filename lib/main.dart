import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Calculator(title: 'Calculator'),
    );
  }
}

class Calculator extends StatefulWidget {
  Calculator({Key key, this.title}): super(key: key);
  final String title;
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = "0";
  String result = "0" ;
  String expression ="";
  double equationSize = 38;
  double resultSize = 60;
  bool isOpPressed = true;
  List ops = ['+', '×', '-', '√' ,'÷', '%'];
  Parser p = Parser();
  calculate(String buttonText){
    setState(() {
      // if(buttonText == '+' || buttonText == '-' || buttonText == '÷' || buttonText == '×' || buttonText == '√' || buttonText == '%'){
      //   isOpPressed = true;
      // }
      if(buttonText == "AC"){
        equation = "0";
        result = "0";
      }else if(buttonText == '±'){
        try {
          equation = (-1 * int.parse(equation)).toString();
        }
        catch(e){
          print(e);
        }
      }
      else if(buttonText == '='){

          try {
            expression = equation;
            expression = expression.replaceAll('×', '*');
            expression = expression.replaceAll('÷', '/');
            expression = expression.replaceAll('√', 'sqrt');

                    Expression exp = p.parse(expression);
                    ContextModel cm = ContextModel();
                    result = exp.evaluate(EvaluationType.REAL, cm).toStringAsFixed(2);
          } catch (e) {
            result = "Error";
          }

      }
      else{
        if(equation == '0'){
          equation = buttonText;
        }
        else {

            equation = equation + buttonText;


        }
      }
    });
  }

  Widget buildButton({String buttonText, double buttonHeight, Color textColor, Color buttonColor}){
    return  Container(
        height: MediaQuery.of(context).size.height * buttonHeight,
        color: buttonColor,
        child: TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
              side: BorderSide(
                  color: Colors.black12,
                  width: 0.5,
                  style: BorderStyle.solid
              ),
            ),
            padding: EdgeInsets.all(16),

          ),
          onPressed: ()=> calculate(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.normal,
                color: textColor

            ),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),

      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: equationSize),),
          ),
          Card(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(result, style: TextStyle(fontSize: resultSize, color: Colors.blue),),
            ),
          ),
          Expanded(
            child: Divider(),
             ),

          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton(buttonText: "√", textColor: Colors.white, buttonHeight: 0.1 , buttonColor: Colors.orangeAccent),
                        buildButton(buttonText: "±", textColor: Colors.white, buttonHeight: 0.1 , buttonColor: Colors.orangeAccent),
                        buildButton(buttonText: "%", textColor: Colors.white, buttonHeight: 0.1 , buttonColor: Colors.orangeAccent),

                      ]
                    ),
                    TableRow(
                        children: [
                          buildButton(buttonText: "7", textColor: Colors.black, buttonHeight: 0.1 , buttonColor: Colors.white),
                          buildButton(buttonText: "8", textColor: Colors.black, buttonHeight: 0.1 , buttonColor: Colors.white),
                          buildButton(buttonText: "9", textColor: Colors.black, buttonHeight: 0.1 , buttonColor: Colors.white),

                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton(buttonText: "6", textColor: Colors.black, buttonHeight: 0.1 , buttonColor: Colors.white),
                          buildButton(buttonText: "5", textColor: Colors.black, buttonHeight: 0.1 , buttonColor: Colors.white),
                          buildButton(buttonText: "4", textColor: Colors.black, buttonHeight: 0.1 , buttonColor: Colors.white),

                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton(buttonText: "3", textColor: Colors.black, buttonHeight: 0.1 , buttonColor: Colors.white),
                          buildButton(buttonText: "2", textColor: Colors.black, buttonHeight: 0.1 , buttonColor: Colors.white),
                          buildButton(buttonText: "1", textColor: Colors.black, buttonHeight: 0.1 , buttonColor: Colors.white),

                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton(buttonText: ".", textColor: Colors.black, buttonHeight: 0.1 ,buttonColor:  Colors.white),
                          buildButton(buttonText: "0", textColor: Colors.black, buttonHeight: 0.1 ,buttonColor:  Colors.white),
                          buildButton(buttonText: "=", textColor: Colors.black, buttonHeight: 0.1 ,buttonColor:  Colors.white),

                        ]
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton(buttonText: "AC", buttonColor: Colors.white,  textColor: Colors.black, buttonHeight: 0.1),

                      ]
                    ),
                    TableRow(
                        children: [
                          buildButton(buttonText: "÷", textColor: Colors.white, buttonHeight: 0.1, buttonColor: Colors.orangeAccent),

                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton(buttonText: "×", textColor: Colors.white, buttonHeight: 0.1, buttonColor: Colors.orangeAccent),

                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton(buttonText: "-", textColor: Colors.white, buttonHeight: 0.1, buttonColor: Colors.orangeAccent),

                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton(buttonText: "+", textColor: Colors.white, buttonHeight: 0.1, buttonColor: Colors.orangeAccent),

                        ]
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
