import 'package:soft_weather_tennis/features/pages/useful_page/domain/useful_data.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/domain/useful_info.dart';
import 'package:soft_weather_tennis/features/pages/useful_page/repository/useful_screen_repository.dart';

/// mock repository
class MockUsefulPageRepository implements UsefulPageRepository {
  ///
  @override
  Future<List<Advice>> getUsefulData(Map<String, dynamic> body) async {
    await Future<void>.delayed(const Duration(seconds: 2));
    return [
      Advice(
        id: '1',
        theme: 'Как делать убойную подачу. Развиваем плечи.',
        text: 'Статичное положение лишает '
            'возможности выполнить хороший, '
            'плавный, мощный удар с выгодной позиции',
        imageUrl: 'https://picsum.photos/500/400',
      ),
      Advice(
        id: '1',
        theme: 'Как делать убойную подачу. Развиваем плечи.',
        text: 'Статичное положение лишает '
            'возможности выполнить хороший, '
            'плавный, мощный удар с выгодной позиции',
        imageUrl: 'https://picsum.photos/500/400',
      ),
      Advice(
        id: '1',
        theme: 'Как делать убойную подачу. Развиваем плечи.',
        text: 'Статичное положение лишает '
            'возможности выполнить хороший, '
            'плавный, мощный удар с выгодной позиции',
        imageUrl: 'https://picsum.photos/500/400',
      ),
      Advice(
        id: '1',
        theme: 'Как делать убойную подачу. Развиваем плечи.',
        text: 'Статичное положение лишает '
            'возможности выполнить хороший, '
            'плавный, мощный удар с выгодной позиции',
        imageUrl: 'https://picsum.photos/500/400',
      ),
      Advice(
        id: '1',
        theme: 'Как делать убойную подачу. Развиваем плечи.',
        text: 'Статичное положение лишает '
            'возможности выполнить хороший, '
            'плавный, мощный удар с выгодной позиции',
        imageUrl: 'https://picsum.photos/500/400',
      ),
    ];
  }

  ///
  @override
  Future<UsefulInfoData> usefulDataByIndex(String index) async {
    await Future<void>.delayed(const Duration(seconds: 2));
    return UsefulInfoData(
      id: '1',
      imageUrl: 'https://picsum.photos/500/500',
      text:
          'Статичное положение лишает возможности выполнить хороший, плавный, мощный удар с выгодной позиции. Статичное положение лишает возможности выполнить хороший, плавный, мощный удар с выгодной позиции.\n\n Статичное положение лишает возможности выполнить хороший, плавный, мощный удар с выгодной позиции. Статичное положение лишает возможности выполнить хороший, плавный, мощный удар с выгодной позиции.\n\n Статичное положение лишает возможности выполнить хороший, плавный, мощный удар с выгодной позиции. Статичное положение лишает возможности выполнить хороший, плавный, мощный удар с выгодной позиции',
      theme: 'Как делать убойную подачу.\nРазвиваем плечи.',
      advices: [
        Advice(
          id: '1',
          theme: 'Как делать убойную подачу. Развиваем плечи.',
          text: 'Статичное положение лишает '
              'возможности выполнить хороший, '
              'плавный, мощный удар с выгодной позиции',
          imageUrl: 'https://picsum.photos/500/400',
        ),
        Advice(
          id: '1',
          theme: 'Состояние, когда изображение не загружается',
          text: 'Статичное положение лишает '
              'возможности выполнить хороший, '
              'плавный, мощный удар с выгодной позиции',
          imageUrl: 'https://picsufm.photos/500/400',
        ),
        Advice(
          id: '1',
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
