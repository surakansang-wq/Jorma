import 'package:flutter/material.dart';

void main() {
  runApp(const JonmaApp());
}

class JonmaApp extends StatelessWidget {
  const JonmaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jonma',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFB71C1C),
        scaffoldBackgroundColor: const Color(0xFF1A0000),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2D0A0A),
          elevation: 0,
        ),
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ============ LOGIN SCREEN ============
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    // ในที่นี้อนุญาตให้ผ่านได้เสมอเพื่อความสะดวกในการทดสอบ
    // หรือตรวจสอบ logic ว่าไม่ว่างเปล่า
    if (_usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // Demo: ให้ผ่านไปเลยแม้ไม่กรอก เพื่อทดสอบ UX ได้ง่าย
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2D0A0A), Color(0xFF0D0000)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3D1515),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Jonmà',
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: _usernameController,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            labelText: 'USER',
                            labelStyle: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            labelText: 'PASSWORD',
                            labelStyle: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            'เข้าสู่ระบบ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
}

// ============ HOME SCREEN ============
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jonmà',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2D0A0A), Color(0xFF0D0000)],
          ),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: allMovies.length,
          itemBuilder: (context, index) {
            return MoviePoster(movie: allMovies[index]);
          },
        ),
      ),
    );
  }
}

// ============ MOVIE POSTER ============
class MoviePoster extends StatelessWidget {
  final Movie movie;

  const MoviePoster({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(movie: movie),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF4D1F1F), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [movie.color, movie.color.withOpacity(0.6)],
                  ),
                ),
                child: movie.imageUrl != null
                    ? Image.network(
                        movie.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.movie,
                              size: 50,
                              color: Colors.white.withOpacity(0.3),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Icon(
                          Icons.movie,
                          size: 50,
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      movie.year,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============ MOVIE DETAIL SCREEN ============
class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF2D0A0A),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2D0A0A), Color(0xFF0D0000)],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Image
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [movie.color, Colors.transparent],
                  ),
                ),
                child: movie.imageUrl != null
                    ? Image.network(
                        movie.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.movie,
                              size: 100,
                              color: Colors.white.withOpacity(0.3),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Icon(
                          Icons.movie,
                          size: 100,
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white54),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            movie.rating,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          movie.year,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          movie.duration,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPlayerScreen(movie: movie),
                            ),
                          );
                        },
                        icon: const Icon(Icons.play_arrow, size: 28),
                        label: const Text(
                          'เล่น',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text(
                          'รายการของฉัน',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white54),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      movie.description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'หมวดหมู่: ',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      movie.genre,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'ตอนที่เกี่ยวข้อง',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // ใช้ ListView แบบไม่ต้อง scroll เพราะอยู่ใน SingleChildScrollView แล้ว
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return _buildEpisodeCard(
                          context,
                          episodeNumber: index + 1,
                          title: 'ตอนที่ ${index + 1}',
                          duration: '${movie.duration}',
                          // ส่งรูปภาพไป (ถ้าไม่มีส่งค่าว่าง เพื่อให้ fallback ทำงาน)
                          imageUrl: movie.imageUrl,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEpisodeCard(
    BuildContext context, {
    required int episodeNumber,
    required String title,
    required String duration,
    String? imageUrl,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerScreen(movie: movie),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF2D0A0A),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF4D1F1F)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(8)),
              child: SizedBox(
                width: 120,
                height: 80,
                child: imageUrl != null
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFF3D1515),
                            child: const Icon(Icons.movie, color: Colors.white38),
                          );
                        },
                      )
                    : Container(
                        color: movie.color.withOpacity(0.3),
                        child: Center(
                            child: Text(
                          '$episodeNumber',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      duration,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 12),
              child:
                  Icon(Icons.play_circle_outline, color: Colors.white, size: 32),
            ),
          ],
        ),
      ),
    );
  }
}

// ============ VIDEO PLAYER SCREEN ============
class VideoPlayerScreen extends StatefulWidget {
  final Movie movie;

