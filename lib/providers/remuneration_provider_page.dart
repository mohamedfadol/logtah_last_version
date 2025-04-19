import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../NetworkHandler.dart';
import '../models/committee_model.dart';
import '../models/member.dart';
import '../models/remuneration.dart';
import '../models/user.dart';

class RemunerationProviderPage  extends ChangeNotifier {
  var log = Logger();
  User user = User();
  NetworkHandler networkHandler = NetworkHandler();


  Remunerations? remunerationsData;
  Remuneration _remuneration = Remuneration();
  Remuneration get remuneration => _remuneration;

  void setRemuneration(Remuneration remuneration) async {
    _remuneration =  remuneration;
    notifyListeners();
  }

  List<Committee> _committees = [];
  String _selectedYear = '2022';
  String _selectedQuarter = 'Q2';
  bool _isLoading = false;
  String? _error;
  final TextEditingController membershipFee = TextEditingController();
  final TextEditingController attendanceFee = TextEditingController();

  List<Committee> get committees => _committees;
  String get selectedYear => _selectedYear;
  String get selectedQuarter => _selectedQuarter;
  bool get isLoading => _isLoading;
  String? get error => _error;

  String _yearSelected = '2025';

  String get yearSelected => _yearSelected;

  void setYearSelected(year) async {
    _yearSelected =  year;
    notifyListeners();
  }

  RemunerationProviderPage() {
    // Add listeners to update the UI when text changes
    membershipFee.addListener(_updateTotalFee);
    attendanceFee.addListener(_updateTotalFee);
  }

  void _updateTotalFee() {
    // This will trigger notifyListeners() which updates the UI
    notifyListeners();
  }

  double get totalFee {
    // Remove any non-numeric characters except decimal point
    String membershipText = membershipFee.text.replaceAll(RegExp(r'[^\d.]'), '');
    String attendanceText = attendanceFee.text.replaceAll(RegExp(r'[^\d.]'), '');

    double membership = double.tryParse(membershipText) ?? 0;
    double attendance = double.tryParse(attendanceText) ?? 0;
    return membership + attendance;
  }

  // Load existing fee data for a committee
  void loadCommitteeFees(Committee committee) {
    // Reset the controllers
    membershipFee.text = '';
    attendanceFee.text = '';

    // TODO: Fetch existing fee data from your API if available
    // For now, let's assume we're setting up new fees
    notifyListeners();
  }

  Map<String, List<Remuneration>> committeeRemunerations = {};

  Future getListOfRemunerationsByFilterDate(_yearSelected) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    user =  User.fromJson(json.decode(prefs.getString("user")!)) ;
    final Map<String, String>  queryParams = {
      'business_id': user.businessId.toString(),
      'yearSelected': _yearSelected,
    };
    log.d("get-list-remunerations_yearSelected $_yearSelected");
    var response = await networkHandler.post1('/get-list-of-remunerations-by-filter-date',queryParams);
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.d("get-list-remunerations form provider response statusCode == 200");
      var responseData = json.decode(response.body) ;
      var responseRemunerationsData = responseData['data'];
      log.d(responseRemunerationsData);
      remunerationsData = Remunerations.fromJson(responseRemunerationsData);
      log.d(remunerationsData!.remunerations!.length);

      committeeRemunerations.clear();

      remunerationsData?.remunerations?.forEach((remuneration) {
        String committeeName = remuneration.committee?.committeeName ?? 'Unknown';

        if (!committeeRemunerations.containsKey(committeeName)) {
          committeeRemunerations[committeeName] = [];
        }

        committeeRemunerations[committeeName]!.add(remuneration);
      });


      notifyListeners();
    } else {
      log.d("get-list-remunerations form provider response statusCode unknown");
      log.d(response.statusCode);
      log.d(json.decode(response.body)['message']);
    }
  }

  // Save remuneration data for a committee
  Future<bool> saveRemunerationData(Map<String, dynamic> data) async {
    logger.i(data);
    if (membershipFee.text.isEmpty && attendanceFee.text.isEmpty) {
      _error = 'Please enter at least one fee amount';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {

      var response = await networkHandler.post1('/insert-new-remuneration', data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        log.d("insert-new-remuneration response statusCode == 200");
        var responseData = json.decode(response.body);
        log.d(responseData);
        var meetingsData = responseData['data'];
        _remuneration =  Remuneration.fromJson(meetingsData);
        setRemuneration(_remuneration);
        await Future.delayed(Duration(seconds: 1));

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        log.d("insert-new-remuneration response statusCode unknown");
        log.d(response.statusCode);
        print(json.decode(response.body)['message']);
        return false;
      }

    } catch (e) {
      _error = 'Error saving data: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Format number with commas
  String formatNumber(num number) {
    if (number == 0) return '0';

    final formatter = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String result = number.toString().replaceAllMapped(
        formatter,
            (Match m) => '${m[1]},'
    );
    return result;
  }


  @override
  void dispose() {
    // Clean up the controllers
    membershipFee.dispose();
    attendanceFee.dispose();
    super.dispose();
  }

}