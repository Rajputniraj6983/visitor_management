import 'package:flutter/material.dart';

class Helpsupport extends StatelessWidget {
  const Helpsupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent.shade100,
        title: const Text(
          'Help & Support',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Comapny Profile',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              Divider(
                endIndent: 225,
                color: Colors.deepOrangeAccent.shade100,
                thickness: 1.5,
              ),
              Text(
                "We believe in Teamwork so large group of professionals from different segments of information andTechnology industry have joined hands with us to build better business environment. Showing theLeverage in collective technological resources available – Shree sai computer world, was incorporated as a Genuine Service in the year 2006 and was vastly experienced in us, our main objective is to offerTimely quality service to our clients as they believed and shown trust in us.",
                style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
              ),
              SizedBox(height: 15),
              Text(
                "Mission",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              Divider(
                endIndent: 300,
                color: Colors.deepOrangeAccent.shade100,
                thickness: 1.5,
              ),
              Text(
                "To organize and upgrade ourselves to advance technology and to cover gap in technical IT Industry andbe one of the Best IT solution Provider by expanding our branches through its Quality and GenuineService in south Gujarat.",
                style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
              ),
              SizedBox(height: 15),
              Text(
                "Infrasture",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              Divider(
                endIndent: 290,
                color: Colors.deepOrangeAccent.shade100,
                thickness: 1.5,
              ),
              Text(
                "Our main focus is on the customer needs and constant innovations as our strong team comes from years of IT experience, we are steady to listen to the needs of the customer and provide the better solutions to your day to day requirement in the IT, IT user the very best in sales and marketing support, we ar here backed up to bring advanced technology.",
                style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
              ),
              SizedBox(height: 15),
              Text(
                "Our Services",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              Divider(
                endIndent: 265,
                color: Colors.deepOrangeAccent.shade100,
                thickness: 1.5,
              ),
              Row(
                children: [
                  Text(
                    "Shree Sai Computer World",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w900),
                  ),
                  Text(
                    "  provides services:-",
                    style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.black,
                    size: 7,
                  ),
                  Text(
                    ' CCTV CAMERA & SECURITY –',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w900),
                  ),
                  Flexible(
                    child: Text(
                      ' Keep your offices & home live.',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.black,
                    size: 7,
                  ),
                  Text(
                    ' ATTENDANCE SOLUTIONS –',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w900),
                  ),
                  Flexible(
                    child: Text(
                      ' save your man power.',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.black,
                    size: 7,
                  ),
                  Text(
                    ' NETWORKING SOLUTIONS -',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w900),
                  ),
                  Flexible(
                    child: Text(
                      ' Keeping you Connected.',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.black,
                    size: 7,
                  ),
                  Text(
                    ' AMC SERVICES -',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w900),
                  ),
                  Flexible(
                    child: Text(
                      ' Complete support and services',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.black,
                    size: 7,
                  ),
                  Text(
                    ' DATA RECOVERY -',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w900),
                  ),
                  Flexible(
                    child: Text(
                      ' Data Backups & Recovery',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.black,
                    size: 7,
                  ),
                  Text(
                    ' FIREWALL –',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w900),
                  ),
                  Flexible(
                    child: Text(
                      ' UTM Solutions.',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.black,
                    size: 7,
                  ),
                  Text(
                    ' HOME AUTOMATION -',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w900),
                  ),
                  Flexible(
                    child: Text(
                      ' save your Time Money Increase Conveniences',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.black,
                    size: 7,
                  ),
                  Text(
                    ' FIRE ALARAM –',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w900),
                  ),
                  Flexible(
                    child: Text(
                      ' Interfaced Fire Detection and Voice Alarm.',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.black,
                    size: 7,
                  ),
                  Text(
                    ' DOOR LOCK & BUGLER (INTRUDER) ALARAM SOLUTIONS',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 13),
                  ),
                  Flexible(
                    child: Text(
                      ' GATE & ENRTY AUTOMATIONS–Open Your Gate Effortlessly, Secure Access To Your Entry',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.black,
                    size: 7,
                  ),
                  Text(
                    ' DOOR LOCK & BUGLER (INTRUDER) ALARAM SOLUTIONS',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w900),
                  ),
                  Flexible(
                    child: Text(
                      ' –Protect Your Premises From Theft',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.black,
                    size: 7,
                  ),
                  Text(
                    ' WIRELESS NETWORKING (P2P) ',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w900),
                  ),
                  Flexible(
                      child: Text(
                    ' – keep you connected wirelessly Any where',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis),
                  ),),
                ],
              ),SizedBox(height: 15),
              Row(
                children: [
                  Icon(Icons.arrow_forward,color: Colors.black,),SizedBox(width: 10,),
                  Text("For Complaint - Inquiry : 9898170002",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),),
                ],
              ),
              SizedBox(height: 10),
              Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        "Developed by  ",
                        style: TextStyle(
                          fontSize: 15,
                             color: Colors.deepOrangeAccent.shade200),
                      ),
                      Text(
                        'Beckon Services',
                        style: TextStyle(fontSize: 20,color: Colors.deepOrangeAccent.shade200),
                      )
                    ],
                  ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