  const VideoPlayerScreen({Key? key, required this.movie}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  bool _isPlaying = true;
  double _currentPosition = 0.0;
  final double _duration = 100.0;
  bool _showControls = true;

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  String _formatDuration(double seconds) {
    final minutes = (seconds / 60).floor();
    final secs = (seconds % 60).floor();
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          setState(() {
            _showControls = !_showControls;
          });
        },
        child: Stack(
          children: [
            Center(
              child: widget.movie.imageUrl != null
                  ? Image.network(
                      widget.movie.imageUrl!,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.black,
                          child: const Center(
                            child: Icon(Icons.movie,
                                size: 100, color: Colors.white38),
                          ),
                        );
                      },
                    )
                  : Container(
                      color: widget.movie.color,
                      child: const Center(
                        child: Icon(Icons.movie, size: 100, color: Colors.white38),
                      ),
                    ),
            ),
            if (_showControls)
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
            if (_showControls)
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white),
                          ),
                          Expanded(
                            child: Text(
                              widget.movie.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.cast, color: Colors.white),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.more_vert,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Center Play/Pause Button
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          iconSize: 64,
                          icon: Icon(
                            _isPlaying
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            color: Colors.white,
                          ),
                          onPressed: _togglePlayPause,
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Bottom Controls (Slider & Time)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                _formatDuration(_currentPosition),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              Expanded(
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: const Color(0xFFB71C1C),
                                    inactiveTrackColor: Colors.white24,
                                    thumbColor: const Color(0xFFB71C1C),
                                    thumbShape: const RoundSliderThumbShape(
                                      enabledThumbRadius: 6,
                                    ),
                                  ),
                                  child: Slider(
                                    value: _currentPosition,
                                    min: 0.0,
                                    max: _duration,
                                    onChanged: (value) {
                                      setState(() {
                                        _currentPosition = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Text(
                                _formatDuration(_duration),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          // Control Buttons Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.skip_previous,
                                    color: Colors.white),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _currentPosition = (_currentPosition - 10)
                                        .clamp(0.0, _duration);
                                  });
                                },
                                icon: const Icon(Icons.replay_10,
                                    color: Colors.white),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _currentPosition = (_currentPosition + 10)
                                        .clamp(0.0, _duration);
                                  });
                                },
                                icon: const Icon(Icons.forward_10,
                                    color: Colors.white),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.skip_next,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ============ MOVIE MODEL ============
class Movie {
  final String title;
  final String description;
  final String genre;
  final String rating;
  final String year;
  final String duration;
  final Color color;
  final String? imageUrl;

  Movie({
    required this.title,
    required this.description,
    required this.genre,
    required this.rating,
    required this.year,
    required this.duration,
    required this.color,
    this.imageUrl,
  });
}

