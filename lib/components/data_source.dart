import 'package:page_controller/components/view_models.dart';

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
