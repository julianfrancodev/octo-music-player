import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/src/helpers/helpers.dart';
import 'package:music_player/src/models/audio_player_model.dart';
import 'package:music_player/src/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class MusicPlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _Background(),
          Column(
            children: [
              CustomAppbar(),
              ImageDiskDuration(),
              TitlePlay(),
              Expanded(
                child: Lirycs(),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: screenSize.height * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.center,
              colors: [
                Color(0xff33333e),
                Color(0xff201e28),
              ])),
    );
  }
}

class Lirycs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> lirycs = getLyrics();

    return Container(
      child: ListWheelScrollView(
        itemExtent: 42,
        physics: BouncingScrollPhysics(),
        diameterRatio: 1.5,
        children: lirycs
            .map((e) => Text(
                  e,
                  style: TextStyle(
                      fontSize: 20, color: Colors.white.withOpacity(0.6)),
                ))
            .toList(),
      ),
    );
  }
}

class TitlePlay extends StatefulWidget {
  @override
  _TitlePlayState createState() => _TitlePlayState();
}

class _TitlePlayState extends State<TitlePlay>
    with SingleTickerProviderStateMixin {
  bool isPlaying = false;
  bool firstTime = true;
  AnimationController playAnimation;

  final assetAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    playAnimation = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    playAnimation.dispose();
    super.dispose();
  }

  void open() {
    final audioPlayerModel =
        Provider.of<AudioPlayerModel>(context, listen: false);
    assetAudioPlayer.open(Audio('assets/Breaking-Benjamin-Far-Away.mp3'));
    assetAudioPlayer.currentPosition.listen((duration) {
      audioPlayerModel.current = duration;
    });

    assetAudioPlayer.current.listen((playingAudio) {
      audioPlayerModel.songDuration = playingAudio.audio.duration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      margin: EdgeInsets.only(top: 40),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                "Far Away",
                style: TextStyle(
                    fontSize: 30, color: Colors.white.withOpacity(0.8)),
              ),
              Text(
                "--Breaking Benjamin--",
                style: TextStyle(
                    fontSize: 14, color: Colors.white.withOpacity(0.5)),
              ),
            ],
          ),
          Spacer(),
          FloatingActionButton(
            backgroundColor: Color(0xfff8cb51),
            child: AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              progress: playAnimation,
            ),
            onPressed: () {
              final audioModel =
                  Provider.of<AudioPlayerModel>(context, listen: false);

              if (this.isPlaying) {
                playAnimation.reverse();
                this.isPlaying = false;
                audioModel.controller.stop();
              } else {
                playAnimation.forward();
                this.isPlaying = true;
                audioModel.controller.repeat();
              }

              if (firstTime) {
                this.open();
              } else {
                assetAudioPlayer.playOrPause();
              }
            },
          )
        ],
      ),
    );
  }
}

class ImageDiskDuration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      margin: EdgeInsets.only(top: 70),
      child: Row(
        children: [
          ImageDisk(),
          // todo progress bar
          SizedBox(
            width: 20,
          ),
          ProgressBar(),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);

    final percent = audioPlayerModel.percent;

    return Container(
      child: Column(
        children: [
          Text(
            '${audioPlayerModel.songTotalDuration}',
            style: TextStyle(color: Colors.white.withOpacity(0.4)),
          ),
          SizedBox(
            height: 10,
          ),
          Stack(
            children: [
              Container(
                width: 3,
                height: 230,
                color: Colors.white.withOpacity(0.1),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: 3,
                  height: 230 * percent,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${audioPlayerModel.currentSecond}',
            style: TextStyle(color: Colors.white.withOpacity(0.4)),
          ),
        ],
      ),
    );
  }
}

class ImageDisk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioModel = Provider.of<AudioPlayerModel>(context);

    return Container(
      padding: EdgeInsets.all(20),
      width: 250,
      height: 250,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SpinPerfect(
              duration: Duration(seconds: 10),
              infinite: true,
              manualTrigger: true,
              controller: (animationController) =>
                  audioModel.controller = animationController,
              child: Image(
                image: AssetImage('assets/aurora.jpg'),
              ),
            ),
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(100)),
            ),
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                  color: Color(0xff1c1c25),
                  borderRadius: BorderRadius.circular(100)),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: [Color(0xff484750), Color(0xff1e1c24)])),
    );
  }
}
