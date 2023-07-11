import 'package:dio/dio.dart';
import 'package:soft_weather_tennis/dto/dto.dart';
import 'package:surf_logger/surf_logger.dart';

/// Класс обработчик exception сущностей для презентативной логики
class ExceptionHandler {
  /// Оболочка с обработчиком ошибок для функции
  static Future<void> shellException(Future Function() function) async {
    try {
      await function();
    }
    // ignore: avoid_catches_without_on_clauses
    catch (e, trace) {
      final msg = _msgError(e);
      if (e is Exception) {
        Logger.e(
          msg ?? '',
          Exception('exception: ${e.toString()} \n trace: $trace'),
        );
      } else if (e is Error) {
        Logger.e(
          msg ?? '',
          Exception(trace),
        );
      }
      throw FormatException(msg ?? '');
    }
  }
}

String? _msgError(Object error) {
  if (error is DioError) {
    if (error.response == null) {
      return 'Ошибка сети';
    } else if (error.response!.data != null) {
      final data = DTO.fromJson(error.response!.data as Map<String, dynamic>);
      if (data.message != null) {
        return data.message;
      }
      return 'Ошибка по статус коду'; // TODO(daniil): Проработать статусы ошибок
    } else {
      return 'Ошибка по статус коду'; // TODO(daniil): Проработать статусы ошибок
    }
  } else if (error is Error) {
    // Обработка ошибок парсинга
    return 'неизвестная ошибка';
  } else {
    return 'ошибка девайса?';
  }
}
