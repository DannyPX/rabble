import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rabble/services/audio_service/audio_enum.dart';
import 'package:rabble/services/audio_service/audio_service.dart';
import 'package:rabble/services/state_controller/state_controller.dart';
import 'package:rabble/shared.dart';
import '../constants.dart';
import 'package:get/get.dart';

class SongPage extends StatefulWidget {
  SongPage({Key? key}) : super(key: key);

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
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

    void update() {
      setState(() {});
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        extendBody: true,
        backgroundColor: cBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TOP BUTTONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: cIconPrimaryColor,
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: EdgeInsets.zero,
                        fixedSize: const Size(50.0, 50.0),
                        minimumSize: Size.zero,
                        side: const BorderSide(
                          color: cIconTertiaryColor,
                          width: 1.0,
                        ),
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Icon(
                            Icons.favorite_border_rounded,
                            size: 28.0,
                            color: cIconPrimaryColor,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: EdgeInsets.zero,
                            fixedSize: const Size(50.0, 50.0),
                            minimumSize: Size.zero,
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Icon(
                            Icons.share_outlined,
                            size: 26.0,
                            color: cIconPrimaryColor,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: EdgeInsets.zero,
                            fixedSize: const Size(50.0, 50.0),
                            minimumSize: Size.zero,
                            primary: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 38.0),
                // SONG IMAGE
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image(
                          image: AssetImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 36.0),
                // TITLE + ARTIST
                Text(title, style: fTitle2Style),
                Text(subtitle, style: fUnderTitleStyle),
                const SizedBox(height: 28.0),
                // SCRUB BAR
                Column(
                  children: [
                    buildSlider(context),
                    const SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(formatDuration(nowTime),
                            style: fSongMinutesTextStyle),
                        Text(formatDuration(totalDuration),
                            style: fSongMinutesTextStyle),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),
                // PLAY BUTTONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (!isFirst) {
                          _audioHandler.previous();
                          update();
                        }
                      },
                      child: Icon(
                        Icons.skip_previous_outlined,
                        size: 42.0,
                        color:
                            !isFirst ? cIconPrimaryColor : cIconTertiaryColor,
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        primary: cBackgroundColor,
                      ),
                    ),
                    const SizedBox(width: 30.0),
                    Ink(
                      decoration: const BoxDecoration(
                          gradient: cPrimaryGradiant, shape: BoxShape.circle),
                      child: ElevatedButton(
                        onPressed: () {
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
                        child: Icon(
                          currentIcon,
                          size: 50.0,
                          color: cIconPrimaryColor,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(12.0),
                          minimumSize: Size.zero,
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                      ),
                    ),
                    const SizedBox(width: 30.0),
                    ElevatedButton(
                      onPressed: () {
                        if (!isLast) {
                          _audioHandler.next();
                          update();
                        }
                      },
                      child: Icon(
                        Icons.skip_next_outlined,
                        size: 42.0,
                        color: !isLast ? cIconPrimaryColor : cIconTertiaryColor,
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        primary: cBackgroundColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30.0),
                // BOTTOM BUTTONS
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Icon(
                          Icons.format_list_bulleted_rounded,
                          size: 28.0,
                          color: cIconTertiaryColor,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: EdgeInsets.zero,
                          fixedSize: const Size(50.0, 50.0),
                          minimumSize: Size.zero,
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Icon(
                          Icons.repeat_rounded,
                          size: 28.0,
                          color: cIconPrimaryColor,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: EdgeInsets.zero,
                          fixedSize: const Size(50.0, 50.0),
                          minimumSize: Size.zero,
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Icon(
                          Icons.shuffle_rounded,
                          size: 28.0,
                          color: cIconTertiaryColor,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: EdgeInsets.zero,
                          fixedSize: const Size(50.0, 50.0),
                          minimumSize: Size.zero,
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Icon(
                          Icons.playlist_add_rounded,
                          size: 28.0,
                          color: cIconTertiaryColor,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: EdgeInsets.zero,
                          fixedSize: const Size(50.0, 50.0),
                          minimumSize: Size.zero,
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildSlider(BuildContext context) {
    return Container(
      height: 7,
      decoration: const BoxDecoration(
        gradient: cButtonHighlightedGradiant,
      ),
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
          thumbColor: Colors.white,
          trackHeight: 7,
          trackShape: const CustomTrackShape(
              gradient: cPrimaryGradiant, darkenInactive: true),
        ),
        child: Slider(
          value: (nowTime.inMilliseconds / totalDuration.inMilliseconds),
          onChanged: (value) {
            var newNowTime = Duration(
                milliseconds: (totalDuration.inMilliseconds * value).toInt());
            setState(() {
              nowTime = newNowTime;
              _audioHandler.seek(nowTime);
            });
          },
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
