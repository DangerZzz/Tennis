import 'package:soft_weather_tennis/features/pages/best_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/best_page/domain/best_data_list.dart';
import 'package:soft_weather_tennis/features/pages/best_page/domain/best_data_list_mapper.dart';
import 'package:soft_weather_tennis/features/pages/best_page/dto/best_data_list_dto.dart';

/// Репозиторий для главной
class BestPageRepository {
  final BestPageClient _bestPageClient;

  /// Конструктор [BestPageRepository]
  BestPageRepository(this._bestPageClient);

  /// Возвращает данные страницы лучшие
  Future<List<BestData>> getBestListData() =>
      _bestPageClient.getBestListData().then(
        (dto) {
          final data = dto.data as List<dynamic>;
          final items = <BestData>[];
          for (final element in data) {
            items.add(bestDataMapper(
              BestDataDto.fromJson(element as Map<String, dynamic>),
            ));
          }
          return items;
          // items
          //     .map((e) => bestDataMapper(BestDataDto.fromJson(e)))
          //     .toList();
          // final data =
          //     BestDataListDtO.fromJson(dto.data as Map<String, dynamic>);
          // return BestDataList(
          //   bestData: [
          //     BestData(
          //       imageUrl: data.bestData.user.avatar.src,
          //       age: '1',
          //       name: data.bestData.user.name,
          //       rank: 'rank',
          //       description: data.bestData.description,
          //       topCount: 1,
          //     ),
          //   ],
          // );
        },
      );
}
