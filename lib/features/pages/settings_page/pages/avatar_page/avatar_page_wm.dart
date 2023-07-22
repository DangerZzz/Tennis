import 'dart:io';

import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:soft_weather_tennis/app/di/app_scope.dart';
import 'package:soft_weather_tennis/components/snack_bar.dart';
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
  ListenableState<EntityState<Uint8List>> get backgroundImageBytes;

  /// Аватар
  ListenableState<EntityState<MemoryImage>> get avatarImageCropped;

  /// Обложка
  XFile get backgroundImage;

  /// Кнопка "назад"
  void onBack();

  /// Кнопка "редактировать"
  void editAvatar();

  /// Кнопка "редактировать"
  void editBackground();

  /// Кнопка "назад"
  void onBackWithIndex();

  /// Кнопка "назад"
  void toChooseImage({required bool isAvatar});

  /// Кнопка "удалить"
  void deleteImageData({
    required String type,
  });

  /// Выбор, откуда будет загружаться фото
  void chooseDirectoryAvatar();

  /// Выбор, откуда будет загружаться фото
  void chooseDirectoryBackground();

  /// Выбор, откуда будет загружаться фото
  void cropAvatar();

  /// Выбор, откуда будет загружаться фото
  void cropBackground();
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

  ///
  bool anyOperation = false;

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
  ListenableState<EntityState<Uint8List>> get backgroundImageBytes =>
      _backgroundImageBytes;

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
  late EntityStateNotifier<Uint8List> _backgroundImageBytes;
  late EntityStateNotifier<MemoryImage> _avatarImageCropped;
  late EntityStateNotifier<MemoryImage> _backgroundImageCropped;

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
    if (isAvatar) {
      chooseDirectoryAvatar();
    } else {
      chooseDirectoryBackground();
    }
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
  Future<void> deleteImageData({
    required String type,
  }) async {
    if (!anyOperation) {
      anyOperation = true;
      try {
        await model.deleteAvatarData(
          id: _avatarImagesData.value?.data?.id ?? '',
          type: type,
        );
        await refresh();
      } on FormatException catch (e) {
        //ignore:use_build_context_synchronously
        ShowSnackBar().showError(context);
      }
      anyOperation = false;
    }
  }

  @override
  Future<void> chooseDirectoryAvatar() async {
    _avatarImage = XFile('');
    _controller.dispose();

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
  Future<void> editAvatar() async {
    if (!anyOperation) {
      anyOperation = true;
      _isAvatar.content(true);

      _avatarImage = XFile('');
      _controller.dispose();

      final imageInUnit8List = (await NetworkAssetBundle(
        Uri.parse(_avatarImagesData.value?.data?.avatarUrl ?? ''),
      ).load(_avatarImagesData.value?.data?.avatarUrl ?? ''))
          .buffer
          .asUint8List();
      final tempDirectory = await getApplicationDocumentsDirectory();
      final file = await File('${tempDirectory.path}/image.png').create();
      file.writeAsBytesSync(imageInUnit8List);
      _avatarImageBytes.content(await file.readAsBytes());
      _avatarImage = XFile(file.path);
      anyOperation = false;
    }
    _index.content(1);
  }

  @override
  Future<void> editBackground() async {
    if (!anyOperation) {
      anyOperation = true;

      _isAvatar.content(false);
      _backgroundImage = XFile('');
      _controller.dispose();

      final imageInUnit8List = (await NetworkAssetBundle(
        Uri.parse(_avatarImagesData.value?.data?.backImageUrl ?? ''),
      ).load(_avatarImagesData.value?.data?.backImageUrl ?? ''))
          .buffer
          .asUint8List();
      final tempDirectory = await getApplicationDocumentsDirectory();
      final file = await File('${tempDirectory.path}/image.png').create();
      file.writeAsBytesSync(imageInUnit8List);
      _backgroundImageBytes.content(await file.readAsBytes());
      _backgroundImage = XFile(file.path);
      anyOperation = false;
    }
    _index.content(1);
  }

  @override
  Future<void> chooseDirectoryBackground() async {
    _avatarImage = XFile('');
    _controller.dispose();
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
                _backgroundImage = image;
                final imageBytes = await image.readAsBytes();
                _backgroundImageBytes.content(imageBytes);
                _index.content(1);
                //ignore: use_build_context_synchronously
                Navigator.pop(context);
              }
            } on PlatformException catch (e) {
              debugPrint('Failed to pick image: $e');
            }
            debugPrint(_backgroundImage.path);
          },
          onGallery: () async {
            final picker = ImagePicker();
            try {
              final image = await picker.pickImage(source: ImageSource.gallery);

              if (image == null) {
                //ignore: use_build_context_synchronously
                Navigator.pop(context);
              } else {
                _backgroundImage = image;
                final imageBytes = await image.readAsBytes();
                _backgroundImageBytes.content(imageBytes);
                _index.content(1);
                //ignore: use_build_context_synchronously
                Navigator.pop(context);
              }
            } on PlatformException catch (e) {
              debugPrint('Failed to pick image: $e');
            }
            debugPrint(_backgroundImage.path);
          },
        );
      },
      context: context,
    );
  }

  @override
  Future<void> cropAvatar() async {
    _buttonAvailability.loading();
    final image = await _controller.onCropImage();
    if (image != null) {
      _avatarImageCropped.content(image);
      await uploadAvatar();
    }
    _buttonAvailability.content(true);
  }

  @override
  Future<void> cropBackground() async {
    _buttonAvailability.loading();
    final image = await _controller.onCropImage();
    if (image != null) {
      _backgroundImageCropped.content(image);
      await uploadBackGround();
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

  ///
  Future<void> refresh() async {
    try {
      _avatarImagesData.loading();
      final res = await model.getAvatarsData();
      _avatarImagesData.content(res);
    } on FormatException catch (e) {
      _avatarImagesData.error(e);
      //ignore:use_build_context_synchronously
      ShowSnackBar().showError(context);
    }
  }

  ///
  Future<void> uploadAvatar() async {
    final imageInUnit8List = _avatarImageCropped.value!.data!.bytes;
    final tempDirectory = await getApplicationDocumentsDirectory();
    final file = await File('${tempDirectory.path}/image.png').create();
    file.writeAsBytesSync(imageInUnit8List);

    final originalFileInUnit8List = await File(_avatarImage.path).readAsBytes();
    final originalFile =
        await File('${tempDirectory.path}/originalFile.png').create();
    originalFile.writeAsBytesSync(originalFileInUnit8List);

    try {
      await model.uploadImage(
        type: 'avatar',
        clippedFile: file,
        originalFile: originalFile, //File(_avatarImage.path),
      );
      //ignore:use_build_context_synchronously
      Navigator.pop(context);
      await refresh();
    } on FormatException catch (e) {
      //ignore:use_build_context_synchronously
      ShowSnackBar().showError(context);
    }
  }

  ///
  Future<void> uploadBackGround() async {
    final imageInUnit8List = _backgroundImageCropped.value!.data!.bytes;
    final tempDirectory = await getApplicationDocumentsDirectory();
    final file = await File('${tempDirectory.path}/image.png').create();
    file.writeAsBytesSync(imageInUnit8List);

    final originalFileInUnit8List =
        await File(_backgroundImage.path).readAsBytes();
    final originalFile =
        await File('${tempDirectory.path}/originalFile.png').create();
    originalFile.writeAsBytesSync(originalFileInUnit8List);

    try {
      await model.uploadImage(
        type: 'wallpaper',
        clippedFile: file,
        originalFile: originalFile, //File(_avatarImage.path),
      );
      //ignore:use_build_context_synchronously
      Navigator.pop(context);
      await refresh();
    } on FormatException catch (e) {
      //ignore:use_build_context_synchronously
      ShowSnackBar().showError(context);
    }
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
    _backgroundImageBytes = EntityStateNotifier<Uint8List>();
    _backgroundImageBytes.loading();
    _buttonAvailability = EntityStateNotifier<bool>();
    _buttonAvailability.content(true);
    _avatarImageCropped = EntityStateNotifier<MemoryImage>();
    _avatarImageCropped.loading();

    _backgroundImageCropped = EntityStateNotifier<MemoryImage>();
    _backgroundImageCropped.loading();
    await refresh();
  }
}
