import 'package:soft_weather_tennis/features/pages/useful_page/domain/useful_data.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/repository/useful_screen_repository.dart';

/// mock repository
class MockUsefulPageRepository implements UsefulPageRepository {
  ///
  @override
  Future<UsefulData> getUsefulData() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return UsefulData(
      fastAdvice:
          'Отличный перекус для настоящих спортсменов - питательные батончики. '
          'Не забывай делать перерыв.',
      fastAdviceImageUrl: 'https://picsum.photos/200',
      advice: [
        Advice(
          id: 1,
          theme: 'Как делать убойную подачу. Развиваем плечи.',
          text: 'Статичное положение лишает '
              'возможности выполнить хороший, '
              'плавный, мощный удар с выгодной позиции',
          imageUrl: 'https://picsum.photos/500/400',
        ),
        Advice(
          id: 1,
          theme: 'Как делать убойную подачу. Развиваем плечи.',
          text: 'Статичное положение лишает '
              'возможности выполнить хороший, '
              'плавный, мощный удар с выгодной позиции',
          imageUrl: 'https://picsum.photos/500/400',
        ),
        Advice(
          id: 1,
          theme: 'Как делать убойную подачу. Развиваем плечи.',
          text: 'Статичное положение лишает '
              'возможности выполнить хороший, '
              'плавный, мощный удар с выгодной позиции',
          imageUrl: 'https://picsum.photos/500/400',
        ),
        Advice(
          id: 1,
          theme: 'Как делать убойную подачу. Развиваем плечи.',
          text: 'Статичное положение лишает '
              'возможности выполнить хороший, '
              'плавный, мощный удар с выгодной позиции',
          imageUrl: 'https://picsum.photos/500/400',
        ),
        Advice(
          id: 1,
          theme: 'Как делать убойную подачу. Развиваем плечи.',
          text: 'Статичное положение лишает '
              'возможности выполнить хороший, '
              'плавный, мощный удар с выгодной позиции',
          imageUrl: 'https://picsum.photos/500/400',
        ),
      ],
    );
  }
}
