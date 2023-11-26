import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class TutorialService extends GetxService {
  // Dashboard
  GlobalKey dashboardTarget = GlobalKey();
  final List<TargetFocus> _dashboardTargets = [];
  bool displayDashboardTutorial = true;

  // Search Books
  GlobalKey searchBookTarget = GlobalKey();
  final List<TargetFocus> _searchBookTargets = [];
  bool _displaySearchBookTutorial = true;

  // Create Quote
  GlobalKey createQuoteTarget = GlobalKey();
  final List<TargetFocus> _createQuoteTargets = [];
  bool _displayCreateQuoteTutorial = true;

  TutorialService() {
    setupTargets();
  }

  void setupTargets() {
    _dashboardTargets.add(
      TargetFocus(
        identify: 'Dashboard Target 1',
        keyTarget: dashboardTarget,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Welcome to QuoteKeeper',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    'Since you\'re new here, lets start by adding your first book quote. Click "Add New Quote".',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );

    _searchBookTargets.add(
      TargetFocus(
        identify: 'Search Book 1',
        keyTarget: searchBookTarget,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 300),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Pick your first book.',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    'What is your favorite book to quote? Let\'s look it up.',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );

    _createQuoteTargets.add(
      TargetFocus(
        identify: 'Create Quote 1',
        keyTarget: createQuoteTarget,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Enter your favorite quote.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    'What line from the book inspired you the most? Enter it above, then click here to submit. Once you return to the home page, be sure to refresh to see your new quote!',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void showDashboardTutorial(BuildContext context) {
    if (displayDashboardTutorial) {
      _showTutorial(context, _dashboardTargets);
      displayDashboardTutorial = false;
    }
  }

  void showSearchBookTutorial(BuildContext context) {
    if (_displaySearchBookTutorial) {
      _showTutorial(context, _searchBookTargets);
      _displaySearchBookTutorial = false;
    }
  }

  void showCreateQuoteTutorial(BuildContext context) {
    if (_displayCreateQuoteTutorial) {
      _showTutorial(context, _createQuoteTargets);
      _displayCreateQuoteTutorial = false;
    }
  }

  void _showTutorial(BuildContext context, List<TargetFocus> targets) {
    TutorialCoachMark(
      targets: targets, // List<TargetFocus>
      colorShadow: Colors.red, // DEFAULT Colors.black
      onClickTarget: (target) {},
      onClickTargetWithTapPosition: (target, tapDetails) {},
      onClickOverlay: (target) {},
      onSkip: () {
        return false;
      },
      onFinish: () {},
      hideSkip: true,
    ).show(context: context);
  }
}
