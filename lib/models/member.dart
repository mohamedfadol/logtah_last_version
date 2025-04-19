import 'package:diligov/models/board_model.dart';
import 'package:diligov/models/committee_model.dart';
import 'package:diligov/models/member_sign_minutes.dart';
import 'package:diligov/models/membership_model.dart';
import 'package:diligov/models/position_model.dart';
import 'package:diligov/models/question_model.dart';
import 'package:diligov/models/roles_model.dart';
import 'package:diligov/models/signature_model.dart';
import 'business_model.dart';
import 'category_model.dart';
import 'competition_model.dart';
import 'meeting_attendances.dart';
import 'minute_signature_model.dart';

class MyData {
  List<Member>? members;

  MyData.fromJson(Map<String, dynamic> json) {
    if (json['members'] != null) {
      members = <Member>[];
      json['members'].forEach((v) {
        members!.add(Member.fromJson(v));
      });
    }
  }
}

class Member{
   int? memberId;
   String? memberProfileImage;
   String? memberEmail;
   String? memberFirstName;
   String? memberMiddelName;
   String? memberLastName;
   String? memberMobile;
   String? memberSignature;
   String? memberBiography;
   String? memberPassword;
   int? businessId;
   bool? isActive;
   Signature? signature;
   MinuteSignature? minuteSignature;
   MembershipModel? memberShip;
   MemberSignMinutes? memberSignMinutes;
   bool? hasVote;
   Position? position;
   Business? business;

   List<Position>? positions;
   List<Committee>? committees;
   List<Board>? boards;
   List<RoleModel>? roles;
   List<QuestionModel>? questions;
   MemberPivotCompetition? pivot;
   List<CompetitionModel>? competitions;
   List<Member>? managementSignature;
   List<MeetingAttendance>? meetingAttendances;


  Member(
      {this.memberId,
      this.memberProfileImage,
      this.memberEmail,
      this.memberFirstName,
      this.memberMiddelName,
      this.memberLastName,
      this.memberMobile,
      this.memberSignature,
      this.memberPassword,
      this.memberBiography,
      this.businessId,
      this.memberShip,
      this.isActive,
      this.signature,
      this.minuteSignature,
      this.memberSignMinutes,
      this.hasVote,
      this.positions,
      this.committees,
        this.boards,
        this.meetingAttendances,
        this.roles,
        this.pivot,
      this.questions,
        this.business,
        this.competitions,
        this.managementSignature
      });
 // create new converter
  Member.fromJson(Map<String, dynamic> json) {
    memberId = json['id'];
    memberEmail = json['member_email'];
    memberFirstName = json['member_first_name'];
    memberMiddelName = json['member_middel_name'];
    memberLastName = json['member_last_name'];
    memberMobile = json['member_mobile'];
    memberSignature = json['signature'];
    memberPassword = json['member_password'];
    memberBiography = json['member_biography'];
    memberProfileImage = json['member_profile_image'];
    businessId = json['business_id'];
    isActive = json['is_active'];
    signature = json['signature_member'] != null ? Signature.fromJson(json['signature_member']) : null;
    memberShip = json['membership'] != null ? MembershipModel.fromJson(json['membership']) : null;
    minuteSignature = json['minute_signature'] != null ? MinuteSignature.fromJson(json['minute_signature']) : null;
    memberSignMinutes = json['minute_signature_member'] != null ? MemberSignMinutes.fromJson(json['minute_signature_member']) : null;
    pivot = json['pivot'] != null ? MemberPivotCompetition.fromJson(json['pivot']) : null;

    hasVote = json['has_vote'];
    // position =  Position?.fromJson(json['position']);
    business = json['business'] != null ? Business.fromJson(json['business']) : null;

    if (json['positions'] != null) {
      positions = <Position>[];
      json['positions'].forEach((v) {
        positions!.add(Position.fromJson(v));
      });
    }

    // In your fromJson method, update the meetingAttendances parsing:
    if (json['attendances'] != null) {
      meetingAttendances = <MeetingAttendance>[];
      json['attendances'].forEach((v) {
        // Create the attendance object
        MeetingAttendance attendance = MeetingAttendance.fromJson(v);

        // Add the pivot data if it exists
        if (v['pivot'] != null) {
          attendance.pivot = MemberMeetingPivot.fromJson(v['pivot']);
        }

        meetingAttendances!.add(attendance);
      });
    }


    if (json['management_signature'] != null) {
      managementSignature = <Member>[];
      json['management_signature'].forEach((v) {
        managementSignature!.add(Member.fromJson(v));
      });
    }

    if (json['committees'] != null) {
      committees = <Committee>[];
      json['committees'].forEach((v) {
        committees!.add(Committee.fromJson(v));
      });
    }

    if (json['boards'] != null) {
      boards = <Board>[];
      json['boards'].forEach((v) {
        boards!.add(Board.fromJson(v));
      });
    }
    if (json['roles'] != null) {
      roles = <RoleModel>[];
      json['roles'].forEach((v) {
        roles!.add(RoleModel.fromJson(v));
      });
    }

    if (json['questions'] != null) {
      questions = <QuestionModel>[];
      json['questions'].forEach((v) {
        questions!.add(QuestionModel.fromJson(v));
      });
    }

    if (json['competitions'] != null) {
      competitions = <CompetitionModel>[];
      json['competitions'].forEach((v) {
        competitions!.add(CompetitionModel.fromJson(v));
      });
    }

  }

}

// Create a pivot class for meeting attendance
class MemberMeetingPivot {
  int? meetingId;
  int? memberId;
  bool? isAttended;
  String? createdAt;
  String? updatedAt;

  MemberMeetingPivot({
    this.meetingId,
    this.memberId,
    this.isAttended,
    this.createdAt,
    this.updatedAt,
  });

  factory MemberMeetingPivot.fromJson(Map<String, dynamic> json) {
    return MemberMeetingPivot(
      meetingId: json['meeting_id'],
      memberId: json['member_id'],
      isAttended: json['is_attended'] == 1, // Convert int to bool
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

// Pivot table model
class MemberPivotCompetition {
  int? competitionId;
  int? memberId;
  int? agree;  // 1 for agree, 0 for disagree
  int? isAgree;  // 1 for agree, 0 for disagree
  int? isSigned;  // 1 for isSigned, 0 for isSigned
  String? comment;
  String? type;
  String? createdAt;
  String? updatedAt;

  MemberPivotCompetition({
    this.competitionId,
    this.memberId,
    this.agree,
    this.isAgree,
    this.isSigned,
    this.comment,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory MemberPivotCompetition.fromJson(Map<String, dynamic> json) {
    return MemberPivotCompetition(
      competitionId: json['competition_id'],
      memberId: json['member_id'],
      agree: json['agree'],
      type: json['type'],
      isAgree: json['is_agree'],
      isSigned: json['is_signed'],
      comment: json['comment'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}