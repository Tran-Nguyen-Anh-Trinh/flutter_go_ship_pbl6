import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';

class ItemViewPage extends StatefulWidget {
  ItemViewPage({Key? key, required this.url}) : super(key: key);

  String url;

  late final VideoPlayerController videoPlayerController;

  @override
  State<ItemViewPage> createState() => _ItemViewPageState();
}

class _ItemViewPageState extends State<ItemViewPage> {
  @override
  void initState() {
    super.initState();
    if (!isImageLink(widget.url)) {
      _initController(widget.url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isImageLink(widget.url)
          ? PhotoView(
              imageProvider: CachedNetworkImageProvider(widget.url),
              minScale: PhotoViewComputedScale.contained * 1,
              maxScale: PhotoViewComputedScale.contained * 2.5,
            )
          : AspectRatio(
              aspectRatio: widget.videoPlayerController.value.aspectRatio,
              child: VideoPlayer(widget.videoPlayerController),
            ),
    );
  }

  @override
  void dispose() {
    if (!isImageLink(widget.url)) {
      widget.videoPlayerController.dispose();
    }
    super.dispose();
  }

  void _initController(String link) {
    widget.videoPlayerController = VideoPlayerController.network(link)
      ..initialize().then((_) {
        widget.videoPlayerController.play();
      });
  }

  bool isImageLink(String url) {
    Uri uri = Uri.parse(url);
    String typeString = uri.path;
    if (typeString.contains("jpg")) {
      return true;
    }
    return false;
  }
}
