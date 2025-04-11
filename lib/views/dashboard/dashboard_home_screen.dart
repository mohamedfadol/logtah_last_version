import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/global_search_provider.dart';
import '../../providers/menus_provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/actions_icon_bar_widget.dart';
import '../../widgets/drawer/NavigationDrawerWidget.dart';
import '../../widgets/drowpdown_list_languages_widget.dart';
import '../../widgets/global_search_box.dart';
import '../../widgets/notification_header_list.dart';
import '../../widgets/circularFabWidget.dart';
import '../../widgets/custome_text.dart';
import '../../views/calenders/calendar_page.dart';
import '../../views/user/profile.dart';
import '../../views/dashboard/setting.dart';
import '../../widgets/footer_home_page.dart';

class DashboardHomeScreen extends StatefulWidget {
  const DashboardHomeScreen({Key? key}) : super(key: key);

  @override
  State<DashboardHomeScreen> createState() => _DashboardHomeScreenState();
}

class _DashboardHomeScreenState extends State<DashboardHomeScreen> {
  bool menuPressed = false;
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  // Add a temporary state for showing the Home icon
  bool showHomeIcon = false;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        leading: ActionsIconBarWidget(
          onPressed: () {
            _scaffoldState.currentState?.openDrawer();
          },
          buttonIcon: Icons.chrome_reader_mode_outlined,
          buttonIconColor: Theme.of(context).iconTheme.color,
          buttonIconSize: 30,
          boxShadowColor: Colors.grey,
          boxShadowBlurRadius: 2.0,
          boxShadowSpreadRadius: 0.4,
          containerBorderRadius: 80.0,
          containerBackgroundColor: Colors.white,
        ),
        title: SizedBox(
          width: 600,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2.0,
                  spreadRadius: 0.4,
                ),
              ],
            ),
            child: GlobalSearchBox(),
          ),
        ),
        actions: [
          Center(child: DropdownListLanguagesWidget()),
          const SizedBox(width: 10),
          ActionsIconBarWidget(
            onPressed: () {
              Navigator.pushReplacementNamed(context, CalendarPage.routeName);
            },
            buttonIcon: Icons.calendar_month_outlined,
            buttonIconColor: Theme.of(context).iconTheme.color,
            buttonIconSize: 30,
            boxShadowColor: Colors.grey,
            boxShadowBlurRadius: 2.0,
            boxShadowSpreadRadius: 0.4,
            containerBorderRadius: 30.0,
            containerBackgroundColor: Colors.white,
          ),
          const SizedBox(width: 10),
          ActionsIconBarWidget(
            onPressed: () {
              bool value = themeProvider.isDarkMode ? false : true;
              themeProvider.toggleTheme(value);
            },
            buttonIcon: Icons.brightness_medium,
            buttonIconColor: Theme.of(context).iconTheme.color,
            buttonIconSize: 30,
            boxShadowColor: Colors.grey,
            boxShadowBlurRadius: 2.0,
            boxShadowSpreadRadius: 0.4,
            containerBorderRadius: 30.0,
            containerBackgroundColor: Colors.white,
          ),
          const SizedBox(width: 10),
          NotificationHeaderList(),
          const SizedBox(width: 10),
          ActionsIconBarWidget(
            onPressed: () {
              Navigator.pushReplacementNamed(context, ProfileUser.routeName);
            },
            buttonIcon: Icons.manage_accounts_outlined,
            buttonIconColor: Theme.of(context).iconTheme.color,
            buttonIconSize: 30,
            boxShadowColor: Colors.grey,
            boxShadowBlurRadius: 2.0,
            boxShadowSpreadRadius: 0.4,
            containerBorderRadius: 30.0,
            containerBackgroundColor: Colors.white,
          ),
          const SizedBox(width: 10),
          ActionsIconBarWidget(
            onPressed: () {
              Navigator.pushReplacementNamed(context, Setting.routeName);
            },
            buttonIcon: Icons.brightness_low,
            buttonIconColor: Theme.of(context).iconTheme.color,
            buttonIconSize: 30,
            boxShadowColor: Colors.grey,
            boxShadowBlurRadius: 2.0,
            boxShadowSpreadRadius: 0.4,
            containerBorderRadius: 30.0,
            containerBackgroundColor: Colors.white,
          ),
          const SizedBox(width: 10),
        ],
      ),
      resizeToAvoidBottomInset: false,
      key: _scaffoldState,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: NavigationDrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Consumer<MenusProvider>(
            builder: (BuildContext context, provider, widget){

              print("DashboardHomeScreen getIconName ${provider.getIconName}");
              print("getIconPath  ${themeProvider.getIconPath}");
              return Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 50),
                      Center(
                        child: GestureDetector(
                          onDoubleTap: () {
                            // Call the provider to navigate to the previous menu
                            Provider.of<MenusProvider>(context, listen: false).goToPreviousMenu();
                          },
                          onTap: () {
                            // menusProvider.toggleHomeIcon(true);
                            //
                            // // Revert to the current icon after 2 seconds
                            // Future.delayed(const Duration(seconds: 2), () {
                            //   menusProvider.toggleHomeIcon(false);
                            // });

                            // Show the Home icon
                            // provider.toggleHomeIcon(true);
                            //
                            // // Revert to the current icon after 2 seconds
                            // Future.delayed(const Duration(seconds: 2), () {
                            //   provider.toggleHomeIcon(false);
                            // });

                            Provider.of<MenusProvider>(context, listen: false).changeMenuPressed();
                          },
                          child: Center(
                            child: Column(
                              children: [
                                LayoutBuilder(
                                  builder: (context, constraints) {
                                   // themeProvider

                                    // String iconPath = provider.getIconName == "Home" && (themeProvider.getIconPath == "icons/committee_circle_menu_icons/committee_icon.png" || themeProvider.getIconPath == "icons/iconsFroDarkMode/committee_icon_dark.png")
                                    //     ? themeProvider.isDarkMode ? 'icons/homepage_circle_menu_icons/board_icon.png' : "icons/homepage_circle_menu_icons/board_icon.png"
                                    //     : provider.getIconName == "Board"
                                    //     ? "icons/board_circle_menu_icons/board_main_icon.png"
                                    //     : themeProvider.getIconPath;

                                    String iconPath = provider.getIconName == "Home" && (themeProvider.getIconPath == "icons/committee_circle_menu_icons/committee_icon.png" || themeProvider.getIconPath == "icons/iconsFroDarkMode/committee_icon_dark.png")
                                        ? (themeProvider.isDarkMode ? 'icons/homepage_circle_menu_icons/board_icon.png' : "icons/homepage_circle_menu_icons/board_icon.png")
                                        : provider.getIconName == "Board" ? "icons/board_circle_menu_icons/board_main_icon.png"
                                        : provider.getIconName == "Committees" && (themeProvider.getIconPath == "icons/board_circle_menu_icons/committee_icon.png" || themeProvider.getIconPath == "icons/iconsFroDarkMode/committee_icon_dark.png")
                                        ? themeProvider.isDarkMode ? 'icons/iconsFroDarkMode/committee_icon_dark.png' : "icons/committee_circle_menu_icons/committee_icon.png"
                                        : themeProvider.getIconPath;

                                    double imageSize = constraints.maxWidth * 0.2; // 20% of the parent's width
                                    return Image.asset(iconPath,
                                      width: imageSize,
                                      height: imageSize,
                                    );
                                  },
                                ),

                                if (provider.getIconName != "Home")
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: CustomText(
                                      text: provider.getIconName,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      FooterHomePage(),
                    ],
                  ),
                  Visibility(
                    visible: provider.menuPressed,
                    child: CircularFabWidget(),
                  ),
                ],
              );
            }
        ),
      ),
    );
  }
}