// ============ SAMPLE DATA ============
final List<Movie> allMovies = [
  Movie(
    title: 'How to Train Your Dragon',
    description:
        'เรื่องราวของไวกิ้งหนุ่มที่ได้มิตรภาพกับมังกร และเปลี่ยนแปลงความสัมพันธ์ระหว่างมังกรกับมนุษย์ไปตลอดกาล',
    genre: 'แอนิเมชั่น, ผจญภัย, ตลก',
    rating: '7+',
    year: '2010',
    duration: '1ช.38น.',
    color: const Color(0xFF2E5266),
    imageUrl: null,
  ),
  Movie(
    title: 'Jumanji',
    description:
        'กลุ่มวัยรุ่นถูกดูดเข้าไปในเกมวิดีโอและต้องเล่นเกมเพื่อหาทางออก พวกเขาต้องผจญภัยในโลกที่อันตรายและลึกลับ',
    genre: 'ผจญภัย, ตลก, แฟนตาซี',
    rating: '13+',
    year: '2017',
    duration: '1ช.59น.',
    color: const Color(0xFF4A6741),
    imageUrl: null,
  ),
  Movie(
    title: 'Harry Potter',
    description:
        'เด็กชายที่ค้นพบว่าเขาเป็นพ่อมด และเข้าเรียนที่โรงเรียนเวทมนตร์เพื่อเรียนรู้ความลับและต่อสู้กับความชั่วร้าย',
    genre: 'แฟนตาซี, ผจญภัย',
    rating: '7+',
    year: '2001',
    duration: '2ช.32น.',
    color: const Color(0xFF3B1F2B),
    imageUrl: null,
  ),
  Movie(
    title: 'Tenet',
    description:
        'เจ้าหน้าที่ลับที่ต้องจัดการกับการจัดการเวลาและพยายามป้องกันสงครามโลกครั้งที่สาม',
    genre: 'แอ็คชั่น, ระทึกขวัญ, ไซไฟ',
    rating: '13+',
    year: '2020',
    duration: '2ช.30น.',
    color: const Color(0xFF1F3A5F),
    imageUrl: null,
  ),
  Movie(
    title: 'Pirates of the Caribbean',
    description:
        'การผจญภัยของกัปตันแจ็ค สแปร์โรว์ และเพื่อนโจรสลัดในการค้นหาสมบัติและต่อสู้กับคำสาป',
    genre: 'ผจญภัย, แฟนตาซี, แอ็คชั่น',
    rating: '13+',
    year: '2003',
    duration: '2ช.23น.',
    color: const Color(0xFF2C3E50),
    imageUrl: null,
  ),
  Movie(
    title: 'Interstellar',
    description:
        'ทีมนักสำรวจท่องเดินทางผ่านรูหนอนในอวกาศเพื่อพยายามรับรองการอยู่รอดของมนุษยชาติ',
    genre: 'ไซไฟ, ผจญภัย, ดราม่า',
    rating: '13+',
    year: '2014',
    duration: '2ช.49น.',
    color: const Color(0xFF34495E),
    imageUrl: null,
  ),
  Movie(
    title: 'Star Wars',
    description:
        'สงครามระหว่างกาแล็กซี่ระหว่างพลังแห่งความดีและความชั่วในจักรวาลที่ห่างไกล',
    genre: 'ไซไฟ, แอ็คชั่น, ผจญภัย',
    rating: '13+',
    year: '1977',
    duration: '2ช.1น.',
    color: const Color(0xFF1C2833),
    imageUrl: null,
  ),
  Movie(
    title: 'Avengers',
    description:
        'ทีมซูเปอร์ฮีโร่มารวมตัวกันเพื่อต่อสู้กับภัยคุกคามที่เกินความสามารถของพวกเขาแต่ละคน',
    genre: 'แอ็คชั่น, ผจญภัย, ไซไฟ',
    rating: '13+',
    year: '2012',
    duration: '2ช.23น.',
    color: const Color(0xFF922B21),
    imageUrl: null,
  ),
  Movie(
    title: 'The Matrix',
    description:
        'โปรแกรมเมอร์ค้นพบความจริงที่น่าตกใจเกี่ยวกับโลกของเขาและบทบาทของเขาในสงครามกับผู้ควบคุมมัน',
    genre: 'ไซไฟ, แอ็คชั่น',
    rating: '18+',
    year: '1999',
    duration: '2ช.16น.',
    color: const Color(0xFF154360),
    imageUrl: null,
  ),
  Movie(
    title: 'Inception',
    description:
        'โจรที่ขโมยความลับของบริษัทผ่านการใช้เทคโนโลยีแชร์ความฝัน ได้รับงานที่ตรงกันข้าม',
    genre: 'ไซไฟ, แอ็คชั่น, ระทึกขวัญ',
    rating: '13+',
    year: '2010',
    duration: '2ช.28น.',
    color: const Color(0xFF1A5276),
    imageUrl: null,
  ),
  Movie(
    title: 'Toy Story',
    description: 'ของเล่นมีชีวิตชีวาเมื่อมนุษย์ไม่อยู่ และพวกเขามีการผจญภัยที่น่าทึ่ง',
    genre: 'แอนิเมชั่น, ตลก, ผจญภัย',
    rating: '0+',
    year: '1995',
    duration: '1ช.21น.',
    color: const Color(0xFF7D6608),
    imageUrl: null,
  ),
  Movie(
    title: 'Frozen',
    description:
        'เจ้าหญิงผู้กล้าหาญเริ่มต้นการเดินทางกับคนขายน้ำแข็งและกวางเรนเดียร์เพื่อค้นหาพี่สาวของเธอ',
    genre: 'แอนิเมชั่น, ผจญภัย, ตลก',
    rating: '0+',
    year: '2013',
    duration: '1ช.42น.',
    color: const Color(0xFF1B4F72),
    imageUrl: null,
  ),
];