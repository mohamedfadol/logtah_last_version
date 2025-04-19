import 'package:diligov/models/user.dart';

import 'business_model.dart';
import 'committee_model.dart';

class Remunerations {

  List<Remuneration>? remunerations;

  Remunerations.fromJson(Map<String, dynamic> json) {
    if (json['remunerations'] != null) {
      remunerations = <Remuneration>[];
      json['remunerations'].forEach((v) {
        remunerations!.add(Remuneration.fromJson(v));
      });
    }
  }
}

class Remuneration{
  int? RemunerationId;
  String? quarter;
  String? membershipFees;
  String? attendanceFees;
  Business? business;
  Committee? committee;

  Remuneration({
        this.RemunerationId,
        this.quarter,
        this.membershipFees,
        this.attendanceFees,
        this.business,
        this.committee,
      });

  // create new converter
  Remuneration.fromJson(Map<String, dynamic> json) {
    RemunerationId = json['id'];
    quarter = json['quarter'];
    membershipFees = json['membership_fees'];
    attendanceFees = json['attendance_fees'];
    business = json['business'] != null ? Business?.fromJson(json['business']) : null;
    committee = json['committee'] != null ? Committee?.fromJson(json['committee']) : null;
  }


  // Get total meetings in the committee
  int get totalMeetings => committee?.meetings?.length ?? 0;

  // Get attended meetings for all members in the committee
  Map<int, int> get memberAttendance {
    Map<int, int> attendance = {};

    if (committee?.members == null) return attendance;

    for (var member in committee!.members!) {
      int memberId = member.memberId ?? 0;
      int attendedCount = 0;

      // Check attendance records for this member
      if (member.meetingAttendances != null) {
        for (var meetingAttendance in member.meetingAttendances!) {
          if (meetingAttendance.pivot?.isAttended == true) {
            attendedCount++;
          }
        }
      }

      attendance[memberId] = attendedCount;
    }

    return attendance;
  }

  // Calculate pro-rated membership fee for a specific member
  double getProRatedMembershipFee(int memberId) {
    if (totalMeetings == 0) return 0;

    double annualFee = double.tryParse(membershipFees ?? '0') ?? 0;
    double perMeetingFee = annualFee / totalMeetings;
    int attended = memberAttendance[memberId] ?? 0;

    return perMeetingFee * attended;
  }

  // Calculate attendance fee for a specific member
  double getAttendanceFee(int memberId) {
    double feePerMeeting = double.tryParse(attendanceFees ?? '0') ?? 0;
    int attended = memberAttendance[memberId] ?? 0;

    return feePerMeeting * attended;
  }

  // Calculate total remuneration for a specific member
  double getTotalRemuneration(int memberId) {
    return getProRatedMembershipFee(memberId) + getAttendanceFee(memberId);
  }

}