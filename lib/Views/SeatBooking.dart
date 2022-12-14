// Author - N.W.R.Amasha
////created Date - 10/8/2019
////TITLE - Seats booking page(SCREEN 3)

/*
    * User can select how many passengers(number of passengers) traveling
    * According to classes the seat panel is shown
    * On the seat panel user can choose the seats they want to book
    * Seat panel is connected to the database to know the previous booked seats
 */

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';


import 'package:train/Views/Login.dart';



class SeatBookingPage extends StatelessWidget {
  String start;
  String end;
  String startTime;
  String endTime;
  String date;
  String trainName;
  String trainClass;
  SeatBookingPage(this.start,this.end,this.startTime,this.endTime,this.date,this.trainName,this.trainClass);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue[800],
        accentColor: Colors.cyan[600],
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Seat Booking'),
            backgroundColor: Color(0xFF2d3447),
            leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
              Navigator.pop(context);
            }),
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                CardDetails(start,end,startTime,endTime,date,trainName,trainClass),
                PassengerDet(),
                SeatsView(),
                PayBtn()
              ],
            ),
          )),
    );
  }
}

class CardDetails extends StatelessWidget {
  String start;
  String end;
  String startTime;
  String endTime;
  String date;
  String trainName;
  String trainClass;
  CardDetails(this.start,this.end,this.startTime,this.endTime,this.date,this.trainName,this.trainClass);
  @override
  Widget build(BuildContext context) {
    return new Card(
      child: Container(
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 15.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bgImage.jpg'),
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.multiply),
                fit: BoxFit.cover),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$start - $end',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '$trainName / $trainClass',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '$date @ $startTime - $endTime',
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ],
          )),
    );
  }
}

class PassengerDet extends StatefulWidget {
  @override
  _PassengerDet createState() => new _PassengerDet();
}

class _PassengerDet extends State<PassengerDet> {
  int _passengers = 1;


  void _showDialogAdults() {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return new NumberPickerDialog.integer(
            minValue: 1,
            maxValue: 20,
            title: new Text("No of passengers"),
            initialIntegerValue: _passengers,
          );
        }).then((int value) {
      setState(() => _passengers = value);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Passengers : $_passengers',
                style: TextStyle(
                  fontSize: 16.0,
                  // color: Colors.white
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _showDialogAdults();
              },
              child: Text('Add'),
            ),
          ],
        ),
        Row(
          children: <Widget>[],
        ),
      ],
    );
  }
}

//--------Seat Panel-----------------------------------------------------
class SeatsView extends StatefulWidget {
  @override
  _seatsView createState() => new _seatsView();
}

class _seatsView extends State<SeatsView> {
  Color cellColor = Colors.blue.shade300;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Seats Number '/*${_SeatController().sendSelectedlst()}*/,
                  style: TextStyle(
                    fontSize: 16.0,
                    // color: Colors.white
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
              ],
            )),
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(5.0),
          height: MediaQuery.of(context).size.height / 2,
          child: new GridView.count(
            crossAxisCount: 4,
            children: new List.generate(16, (index) {
              return new SeatController(
                color: cellColor,
                index: index,
              );
            }),
          ),
        ),
      ],
    );
  }

}

//controller
List selectedSeats = new List();
class SeatController extends StatefulWidget {
  final Color color;
  final int index;
  final String seatNo;

  SeatController({this.color, this.index, this.seatNo});
  @override
  _SeatController createState() => new _SeatController();
}

class _SeatController extends State<SeatController> {

  Color cellColor = Colors.blue.shade300;
  String seatNo;

  final List seatList = [
    '1A',
    '1B',
    '1C',
    '1D',
    '2A',
    '2B',
    '2C',
    '2D',
    '3A',
    '3B',
    '3C',
    '3D',
    '4A',
    '4B',
    '4C',
    '4D'
  ];

  @override
  void initState() {
    super.initState();
    cellColor = widget.color;

    for (int i = 0; i < 16; i++) {
      if (i == widget.index) {
        seatNo = seatList[i];
      }
    }
  }

  _changeCell(index) {
    setState(() {
      for (int i = 0; i < 16; i++) {
        if (i == index) {
          // to reserve the seats
          if (cellColor == Colors.blue.shade300) {
            cellColor = Colors.red.shade300;
            selectedSeats.add(seatList[index]);
            print(selectedSeats);
          } else {
            //to undo the selected the seats
            cellColor = Colors.blue.shade300;
            selectedSeats.remove(seatList[index]);
          }
        }
      }
    });
    print("Container clicked " + seatList[index]);

  }

  void _clearSeats(List lst) {
    selectedSeats.clear();
    setState(() {
      for(int i=0;i<seatList.length;i++){
        cellColor =Colors.blue.shade300;
      }
    });
  }
  Future<String> sendSelectedlst(){
    return seatList[widget.index];
  }

  @override
  Widget build(BuildContext context) {

    return new GestureDetector(
      onTap: () {
        _changeCell(widget.index);

      },

      child: new Container(
        margin: new EdgeInsets.symmetric(horizontal: 1.0, vertical: 1.0),
        decoration: new BoxDecoration(
          color: cellColor,
        ),
        child: Center(
          child: Text('$seatNo'),
        ),
      ),
    );
  }
}

class PayBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/2),
      //alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => LoginPage()));
        },
        child: Text(
          'PAY',
          style: TextStyle(fontSize: 25.0, color: Colors.white),
        ),
      ),
    );

  }
}
