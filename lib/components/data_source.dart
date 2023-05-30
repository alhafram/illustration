import 'package:page_controller/components/asset_view_model.dart';

abstract class DataSource {
  List<PageViewModel> viewModels = [];

  DataSource();

  DataSourceDelegate? delegate;
}

abstract class DataSourceDelegate {
  void pageDidOpened(Type pageType);
  void pageDidTapMainButton(Type pageType);
  void pageDidOpenDetailScreen(Type pageType);
}
