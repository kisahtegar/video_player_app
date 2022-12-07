import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import "constant.dart" as color;

class VideoInfo extends StatefulWidget {
  const VideoInfo({Key? key}) : super(key: key);

  @override
  _VideoInfoState createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  List videoInfo = [];
  bool _playArea = false;
  bool _isPlaying = false;
  VideoPlayerController? _controller;
  bool _disposed = false;
  int _isPlayingIndex = -1;

  //new appers
  //_oldVideo
  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/videoinfo.json")
        .then((value) {
      setState(() {
        videoInfo = json.decode(value);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    super.dispose();
    _disposed = true;
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    debugPrint("[dbg]dispose: VIDEO DISPOSED");
  }

  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Container(
      decoration: _playArea == false
          ? BoxDecoration(
              gradient: LinearGradient(
              colors: [
                color.AppColor.gradientFirst.withOpacity(0.9),
                color.AppColor.gradientSecond
              ],
              begin: const FractionalOffset(0.0, 0.4),
              end: Alignment.topRight,
            ))
          : BoxDecoration(color: color.AppColor.gradientSecond),
      child: Column(
        children: [
          _playArea == false
              ? Container(
                  padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(Icons.arrow_back_ios,
                                size: 20,
                                color: color.AppColor.secondPageIconColor),
                          ),
                          Expanded(child: Container()),
                          Icon(Icons.info_outline,
                              size: 20,
                              color: color.AppColor.secondPageIconColor),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Legs Toning",
                        style: TextStyle(
                            fontSize: 25,
                            color: color.AppColor.secondPageTitleColor),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "and Glutes Workout",
                        style: TextStyle(
                            fontSize: 25,
                            color: color.AppColor.secondPageTitleColor),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 90,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    color.AppColor
                                        .secondPageContainerGradient1stColor,
                                    color.AppColor
                                        .secondPageContainerGradient2ndColor
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.timer,
                                  size: 20,
                                  color: color.AppColor.secondPageIconColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "68 min",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color:
                                          color.AppColor.secondPageIconColor),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: _w * 0.55,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [
                                    color.AppColor
                                        .secondPageContainerGradient1stColor,
                                    color.AppColor
                                        .secondPageContainerGradient2ndColor
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.handyman_outlined,
                                  size: 20,
                                  color: color.AppColor.secondPageIconColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Resistent band, kettebell",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color:
                                          color.AppColor.secondPageIconColor),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ))
              : Container(
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        padding: EdgeInsets.only(top: 50, left: 30, right: 30),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: color.AppColor.secondPageIconColor,
                              ),
                            ),
                            Expanded(child: Container()),
                            Icon(
                              Icons.info_outline,
                              size: 20,
                              color: color.AppColor.secondPageIconColor,
                            )
                          ],
                        ),
                      ),
                      _playView(context),
                      _controlView(context, _w),
                    ],
                  ),
                ),

          // other
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(70))),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Circuit 1: Legs Toning",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: color.AppColor.circuitsColor),
                    ),
                    Expanded(child: Container()),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            debugPrint(
                                "[dbg]debugButton:_playArea = ${_playArea.toString()}");
                            debugPrint(
                                "[dbg]debugButton:_controller.dataSource = ${_controller?.dataSource}");
                            //debugPrint();
                          },
                          child: Icon(Icons.loop,
                              size: 30, color: color.AppColor.loopColor),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "3 sets",
                          style: TextStyle(
                            fontSize: 15,
                            color: color.AppColor.setsColor,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                SizedBox(height: _h * 0.03),
                Expanded(child: _listView(_w)),
              ],
            ),
          ))
        ],
      ),
    ));
  }

  // Number converter
  String convertTwo(int value) {
    return value < 10 ? '0$value' : '$value';
  }

  Widget _controlView(BuildContext context, double _w) {
    final noMute = (_controller?.value.volume ?? 0) > 0; // Volume logic

    final duration = _duration?.inSeconds ?? 0; // duration video
    final head = _position?.inSeconds ?? 0; //current position duration video
    final remained = max(0, duration - head); //remaining time

    // operator(~/). 22/7 = 3.1-- with operator 22 ~/ 7 = 3 (Only take first number or integer number)
    // Operator(%). 22/7 = 3.1-- with operator 22 % 7 = 1 (Only get remaining part)
    final mins = convertTwo(remained ~/ 60.0); // Minute video
    final secs = convertTwo(remained % 60); // Seconds video

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Slider Duration
        SliderTheme(
            data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.red[700],
                inactiveTrackColor: Colors.red[100],
                trackShape: RoundedRectSliderTrackShape(),
                trackHeight: 2.0,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                thumbColor: Colors.redAccent,
                overlayColor: Colors.red.withAlpha(32),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                tickMarkShape: RoundSliderTickMarkShape(),
                activeTickMarkColor: Colors.red[700],
                inactiveTickMarkColor: Colors.red[100],
                valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                valueIndicatorColor: Colors.redAccent,
                valueIndicatorTextStyle: TextStyle(color: Colors.white)),

            // This Very Important Logic
            child: Slider(
              value: max(0, min(_progress * 100, 100)),
              min: 0,
              max: 100,
              divisions: 100, // this for make output time in top
              //LABEL = SHOWING TEXT DURATION
              label: _position?.toString().split(".")[0],

              onChanged: (value) {
                setState(() {
                  _progress = value * 0.01;
                });
              },

              // NEED TO STOP VIDEO BEFORE CHANGE DURATION
              onChangeStart: (value) {
                setState(() {
                  _controller?.pause();
                });
              },

              // AFTER CHANGE DURATION DONE DO THIS
              onChangeEnd: (value) {
                final duration = _controller?.value.duration;
                if (duration != null) {
                  var newValue = max(0, min(value, 99)) * 0.01;
                  var millis = (duration.inMilliseconds * newValue).toInt();
                  _controller?.seekTo(Duration(milliseconds: millis));
                  _controller?.play();
                }
              },
            )),

        Container(
          height: 50,
          width: _w,
          margin: EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Volume Logic
              InkWell(
                onTap: () {
                  if (noMute) {
                    _controller?.setVolume(0);
                  } else {
                    _controller?.setVolume(1.0);
                  }
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0.0, 0.0),
                          blurRadius: 4.0,
                          color: Color.fromARGB(50, 0, 0, 0))
                    ],
                  ),
                  child: Icon(
                    noMute ? Icons.volume_up : Icons.volume_off,
                    color: Colors.white,
                  ),
                ),
              ),

              //Previous video Logic
              TextButton(
                onPressed: () async {
                  final index = _isPlayingIndex - 1;
                  if (index >= 0) {
                    _initializeVideo(index);
                  } else {
                    Get.snackbar('Video', '',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: color.AppColor.gradientSecond,
                        colorText: Colors.white,
                        messageText: Text(
                          'No more video in the early',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        icon: Icon(
                          Icons.face,
                          size: 30,
                          color: Colors.white,
                        ));
                  }
                },
                child: Icon(Icons.fast_rewind, size: 36, color: Colors.white),
              ),

              // Play video Logic
              TextButton(
                onPressed: () async {
                  if (_isPlaying) {
                    setState(() {
                      _isPlaying = false;
                    });
                    _controller?.pause();
                  } else {
                    setState(() {
                      _isPlaying = true;
                    });
                    _controller?.play();
                  }
                },
                child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 36, color: Colors.white),
              ),

              // next video Logic
              TextButton(
                onPressed: () async {
                  final index = _isPlayingIndex + 1;
                  if (index <= videoInfo.length - 1) {
                    _initializeVideo(index);
                  } else {
                    Get.snackbar('Video', '',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: color.AppColor.gradientSecond,
                        colorText: Colors.white,
                        messageText: Text(
                          'No more video in the list',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        icon: Icon(
                          Icons.face,
                          size: 30,
                          color: Colors.white,
                        ));
                  }
                },
                child: Icon(Icons.fast_forward, size: 36, color: Colors.white),
              ),

              // Duration time
              Text(
                '$mins:$secs',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        TextButton(
            onPressed: () {
              //dispose();
            },
            child: Icon(
              Icons.restart_alt,
              color: Colors.white,
            ))
      ],
    );
  }

  Widget _playView(BuildContext context) {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: VideoPlayer(controller),
      );
    } else {
      return AspectRatio(
          aspectRatio: 16 / 9,
          child: Center(
            child: Text(
              'Loading...',
              style: TextStyle(color: Colors.white60, fontSize: 20),
            ),
          ));
    }
  }

  // initialized
  var _onControllerUpdateTime; // Update time for disposed video
  Duration? _duration; // duration of video
  Duration? _position;
  var _progress = 0.0;

  void _onControllerUpdate() async {
    debugPrint('pass _onControllerUpdate');
    // disposed video
    if (_disposed) {
      debugPrint("[dbg]_onControllerUpdate: gate _disposed");
      return;
    }
    _onControllerUpdateTime = 0;
    final now = DateTime.now().millisecondsSinceEpoch;
    if (_onControllerUpdateTime > now) {
      return;
    }
    _onControllerUpdateTime = now + 500;

    // controller check
    final controller = _controller;
    if (controller == null) {
      debugPrint('controller is null');
      return;
    }
    if (!controller.value.isInitialized) {
      debugPrint('Controller can not be initializeds');
      return;
    }

    // Duration check
    if (_duration == null) {
      _duration = _controller?.value.duration;
    }
    var duration = _duration;
    if (duration == null) return; // double check from Duration

    // Get Position
    var position = await controller.position;
    _position = position; // saved value

    final playing = controller.value.isPlaying;
    if (playing) {
      // handle progress indicator
      if (_disposed) return;
      setState(() {
        // it mean if video 60 sec and position 30, 30/60 = 0.5. value with get bigger deppend on _progress
        // range _progress maybe (0,1)
        _progress = position!.inMilliseconds.ceilToDouble() /
            duration.inMilliseconds.ceilToDouble();
      });
    }
    _isPlaying = playing;
    //debugPrint('[dbg]_onControlUpdate: nothing');
  }

  _initializeVideo(int index) async {
    //debugPrint('======================================');
    debugPrint("[dbg]_initializeVideo() : only passing");
    final controller =
        VideoPlayerController.network(videoInfo[index]["videoUrl"]);
    final old = _controller;
    _controller = controller;

    debugPrint("[dbg]_initializeVideo() : old = $old");

    // remove video
    if (old != null) {
      debugPrint('[dbg]_initializeVideo() : Remove old video');
      old.removeListener(_onControllerUpdate);
      old.pause();
    }

    //setState(() {});
    controller
      ..initialize().then((_) {
        debugPrint("[dbg]_initializeVideo() : Inside controller");
        _isPlayingIndex = index; // current video index
        old?.dispose(); //remove old video

        // play video
        controller.addListener(_onControllerUpdate);
        controller.play();
        setState(() {});
      });
    debugPrint('======================================');
  }

  ListView _listView(double _w) {
    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: _w * 0.06),
        itemCount: videoInfo.length,
        itemBuilder: (_, i) {
          return GestureDetector(
            onTap: () {
              _initializeVideo(i);
              debugPrint(i.toString());
              setState(() {
                if (_playArea == false) {
                  _playArea = true;
                }
              });
            },
            child: _buildCard(i),
          );
        });
  }

  Container _buildCard(int i) {
    return Container(
      height: 135,
      width: 200,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage(videoInfo[i]["thumbnail"]),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    videoInfo[i]['title'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    videoInfo[i]['time'],
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 18),
          Row(
            children: [
              Container(
                width: 88,
                height: 20,
                decoration: BoxDecoration(
                    color: Color(0xFFeaeefc),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text('15s rest',
                      style: TextStyle(color: Color(0xFF839fed))),
                ),
              ),
              Row(
                children: [
                  for (int i = 0; i < 70; i++)
                    i.isEven
                        ? Container(
                            width: 3,
                            height: 1,
                            decoration: BoxDecoration(
                                color: Color(0xFFeaeefc),
                                borderRadius: BorderRadius.circular(2)),
                          )
                        : Container(
                            width: 3,
                            height: 1,
                          )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
