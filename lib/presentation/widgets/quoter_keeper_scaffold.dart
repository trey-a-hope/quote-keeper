library simple_page_widget;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuoteKeeperScaffold extends StatelessWidget {
  final Widget child;
  final String title;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final IconButton? leftIconButton;
  final IconButton? rightIconButton;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const QuoteKeeperScaffold({
    Key? key,
    required this.child,
    required this.title,
    this.floatingActionButton,
    this.drawer,
    this.leftIconButton,
    this.rightIconButton,
    this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      floatingActionButton: floatingActionButton,
      drawer: drawer,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: Column(
            children: [
              Column(
                children: [
                  //App Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        leftIconButton == null
                            ? Container(
                                width: 50,
                              )
                            : _CustomIconBoxWidget(
                                iconButton: leftIconButton!,
                              ),
                        Expanded(
                          child: Text(
                            title,
                            style: Theme.of(context).textTheme.displayLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        rightIconButton == null
                            ? Container(
                                width: 50,
                              )
                            : _CustomIconBoxWidget(
                                iconButton: rightIconButton!,
                              ),
                      ],
                    ),
                  ),
                  const Divider(),
                ],
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomIconBoxWidget extends StatelessWidget {
  final IconButton iconButton;

  const _CustomIconBoxWidget({
    Key? key,
    required this.iconButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey.withAlpha(40),
          width: 2,
        ),
      ),
      child: iconButton,
    );
  }
}
