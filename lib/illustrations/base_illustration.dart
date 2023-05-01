import 'package:illustration/home_screen_provider.dart';
import 'package:illustration/illustrations/fade_color_transition.dart';
import 'package:illustration/illustrations/illustration_piece.dart';
import 'package:illustration/illustrations/view_models.dart';
import 'package:illustration/illustrations/paint_textures.dart';
import 'package:illustration/illustrations/illustration_builder.dart';
import 'package:illustration/illustrations/illustration_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseIllustration extends StatelessWidget {
  final IllustrationViewModel illustrationViewModel;
  final IllustrationConfig config;

  const BaseIllustration(
      {super.key, required this.illustrationViewModel, required this.config});
  @override
  Widget build(BuildContext context) {
    return IllustrationBuilder(
        config: config,
        bgBuilder: _buildBg,
        mgBuilder: _buildMg,
        fgBuilder: _buildFg);
  }

  List<Widget> _buildBg(BuildContext context, Animation<double> anim) {
    return [
      FadeColorTransition(
          animation: anim,
          color: illustrationViewModel.backgroundViewModel.color),
      Positioned.fill(
          child: IllustrationTexture.withViewModel(
              viewModel:
                  illustrationViewModel.backgroundViewModel.textureViewModel,
              opacity: anim.drive(illustrationViewModel
                  .backgroundViewModel.textureViewModel.tween))),
      ChangeNotifierProvider(
          create: (_) => IllustrationPieceProvider(),
          child: IllustrationPiece.withViewModel(
              viewModel: illustrationViewModel
                  .backgroundViewModel.illustrationPieceViewModel))
    ];
  }

  List<Widget> _buildMg(BuildContext context, Animation<double> anim) {
    if (illustrationViewModel.middlegroundViewModel.offset != null) {
      return [
        Transform.translate(
            offset: illustrationViewModel.middlegroundViewModel.offset!,
            child: ChangeNotifierProvider(
                create: (_) => IllustrationPieceProvider(),
                child: IllustrationPiece.withViewModel(
                    viewModel: illustrationViewModel
                        .middlegroundViewModel.illustrationPieceViewModel)))
      ];
    }
    if (illustrationViewModel.middlegroundViewModel.clipBehavior != null) {
      return [
        ClipRect(
            clipBehavior:
                illustrationViewModel.middlegroundViewModel.clipBehavior!,
            child: ChangeNotifierProvider(
                create: (_) => IllustrationPieceProvider(),
                child: IllustrationPiece.withViewModel(
                    viewModel: illustrationViewModel
                        .middlegroundViewModel.illustrationPieceViewModel)))
      ];
    }
    if (illustrationViewModel.middlegroundViewModel.heightFactor != null &&
        illustrationViewModel.middlegroundViewModel.alignment != null) {
      return [
        FractionallySizedBox(
            heightFactor:
                illustrationViewModel.middlegroundViewModel.heightFactor!,
            alignment: illustrationViewModel.middlegroundViewModel.alignment!,
            child: ChangeNotifierProvider(
                create: (_) => IllustrationPieceProvider(),
                child: IllustrationPiece.withViewModel(
                    viewModel: illustrationViewModel
                        .middlegroundViewModel.illustrationPieceViewModel)))
      ];
    }
    return [
      ChangeNotifierProvider(
          create: (_) => IllustrationPieceProvider(),
          child: IllustrationPiece.withViewModel(
              viewModel: illustrationViewModel
                  .middlegroundViewModel.illustrationPieceViewModel))
    ];
  }

  List<Widget> _buildFg(BuildContext context, Animation<double> anim) {
    var list = List<Widget>.empty(growable: true);
    for (var viewModel
        in illustrationViewModel.illustrationForegroundViewModel.viewModels) {
      list.add(ChangeNotifierProvider(
          create: (_) => IllustrationPieceProvider(),
          child: IllustrationPiece.withViewModel(viewModel: viewModel)));
    }
    return list;
  }
}
