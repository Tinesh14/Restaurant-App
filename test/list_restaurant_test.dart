import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app_v1/cubit/list_restaurant_cubit.dart';
import 'package:restaurant_app_v1/cubit/list_restaurant_state.dart';
import 'package:restaurant_app_v1/data/api/api_service.dart';
import 'package:restaurant_app_v1/data/model/list_restaurant.dart';
import 'package:restaurant_app_v1/data/model/restaurant.dart';

import 'list_restaurant_test.mocks.dart';

final mockApiService = MockApiService();
late ListRestaurantCubit listRestaurantCubit;
@GenerateMocks([
  ApiService,
  ListRestaurantCubit,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() {
    listRestaurantCubit = ListRestaurantCubit(mockApiService);
  });

  group(
    "Unit Test List Restaurant",
    () {
      blocTest<ListRestaurantCubit, ListRestaurantState>(
        'Check Restaurant List if empty',
        build: () {
          when(mockApiService.getListRestaurant()).thenAnswer(
            (realInvocation) async => RestaurantList(),
          );
          return listRestaurantCubit;
        },
        act: (bloc) => bloc.init(isLoad: true),
        expect: () => [
          ListRestaurantLoading(),
          ListRestaurantEmpty(),
          //  isA<CheckOrderPackageMessage>(),
        ],
      );

      blocTest<ListRestaurantCubit, ListRestaurantState>(
        'Check Restaurant List',
        build: () {
          when(mockApiService.getListRestaurant()).thenAnswer(
            (realInvocation) async => RestaurantList(restaurants: [
              Restaurant(),
            ]),
          );
          return listRestaurantCubit;
        },
        act: (bloc) => bloc.init(isLoad: true),
        expect: () => [
          ListRestaurantLoading(),
          isA<ListRestaurantSuccess>(),
          //  isA<CheckOrderPackageMessage>(),
        ],
      );

      blocTest<ListRestaurantCubit, ListRestaurantState>(
        'Check Restaurant List if error',
        build: () {
          when(mockApiService.getListRestaurant()).thenThrow(Exception());
          return listRestaurantCubit;
        },
        act: (bloc) => bloc.init(isLoad: true),
        expect: () => [
          ListRestaurantLoading(),
          isA<ListRestaurantError>(),
          //  isA<CheckOrderPackageMessage>(),
        ],
      );

      blocTest<ListRestaurantCubit, ListRestaurantState>(
        'Check Restaurant List if no internet connection',
        build: () {
          when(mockApiService.getListRestaurant())
              .thenThrow(const SocketException(''));
          return listRestaurantCubit;
        },
        act: (bloc) => bloc.init(isLoad: true),
        expect: () => [
          ListRestaurantLoading(),
          isA<ListRestaurantOffline>(),
          //  isA<CheckOrderPackageMessage>(),
        ],
      );
    },
  );

  group(
    'Widget Test',
    () {
      testWidgets(
        'test widget',
        (widgetTester) async {
          await widgetTester.runAsync(() async=> {
            final stream0 = StreamController<ListRestaurantState>.broadcast().stream;
              var lab = MockListRestaurantCubit();
              //    Iterable iterable = jsonDecode(jsonEncode(dataLab));
              // List<LabOrderItemView> data = List<LabOrderItemView>.from(
              //   iterable.map(
              //     (e) => LabOrderItemView.fromJson(e),
              //   ),
              // );
              // when(lab.init("LAB", "MTMH", "PST3")).thenAnswer(
              //   (realInvocation) => () {},
              // );

              // when(lab.stream).thenAnswer((_) => stream0);

              // when(lab.state).thenAnswer(
              //   (realInvocation) => LabSuccess(
              //     labOrderItemView: data,
              //     isItemExpired: false,
              //   ),
              // );
              //               await tester.pumpWidget(
              //   ScreenUtilInit(
              //     designSize: const Size(375, 812),
              //     minTextAdapt: true,
              //     splitScreenMode: true,
              //     builder: (context, child) {
              //       return MaterialApp(
              //         home: LabUi(
              //           labCubit: lab,
              //           firebaseRemoteConfig: MockFirebaseRemoteConfig(),
              //           remotePromoRibbon: "true",
              //           args: args,
              //           isGrid: true,
              //         ),
              //       );
              //     },
              //   ),
              // );

              // final ribbon = find.byWidgetPredicate(
              //   (widget) => widget is Ribbon && widget.key == Key("list"),
              // );

              // expect(ribbon, findsOneWidget);
          });
        },
      );
    },
  );
}
