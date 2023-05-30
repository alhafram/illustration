import 'package:page_controller/asset_view_model.dart';
import 'package:page_controller/page_controller_delegate.dart';

abstract class PageControllerDataSource {
  List<PageViewModel> viewModels = [];

  PageControllerDataSource();

  PageControllerDelegate? delegate;
}
