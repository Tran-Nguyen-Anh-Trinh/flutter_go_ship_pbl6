// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common.dart';

// **************************************************************************
// FunctionalWidgetGenerator
// **************************************************************************

class CommonBackButton extends StatelessWidget {
  const CommonBackButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final void Function()? onPressed;

  @override
  Widget build(BuildContext _context) => commonBackButton(onPressed: onPressed);
}

class CommonCloseButton extends StatelessWidget {
  const CommonCloseButton({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final void Function()? onPressed;

  @override
  Widget build(BuildContext _context) =>
      commonCloseButton(onPressed: onPressed);
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext _context) => loadingWidget();
}

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    Key? key,
    this.title,
    this.content,
    this.onPressed,
  }) : super(key: key);

  final Widget? title;

  final Widget? content;

  final void Function()? onPressed;

  @override
  Widget build(BuildContext _context) => errorDialog(
        title: title,
        content: content,
        onPressed: onPressed,
      );
}
