import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quote_keeper/utils/constants/globals.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class TutorialService extends GetxService {
  // Dashboard
  GlobalKey dashboardTarget1 = GlobalKey();
  final List<TargetFocus> _dashboardTargets = [];
  bool _showDashboardTutorial = true;

  // Search Books
  GlobalKey searchBookTarget1 = GlobalKey();
  final List<TargetFocus> _searchBookTargets = [];
  bool _showSearchBookTutorial = true;

  // Create Quote
  GlobalKey createQuoteTarget1 = GlobalKey();
  final List<TargetFocus> _createQuoteTargets = [];
  bool _showCreateQuoteTutorial = true;

  // Refresh
  final List<TargetFocus> _refreshDashboardTargets = [];
  bool _showRefreshDashboardTutorial = true;

  final GetStorage _getStorage = Get.find();

  TutorialService() {
    setupTargets();
  }

  void setupTargets() {
    // Determine if the user has completed the tutorial already.
    var tutorialComplete = _getStorage.read<bool>(Globals.tutorialComplete);

    if (tutorialComplete != null && !tutorialComplete) {
      _dashboardTargets.add(
        TargetFocus(
          identify: 'Dashboard Target 1',
          keyTarget: dashboardTarget1,
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
          keyTarget: searchBookTarget1,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
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
          keyTarget: createQuoteTarget1,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Enter your favorite quote.',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      'What line from the book inspired you the most? Enter it here, then click the check button to submit.',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );

      _refreshDashboardTargets.add(
        TargetFocus(
          identify: 'Refresh Dashboard 1',
          keyTarget: dashboardTarget1,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Congrats! You saved your first quote.',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Now refresh the page to see your newly entered quote. Enjoy!',
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
  }

  void showDashboardTutorial(BuildContext context) {
    if (_showDashboardTutorial && _dashboardTargets.isNotEmpty) {
      _showTutorial(context, _dashboardTargets);
      _showDashboardTutorial = false;
    }
  }

  void showSearchBookTutorial(BuildContext context) {
    if (_showSearchBookTutorial && _searchBookTargets.isNotEmpty) {
      _showTutorial(context, _searchBookTargets);
      _showSearchBookTutorial = false;
    }
  }

  void showCreateQuoteTutorial(BuildContext context) {
    if (_showCreateQuoteTutorial && _createQuoteTargets.isNotEmpty) {
      _showTutorial(context, _createQuoteTargets);
      _showCreateQuoteTutorial = false;
    }
  }

  void showRefreshDashboardTutorial(BuildContext context) async {
    if (_showRefreshDashboardTutorial && _refreshDashboardTargets.isNotEmpty) {
      await _getStorage.write(Globals.tutorialComplete, true);
      _showTutorial(context, _refreshDashboardTargets);
      _showRefreshDashboardTutorial = false;
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
