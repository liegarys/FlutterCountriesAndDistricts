// ignore_for_file: prefer_const_constructors, must_be_immutable, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iller_ilceler_proje/il.dart';
import 'package:iller_ilceler_proje/ilce.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Il> iller = [];

  void _jsonCozumle() async {
    String jsonString =
        await rootBundle.loadString("assets/iller_ilceler.json");

    Map<String, dynamic> illerMap = json.decode(jsonString);

    for (String plakaKodu in illerMap.keys) {
      Map<String, dynamic> ilMap = illerMap[plakaKodu];
      String il_ismi = ilMap["name"];

      Map<String, dynamic> ilcelerMap = ilMap["districts"];
      List<Ilce> tumIlceler = [];

      for (String ilce_kodu in ilcelerMap.keys) {
        Map<String, dynamic> ilceMap = ilcelerMap[ilce_kodu];
        String ilce_ismi = ilceMap["name"];

        Ilce ilce = Ilce(ilce_ismi);
        tumIlceler.add(ilce);
      }

      Il il = Il(il_ismi, plakaKodu, tumIlceler);
      iller.add(il);
    }

    setState(() {});
  }

  Widget _listeOgesiOlustur(BuildContext context, int index) {
    return Card(
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(iller[index].il_ismi),
            Text(iller[index].plaka_kodu),

          ],
        ),
        leading: Icon(Icons.location_city),
        children: iller[index].ilceler.map((ilce) {
          return ListTile(
            title: Text(ilce.ilce_ismi),
          );
        }).toList(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      _jsonCozumle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ana Sayfa"),
      ),
      body: ListView.builder(
          itemCount: iller.length, itemBuilder: _listeOgesiOlustur),
    );
  }
}
