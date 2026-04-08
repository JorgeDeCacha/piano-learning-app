import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/song.dart';
import '../models/difficulty.dart';
import '../widgets/piano_keyboard.dart';
import '../widgets/player_controls.dart';

class PlayerScreen extends ConsumerStatefulWidget {
  final Song song;

  const PlayerScreen({Key? key, required this.song}) : super(key: key);

  @override
  ConsumerState<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends ConsumerState<PlayerScreen> {
  late Difficulty selectedDifficulty;
  double playbackSpeed = 1.0;

  @override
  void initState() {
    super.initState();
    selectedDifficulty = widget.song.availableDifficulties.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.song.title),
        subtitle: Text(widget.song.artist),
        elevation: 0,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('Descargar'),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Descargando...')), 
                  );
                },
              ),
              PopupMenuItem(
                child: const Text('Compartir'),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Compartiendo...')), 
                  );
                },
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Song Info Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.blue[900],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.music_note, size: 80),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.song.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.song.artist,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.song.formattedDuration,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Difficulty Selector
                const Text(
                  'Dificultad',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: widget.song.availableDifficulties.map((diff) {
                    final isSelected = diff == selectedDifficulty;
                    return FilterChip(
                      label: Text(diff.displayName),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() => selectedDifficulty = diff);
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                // Piano Keyboard Preview
                const Text(
                  'Teclado del Piano',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const PianoKeyboard(),
                const SizedBox(height: 24),
                // Playback Controls
                const PlayerControls(),
                const SizedBox(height: 24),
                // Speed Control
                const Text(
                  'Velocidad de Reproducción',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text('${(playbackSpeed * 100).toStringAsFixed(0)}%'),
                    Expanded(
                      child: Slider(
                        value: playbackSpeed,
                        min: 0.5,
                        max: 2.0,
                        divisions: 6,
                        label: '${(playbackSpeed * 100).toStringAsFixed(0)}%',
                        onChanged: (value) {
                          setState(() => playbackSpeed = value);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}