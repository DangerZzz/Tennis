import 'package:flutter/material.dart';
import 'package:soft_weather_tennis/features/pages/settings_page/pages/avatar_page/avatar_page_wm.dart';

///
class ImageUpload extends StatelessWidget {
  /// wm
  final IAvatarPageWidgetModel widgetModel;

  ///
  const ImageUpload({required this.widgetModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: widgetModel.chooseDirectory,
        child: Container(
          height: 273,
          width: 273,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(238, 238, 238, 1),
            borderRadius: BorderRadius.circular(200),
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Icon(
              Icons.camera_alt_rounded,
              size: 150,
              color: Color.fromRGBO(153, 153, 153, 1),
            ),
          ),
        ),
      ),
    );
  }
}
