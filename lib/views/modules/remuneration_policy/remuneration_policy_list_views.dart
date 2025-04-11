import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';

import '../../../colors.dart';
import '../../../models/competition_model.dart';
import '../../../models/data/years_data.dart';
import '../../../models/meeting_model.dart';
import '../../../models/member.dart';
import '../../../providers/competition_provider_page.dart';
import '../../../utility/utils.dart';
import '../../../widgets/appBar.dart';
import '../../../widgets/build_dynamic_data_cell.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_icon.dart';
import '../../../widgets/custom_message.dart';
import '../../../widgets/custome_text.dart';
import '../../../widgets/dropdown_string_list.dart';
import '../../../widgets/loading_sniper.dart';
import '../../dashboard/setting.dart';
import '../meetings/show_meeting.dart';
class RemunerationPolicyListViews extends StatefulWidget {
  const RemunerationPolicyListViews({super.key});
  static const routeName = '/RemunerationPolicyListViews';
  @override
  State<RemunerationPolicyListViews> createState() => _RemunerationPolicyListViewsState();
}

class _RemunerationPolicyListViewsState extends State<RemunerationPolicyListViews> {

  String selectedYear = '2022';
  String selectedQuarter = 'Q2';

  // Track expanded/collapsed state of sections
  bool boardExpanded = true;
  bool auditExpanded = false;
  bool nrcExpanded = false;
  bool executiveExpanded = false;

  // Sample data
  // List<Member> boardMembers = [
  //   Member(name: 'Member Name', membershipFee: 40000, attendanceFee: 3000),
  //   Member(name: 'Member Name', membershipFee: 60000, attendanceFee: 3000),
  //   Member(name: 'Member Name', membershipFee: 0, attendanceFee: 0),
  // ];
  //
  // // Calculate totals
  // int get totalMembershipFees =>
  //     boardMembers.fold(0, (sum, member) => sum + member.membershipFee);
  //
  // int get totalAttendanceFees =>
  //     boardMembers.fold(0, (sum, member) => sum + member.attendanceFee);

  // int get grandTotal => totalMembershipFees + totalAttendanceFees;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              buildFullTopFilter(),
              Center(
                child: Consumer<CompetitionProviderPage>(
                    builder: (context, provider, child) {
                      // Show loading indicator if data is being fetched
                      if (provider.loading) {
                        return buildLoadingSniper();
                      }

                      // Show error message if there was an error
                      if (provider.errorMessage != null) {
                        return CustomMessage(
                          text: provider.errorMessage!,
                        );
                      }

                      if (provider.competitionsData?.competitions == null) {
                        // provider.getMemberCompetitions(provider.yearSelected,widget.member.memberId.toString(), widget.type);
                        return buildLoadingSniper();
                      }
                      return provider.competitionsData!.competitions!.isEmpty
                          ? buildEmptyMessage(
                          AppLocalizations.of(context)!.no_data_to_show)
                          : Container(
                        padding: EdgeInsets.only(left: 10.0),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: SizedBox.expand(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SingleChildScrollView(
                              child: DataTable(
                                columnSpacing: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colour()
                                          .darkHeadingColumnDataTables),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                // showBottomBorder: true,
                                headingRowHeight: 60,
                                dividerThickness: 0.3,
                                headingRowColor: WidgetStateColor.resolveWith(
                                        (states) =>
                                    Colour().darkHeadingColumnDataTables),
                                columns: <DataColumn>[
                                  DataColumn(
                                      label: CustomText(
                                        text: "Name English",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                        color: Colour().lightBackgroundColor,
                                      ),
                                      tooltip: "show name"),
                                  DataColumn(
                                      label: CustomText(
                                        text: "Name Arabic",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                        color: Colour().lightBackgroundColor,
                                      ),
                                      tooltip: "show name"),
                                  DataColumn(
                                      label: CustomText(
                                        text: AppLocalizations.of(context)!
                                            .date,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                        color: Colour().lightBackgroundColor,
                                      ),
                                      tooltip: "show Date"),
                                  DataColumn(
                                      label: CustomText(
                                        text: "File",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                        color: Colour().lightBackgroundColor,
                                      ),
                                      tooltip: "show file"),

                                ],
                                rows:
                                provider!.competitionsData!.competitions!
                                    .map((CompetitionModel competition) =>
                                    DataRow(cells: [
                                      BuildDynamicDataCell(
                                        child: CustomText(
                                          text: competition
                                              ?.competitionEnName ??
                                              'N/A',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                          softWrap: false,
                                          maxLines: 1,
                                          overflow:
                                          TextOverflow.ellipsis,
                                        ),
                                      ),
                                      BuildDynamicDataCell(
                                        child: CustomText(
                                          text: competition
                                              ?.competitionArName ??
                                              'N/A',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                          softWrap: false,
                                          maxLines: 1,
                                          overflow:
                                          TextOverflow.ellipsis,
                                        ),
                                      ),
                                      BuildDynamicDataCell(
                                        child: CustomText(
                                          text:
                                          "${Utils.convertStringToDateFunction(competition!.competitionCreateAt!)}",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                          softWrap: false,
                                          maxLines: 1,
                                          overflow:
                                          TextOverflow.ellipsis,
                                        ),
                                      ),
                                      BuildDynamicDataCell(
                                        child: CustomText(
                                          text: ' link to PDF',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0,
                                          softWrap: false,
                                          maxLines: 1,
                                          overflow:
                                          TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ]))
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFullTopFilter() {
    return Consumer<CompetitionProviderPage>(
        builder: (BuildContext context, provider, child) {
          return Padding(
            padding:
            const EdgeInsets.only(top: 3.0, left: 0.0, right: 8.0, bottom: 8.0),
            child: Row(
              children: [
                Container(
                    padding:
                    const EdgeInsets.symmetric(vertical: 7.0, horizontal: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                      color: Colour().buttonBackGroundRedColor,
                    ),
                    child: CustomText(
                        text:
                        'Remuneration',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(
                  width: 5.0,
                ),
                Container(
                  width: 200,
                  padding:
                  const EdgeInsets.symmetric(vertical: 7.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colour().buttonBackGroundRedColor,
                  ),
                  child: DropdownStringList(
                    boxDecoration: Colors.white,
                    hint:
                    CustomText(text: AppLocalizations.of(context)!.select_year),
                    selectedValue: provider.yearSelected,
                    dropdownItems: yearsData,
                    onChanged: (String? newValue) async {
                      provider.setYearSelected(newValue!.toString());
                      // await provider.getMemberCompetitions(provider.yearSelected, member.memberId.toString(), type);
                    },
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Container(
                    padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colour().buttonBackGroundRedColor,
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => Setting(initialTabIndex: 5),
                          ),
                        );
                      },
                      child: CustomText(
                        text: 'Q2',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ],
            ),
          );
        });
  }

  buildEmptyMessage(String message) {
    return CustomMessage(
      text: message,
    );
  }

  buildLoadingSniper() {
    return const LoadingSniper();
  }
}
