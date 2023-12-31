import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_app/models/city.dart';
import 'package:quran_app/services/jadwal_sholat.dart';
import 'package:quran_app/widgets/city_item.dart';

class JadwalSholatScreen extends StatefulWidget {
  const JadwalSholatScreen({super.key});

  @override
  State<JadwalSholatScreen> createState() => _JadwalSholatScreenState();
}

class _JadwalSholatScreenState extends State<JadwalSholatScreen> {
  List<City> _allCities = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    JadwalSholatService.getCities().then((value) {
      setState(() {
        _allCities = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 32,
                  left: 12,
                  right: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Jadwal Sholat",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF672CBC),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _allCities.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return CityItem(
                            number: index + 1,
                            id: _allCities[index].id,
                            city: _allCities[index].city,
                          );
                        },
                        itemCount: _allCities.length,
                      )
                    : const Text("Loading..."),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
