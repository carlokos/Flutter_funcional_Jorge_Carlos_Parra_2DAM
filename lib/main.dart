import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  double billAmount = 0, tipPercentage = 0, people = 1, totalAmount = 0, tipAmount = 0;

  void tipDecrement(){
    setState(() {
      tipPercentage--;
    });
  }

  void tipIncrement(){
    setState(() {
      tipPercentage++;
    });
  }

  void peopleDecrement(){
    setState(() {
      people--;
    });
  }

  void peopleIncrement(){
    setState(() {
      people++;
    });
  }

  void calculate(){
    if(people == 1){
      setState(() {
        tipAmount = billAmount * (tipPercentage/100);
        totalAmount = billAmount + tipAmount;
      });
    } else{
      setState(() {
        tipAmount = billAmount * (tipPercentage/100);
        tipAmount = tipAmount/people;
        double billPerperson = billAmount/people;
        totalAmount = billAmount + tipAmount;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Calculadora de propinas", style: TextStyle(
              fontSize: 17
            ),),
            SizedBox(height: 20,),
            TextField(
              onChanged: (val){
                billAmount = double.parse(val);
              },
              decoration: InputDecoration(
                hintText: "cantidad de la factura"
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20,),
            Row(
              children: <Widget>[
                Text("Tip %"),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    while(tipPercentage >= 1){
                      tipDecrement();
                    }
                  }, child: Icon(Icons.remove_circle)),
                SizedBox(width: 8,),
                Text("${tipPercentage} %"),
                GestureDetector(
                  onTap: (){
                    tipIncrement();
                  }, child: Icon(Icons.add_circle)),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: <Widget>[
                Text("Personas: "),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    while(people >= 2){
                      peopleDecrement();
                    }
                  }, child: Icon(Icons.remove_circle)),
                SizedBox(width: 8,),
                Text("${people} "),
                SizedBox(width: 8,),
                GestureDetector(
                  onTap: (){
                    peopleIncrement();
                  }, child: Icon(Icons.add_circle)),
              ],
            ),
            SizedBox(height: 40,),
            GestureDetector(
              onTap: (){
                if(billAmount > 0){
                  calculate();
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(24)
                ),
                child: Text("Calcular", style: TextStyle(
                  color: Colors.white,
                  fontSize: 17
                ),),
              ),
            ),
            tipAmount != 0 ? Text(
              people == 1 ? "Tip: $tipAmount" : "Tip : $tipAmount por persona"
              ) : Container(),
            SizedBox(height: 8,),
            totalAmount != 0 ? Text(
              people == 1 ? "Total: $totalAmount" : "Cantidad total : $totalAmount por persona" 
              ): Container()
          ],
        )
      ),
    );
  }
}
