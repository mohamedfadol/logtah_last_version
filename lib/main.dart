import 'package:diligov/app_routers.dart';
import 'package:diligov/core/firebase_messageing_service.dart';
import 'package:diligov/firebase_options.dart';
import 'package:diligov/l10n/l10n.dart';
import 'package:diligov/providers/actions_tracker_page_provider.dart';
import 'package:diligov/providers/agenda_page_provider.dart';
import 'package:diligov/providers/annual_audit_report_provider.dart';
import 'package:diligov/providers/annual_reports_provider_page.dart';
import 'package:diligov/providers/audio_recording_provider.dart';
import 'package:diligov/providers/authentications/auth_provider.dart';
import 'package:diligov/providers/authentications/user_provider.dart';
import 'package:diligov/providers/board_page_provider.dart';
import 'package:diligov/providers/committee_provider_page.dart';
import 'package:diligov/providers/competition_provider_page.dart';
import 'package:diligov/providers/disclosure_page_provider.dart';
import 'package:diligov/providers/document_page_provider.dart';
import 'package:diligov/providers/evaluation_page_provider.dart';
import 'package:diligov/providers/file_upload_page_provider.dart';
import 'package:diligov/providers/financial_page_provider.dart';
import 'package:diligov/providers/global_search_provider.dart';
import 'package:diligov/providers/icons_provider.dart';
import 'package:diligov/providers/laboratory_file_processing_provider_page.dart';
import 'package:diligov/providers/localizations_provider.dart';
import 'package:diligov/providers/meeting_page_provider.dart';
import 'package:diligov/providers/member_page_provider.dart';
import 'package:diligov/providers/menus_provider.dart';
import 'package:diligov/providers/minutes_provider_page.dart';
import 'package:diligov/providers/navigation_model_provider.dart';
import 'package:diligov/providers/navigator_provider.dart';
import 'package:diligov/providers/nomination_page_provider.dart';
import 'package:diligov/providers/note_page_provider.dart';
import 'package:diligov/providers/notification_page_provider.dart';
import 'package:diligov/providers/orientation_page_provider.dart';
import 'package:diligov/providers/performance_reward_provider_page.dart';
import 'package:diligov/providers/positions_provider_page.dart';
import 'package:diligov/providers/remuneration_provider_page.dart';
import 'package:diligov/providers/resolutions_page_provider.dart';
import 'package:diligov/providers/suite_kpi_provider_page.dart';
import 'package:diligov/providers/theme_provider.dart';
import 'package:diligov/views/auth/reset_password_screen.dart';
import 'package:diligov/views/dashboard/dashboard_home_screen.dart';
import 'package:diligov/views/auth/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
import 'utility/shared_preference.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  await Firebase.initializeApp();
  if (kDebugMode) {
    print('firebase Messaging Background Handler is ${message.messageId}');
  }
}

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await initLocalNotification();
  await Firebase.initializeApp(
    name: 'diligov-d53c5',
    // options: DefaultFirebaseOptions.currentPlatform,
    options: FirebaseOptions(
      apiKey: 'AIzaSyCC8QHqRgmc1LzbRss_jnequ0boGeQmsh8',
      appId: '1:181277678733:android:bfd8a12617d232cd7596c4',
      messagingSenderId: '181277678733',
      projectId: 'diligov',
      storageBucket: 'diligov.appspot.com',
    ),
  );

  FirebaseMessagingService().initialize();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((value) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => RemunerationProviderPage()),
          ChangeNotifierProvider<MenusProvider>(create:(_) => MenusProvider()),
          ChangeNotifierProvider<PositionsProviderPage>(create:(_) => PositionsProviderPage()),
          ChangeNotifierProvider<SuiteKpiProviderPage>(create:(_) => SuiteKpiProviderPage()),
          ChangeNotifierProvider<CompetitionProviderPage>(create:(_) => CompetitionProviderPage()),
          ChangeNotifierProvider<PerformanceRewardProviderPage>(create:(_) => PerformanceRewardProviderPage()),
          ChangeNotifierProvider<NominationPageProvider>(create: (_) => NominationPageProvider()),
          ChangeNotifierProvider<AuthProvider>(create:(_) => AuthProvider()),
          ChangeNotifierProvider<UserProfilePageProvider>(create:(_) => UserProfilePageProvider()),
          ChangeNotifierProvider<NavigatorProvider>(create:(_) => NavigatorProvider()),
          ChangeNotifierProvider<MemberPageProvider>(create:(_) => MemberPageProvider()),
          ChangeNotifierProvider<BoardPageProvider>(create:(_) => BoardPageProvider()),
          ChangeNotifierProvider<CommitteeProviderPage>(create:(_) => CommitteeProviderPage()),
          ChangeNotifierProvider<MeetingPageProvider>(create:(_) => MeetingPageProvider()),
          ChangeNotifierProvider<EvaluationPageProvider>(create:(_) => EvaluationPageProvider()),
          ChangeNotifierProvider<AnnualAuditReportProvider>(create: (_) => AnnualAuditReportProvider()),
          ChangeNotifierProvider<MinutesProviderPage>(create: (_) => MinutesProviderPage()),
          ChangeNotifierProvider<ResolutionsPageProvider>(create:(_) => ResolutionsPageProvider()),
          ChangeNotifierProvider<LocalizationsProvider>(create:(_) => LocalizationsProvider()),
          ChangeNotifierProvider<ActionsTrackerPageProvider>(create:(_) => ActionsTrackerPageProvider()),
          ChangeNotifierProvider<FinancialPageProvider>(create:(_) => FinancialPageProvider()),
          ChangeNotifierProvider<AnnualReportsProviderPage>(create:(_) => AnnualReportsProviderPage()),
          ChangeNotifierProvider<DisclosurePageProvider>(create:(_) => DisclosurePageProvider()),
          ChangeNotifierProvider<NotePageProvider>(create:(_) => NotePageProvider()),
          ChangeNotifierProvider<NavigationModelProvider>(create:(_) => NavigationModelProvider()),
          ChangeNotifierProvider<NotificationPageProvider>(create:(_) => NotificationPageProvider()),
          ChangeNotifierProvider<GlobalSearchProvider>(create:(_) => GlobalSearchProvider()),
          ChangeNotifierProvider<AudioRecordingProvider>(create:(_) => AudioRecordingProvider()),
          ChangeNotifierProvider<LaboratoryFileProcessingProviderPage>(create:(_) => LaboratoryFileProcessingProviderPage()),
          ChangeNotifierProvider<OrientationPageProvider>(create:(_) => OrientationPageProvider()),
          ChangeNotifierProvider<DocumentPageProvider>(create:(_) => DocumentPageProvider()),
          ChangeNotifierProvider<FileUploadPageProvider>(create:(_) => FileUploadPageProvider()),
          ChangeNotifierProvider<AgendaPageProvider>(create:(_) => AgendaPageProvider()),
          ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
          ChangeNotifierProvider<IconsProvider>(create: (context) => IconsProvider(context.read<ThemeProvider>())),

        ],
        child: MyApp(),
      ),
    );
  });
}

