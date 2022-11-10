import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/base_widget.dart';
import 'package:flutter_go_ship_pbl6/base/presentation/widgets/common.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_navigation.dart';
import 'package:flutter_go_ship_pbl6/utils/config/app_text_style.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/assets.gen.dart';
import 'package:flutter_go_ship_pbl6/utils/gen/colors.gen.dart';
import 'package:mime/mime.dart';

class SentItem extends StatefulWidget {
  SentItem({
    super.key,
    required this.width,
    required this.content,
    required this.dateTime,
  });

  final double width;
  final String content;
  final String dateTime;
  bool isHide = true;

  @override
  State<SentItem> createState() => _SentItemState();
}

class _SentItemState extends State<SentItem> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                widget.isHide = !widget.isHide;
              });
            },
            child: Container(
              constraints: BoxConstraints(maxWidth: widget.width),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ColorName.blue007.withOpacity(0.85),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Text(
                widget.content,
                style: AppTextStyle.w400s15(ColorName.whiteFff),
                maxLines: null,
              ),
            ),
          ),
          AnimatedContainer(
            height: widget.isHide ? 0 : 15,
            margin: const EdgeInsets.only(bottom: 2),
            duration: const Duration(milliseconds: 200),
            child: Text(
              widget.dateTime,
              style: AppTextStyle.w400s12(ColorName.gray838),
            ),
          )
        ],
      ),
    );
  }
}

class ReceiveItem extends StatefulWidget {
  ReceiveItem({
    super.key,
    required this.width,
    required this.content,
    required this.dateTime,
  });

  final double width;
  bool isHide = true;
  final String content;
  final String dateTime;

  @override
  State<ReceiveItem> createState() => _ReceiveItemState();
}

class _ReceiveItemState extends State<ReceiveItem> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                widget.isHide = !widget.isHide;
              });
            },
            child: Container(
              constraints: BoxConstraints(maxWidth: widget.width),
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: ColorName.grayD2d,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Text(
                widget.content,
                style: AppTextStyle.w400s15(ColorName.black000),
                maxLines: null,
              ),
            ),
          ),
          AnimatedContainer(
            height: widget.isHide ? 0 : 15,
            margin: const EdgeInsets.only(bottom: 2),
            duration: const Duration(milliseconds: 200),
            child: Text(
              widget.dateTime,
              style: AppTextStyle.w400s12(ColorName.gray838),
            ),
          )
        ],
      ),
    );
  }
}

class ImageSelect extends StatefulWidget {
  ImageSelect({super.key, required this.path, this.onPressed});

  String path;
  Function()? onPressed;

  @override
  State<ImageSelect> createState() => _ImageSelect();
}

class _ImageSelect extends State<ImageSelect> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          height: 80,
          width: 80,
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(color: ColorName.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(7)),
          child: isImages(widget.path)
              ? Image.file(
                  File(widget.path),
                  fit: BoxFit.fitWidth,
                )
              : const Icon(
                  Icons.video_file,
                  color: ColorName.primaryColor,
                  size: 65,
                ),
        ),
        GestureDetector(
          onTap: () {
            widget.onPressed?.call();
          },
          child: Container(
            padding: const EdgeInsets.all(2.5),
            decoration: BoxDecoration(
              color: ColorName.primaryColor,
              border: Border.all(
                color: ColorName.primaryColor,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Assets.images.deleteIcon
                .image(color: ColorName.whiteFff, scale: 4.5),
          ),
        ),
      ],
    );
  }
}

bool isImages(String path) {
  String? mimeStr = lookupMimeType(path);
  try {
    if (mimeStr!.contains('image')) {
      return true;
    }
    return false;
  } catch (e) {
    return false;
  }
}

class SendImageItems extends StatelessWidget {
  SendImageItems({super.key, this.urls = const [''], required this.width});

  List<String> urls;
  double width;

  @override
  Widget build(BuildContext context) {
    return urls.length == 1
        ? SendImageItem(
            url: urls.first,
            width: width,
          )
        : Align(
            alignment: Alignment.centerRight,
            child: Wrap(
              spacing: 2,
              alignment: WrapAlignment.end,
              children: buildImageList(urls, width / 3),
            ),
          );
  }
}

List<Widget> buildImageList(List<String> urls, double width) {
  return urls
      .map(
        (e) => GestureDetector(
          onTap: () {
            N.toViewMedia(input: {'urls': urls, 'initPage': urls.indexOf(e)});
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 2),
            width: width,
            height: width,
            child: isImageLink(e)
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: e,
                      errorWidget: (context, url, error) {
                        return Container(
                          color: ColorName.grayD2d,
                          width: width,
                          height: 200,
                          child: const LoadingWidget(),
                        );
                      },
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: ColorName.primaryColor, width: 1),
                        borderRadius: BorderRadius.circular(12)),
                    child: const Icon(
                      Icons.video_file,
                      color: ColorName.primaryColor,
                      size: 60,
                    ),
                  ),
          ),
        ),
      )
      .toList();
}

bool isImageLink(String url) {
  Uri uri = Uri.parse(url);
  String typeString = uri.path;
  if (typeString.contains("jpg")) {
    return true;
  }
  return false;
}

class SendImageItem extends StatelessWidget {
  SendImageItem({
    super.key,
    required this.width,
    this.url = '',
  });

  String url;
  double width;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          N.toViewMedia(input: {
            'urls': [url],
          });
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 2),
          width: width,
          child: isImageLink(url)
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: url,
                    errorWidget: (context, url, error) {
                      return Container(
                        color: ColorName.grayD2d,
                        width: width,
                        height: 200,
                        child: const LoadingWidget(),
                      );
                    },
                  ),
                )
              : Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 140,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: ColorName.primaryColor, width: 1),
                        borderRadius: BorderRadius.circular(12)),
                    child: const Icon(
                      Icons.video_file,
                      color: ColorName.primaryColor,
                      size: 120,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class ReceiveImageItems extends StatelessWidget {
  ReceiveImageItems({super.key, this.urls = const [''], required this.width});

  List<String> urls;
  double width;

  @override
  Widget build(BuildContext context) {
    return urls.length == 1
        ? ReceiveImageItem(
            url: urls.first,
            width: width,
          )
        : Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 2,
              runSpacing: 2,
              alignment: WrapAlignment.end,
              children: buildImageList(urls, width / 3),
            ),
          );
  }
}

class ReceiveImageItem extends StatelessWidget {
  ReceiveImageItem({
    super.key,
    required this.width,
    this.url = '',
  });

  String url;
  double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        N.toViewMedia(input: {
          'urls': [url],
        });
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(bottom: 2),
          width: width,
          child: isImageLink(url)
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: url,
                    errorWidget: (context, url, error) {
                      return Container(
                        color: ColorName.grayD2d,
                        width: width,
                        height: 200,
                        child: const LoadingWidget(),
                      );
                    },
                  ),
                )
              : Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 140,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: ColorName.primaryColor, width: 1),
                        borderRadius: BorderRadius.circular(12)),
                    child: const Icon(
                      Icons.video_file,
                      color: ColorName.primaryColor,
                      size: 120,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
