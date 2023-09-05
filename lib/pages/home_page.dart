import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/direcciones_page.dart';
import 'package:qr_reader/pages/mapas_page.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Historial'),
        actions: [
          IconButton(onPressed: (){
            final ScanListProvider scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
            
            scanListProvider.borrarTodos();

          }, icon: Icon(Icons.delete_forever))
        ],),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final UiProvider uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    final tempScan = new ScanModel(valor: 'http://google.com');
    //inserción del registro
    /* DBProvider.db.nuevoScan(tempScan); */

    //metodo para obtener registro por id
    /* DBProvider.db.getScanById(3).then((scan) => print(scan!.valor)); */

    //Metodo para obtener todos los scans e imprimir su valor
    /* DBProvider.db.getAllScans().then( (scan) => scan!.forEach((element) { print(element.valor);}) ); */

    //Usar el ScanListProvider
    final ScanListProvider scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansPorTipo('geo');
        return MapasPage();

      case 1:
        scanListProvider.cargarScansPorTipo('http');
        return DireccionesPage();
        
      default:
        return MapasPage();
    }

  }
}