Future<void> initLocalNotification()async{
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid,);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}


class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>  with WidgetsBindingObserver{

  void requestPermissions() async{
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(alert: true,announcement: false,badge: true,carPlay: false,criticalAlert: false,provisional: false,sound: true,);
    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('user granted permission');
    } else {
      print('User declined or has not yet granted permission');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermissions();
    WidgetsBinding.instance?.addObserver(this);

    // Set up method channel to receive termination events
    const platform = MethodChannel('app_lifecycle');
    platform.setMethodCallHandler((call) async {
      if (call.method == 'onTerminate') {
        // Handle termination event
        print('App is being terminated');
        // Perform actions, such as removing tokens, when the app is being terminated
      }
    });

  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
      // App is in the foreground
        print('App is in the foreground');
        break;
      case AppLifecycleState.inactive:
      // App is in an inactive state (possibly transitioning between foreground and background)
        break;
      case AppLifecycleState.paused:
      // App is in the background
        print('App is in the background');
        break;
      case AppLifecycleState.detached:
      // App is detached (not running)
        print('App is inactive remove token');
        UserPreferences().removeUser();
        print('App is detached');
        break;
      case AppLifecycleState.hidden:
        // TODO: Handle this case.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      final themeProvider = Provider.of<ThemeProvider>(context);
      final localeLanguage = Provider.of<LocalizationsProvider>(context);
      // Ideally, fetch notifications when the app is initialized or at a suitable place
      context.read<NotificationPageProvider>().fetchNotifications();
      Future<UserModel> getUserData () => UserPreferences().getUser();
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarIconBrightness: Brightness.dark ,
      ));

      return MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: L10n.all,
        locale: localeLanguage.locale,
        debugShowCheckedModeBanner: false,
        themeMode: themeProvider.themeMode,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        home: FutureBuilder(
            future: getUserData(),
            builder: (context,AsyncSnapshot<UserModel> snapshot) {

              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return LoginScreen();
                case ConnectionState.waiting:
                  return const CircularProgressIndicator();
                default:
                  if (snapshot.hasError || !snapshot.hasData || snapshot.data?.token == null) {
                    print(snapshot.error);
                    return LoginScreen();
                  } else if (snapshot.data?.token == null) {
                    return LoginScreen();
                  } else if(snapshot.data!.resetPasswordRequest! == true){
                    print(' snapshot.data!.resetPasswordRequest! ${snapshot.data!.resetPasswordRequest!}');
                    return  ResetPasswordScreen();
                  }else{
                    Provider.of<UserProfilePageProvider>(context).setUser(snapshot.data!.user);
                    return const DashboardHomeScreen();
                  }
              }
            }
        ),
        routes: AppRoutes.routes,
      );
    });
  }
}

