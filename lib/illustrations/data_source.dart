import 'package:illustration/illustrations/view_models.dart';

abstract class DataSource {
  List<IllustrationViewModel> viewModels = [];

  DataSource();

  DataSourceDelegate get delegate;
}

abstract class DataSourceDelegate {
  void pageDidOpened(Type pageType);
  void pageDidTapMainButton(Type pageType);
}
