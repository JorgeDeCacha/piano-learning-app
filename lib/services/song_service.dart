import '../models/song.dart';
import '../models/difficulty.dart';

class SongService {
  final List<Song> _cachedSongs = [];
  
  Future<List<Song>> getAllSongs() async {
    if (_cachedSongs.isNotEmpty) return _cachedSongs;
    
    // In production, fetch from Firebase or API
    _cachedSongs.addAll(_getSampleSongs());
    return _cachedSongs;
  }
  
  Future<List<Song>> searchSongs(String query) async {
    final allSongs = await getAllSongs();
    final lowerQuery = query.toLowerCase();
    
    return allSongs.where((song) {
      return song.title.toLowerCase().contains(lowerQuery) ||
             song.artist.toLowerCase().contains(lowerQuery);
    }).toList();
  }
  
  Future<Song?> getSongById(String id) async {
    final allSongs = await getAllSongs();
    try {
      return allSongs.firstWhere((song) => song.id == id);
    } catch (e) {
      return null;
    }
  }
  
  List<Song> _getSampleSongs() {
    return [
      Song(
        id: '1',
        title: 'Moonlight Sonata',
        artist: 'Ludwig van Beethoven',
        audioPath: 'assets/audio/moonlight_sonata.mp3',
        midiPath: 'assets/midi/moonlight_sonata.mid',
        duration: Duration(minutes: 5, seconds: 23),
        difficulty: 3,
        availableDifficulties: [Difficulty.intermediate, Difficulty.advanced],
      ),
      Song(
        id: '2',
        title: 'Fur Elise',
        artist: 'Ludwig van Beethoven',
        audioPath: 'assets/audio/fur_elise.mp3',
        midiPath: 'assets/midi/fur_elise.mid',
        duration: Duration(minutes: 3, seconds: 32),
        difficulty: 2,
        availableDifficulties: [Difficulty.beginner, Difficulty.intermediate],
      ),
      Song(
        id: '3',
        title: 'Nocturne Op. 9 No. 2',
        artist: 'Frédéric Chopin',
        audioPath: 'assets/audio/nocturne.mp3',
        midiPath: 'assets/midi/nocturne.mid',
        duration: Duration(minutes: 4, seconds: 28),
        difficulty: 2,
        availableDifficulties: [Difficulty.intermediate, Difficulty.advanced],
      ),
    ];
  }
}