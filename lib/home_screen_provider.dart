import 'package:page_controller/components/data_source.dart';
import 'package:page_controller/components/view_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui show Image;

class HomeScreenProvider extends ChangeNotifier {
  HomeScreenProvider(this._dataSource);
  final DataSource _dataSource;

  int currentId = 0;

  bool isSelected(int id) => id == currentId;

  List<PageViewModel> get viewModels {
    return _dataSource.viewModels;
  }

  int get count {
    return viewModels.length;
  }

  PageViewModel get selectedViewModel {
    return viewModels[currentId];
  }

  void changeCurrentId(int newId) {
    currentId = newId % viewModels.length;
    notifyListeners();
    _dataSource.delegate?.pageDidOpened(selectedViewModel.pageType);
  }

  void tapMainButton() {
    _dataSource.delegate?.pageDidTapMainButton(selectedViewModel.pageType);
  }

  void openDetails() {
    print('OPEN DETAILS');
    _dataSource.delegate?.pageDidOpenDetailScreen(selectedViewModel.pageType);
  }

  void setDelegate(DataSourceDelegate delegate) {
    _dataSource.delegate = delegate;
  }
}

class PagePieceProvider extends ChangeNotifier {
  double? aspectRatio;
  ui.Image? uiImage;

  Future<void> load(String fileName) async {
    var img = await rootBundle.load('packages/page_controller/$fileName');
    var uiImage = await decodeImageFromList(img.buffer.asUint8List());
    this.uiImage = uiImage;
    aspectRatio = uiImage.width / uiImage.height;
  }
}
