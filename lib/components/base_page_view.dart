import 'package:page_controller/home_screen_provider.dart';
import 'package:page_controller/components/fade_color_transition.dart';
import 'package:page_controller/components/pager_piece.dart';
import 'package:page_controller/components/view_models.dart';
import 'package:page_controller/components/pager_texture.dart';
import 'package:page_controller/components/pager_builder.dart';
import 'package:page_controller/components/page_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasePageView extends StatelessWidget {
  final PageViewModel pageViewModel;
  final PageConfig config;

  const BasePageView(
      {super.key, required this.pageViewModel, required this.config});
  @override
  Widget build(BuildContext context) {
    return PagerBuilder(
        config: config,
        bgBuilder: _buildBg,
        mgBuilder: _buildMg,
        fgBuilder: _buildFg);
  }

  List<Widget> _buildBg(BuildContext context, Animation<double> anim) {
    return [
      FadeColorTransition(animation: anim, color: pageViewModel.color),
      Positioned.fill(
          child: PagerTexture.withViewModel(
              viewModel: pageViewModel.textureViewModel,
              opacity: anim.drive(pageViewModel.textureViewModel.tween))),
      ChangeNotifierProvider(
          create: (_) => PagePieceProvider(),
          child: PagerPiece.withViewModel(
              viewModel: pageViewModel.backgroundViewModel))
    ];
  }

  List<Widget> _buildMg(BuildContext context, Animation<double> anim) {
    if (pageViewModel.offset != null) {
      return [
        Transform.translate(
            offset: pageViewModel.offset!,
            child: ChangeNotifierProvider(
                create: (_) => PagePieceProvider(),
                child: PagerPiece.withViewModel(
                    viewModel: pageViewModel.middlegroundViewModel)))
      ];
    }
    if (pageViewModel.clipBehavior != null) {
      return [
        ClipRect(
            clipBehavior: pageViewModel.clipBehavior!,
            child: ChangeNotifierProvider(
                create: (_) => PagePieceProvider(),
                child: PagerPiece.withViewModel(
                    viewModel: pageViewModel.middlegroundViewModel)))
      ];
    }
    if (pageViewModel.heightFactor != null && pageViewModel.alignment != null) {
      return [
        FractionallySizedBox(
            heightFactor: pageViewModel.heightFactor!,
            alignment: pageViewModel.alignment!,
            child: ChangeNotifierProvider(
                create: (_) => PagePieceProvider(),
                child: PagerPiece.withViewModel(
                    viewModel: pageViewModel.middlegroundViewModel)))
      ];
    }
    var provider = context.read<HomeScreenProvider>();
    return [
      Positioned(
          top: 100,
          left: 100,
          child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: provider.tapMainButton,
              child: Text('Main button'))),
      ChangeNotifierProvider(
          create: (_) => PagePieceProvider(),
          child: PagerPiece.withViewModel(
              viewModel: pageViewModel.middlegroundViewModel))
    ];
  }

  List<Widget> _buildFg(BuildContext context, Animation<double> anim) {
    var list = List<Widget>.empty(growable: true);
    for (var viewModel in pageViewModel.foregroundViewModels) {
      list.add(ChangeNotifierProvider(
          create: (_) => PagePieceProvider(),
          child: PagerPiece.withViewModel(viewModel: viewModel)));
    }
    return list;
  }
}
