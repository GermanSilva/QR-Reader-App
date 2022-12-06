import 'package:flutter/cupertino.dart';

class UiProvider extends ChangeNotifier {
  int _selectedNavBarOption = 1;

  int get selectedNavBarOption {
    return _selectedNavBarOption;
  }

  set selectedNavBarOption(int index) {
    _selectedNavBarOption = index;
    notifyListeners();
  }
}
