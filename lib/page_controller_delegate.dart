import 'package:page_controller/asset_view_model.dart';

abstract class PageControllerDelegate {
  void pageDidOpened(PageType pageType);
  void pageDidTapMainButton(PageType pageType);
  void pageDidOpenDetailScreen(PageType pageType);
}
