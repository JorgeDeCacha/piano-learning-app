import 'package:flutter/material.dart';

class PlayerControls extends StatefulWidget {
  @override
  _PlayerControlsState createState() => _PlayerControlsState();
}

class _PlayerControlsState extends State<PlayerControls> {
  double _progress = 0.0;
  Duration _currentPosition = Duration.zero;
  Duration _duration = Duration(minutes: 3);

  void _playPause() {
    // Logic to play or pause the audio
  }

  void _rewind() {
    setState(() {
      _currentPosition = _currentPosition.inSeconds > 10
          ? _currentPosition - Duration(seconds: 10)
          : Duration.zero;
    });
  }

  void _forward() {
    setState(() {
      _currentPosition += Duration(seconds: 10);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Slider(
          value: _progress,
          onChanged: (value) {
            setState(() {
              _progress = value;
            });
          },
        ),
        Text('${_currentPosition.inMinutes}:${(_currentPosition.inSeconds % 60).toString().padLeft(2, '0')}/${_duration.inMinutes}:${(_duration.inSeconds % 60).toString().padLeft(2, '0')}'),
        Row(
          children: <Widget>[ 
            IconButton(
              icon: Icon(Icons.replay_10),
              onPressed: _rewind,
            ),
            IconButton(
              icon: Icon(_currentPosition == _duration ? Icons.play_arrow : Icons.pause),
              onPressed: _playPause,
            ),
            IconButton(
              icon: Icon(Icons.forward_10),
              onPressed: _forward,
            ),
          ],
        ),
      ],
    );
  }
}