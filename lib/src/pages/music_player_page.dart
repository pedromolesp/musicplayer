import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer/src/helpers/helpers.dart';
import 'package:musicplayer/src/models/audioplayer_model.dart';
import 'package:musicplayer/src/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class MusicPlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Background(),
          Column(
            children: [
              CustomAppBar(),
              ImageDiscDuration(),
              TitlePlay(),
              Expanded(child: Lyrics())
            ],
          ),
        ],
      )),
    );
  }
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          gradient: LinearGradient(
              colors: [Color(0xff33333E), Color(0xff201E28)],
              begin: Alignment.centerLeft,
              end: Alignment.center)),
    );
  }
}

class Lyrics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lyrics = getLyrics();
    return Container(
      child: ListWheelScrollView(
        physics: BouncingScrollPhysics(),
        itemExtent: lyrics.length * 1.0,
        diameterRatio: 1.5,
        children: getLyrics()
            .map((e) => Text(
                  e,
                  style: TextStyle(fontSize: 20, color: Colors.white60),
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
  final assetAudioPlayer = new AssetsAudioPlayer();
  late AnimationController animationController;
  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void open() {
    final audioPlayerModel =
        Provider.of<AudioPlayerModel>(context, listen: false);
    assetAudioPlayer.open(Audio('assets/Breaking-Benjamin-Far-Away.mp3'),
        autoStart: true, showNotification: true);
    assetAudioPlayer.currentPosition.listen((duration) {
      audioPlayerModel.current = duration;
    });
    assetAudioPlayer.current.listen((duration) {
      audioPlayerModel.songDuration = duration!.audio.duration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      margin: EdgeInsets.only(top: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                'Far Away ',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white70,
                ),
              ),
              Text(
                '-Breaking benjamin',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
          Spacer(),
          FloatingActionButton(
            elevation: 0,
            highlightElevation: 0,
            onPressed: () {
              if (firstTime) {
                open();
                firstTime = false;
              } else {
                assetAudioPlayer.playOrPause();
              }
              final provider =
                  Provider.of<AudioPlayerModel>(context, listen: false);
              if (this.isPlaying) {
                animationController.reverse();

                this.isPlaying = false;
                provider.controller.stop();
              } else {
                animationController.forward();

                this.isPlaying = true;
                provider.controller.repeat();
              }
            },
            backgroundColor: Color(0xffF8CB51),
            child: AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              progress: animationController,
            ),
          )
        ],
      ),
    );
  }
}

class ImageDiscDuration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      margin: EdgeInsets.only(top: 50),
      child: Row(
        children: [
          DiscoImage(),
          Expanded(child: ProgressBar()),
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
    final style = TextStyle(
      color: Colors.white38,
    );
    return Container(
      child: Column(
        children: [
          Text("0:00", style: style),
          SizedBox(
            height: 10,
          ),
          Stack(
            children: [
              Container(
                width: 3,
                height: 230,
                color: Colors.white10,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: 3,
                  height: 150,
                  color: Colors.white70,
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text("0:00", style: style),
        ],
      ),
    );
  }
}

class DiscoImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: [
              Color(0xff484750),
              Color(0xff1E1C24),
            ],
          ),
          borderRadius: BorderRadius.circular(200)),
      padding: EdgeInsets.all(20),
      width: 250,
      height: 250,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Builder(builder: (context) {
                final provider =
                    Provider.of<AudioPlayerModel>(context, listen: true);
                return SpinPerfect(
                  infinite: true,
                  manualTrigger: true,
                  controller: (animationController) =>
                      provider.controller = animationController,
                  duration: Duration(seconds: 10),
                  child: Image(
                    image: AssetImage(
                      "assets/aurora.jpg",
                    ),
                  ),
                );
              }),
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
                    color: Color(0xff1C1C25),
                    borderRadius: BorderRadius.circular(100)),
              )
            ],
          )),
    );
  }
}
