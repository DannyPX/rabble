import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:rabble/constants.dart';
import 'package:rabble/services/audio_service/audio_enum.dart';
import 'package:rabble/services/audio_service/audio_service.dart';
import 'package:get/get.dart';
import 'package:rabble/services/state_controller/state_controller.dart';

class Player extends StatefulWidget {
  Player({
    Key? key,
  }) : super(key: key);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final _audioHandler = Get.find<RabbleAudioService>();
  final _stateController = Get.find<GetController>();
  String get title => _stateController.currentMediaItem.title;
  String get subtitle => _stateController.currentMediaItem.artist!;
  String get imageUrl => _stateController.currentMediaItem.extras!['imageUrl'];
  Duration get totalDuration =>
      checkDuration(_stateController.currentMediaItem.duration);
  bool get isFirst => _stateController.isFirst;
  bool get isLast => _stateController.isLast;
  bool isPlaying = false;
  double iconSize = 35;
  Duration nowTime = Duration();
  IconData currentIcon = Icons.play_arrow_rounded;

  Duration checkDuration(duration) {
    if (duration == null) return const Duration(seconds: 1);
    return duration;
  }

  @override
  Widget build(BuildContext context) {
    AudioService.position.listen((Duration position) {
      setState(() => nowTime = position);
      switch (_stateController.isPlaying) {
        case ButtonState.playing:
          setState(() => currentIcon = Icons.pause_rounded);
          break;
        case ButtonState.loading:
          // TODO: Handle this case.
          break;
        case ButtonState.paused:
          setState(() => currentIcon = Icons.play_arrow_rounded);
          break;
      }
    });

    print(_stateController.isPlaying.toString());
    print(_stateController.currentMediaItem);

    void update() {
      setState(() {});
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
        child: Column(
          children: [
            Container(
              height: 75,
              decoration: BoxDecoration(
                color: Color(0x44FFFFFF),
              ),
              child: Row(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 10,
                        bottom: 10,
                      ),
                      child: Expanded(
                        child: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image(
                              image: AssetImage(imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        flex: 1,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: ListTile(
                      title: Text(
                        title,
                        style: fListTitleStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        subtitle,
                        style: fListUnderTitleStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Center(
                    //TODO Previous
                    child: GestureDetector(
                      onTap: () {
                        if (!isFirst) {
                          _audioHandler.previous();
                          update();
                        }
                      },
                      child: Icon(
                        Icons.skip_previous_rounded,
                        color:
                            !isFirst ? cTextPrimaryColor : cTextTertiaryColor,
                        size: iconSize,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        switch (_stateController.isPlaying) {
                          case ButtonState.playing:
                            _audioHandler.pause();
                            break;
                          case ButtonState.loading:
                            // TODO: Handle this case.
                            break;
                          case ButtonState.paused:
                            _audioHandler.play();
                            break;
                        }
                      },
                      child: CircleAvatar(
                        backgroundColor: cButtonTransparentBgColor,
                        radius: 22,
                        child: Stack(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: cPrimaryGradiant),
                            ),
                            Center(
                              child: ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  final Rect rect =
                                      Rect.fromLTRB(0, 0, iconSize, iconSize);
                                  return cIconGradiant.createShader(rect);
                                },
                                child: SizedBox(
                                  child: Icon(
                                    currentIcon,
                                    color: cTextPrimaryColor,
                                    size: iconSize,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Center(
                    //TODO Next
                    child: GestureDetector(
                      onTap: () {
                        if (!isLast) {
                          _audioHandler.next();
                          update();
                        }
                      },
                      child: Icon(
                        Icons.skip_next_rounded,
                        color: !isLast ? cTextPrimaryColor : cTextTertiaryColor,
                        size: iconSize,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
            buildSlider(context)
          ],
        ),
      ),
    );
  }

  Container buildSlider(BuildContext context) {
    return Container(
      height: 5,
      color: const Color(0x44FFFFFF),
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),
          trackHeight: 5,
          trackShape: CustomTrackShape(
              gradient: cPrimaryGradiant, darkenInactive: true),
        ),
        child: Slider(
          value: (nowTime.inMilliseconds / totalDuration.inMilliseconds),
          onChanged: (value) {},
        ),
      ),
    );
  }
}

class CustomTrackShape extends RectangularSliderTrackShape {
  final LinearGradient gradient;
  final bool darkenInactive;
  const CustomTrackShape(
      {this.gradient:
          const LinearGradient(colors: [Colors.lightBlue, Colors.blue]),
      this.darkenInactive: true});

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {
    assert(context != null);
    assert(offset != null);
    assert(parentBox != null);
    assert(sliderTheme != null);
    assert(sliderTheme.disabledActiveTrackColor != null);
    assert(sliderTheme.disabledInactiveTrackColor != null);
    assert(sliderTheme.activeTrackColor != null);
    assert(sliderTheme.inactiveTrackColor != null);
    assert(sliderTheme.thumbShape != null);
    assert(enableAnimation != null);
    assert(textDirection != null);
    assert(thumbCenter != null);
    // If the slider [SliderThemeData.trackHeight] is less than or equal to 0,
    // then it makes no difference whether the track is painted or not,
    // therefore the painting  can be a no-op.
    if (sliderTheme.trackHeight! <= 0) {
      return;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    // Assign the track segment paints, which are leading: active and
    // trailing: inactive.
    final ColorTween activeTrackColorTween = ColorTween(
        begin: sliderTheme.disabledActiveTrackColor,
        end: sliderTheme.activeTrackColor);
    final ColorTween inactiveTrackColorTween = darkenInactive
        ? ColorTween(
            begin: sliderTheme.disabledInactiveTrackColor,
            end: sliderTheme.inactiveTrackColor)
        : activeTrackColorTween;
    final Paint activePaint = Paint()
      ..shader = gradient.createShader(trackRect)
      ..color = activeTrackColorTween.evaluate(enableAnimation)!;
    final Paint inactivePaint = Paint()
      ..shader = gradient.createShader(trackRect)
      ..color = inactiveTrackColorTween.evaluate(enableAnimation)!;
    Paint leftTrackPaint;
    Paint rightTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
        break;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
        break;
    }
    final Radius trackRadius = Radius.circular(trackRect.height / 2);
    final Radius activeTrackRadius = Radius.circular(trackRect.height / 2 + 1);

    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        trackRect.left,
        (textDirection == TextDirection.ltr)
            ? trackRect.top - (additionalActiveTrackHeight / 2)
            : trackRect.top,
        thumbCenter.dx,
        (textDirection == TextDirection.ltr)
            ? trackRect.bottom + (additionalActiveTrackHeight / 2)
            : trackRect.bottom,
        topLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
        bottomLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
      ),
      leftTrackPaint,
    );
    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        thumbCenter.dx,
        (textDirection == TextDirection.rtl)
            ? trackRect.top - (additionalActiveTrackHeight / 2)
            : trackRect.top,
        trackRect.right,
        (textDirection == TextDirection.rtl)
            ? trackRect.bottom + (additionalActiveTrackHeight / 2)
            : trackRect.bottom,
        topRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
        bottomRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
      ),
      rightTrackPaint,
    );
  }
}
