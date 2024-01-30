/*
 * @Author: 高江华 g598670138@163.com
 * @Date: 2023-09-21 10:53:47
 * @LastEditors: 高江华
 * @LastEditTime: 2024-01-30 10:06:27
 * @Description: file content
 */
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_shop/pages/common/not_found_page.dart';
import 'generated/l10n.dart';
import 'router/index.dart';
import 'package:get/get.dart';
import 'config/request/index.dart';
import 'pages/tabbar/index_page.dart';
import 'store/cart_store.dart';
import 'store/system_store.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_refresh/easy_refresh.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CustomDio();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    EasyRefresh.defaultHeaderBuilder = () => ClassicHeader(
          dragText: 'Pull to refresh'.tr,
          armedText: 'Release ready'.tr,
          readyText: 'Refreshing...'.tr,
          processingText: 'Refreshing...'.tr,
          processedText: 'Succeeded'.tr,
          noMoreText: 'No more'.tr,
          failedText: 'Failed'.tr,
          messageText: 'Last updated at %T'.tr,
        );
    EasyRefresh.defaultFooterBuilder = () => ClassicFooter(
          dragText: 'Pull to load'.tr,
          armedText: 'Release ready'.tr,
          readyText: 'Loading...'.tr,
          processingText: 'Loading...'.tr,
          processedText: 'Succeeded'.tr,
          noMoreText: 'No more'.tr,
          failedText: 'Failed'.tr,
          messageText: 'Last updated at %T'.tr,
        );
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SystemStore>(create: (centext) => SystemStore()),
          BlocProvider<CartStore>(create: (centext) => CartStore()),
        ],
        child: ScreenUtilInit(
          designSize: const Size(750, 1334),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return BlocBuilder<SystemStore, SystemState>(
                builder: (context, state) {
              return GetMaterialApp(
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  locale: state.language,
                  supportedLocales: S.delegate.supportedLocales,
                  localeResolutionCallback:
                      (Locale? locale, Iterable<Locale> supportedLocales) {
                    if (locale != null) {
                      for (var supportedLocale in supportedLocales) {
                        if (supportedLocale.languageCode ==
                            locale.languageCode) {
                          return supportedLocale;
                        }
                      }
                    }
                    // 如果用户的偏好语言不在支持的语言列表中，可以返回默认的语言
                    return supportedLocales.first;
                  },
                  debugShowCheckedModeBanner: false,
                  initialRoute: '/',
                  getPages: routers,
                  unknownRoute:
                      GetPage(name: '/not-found', page: () => NotFoundPage()),
                  theme: ThemeData(
                    primarySwatch: Colors.pink,
                    textTheme:
                        TextTheme(bodyMedium: TextStyle(fontSize: 28.sp)),
                  ),
                  home: IndexPage());
            });
          },
        ));
  }
}
