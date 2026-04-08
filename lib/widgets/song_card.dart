import 'package:flutter/material.dart';
import '../models/song.dart';
import '../screens/player_screen.dart';

class SongCard extends StatelessWidget {
  final Song song;
  final VoidCallback? onTap;

  const SongCard({
    Key? key,
    required this.song,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[900]!, Colors.blue[600]!],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.music_note, color: Colors.white),
        ),
        title: Text(
          song.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(song.artist, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.schedule, size: 12),
                const SizedBox(width: 4),
                Text(song.formattedDuration, style: const TextStyle(fontSize: 12)),
                const SizedBox(width: 12),
                ...List.generate(
                  song.difficulty,
                  (index) => const Icon(Icons.star, size: 12, color: Colors.amber),
                ),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.play_arrow_rounded),
        onTap: onTap ??
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PlayerScreen(song: song),
                ),
              );
            },
      ),
    );
  }
}