import 'package:flutter/material.dart';

import 'package:math_expressions/math_expressions.dart';

void main ()
{
  runApp(Calculator());
}

class Calculator extends StatelessWidget {

  @override

  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      theme: ThemeData(primarySwatch: Colors.brown),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget
{
  @override

  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator>{

  String equation = '0';
  String result = '0';
  String expression = '';
  double equationFontSize = 30;
  double resultFontSize = 30;

  buttonPressed (String buttonText)
  {
    setState(() {

      if (buttonText == 'C')
        {
          equation = result = '0';
          equationFontSize = resultFontSize = 30;
        }
      else if ( buttonText == '⌫')
        {
          equationFontSize = resultFontSize = 30;
          equation = equation.substring(0,equation.length-1);

            if (equation == '')
              {
                equation = '0';
              }
        }
      else if ( buttonText == '=')
        {
          equationFontSize = resultFontSize = 30;
          expression = equation;
          expression = expression.replaceAll('×', '*');
          expression = expression.replaceAll('÷', '/');
          
            try {
                Parser p = Parser();
                Expression exp = p.parse(expression);
                ContextModel cm = ContextModel();
                result = '${exp.evaluate(EvaluationType.REAL, cm)}';
              
            }catch(e) {
              result = 'Error';
            }
            
        } else {

          equationFontSize = resultFontSize = 30;
          if (equation == '0')
            {
              equation = buttonText;
            }else {
            equation = equation + buttonText;
          }
      }


    });
  }

  Widget buildButton (String buttonText, double buttonHeight, Color buttonColor) {

    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.1 * buttonHeight,
      child: TextButton(
        onPressed: ()=> buttonPressed(buttonText),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.black),
            backgroundColor: MaterialStateProperty.all(buttonColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                  side: const BorderSide(color: Colors.black, width: 1),
                )
            )
        ),

        child: Text(buttonText, style:
        const TextStyle(fontSize: 30.0,
          fontWeight: FontWeight.normal,
        ),
        ),

      ),
    );
  }


  @override

  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator'),),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation, style: TextStyle(
              fontSize: equationFontSize,
            ),

            ),

          ),

          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(result, style: TextStyle(
              fontSize: resultFontSize,
            ),

            ),
          ),
          Expanded(child: Divider()),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .70,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton('C',1 , Colors.brown.shade100),
                        buildButton('⌫',1 , Colors.brown.shade100),
                        buildButton('%',1 , Colors.brown.shade100),

                      ]
                    ),

                    TableRow(
                        children: [
                          buildButton('7',1 , Colors.brown.shade100),
                          buildButton('8',1 , Colors.brown.shade100),
                          buildButton('9',1 , Colors.brown.shade100),

                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton('4',1 , Colors.brown.shade100),
                          buildButton('5',1 , Colors.brown.shade100),
                          buildButton('6',1 , Colors.brown.shade100),

                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton('1',1 , Colors.brown.shade100),
                          buildButton('2',1 , Colors.brown.shade100),
                          buildButton('3',1 , Colors.brown.shade100),

                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton('.',1 , Colors.brown.shade100),
                          buildButton('0',1 , Colors.brown.shade100),
                          buildButton('00',1 , Colors.brown.shade100),

                        ]
                    ),
                  ],
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.23,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton('×', 1, Colors.brown.shade200),
                      ]
                    ),
                    TableRow(
                        children: [
                          buildButton('-', 1, Colors.brown.shade200),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton('+', 1, Colors.brown.shade200),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton('÷', 1, Colors.brown.shade200),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton('=', 1, Colors.brown.shade200),
                        ]
                    ),
                  ],
                ),
              ),

            ],
          ),
          SizedBox(height: 50,),
        ],
      ),
    );
  }
}