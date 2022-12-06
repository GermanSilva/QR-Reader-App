import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader_app/providers/ui_provider.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedNavBarOption;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      iconSize: 35,
      selectedFontSize: 0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
        BottomNavigationBarItem(icon: Icon(Icons.link), label: 'Links'),
      ],
      onTap: (value) => uiProvider.selectedNavBarOption = value,
    );
  }
}
