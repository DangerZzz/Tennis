import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/features/navigation/service/coordinator.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/domain/avatar_images.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/avatar_page/avatar_page_model.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/avatar_page/avatar_page_widget.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/avatar_page/di/avatar_scope.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/avatar_page/widgets/directory_dialog.dart';

///
abstract class IAvatarPageWidgetModel extends IWidgetModel {
  /// Контролер страницы
  ListenableState<EntityState<int>> get index;

  /// Контролер перехода на страницу с аватаром/обложкой
  ListenableState<EntityState<bool>> get isAvatar;

  /// Контролер перехода на страницу с аватаром/обложкой
  ListenableState<EntityState<bool>> get buttonAvailability;

  /// Данные пользователя с бэка
  ListenableState<EntityState<AvatarImages>> get avatarImagesData;

  ///Контроллер обрезки фото
  CustomImageCropController get controller;

  /// Ширина страницы
  double get width;

  /// Аватар
  XFile get avatarImage;

  /// Аватар
  ListenableState<EntityState<Uint8List>> get avatarImageBytes;

  /// Аватар
  ListenableState<EntityState<MemoryImage>> get avatarImageCropped;

  /// Обложка
  XFile get backgroundImage;

  /// Кнопка "назад"
  void onBack();

  /// Кнопка "назад"
  void onBackWithIndex();

  /// Кнопка "назад"
  void toChooseImage({required bool isAvatar});

  /// Выбор, откуда будет загружаться фото
  void chooseDirectory();

  /// Выбор, откуда будет загружаться фото
  void cropImage();
}

///
AvatarPageWidgetModel defaultAvatarPageWidgetModelFactory(
  BuildContext context,
) {
  final scope = context.read<IAvatarPageScope>();
  final appDependencies = context.read<IAppScope>();
  final coordinator = appDependencies.coordinator;
  final model = scope.avatarModel;
  return AvatarPageWidgetModel(
    model,
    coordinator: coordinator,
  );
}

/// Default widget model for AvatarPageWidget
class AvatarPageWidgetModel
    extends WidgetModel<AvatarPageWidget, AvatarPageModel>
    implements IAvatarPageWidgetModel {
  /// [Coordinator] для перехода на другие страницы.
  final Coordinator coordinator;

  @override
  double get width => MediaQuery.of(context).size.width;

  @override
  CustomImageCropController get controller => _controller;

  @override
  XFile get avatarImage => _avatarImage;

  @override
  XFile get backgroundImage => _backgroundImage;

  @override
  ListenableState<EntityState<bool>> get isAvatar => _isAvatar;

  @override
  ListenableState<EntityState<bool>> get buttonAvailability =>
      _buttonAvailability;

  @override
  ListenableState<EntityState<Uint8List>> get avatarImageBytes =>
      _avatarImageBytes;

  @override
  ListenableState<EntityState<MemoryImage>> get avatarImageCropped =>
      _avatarImageCropped;

  @override
  ListenableState<EntityState<AvatarImages>> get avatarImagesData =>
      _avatarImagesData;

  @override
  ListenableState<EntityState<int>> get index => _index;

  late EntityStateNotifier<AvatarImages> _avatarImagesData;

  late EntityStateNotifier<int> _index;
  late EntityStateNotifier<bool> _isAvatar;
  late EntityStateNotifier<bool> _buttonAvailability;
  late EntityStateNotifier<Uint8List> _avatarImageBytes;
  late EntityStateNotifier<MemoryImage> _avatarImageCropped;

  late XFile _avatarImage;
  late XFile _backgroundImage;

  late CustomImageCropController _controller;

  ///
  AvatarPageWidgetModel(
    AvatarPageModel model, {
    required this.coordinator,
  }) : super(model);

  @override
  void toChooseImage({required bool isAvatar}) {
    _isAvatar.content(isAvatar);
    chooseDirectory();
  }

  @override
  void onBack() {
    coordinator.pop();
  }

  @override
  void onBackWithIndex() {
    var currentIndex = _index.value?.data;
    currentIndex = currentIndex! - 1;
    _index.content(currentIndex);
  }

  @override
  Future<void> chooseDirectory() async {
    await showDialog<void>(
      builder: (context) {
        return DirectoryDialog(
          isAvatar: _isAvatar.value?.data ?? false,
          onCamera: () async {
            final picker = ImagePicker();
            try {
              final image = await picker.pickImage(source: ImageSource.camera);

              if (image == null) {
                //ignore: use_build_context_synchronously
                Navigator.pop(context);
              } else {
                _avatarImage = image;
                _index.content(1);
                //ignore: use_build_context_synchronously
                Navigator.pop(context);
              }
            } on PlatformException catch (e) {
              debugPrint('Failed to pick image: $e');
            }
            debugPrint(_avatarImage.path);
          },
          onGallery: () async {
            final picker = ImagePicker();
            try {
              final image = await picker.pickImage(source: ImageSource.gallery);

              if (image == null) {
                //ignore: use_build_context_synchronously
                Navigator.pop(context);
              } else {
                _avatarImage = image;
                final imageBytes = await image.readAsBytes();
                _avatarImageBytes.content(imageBytes);
                _index.content(1);
                //ignore: use_build_context_synchronously
                Navigator.pop(context);
              }
            } on PlatformException catch (e) {
              debugPrint('Failed to pick image: $e');
            }
            debugPrint(_avatarImage.path);
          },
        );
      },
      context: context,
    );
  }

  @override
  Future<void> cropImage() async {
    _buttonAvailability.loading();
    final image = await _controller.onCropImage();
    if (image != null) {
      _avatarImageCropped.content(image);
      _index.content(2);
    }
    _buttonAvailability.content(true);
  }

  @override
  Future<void> initWidgetModel() async {
    super.initWidgetModel();
    await _initLoad();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initLoad() async {
    _index = EntityStateNotifier<int>();
    _index.content(0);
    _isAvatar = EntityStateNotifier<bool>();
    _avatarImage = XFile('');
    _backgroundImage = XFile('');
    _isAvatar.content(true);
    _avatarImagesData = EntityStateNotifier<AvatarImages>();
    _avatarImagesData.loading();
    _controller = CustomImageCropController();
    _avatarImageBytes = EntityStateNotifier<Uint8List>();
    _avatarImageBytes.loading();
    _buttonAvailability = EntityStateNotifier<bool>();
    _buttonAvailability.content(true);
    _avatarImageCropped = EntityStateNotifier<MemoryImage>();
    _avatarImageCropped.loading();
    final res = await model.getAvatarsData();
    _avatarImagesData.content(res);
  }
}
