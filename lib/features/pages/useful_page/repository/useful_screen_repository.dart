import 'package:soft_weather_tennis/features/pages/useful_page/api/client.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/domain/useful_data.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/domain/useful_data_list_mapper.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/domain/useful_info.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/dto/useful_data_list_dto.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/dto/useful_info_dto.dart';

/// Репозиторий для главной
class UsefulPageRepository {
  final UsefulPageClient _usefulPageClient;

  /// Конструктор [UsefulPageRepository]
  UsefulPageRepository(this._usefulPageClient);

  /// Возвращает данные страницы полезное
  Future<List<Advice>?> getUsefulData(Map<String, dynamic> body) =>
      _usefulPageClient.getUsefulData(body).then(
        (dto) {
          final data = dto.data as List<dynamic>;
          final items = <Advice>[];
          for (final element in data) {
            items.add(usefulDataMapper(
              UsefulDataDto.fromJson(element as Map<String, dynamic>),
            ));
          }
          return items;
        },
      );

  /// Возвращает данные страницы полезное
  Future<UsefulInfoData?> usefulDataByIndex(String id) =>
      _usefulPageClient.usefulDataByIndex('/api/advice/$id').then(
        (dto) {
          final data = UsefulInfoDtO.fromJson(dto.data as Map<String, dynamic>);
          final res = UsefulInfoData(
            text: data.advice.title ?? '',
            imageUrl: data.advice.cover?.src ?? '',
            theme: data.advice.content ?? '',
            id: data.advice.id ?? '',
            advices: data.seeAlso.map(usefulDataMapper).toList(),
          );

          return res;
        },
      );
}
