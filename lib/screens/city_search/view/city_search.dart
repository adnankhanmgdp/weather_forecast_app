import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_forcast_app/screens/city_search/controller/city_search_controller.dart';

import 'package:weather_forcast_app/utility/local_storage.dart';


class SearchCity extends StatefulWidget {
  final bool fromHome;
  const SearchCity({super.key, this.fromHome = false});
  @override
  State<SearchCity> createState() => _SearchCityState();
}

class _SearchCityState extends State<SearchCity> {
  final TextEditingController _cityController = TextEditingController();
  String city = "";
  String temp = "";

  void setEverything() async {
    city = await WeatherPreferences.getCity() ?? "";
    if(city != "") {
      city = city.substring(0, 1).toUpperCase() + city.substring(1);
    }
    temp = await WeatherPreferences.getTemp() ?? "";
    if(temp != "") {
      temp = temp.split('.')[0];
    }
    setState(() {});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setEverything();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: (!widget.fromHome)
          ? AppBar(
              backgroundColor: Colors.grey[900],
              iconTheme: const IconThemeData(color: Colors.white),
            )
          : null,
      body: Consumer(builder: (context, ref, child) {
        return Container(
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (widget.fromHome)
                    ? const SizedBox(
                        height: 50,
                      )
                    : const SizedBox(
                        height: 0,
                      ),
                Text("Manage cities",
                    style:
                        GoogleFonts.aBeeZee(color: Colors.white, fontSize: 35)),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  style: GoogleFonts.aBeeZee(color: Colors.white),
                  validator: (value) {
                    if (value!.trim().length < 3) {
                      return 'Please enter valid city name';
                    }
                    return null;
                  },
                  controller: _cityController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Enter City Name',
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    errorStyle: GoogleFonts.aBeeZee(color: Colors.red),
                    hintStyle: GoogleFonts.aBeeZee(color: Colors.white),
                    fillColor: Colors.grey[800],
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () => CitySearchController.onCitySelected(
                        ref, _cityController.value.text.trim(), context),
                    child: const Text('Search'),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                (city != "")?
                GestureDetector(
                  onTap: () =>
                      CitySearchController.onCitySelected(ref, city, context),
                  child: Container(
                    width: width * 0.9,
                    // height: 100,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 0, 108, 197),
                          Color.fromARGB(255, 21, 138, 222),
                        ],
                        stops: [0.5, 0.9],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(.0),
                              child: Text(city,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 25)),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("$temp°",
                              style: GoogleFonts.aBeeZee(
                                  color: Colors.white, fontSize: 45)),
                        ),
                      ],
                    ),
                  ),
                ):const SizedBox(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
