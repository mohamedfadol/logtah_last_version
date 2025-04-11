// import 'dart:convert';
// import 'dart:math';
// import 'package:diligov/NetworkHandler.dart';
// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../core/constants/constant_name.dart';
// import '../models/user.dart';
// import '../providers/committee_provider_page.dart';
// import '../providers/icons_provider.dart';
// import '../providers/menus_provider.dart';
// import '../providers/theme_provider.dart';
// import '../widgets/custom_message.dart';
// import '../widgets/loading_sniper.dart';
// import '../widgets/menu_button.dart';
// import 'package:flutter_gen/gen_l10n/app_localization.dart';
//
// class CommitteeCircleMenu extends StatefulWidget {
//
//   @override
//   State<CommitteeCircleMenu> createState() => _CommitteeCircleMenuState();
// }
//
// Map<String,String> iconsMap = {
//   "Committees": "icons/committee_circle_menu_icons/committee_icon.png"
// };
//
// class _CommitteeCircleMenuState extends State<CommitteeCircleMenu> {
//   var log = Logger();
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     return Center(
//       child: Flow(
//         delegate: FlowMenuDelegate(),
//         //you can change the buttons icons or name and name from here
//         children: <List<dynamic>>[
//           ["icons/committee_circle_menu_icons/action_tracker_icon.png","Action Tracker",ConstantName.actionsTrackerList,"icons/iconsFroDarkMode/action_tracker_icon_dark.png"],//
//           ["icons/committee_circle_menu_icons/board_evaluation_icon.png","Evaluation",ConstantName.evaluationListViews,"icons/iconsFroDarkMode/board_evaluation_icon_dark.png"],//
//           ["icons/committee_circle_menu_icons/annual_calendar_icon.png","Annual Calendar",ConstantName.committeeCalendarPage,"icons/iconsFroDarkMode/annual_calendar_icon_dark.png"],//
//           // ["images/diligov_icon.png","Home","Home","images/iconsFroDarkMode/diligov_logo_darkmode.png"],//
//           ["icons/committee_circle_menu_icons/resolutions_icon.png","Resolutions",ConstantName.committeeResolutionsListViews,"icons/iconsFroDarkMode/resolutions_icon_dark.png"],//
//           ["icons/committee_circle_menu_icons/agenda_minutes_icon.png","Minutes",ConstantName.minutesMeetingList,"icons/iconsFroDarkMode/agenda_minutes_icon_dark.png"],//
//           ["icons/homepage_circle_menu_icons/reports_icon.png","Annual Report",ConstantName.committeesAnnualAuditReportListView,"icons/iconsFroDarkMode/annual_report_icon_dark.png"],//
//           ["icons/homepage_circle_menu_icons/financials_icon.png","Financials",ConstantName.financialListViews,"icons/iconsFroDarkMode/financials_icon_dark.png"],//
//           ["icons/homepage_circle_menu_icons/company_information_icon.png","Committee Information",ConstantName.calendarListView,"icons/iconsFroDarkMode/company_information_icon_dark.png"],//
//           ["icons/homepage_circle_menu_icons/kpi_icon.png","KPI",ConstantName.calendarListView,"icons/iconsFroDarkMode/kpi_icon_dark.png"],//
//           ["icons/board_circle_menu_icons/committee_icon.png","Nominations",ConstantName.nominationsList,"icons/iconsFroDarkMode/committee_icon_dark.png"],
//           ["icons/board_circle_menu_icons/committee_icon.png","Performance & Rewards",ConstantName.performanceRewardListView,"icons/iconsFroDarkMode/committee_icon_dark.png"],
//           //Center Icon
//
//         ].map<Widget>(buildFAB).toList(),
//       ),
//     );
//   }
//
//   buildLoadingSniper() {
//     return const LoadingSniper();
//   }
//   buildEmptyMessage(String message) {
//     return CustomMessage(
//       text: message,
//     );
//   }
//
//   Widget buildFAB(List<dynamic> list) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     return  SizedBox(
//       height: 100,
//       width: 120,
//       child: Consumer<CommitteeProviderPage>(
//           builder: (BuildContext context, provider, Widget){
//             if (provider.committeesData?.committees == null) {
//
//               provider.getListOfMeetingsCommitteesByFilter(provider.yearSelected);
//               return buildLoadingSniper();
//             }
//
//             return provider.committeesData!.committees!.isEmpty
//                 ? buildEmptyMessage(AppLocalizations.of(context)!.no_data_to_show)
//                 : GestureDetector(
//               onTap: (){
//                 // if(list[1] == "Home" && list[2] == "Home"){
//                 //   context.read<MenusProvider>().changeMenu("Home");
//                 //   context.read<MenusProvider>().changeIconName("Home");
//                 // }
//                 // else{
//                   Navigator.pushReplacementNamed(context, list[2],arguments: 'committees');
//                 // }
//
//
//               },
//               child: Container(
//                 margin: const EdgeInsets.only(bottom: 10.0,top: 10),
//                 // color: Colors.green,
//                 child: Column(
//                   children: [
//                     // index 0 => The icon or img name from line 22
//                     // index 1 => the name of the button
//                     Image.asset(
//                       //context.watch<IconsProvider>().getIconPath
//                       themeProvider.isDarkMode ? list[3] : list[0],height: 40.0,),
//                     MenuButton(text: list[1],fontSize:10.0,fontWeight: FontWeight.bold),
//                   ],
//                 ),
//               ),
//             );
//           }
//       )
//     );
//   }
//
//
//
// }
//
// class FlowMenuDelegate extends FlowDelegate {
//   @override
//   void paintChildren(FlowPaintingContext context) {
//     final size = context.size;
//     final n = context.childCount;
//     const double radius = 230; // Adjust the radius to your preference
//     final Offset center = Offset(size.width / 2, size.height / 2);
//
//     for (int i = 0; i < n; i++) {
//       final double angle = (2 * pi * i) / n; // Evenly distribute in a full circle
//
//       final double x = center.dx + radius * cos(angle) - 25; // Centering offset
//       final double y = center.dy + radius * sin(angle) - 25; // Centering offset
//
//       context.paintChild(i,transform: Matrix4.identity()..translate(x, y, 0),);
//     }
//   }
//
//   @override
//   bool shouldRepaint(FlowMenuDelegate oldDelegate) => false;
// }



// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../core/constants/constant_name.dart';
// import '../models/committee_model.dart';
// import '../providers/committee_provider_page.dart';
// import '../providers/theme_provider.dart';
// import '../widgets/menu_button.dart';
// import '../widgets/custom_message.dart';
// import '../widgets/loading_sniper.dart';
// import 'package:flutter_gen/gen_l10n/app_localization.dart';
//
// class CommitteeCircleMenu extends StatefulWidget {
//   @override
//   State<CommitteeCircleMenu> createState() => _CommitteeCircleMenuState();
// }
//
// class _CommitteeCircleMenuState extends State<CommitteeCircleMenu> {
//   List<List<String>> currentMenu = [];
//   bool isSubMenuOpen = false;
//
//   // Static sub-menu mapping
//   final Map<String, List<List<String>>> staticSubMenus = {
//     "Nominations": [
//       ["icons/committee_circle_menu_icons/action_tracker_icon.png", "Action Tracker", ConstantName.actionsTrackerList, "icons/iconsFroDarkMode/action_tracker_icon_dark.png"],
//       ["icons/committee_circle_menu_icons/board_evaluation_icon.png", "Evaluation", ConstantName.evaluationListViews, "icons/iconsFroDarkMode/board_evaluation_icon_dark.png"],
//       ["icons/committee_circle_menu_icons/annual_calendar_icon.png", "Annual Calendar", ConstantName.committeeCalendarPage, "icons/iconsFroDarkMode/annual_calendar_icon_dark.png"],
//     ],
//     "Annual Audit Committee": [
//       ["icons/homepage_circle_menu_icons/reports_icon.png", "Annual Report", ConstantName.committeesAnnualAuditReportListView, "icons/iconsFroDarkMode/annual_report_icon_dark.png"],
//       ["icons/homepage_circle_menu_icons/financials_icon.png", "Financials", ConstantName.financialListViews, "icons/iconsFroDarkMode/financials_icon_dark.png"],
//     ],
//   };
//
//   @override
//   void initState() {
//     super.initState();
//     _loadMainMenu();
//   }
//
//   Widget buildLoadingSniper() {
//     return const LoadingSniper();
//   }
//
//   Widget buildEmptyMessage(String message) {
//     return CustomMessage(text: message);
//   }
//
//   void _loadMainMenu() {
//     setState(() {
//       currentMenu = [
//         ["icons/committee_circle_menu_icons/action_tracker_icon.png", "Action Tracker", ConstantName.actionsTrackerList, "icons/iconsFroDarkMode/action_tracker_icon_dark.png"],
//         ["icons/committee_circle_menu_icons/board_evaluation_icon.png", "Evaluation", ConstantName.evaluationListViews, "icons/iconsFroDarkMode/board_evaluation_icon_dark.png"],
//         ["icons/committee_circle_menu_icons/annual_calendar_icon.png", "Annual Calendar", ConstantName.committeeCalendarPage, "icons/iconsFroDarkMode/annual_calendar_icon_dark.png"],
//         ["icons/committee_circle_menu_icons/resolutions_icon.png", "Resolutions", ConstantName.committeeResolutionsListViews, "icons/iconsFroDarkMode/resolutions_icon_dark.png"],
//         ["icons/committee_circle_menu_icons/agenda_minutes_icon.png", "Minutes", ConstantName.minutesMeetingList, "icons/iconsFroDarkMode/agenda_minutes_icon_dark.png"],
//         ["icons/homepage_circle_menu_icons/reports_icon.png", "Annual Report", ConstantName.committeesAnnualAuditReportListView, "icons/iconsFroDarkMode/annual_report_icon_dark.png"],
//         ["icons/homepage_circle_menu_icons/financials_icon.png", "Financials", ConstantName.financialListViews, "icons/iconsFroDarkMode/financials_icon_dark.png"],
//         ["icons/homepage_circle_menu_icons/company_information_icon.png", "Committee Information", ConstantName.calendarListView, "icons/iconsFroDarkMode/company_information_icon_dark.png"],
//         ["icons/homepage_circle_menu_icons/kpi_icon.png", "KPI", ConstantName.calendarListView, "icons/iconsFroDarkMode/kpi_icon_dark.png"],
//         ["icons/board_circle_menu_icons/committee_icon.png", "Nominations", "nominations_list", "icons/iconsFroDarkMode/committee_icon_dark.png"],
//         ["icons/board_circle_menu_icons/committee_icon.png", "Annual Audit Committee", "annual_audit_list", "icons/iconsFroDarkMode/committee_icon_dark.png"],
//       ];
//       isSubMenuOpen = false;
//     });
//   }
//
//   Widget buildFAB(List<dynamic> item) {
//     final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
//
//     return Consumer<CommitteeProviderPage>(
//       builder: (context, committeeProvider, child) {
//         // Ensure committees are available
//         if (committeeProvider.committeesData?.committees == null) {
//           committeeProvider.getListOfMeetingsCommitteesByFilter(committeeProvider.yearSelected);
//           return buildLoadingSniper();
//         }
//
//         // Retrieve `committeeId` dynamically from the first available committee (or use a default)
//         String? committeeId = committeeProvider.committeesData!.committees!.isNotEmpty
//             ? committeeProvider.committeesData!.committees!.first.id?.toString()
//             : null;
//
//         return committeeProvider.committeesData!.committees!.isEmpty
//             ? buildEmptyMessage(AppLocalizations.of(context)!.no_data_to_show)
//             : SizedBox(
//           height: 100,
//           width: 120,
//           child: GestureDetector(
//             onTap: () {
//               String committeeName = item[1];
//               String routeName = item[2];
//
//               print("Navigating to: $routeName with committeeId: $committeeId");
//
//               if (staticSubMenus.containsKey(committeeName)) {
//                 setState(() {
//                   currentMenu = [
//                     ["icons/board_circle_menu_icons/committee_icon.png", "Back", "main_menu", "icons/iconsFroDarkMode/committee_icon_dark.png"]
//                   ] + staticSubMenus[committeeName]!;
//
//                   isSubMenuOpen = true;
//                 });
//               } else {
//                 Navigator.pushNamed(
//                   context,
//                   routeName,
//                   arguments: {'committeeId': committeeId ?? "No ID Found"},
//                 );
//               }
//             },
//             child: Container(
//               margin: const EdgeInsets.only(bottom: 10.0, top: 10),
//               child: Column(
//                 children: [
//                   Image.asset(
//                     themeProvider.isDarkMode ? item[3] : item[0],
//                     height: 40.0,
//                   ),
//                   MenuButton(
//                     text: item[1],
//                     fontSize: 10.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Flow(
//       delegate: FlowMenuDelegate(),
//       children: currentMenu.map<Widget>(buildFAB).toList(),
//     );
//   }
// }
//
// // Flow menu layout for circular arrangement
// class FlowMenuDelegate extends FlowDelegate {
//   @override
//   void paintChildren(FlowPaintingContext context) {
//     final size = context.size;
//     final n = context.childCount;
//     const double radius = 230;
//     final Offset center = Offset(size.width / 2, size.height / 2);
//
//     for (int i = 0; i < n; i++) {
//       final double angle = (2 * pi * i) / n;
//       final double x = center.dx + radius * cos(angle) - 25;
//       final double y = center.dy + radius * sin(angle) - 25;
//
//       context.paintChild(i, transform: Matrix4.identity()..translate(x, y, 0));
//     }
//   }
//
//   @override
//   bool shouldRepaint(FlowMenuDelegate oldDelegate) => false;
// }
//



// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/committee_provider_page.dart';
// import '../providers/theme_provider.dart';
// import '../widgets/menu_button.dart';
// import '../widgets/custom_message.dart';
// import '../widgets/loading_sniper.dart';
// import 'package:flutter_gen/gen_l10n/app_localization.dart';
//
// class CommitteeCircleMenu extends StatefulWidget {
//   @override
//   State<CommitteeCircleMenu> createState() => _CommitteeCircleMenuState();
// }
//
// class _CommitteeCircleMenuState extends State<CommitteeCircleMenu> {
//   String? selectedCommitteeId; // Track the selected committee ID
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CommitteeProviderPage>(
//       builder: (context, provider, child) {
//         if (provider.committeesData?.committees == null) {
//           provider.getListOfMeetingsCommitteesByFilter(provider.yearSelected);
//           return buildLoadingSniper(); // Show loading while fetching data
//         }
//
//         if (provider.committeesData!.committees!.isEmpty) {
//           return buildEmptyMessage(AppLocalizations.of(context)!.no_data_to_show);
//         }
//
//         return selectedCommitteeId == null
//             ? _buildCommitteeSelection(provider) // Show list of committees
//             : _buildCommitteeWidgets(selectedCommitteeId!); // Show widgets for selected committee
//       },
//     );
//   }
//
//   /// **🔹 Step 2: Display the list of committees**
//   Widget _buildCommitteeSelection(CommitteeProviderPage provider) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: provider.committeesData!.committees!.map((committee) {
//           return ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 selectedCommitteeId = committee.id.toString(); // Set selected committee
//               });
//             },
//             child: Text(committee.committeeName ?? "Unnamed Committee"),
//           );
//         }).toList(),
//       ),
//     );
//   }
//
//   /// **🔹 Step 3: Display widgets for the selected committee**
//   Widget _buildCommitteeWidgets(String committeeId) {
//     final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
//     return Center(
//       child: Flow(
//         delegate: FlowMenuDelegate(),
//         children: [
//           ["icons/committee_circle_menu_icons/action_tracker_icon.png", "Action Tracker", "action_tracker", "icons/iconsFroDarkMode/action_tracker_icon_dark.png"],
//           ["icons/committee_circle_menu_icons/board_evaluation_icon.png", "Evaluation", "evaluation_list", "icons/iconsFroDarkMode/board_evaluation_icon_dark.png"],
//           ["icons/committee_circle_menu_icons/annual_calendar_icon.png", "Annual Calendar", "annual_calendar", "icons/iconsFroDarkMode/annual_calendar_icon_dark.png"],
//           ["icons/committee_circle_menu_icons/resolutions_icon.png", "Resolutions", "resolutions_list", "icons/iconsFroDarkMode/resolutions_icon_dark.png"],
//           ["icons/committee_circle_menu_icons/agenda_minutes_icon.png", "Minutes", "minutes_list", "icons/iconsFroDarkMode/agenda_minutes_icon_dark.png"],
//           ["icons/homepage_circle_menu_icons/reports_icon.png", "Annual Report", "annual_report", "icons/iconsFroDarkMode/annual_report_icon_dark.png"],
//           ["icons/homepage_circle_menu_icons/financials_icon.png", "Financials", "financials_list", "icons/iconsFroDarkMode/financials_icon_dark.png"],
//           ["icons/homepage_circle_menu_icons/company_information_icon.png", "Committee Information", "committee_info", "icons/iconsFroDarkMode/company_information_icon_dark.png"],
//           ["icons/homepage_circle_menu_icons/kpi_icon.png", "KPI", "kpi_list", "icons/iconsFroDarkMode/kpi_icon_dark.png"],
//         ].map<Widget>((item) => _buildFAB(item, committeeId)).toList(),
//       ),
//     );
//   }
//
//   /// **🔹 Step 4: Build FAB buttons for widgets**
//   Widget _buildFAB(List<dynamic> item, String committeeId) {
//     final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
//     return SizedBox(
//       height: 100,
//       width: 120,
//       child: GestureDetector(
//         onTap: () {
//           String routeName = item[2];
//
//           print("Navigating to: $routeName with committeeId: $committeeId");
//
//           Navigator.pushNamed(
//             context,
//             routeName,
//             arguments: {'committeeId': committeeId},
//           );
//         },
//         child: Container(
//           margin: const EdgeInsets.only(bottom: 10.0, top: 10),
//           child: Column(
//             children: [
//               Image.asset(
//                 themeProvider.isDarkMode ? item[3] : item[0],
//                 height: 40.0,
//               ),
//               MenuButton(
//                 text: item[1],
//                 fontSize: 10.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildLoadingSniper() {
//     return const LoadingSniper();
//   }
//
//   Widget buildEmptyMessage(String message) {
//     return CustomMessage(text: message);
//   }
// }
//
// /// **🔹 Step 5: FlowMenu layout for circular button arrangement**
// class FlowMenuDelegate extends FlowDelegate {
//   @override
//   void paintChildren(FlowPaintingContext context) {
//     final size = context.size;
//     final n = context.childCount;
//     const double radius = 230;
//     final Offset center = Offset(size.width / 2, size.height / 2);
//
//     for (int i = 0; i < n; i++) {
//       final double angle = (2 * pi * i) / n;
//       final double x = center.dx + radius * cos(angle) - 25;
//       final double y = center.dy + radius * sin(angle) - 25;
//
//       context.paintChild(i, transform: Matrix4.identity()..translate(x, y, 0));
//     }
//   }
//
//   @override
//   bool shouldRepaint(FlowMenuDelegate oldDelegate) => false;
// }




import 'dart:math';
import 'package:diligov/core/constants/constant_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/committee_provider_page.dart';
import '../providers/icons_provider.dart';
import '../providers/menus_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/custome_text.dart';
import '../widgets/menu_button.dart';
import '../widgets/custom_message.dart';
import '../widgets/loading_sniper.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class CommitteeCircleMenu extends StatefulWidget {
  @override
  State<CommitteeCircleMenu> createState() => _CommitteeCircleMenuState();
}

class _CommitteeCircleMenuState extends State<CommitteeCircleMenu> {
  String? selectedCommitteeId; // Track the selected committee ID
  String? selectedCommitteeName;
  String? selectedCommitteeCode;


  @override
  Widget build(BuildContext context) {
    return Consumer<CommitteeProviderPage>(
      builder: (context, provider, child) {
        if (provider.committeesData?.committees == null) {
          provider.getListOfMeetingsCommitteesByFilter(provider.yearSelected);
          return buildLoadingSniper();
        }

        if (provider.committeesData!.committees!.isEmpty) {
          return buildEmptyMessage(AppLocalizations.of(context)!.no_data_to_show);
        }

        return Stack(
          alignment: Alignment.center,
          children: [
            selectedCommitteeId == null
                ? _buildCommitteeCircle(provider)
                : _buildCommitteeWidgets(selectedCommitteeId!),

            // **Center Text for Selected Committee Name**
            if (selectedCommitteeName != null)
              Positioned(
                top: MediaQuery.of(context).size.height / 2 - 20,
                child: CustomText(text:selectedCommitteeName!, textAlign: TextAlign.center,),
              ),
          ],
        );
      },
    );
  }

  Widget _buildCommitteeCircle(CommitteeProviderPage provider) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    if (provider.committeesData?.committees == null) {
      return Center(child: CircularProgressIndicator()); // Show loading indicator
    }

    if (provider.committeesData!.committees!.isEmpty) {
      return Center(child: CustomText(text:"No committees available")); // Show message if empty
    }

    int itemCount = provider.committeesData!.committees!.length;

    // Ensure we have at least one committee to display
    if (itemCount == 0) return Center(child: CustomText(text:"No committees available"));

    // Dynamically adjust radius based on committee count
    double radius = (itemCount < 6) ? 200 : min(250, 100 + itemCount * 12);

    print("Total Committees: $itemCount, Calculated Radius: $radius"); // Debugging

    return Center(
      child: SizedBox(
        width: 500, // Fixed container size
        height: 500, // Fixed container size
        child: Stack(
          clipBehavior: Clip.none, // Prevents clipping of Positioned widgets
          children: provider.committeesData!.committees!.asMap().entries.map((entry) {
            int index = entry.key;
            var committee = entry.value;

            // Calculate evenly distributed angles
            double angle = (2 * pi * index) / itemCount;
            double x = radius * cos(angle);
            double y = radius * sin(angle);

            print("Committee: ${committee.committeeName}, Position: ($x, $y)"); // Debugging

            return Positioned(
              left: (250 + x) - 40, // Centering logic
              top: (250 + y) - 40, // Centering logic
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCommitteeId = committee.id.toString(); // Set selected committee
                    selectedCommitteeName = committee.committeeName;
                    selectedCommitteeCode = committee.committeeCode;
                  });
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 40,
                      backgroundImage: AssetImage("icons/committee_circle_menu_icons/committee_icon.png"),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 150, // Ensure text stays within bounds
                      child: CustomText(text:
                        committee.committeeName ?? "Unknown",
                         fontSize: 12, fontWeight: FontWeight.bold,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis, // Avoid long text overflow
                        maxLines: 2, // Wrap text properly
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  /// **🔹 Step 2: Show widgets for the selected committee**
  Widget _buildCommitteeWidgets(String committeeId) {

    List<List<String>> menuItems = [
      ["icons/committee_circle_menu_icons/action_tracker_icon.png", "Action Tracker", ConstantName.actionsTrackerList, "icons/iconsFroDarkMode/action_tracker_icon_dark.png"],
      ["icons/committee_circle_menu_icons/board_evaluation_icon.png", "Evaluation", ConstantName.evaluationListViews, "icons/iconsFroDarkMode/board_evaluation_icon_dark.png"],
      ["icons/committee_circle_menu_icons/annual_calendar_icon.png", "Annual Calendar", ConstantName.committeeCalendarPage, "icons/iconsFroDarkMode/annual_calendar_icon_dark.png"],
      ["icons/committee_circle_menu_icons/resolutions_icon.png", "Resolutions", ConstantName.resolutionsListViews, "icons/iconsFroDarkMode/resolutions_icon_dark.png"],
      ["icons/committee_circle_menu_icons/agenda_minutes_icon.png", "Minutes", ConstantName.minutesMeetingList, "icons/iconsFroDarkMode/agenda_minutes_icon_dark.png"],
      ["icons/committee_circle_menu_icons/reports_icon.png", "Annual Report", ConstantName.committeesAnnualAuditReportListView, "icons/iconsFroDarkMode/annual_report_icon_dark.png"],
      ["icons/committee_circle_menu_icons/remuneration_policy_light.png","Remuneration Policy",ConstantName.remunerationPolicyListViews,"icons/iconsFroDarkMode/remuneration_policy_dark.png"],
      ["icons/committee_circle_menu_icons/perfromance_and_rewards_light.png","Performance & Rewards",ConstantName.performanceRewardListView,"icons/iconsFroDarkMode/perfromance-and-rewards-dark.png"],
      ["icons/committee_circle_menu_icons/nominations_light.png", "Nominations", ConstantName.nominationsList, "icons/iconsFroDarkMode/nominations_dark.png"],
      ["icons/committee_circle_menu_icons/financials_icon.png", "Financials", ConstantName.financialListViews, "icons/iconsFroDarkMode/financials_icon_dark.png"],
      ["icons/committee_circle_menu_icons/disclosures_light.png", "Disclosures", ConstantName.disclosuresHowMenus, "icons/iconsFroDarkMode/disclosures_dark.png"],
      ["icons/committee_circle_menu_icons/s-suite_kpi_light.png", "C-Suite  KPI’s", ConstantName.suiteKpiListView, "icons/iconsFroDarkMode/c-suite_kpi_dark.png"],
      ["icons/committee_circle_menu_icons/committee_information_light.png", "Committee Information", "committee_info", "icons/iconsFroDarkMode/company_information_icon_dark.png"],
      ["icons/committee_circle_menu_icons/s-suite_kpi_light.png", "KPI", "kpi_list", "icons/iconsFroDarkMode/kpi_icon_dark.png"],
    ];

    // **Remove "Financials" if selected committee is "Nominations"**
    if (selectedCommitteeCode == "nomination_remuneration_committee") {
      menuItems.removeWhere((item) => item[1] == "Financials");
    }

    // **Remove "Disclosures" if selected committee is "Audit committee"**
    if (selectedCommitteeCode == "audit_committee") {
      menuItems.removeWhere((item) => item[1] == "Disclosures");
      menuItems.removeWhere((item) => item[1] == "Remuneration Policy");
    }

    return Center(
      child: Flow(
        delegate: FlowMenuDelegate(),
        children: menuItems.map<Widget>((item) => _buildFAB(item, committeeId)).toList(),
      ),
    );
  }

  /// **🔹 Step 3: Build FAB buttons for widgets**
  Widget _buildFAB(List<dynamic> item, String committeeId) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return SizedBox(
      height: 100,
      width: 120,
      child: GestureDetector(
        onTap: () {

          context.read<MenusProvider>().changeMenu(item[1]);
          context.read<MenusProvider>().changeIconName(item[1]);
          // context.read<IconsProvider>().updateIcon(item[item[1]]!,item[3]);

          String routeName = item[2];

          print("Navigating to: $routeName with committeeId: $committeeId");

          Navigator.pushReplacementNamed( // it was pushNamed
            context,
            routeName,
            arguments: {'committeeId': committeeId},
          );
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 10.0, top: 10),
          child: Column(
            children: [
              Image.asset(
                themeProvider.isDarkMode ? item[3] : item[0],
                height: 40.0,
              ),
              MenuButton(
                text: item[1],
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoadingSniper() {
    return const LoadingSniper();
  }

  Widget buildEmptyMessage(String message) {
    return CustomMessage(text: message);
  }
}



class FlowMenuDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    final size = context.size;
    final int n = context.childCount; // Number of items
    const double radius = 230; // Circle size
    final Offset center = Offset(size.width / 2, size.height / 2);

    if (n == 1) {
      // If there's only one child, center it
      context.paintChild(
        0,
        transform: Matrix4.identity()..translate(center.dx - 25, center.dy - 25, 0),
      );
      return;
    }

    final double angleStep = (2 * pi) / n; // Distribute items evenly

    for (int i = 0; i < n; i++) {
      final double angle = angleStep * i;
      final double x = center.dx + radius * cos(angle) - 25;
      final double y = center.dy + radius * sin(angle) - 25;

      context.paintChild(i, transform: Matrix4.identity()..translate(x, y, 0));
    }
  }

  @override
  bool shouldRepaint(FlowMenuDelegate oldDelegate) => false;
}

