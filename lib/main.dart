import 'package:core/localization/language_cubit.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:curd_assignment/l10n/app_localizations.dart';
import 'package:curd_assignment/resources/app_colors.dart';
import 'package:curd_assignment/resources/app_strings.dart';
import 'package:core/di/service_locator.dart';
import 'package:core/theme/theme_cubit.dart';
import 'routes/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(
    DevicePreview(
      enabled: true,
      tools: const [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) => const CurdAssignment(),
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: primaryColor,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );
}

class CurdAssignment extends StatefulWidget {
  const CurdAssignment({super.key});

  @override
  State<CurdAssignment> createState() => _CurdAssignmentState();
}

class _CurdAssignmentState extends State<CurdAssignment> {
  late final ThemeCubit themeCubit;
  late final LanguageCubit languageCubit;

  @override
  void initState() {
    super.initState();
    themeCubit = sl<ThemeCubit>();
    languageCubit = sl<LanguageCubit>();
    languageCubit.getLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (_) => sl<ThemeCubit>(),
        ),
        BlocProvider<LanguageCubit>(
          create: (_) => sl<LanguageCubit>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(440, 956),
        child: BlocBuilder<ThemeCubit, ThemeData>(
          bloc: themeCubit,
          builder: (final context, final themeState) {
            return BlocBuilder<LanguageCubit, Locale>(
              bloc: languageCubit,
              builder: (final context, final localeState) {
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  title: appNameString,
                  locale: localeState,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [Locale('en'), Locale('hi'), Locale('mr')],
                  theme: themeState,
                  themeMode: ThemeMode.light,
                  routerConfig: router,
                  builder: (context, child) {
                    return MediaQuery(
                      data:
                          MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(.85)),
                      child: child!,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
