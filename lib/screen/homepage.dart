import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List cartList = [];
  var currentBookingData;

  Future<void> getCurrentBookingData() async {
    var response = await http.get(
      Uri.parse("http://cgprojects.in/flutter/"),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      currentBookingData = map["current_bookings"];
      print("currentBookingData...${currentBookingData["package_label"]}");

      List<dynamic> data = map["packages"];

      setState(() {
        cartList = data;
        print(cartList);
      });
    } else {
      print(' Error Api');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentBookingData();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: updateDrawer(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: currentBookingData != null
              ? SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: () {
                                _scaffoldKey.currentState!.openDrawer();
                              },
                              child: Container(
                                width: 25,
                                height: 20,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        AssetImage("assets/images/menus.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ))
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            width: 53,
                            height: 53,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: const DecorationImage(
                                image:
                                    AssetImage("assets/images/profilepic.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 10),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Welcome",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                "Emily Cyrus",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color(0xffE36DA6)),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Stack(
                          fit: StackFit.passthrough,
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Container(
                              height: screenHeight * 0.21,
                              width: screenWidth * 0.9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xffF5B5CF),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.only(
                                          left: 20.0, top: 35.0),
                                      child: SizedBox(
                                        width: 150,
                                        child: Text(
                                          'Nanny And Babysitting Services',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Color(0xff262F71),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, top: 10.0),
                                      child: Container(
                                          height: screenHeight * 0.035,
                                          width: screenWidth * 0.2,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: const Color(0xff262F71),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "Book Now",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )))
                                ],
                              ),
                            ),
                            Positioned(
                              top: -38,
                              right: 0,
                              child: Container(
                                height: screenHeight * 0.27,
                                width: screenWidth * 0.4,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/childimage.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                      const Padding(
                          padding: EdgeInsets.only(bottom: 10.0, top: 20.0),
                          child: Text(
                            "Your Current Booking",
                            style: TextStyle(
                            color: Color(0xff262F71),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: screenWidth * 0.9,
                          height: screenHeight * 0.22,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(currentBookingData["package_label"],
                                    style: const TextStyle(
                                        color: Color(0xffE36DA6),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                Container(
                                    height: screenHeight * 0.035,
                                    width: screenWidth * 0.25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xffE36DA6),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Start",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ))
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("From",
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                  SizedBox(
                                    width: screenWidth * 0.3,
                                  ),
                                  const Text("To",
                                      style: TextStyle(
                                        fontSize: 14,
                                      )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.date_range_outlined,
                                          color: Color(0xffE36DA6), size: 18),
                                      Text(currentBookingData["from_date"],
                                          style: const TextStyle(
                                            fontSize: 14,
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.16,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.date_range_outlined,
                                          color: Color(0xffE36DA6), size: 18),
                                      Text(currentBookingData["to_date"],
                                          style: const TextStyle(
                                            fontSize: 14,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.watch_later_outlined,
                                        color: Color(0xffE36DA6),
                                        size: 18,
                                      ),
                                      Text(currentBookingData["from_time"],
                                          style: TextStyle(
                                            fontSize: 14,
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.24,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.watch_later_outlined,
                                          color: Color(0xffE36DA6), size: 18),
                                      Text(currentBookingData["to_time"],
                                          style: TextStyle(
                                            fontSize: 14,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                  top: 20.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                        height: screenHeight * 0.036,
                                        width: screenWidth * 0.23,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color(0xff262F71),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.star_border_outlined,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              " Rate Us",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            )
                                          ],
                                        )),
                                    Container(
                                        height: screenHeight * 0.036,
                                        width: screenWidth * 0.26,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color(0xff262F71),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.location_on_outlined,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              " Geolocation",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            )
                                          ],
                                        )),
                                    Container(
                                        height: screenHeight * 0.036,
                                        width: screenWidth * 0.24,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color(0xff262F71),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              Icons.opacity_rounded,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              " Survillence",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            )
                                          ],
                                        ))
                                  ],
                                ))
                          ]),
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
                          child: Text(
                            "Packages",
                            style: TextStyle(
                            color: Color(0xff262F71),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                          )),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cartList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                padding: EdgeInsets.all(10.0),
                                height: screenHeight * 0.21,
                                width: screenWidth * 0.9,
                                child: Material(
                                    elevation: 4.0,
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: index % 2 == 0
                                        ? Color(0xffF0B3CD)
                                        : Color(0xff80ABDB),
                                    child: Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Stack(
                                                    alignment: Alignment.center,
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons
                                                            .calendar_today_outlined,
                                                        color: index % 2 == 0
                                                            ? Color(0xffD84D90)
                                                            : Color(0xffFFFFFF),
                                                        size: 28,
                                                      ),
                                                      Positioned(
                                                          top: 11,
                                                          right: 6,
                                                          child: index == 0
                                                              ? Text(
                                                                  "01",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          11,
                                                                      color: index % 2 ==
                                                                              0
                                                                          ? Color(
                                                                              0xffD84D90)
                                                                          : Color(
                                                                              0xffFFFFFF),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )
                                                              : index == 1
                                                                  ? Text(
                                                                      "03",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                          color: index % 2 == 0
                                                                              ? Color(0xffD84D90)
                                                                              : Color(0xffFFFFFF),
                                                                          fontWeight: FontWeight.bold),
                                                                    )
                                                                  : index == 2
                                                                      ? Text(
                                                                          "05",
                                                                          style: TextStyle(
                                                                              fontSize: 11,
                                                                              color: index % 2 == 0 ? Color(0xffD84D90) : Color(0xffFFFFFF),
                                                                              fontWeight: FontWeight.bold),
                                                                        )
                                                                      : Icon(
                                                                          Icons
                                                                              .wb_sunny_outlined,
                                                                          size:
                                                                              11,
                                                                          color:
                                                                              Color(0xffFFFFFF),
                                                                        ))
                                                    ],
                                                  ),
                                                  Container(
                                                      height:
                                                          screenHeight * 0.034,
                                                      width: screenWidth * 0.21,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        color: index % 2 == 0
                                                            ? Color(0xffE36DA6)
                                                            : Color(
                                                                0xff0098D0), //const Color(0xffE36DA6),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Book Now",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ))
                                                ]),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        cartList[index]
                                                            ["package_name"],
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff262F71),
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(children: [
                                                    Text(
                                                        '\u{20B9}${cartList[index]["price"]}',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff262F71),
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))
                                                  ])
                                                ]),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  SizedBox(
                                                    width: screenWidth * 0.79,
                                                    child: Text(
                                                      cartList[index]
                                                          ["description"],
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ])
                                          ],
                                        ))));
                          }),
                    ]))
              : const Center(
                  child: CircularProgressIndicator(color: Color(0xffE36DA6)),
                ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.build_circle_outlined, color: Colors.grey),
              label: 'Packages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.watch_later_outlined, color: Colors.grey),
              label: 'Bookings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_outlined, color: Colors.grey),
              label: 'profile',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: 0,
          selectedItemColor: const Color(0xffE36DA6)
          // onTap: _onItemTapped,
          ),
    );
  }

  Widget updateDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: AssetImage("assets/images/profilepic.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Emily Cyrus",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: const Color(0xffE36DA6)),
                    ),
                  ],
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () => {},
          ),

          ListTile(
            title: Text('Book A Nanny'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            title: Text('How It Works'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          // Divider(
          //   color: Colors.black,
          //   thickness: 0.3,
          // ),
          ListTile(
            title: Text('Why Nanny Vanny'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            title: Text('My Bookings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            title: Text('My Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            title: Text('Support'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
