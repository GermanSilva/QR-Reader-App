import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader_app/providers/db_provider.dart';
import 'package:qr_reader_app/providers/ui_provider.dart';
import 'package:qr_reader_app/screens/screens.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete_forever,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: const _HomeScreenBody(),
      bottomNavigationBar: const CustomNavBar(),
      floatingActionButton: const CustomFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedNavBarOption;

    final tempScan = ScanModel(valor: 'http://loona.com');
    // -- Create (Registrar)
    // DBProvider.db.newScan(tempScan);
    // -- Read (Leer)
    // DBProvider.db.getScanById(5);
    // DBProvider.db.getAllScans();
    // DBProvider.db.getScanByTipo('http');
    // -- Update (Actualizar)
    // DBProvider.db.updateScan(ScanModel(id: 2, valor: 'http://loona.com'));
    // -- Delete (Borrar)
    DBProvider.db.deleteScanById(3);
    DBProvider.db.getAllScans();

    switch (currentIndex) {
      case 0:
        return const MapHistoryScreen();
      case 1:
        return const LinksScreen();
      default:
        return const MapHistoryScreen();
    }
  }
}
