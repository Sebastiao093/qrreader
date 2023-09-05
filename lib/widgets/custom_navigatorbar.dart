import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final UiProvider uiProvider = Provider.of<UiProvider>(context);

    return BottomNavigationBar(
      onTap: (int i) => uiProvider.selectedMenuOpt = i,
      selectedItemColor: Colors.indigo,
      currentIndex: uiProvider.selectedMenuOpt,
      elevation: 0,
      items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.map),
      label: 'Mapa'),

      BottomNavigationBarItem(icon: Icon(Icons.compass_calibration),
      label: 'Direcciones')

    ]);
  }
}