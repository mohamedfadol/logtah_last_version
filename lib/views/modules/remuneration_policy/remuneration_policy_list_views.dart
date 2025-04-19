import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../colors.dart';
import '../../../models/data/years_data.dart';
import '../../../models/remuneration.dart';
import '../../../providers/remuneration_provider_page.dart';
import '../../../widgets/appBar.dart';
import '../../../widgets/custom_message.dart';
import '../../../widgets/custome_text.dart';
import '../../../widgets/dropdown_string_list.dart';
import '../../../widgets/loading_sniper.dart';

class RemunerationPolicyListViews extends StatelessWidget {
  const RemunerationPolicyListViews({super.key});
  static const routeName = '/RemunerationPolicyListViews';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        child: Column(
          children: [
            // Header with filters
            buildFullTopFilter(),
          Consumer<RemunerationProviderPage>(
              builder: (BuildContext context, provider, _) {
                if (provider.remunerationsData?.remunerations == null) {
                  provider.getListOfRemunerationsByFilterDate(provider.yearSelected);
                  return buildLoadingSniper();
                }

                return Expanded(
                  child: SingleChildScrollView(
                    child: provider.remunerationsData!.remunerations!.isEmpty
                        ? buildEmptyMessage(
                        AppLocalizations.of(context)!.no_data_to_show)
                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var committeeEntry in provider.committeeRemunerations.entries)
                          _buildCommitteeSection(
                            context: context,
                            committeeName: committeeEntry.key,
                            remunerations: committeeEntry.value,
                          ),


                        SizedBox(height: 20),

                        // Totals and export section
                        _buildTotalsSection(provider),

                      ],
                    ),
                  ),
                );
              }
          )


          ],
        ),
      ),
    );
  }

  Widget _buildCommitteeSection({
    required BuildContext context,
    required String committeeName,
    required List<Remuneration> remunerations,
  }) {
    // Track expanded state
    bool isExpanded = remunerations.isNotEmpty &&
        remunerations.first.committee != null &&
        (remunerations.first.committee!.isExpanded ?? false);


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Committee header (expandable)
        InkWell(
          onTap: () {
            final provider = Provider.of<RemunerationProviderPage>(context, listen: false);

            // Toggle expanded state for this committee
            for (var remuneration in remunerations) {
              if (remuneration.committee != null) {
                remuneration.committee!.isExpanded = !isExpanded;
              }
            }

            provider.notifyListeners();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Text(
                  isExpanded ? '- ' : '+ ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  committeeName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Committee content (members and their remunerations)
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Table header
                Table(
                  border: TableBorder.all(color: Colors.grey.shade300),
                  columnWidths: {
                    0: FlexColumnWidth(2),  // Member Name
                    1: FlexColumnWidth(1),  // Annual Membership Fee
                    2: FlexColumnWidth(1),  // Attendance Fee (per meeting)
                    3: FlexColumnWidth(1),  // Meetings
                    4: FlexColumnWidth(1),  // Attended
                    5: FlexColumnWidth(1.5),  // Total
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: Colors.grey.shade100),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Member Name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Annual Fee',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Per Meeting',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Total',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Attended',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Remuneration',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Member rows
                // Member rows
                for (var remuneration in remunerations)
                  Table(
                    border: TableBorder.all(color: Colors.grey.shade300),
                    columnWidths: {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(1),
                      4: FlexColumnWidth(1),
                      5: FlexColumnWidth(1.5),
                    },
                    children: [
                      // Correct way to iterate and create TableRows
                      ...remuneration.committee?.members?.map((member) =>
                          TableRow(
                            children: [
                              // Member name
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${member.memberFirstName ?? ''} ${member.memberLastName ?? ''}",
                                ),
                              ),
                              // Annual membership fee
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  formatNumber(double.parse(remuneration.membershipFees ?? '0')),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              // Attendance fee per meeting
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  formatNumber(double.parse(remuneration.attendanceFees ?? '0')),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              // Total meetings
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${remuneration.totalMeetings}",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              // Attended meetings
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${remuneration.memberAttendance[member.memberId] ?? 0}",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              // Calculated total remuneration
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        formatNumber(remuneration.getTotalRemuneration(member.memberId ?? 0)),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "(${formatNumber(remuneration.getProRatedMembershipFee(member.memberId ?? 0))} + ${formatNumber(remuneration.getAttendanceFee(member.memberId ?? 0))})",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey.shade700,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                      ).toList() ?? [],
                    ],
                  ),

                // Calculation explanation
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      border: Border.all(color: Colors.amber.shade200),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Calculation Formula:",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "• Annual Fee ÷ Total Meetings × Attended Meetings",
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          "• + (Attendance Fee per Meeting × Attended Meetings)",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

        SizedBox(height: 20),
      ],
    );
  }



  buildEmptyMessage(String message) {
    return CustomMessage(
      text: message,
    );
  }

  buildLoadingSniper() {
    return const LoadingSniper();
  }

  Widget buildFullTopFilter() {
    return Consumer<RemunerationProviderPage>(
        builder: (BuildContext context, provider, _) {
          return Padding(
            padding:
            const EdgeInsets.only(top: 3.0, left: 0.0, right: 8.0, bottom: 8.0),
            child: Row(
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 7.0, horizontal: 15.0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0)),
                      color: Colour().buttonBackGroundRedColor,
                    ),
                    child: CustomText(
                        text: "Remuneration",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    )),
                const SizedBox(
                  width: 5.0,
                ),

                Container(
                  width: 200,
                  padding: const EdgeInsets.symmetric(
                      vertical: 7.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colour().buttonBackGroundRedColor,
                  ),
                  child: DropdownStringList(
                    boxDecoration: Colors.white,
                    hint: CustomText(
                        text: AppLocalizations.of(context)!.select_year),
                    selectedValue: provider.yearSelected,
                    dropdownItems: yearsData,
                    onChanged: (String? newValue) async {
                      provider.setYearSelected(newValue!.toString());
                      await provider.getListOfRemunerationsByFilterDate(provider.yearSelected);
                    },
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  Widget _buildTotalsSection(RemunerationProviderPage provider) {
    // Calculate totals across all remunerations
    double totalMembershipFees = 0;
    double totalAttendanceFees = 0;

    // Loop through all remunerations and sum up the fees
    if (provider.remunerationsData?.remunerations != null) {
      for (var remuneration in provider.remunerationsData!.remunerations!) {
        totalMembershipFees += double.tryParse(remuneration.membershipFees ?? '0') ?? 0;
        totalAttendanceFees += double.tryParse(remuneration.attendanceFees ?? '0') ?? 0;
      }
    }

    double grandTotal = totalMembershipFees + totalAttendanceFees;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(thickness: 2, color: Colors.grey.shade400),
        SizedBox(height: 10),

        // Use a Table for the header row to match column alignment with the data tables
        Table(
          columnWidths: {
            0: FlexColumnWidth(2), // Member name column (empty for totals)
            1: FlexColumnWidth(1), // Membership Fees
            2: FlexColumnWidth(1), // Attendance Fees
            3: FlexColumnWidth(1), // Total
          },
          children: [
            TableRow(
              children: [
                Container(), // Empty cell where member names would be
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Total Membership Fees',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Total Attendance Fees',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),

        // Use another Table for the totals values to ensure alignment
        Table(
          columnWidths: {
            0: FlexColumnWidth(2), // Member name column (empty for totals)
            1: FlexColumnWidth(1), // Membership Fees
            2: FlexColumnWidth(1), // Attendance Fees
            3: FlexColumnWidth(1), // Total
          },
          children: [
            TableRow(
              children: [
                Container(), // Empty cell where member names would be
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Text(
                      formatNumber(totalMembershipFees),
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Text(
                      formatNumber(totalAttendanceFees),
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Text(
                      formatNumber(grandTotal),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        SizedBox(height: 20),

        // Export buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildExportButton(title: 'EXPORT'),
            SizedBox(width: 20),
            _buildExportButton(title: 'EXPORT ALL XIs'),
          ],
        ),
      ],
    );
  }

// Helper function to format number with commas
  String formatNumber(double number) {
    if (number == 0) return '0';

    // Format with commas as thousands separator and 2 decimal places
    final formatter = NumberFormat('#,##0.00');
    return formatter.format(number);
  }

  Widget _buildExportButton({required String title}) {
    return ElevatedButton(
      onPressed: () {
        // Implement export functionality
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}


