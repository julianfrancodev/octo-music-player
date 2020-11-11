import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:music_player/src/helpers/helpers.dart';
import 'package:music_player/src/widgets/custom_appbar.dart';

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

  AnimationController playAnimation;

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
              if(this.isPlaying){
                playAnimation.reverse();
                this.isPlaying = false;
              }else{
                playAnimation.forward();
                this.isPlaying = true;
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
    return Container(
      child: Column(
        children: [
          Text(
            '00:00',
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
                  height: 100,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '00:00',
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
