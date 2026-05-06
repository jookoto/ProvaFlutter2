import 'package:flutter/material.dart';

void main() {
  runApp(const PinterestSimpleApp());
}

class PinterestSimpleApp extends StatelessWidget {
  const PinterestSimpleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PinterestScreen(),
    );
  }
}

class PinterestScreen extends StatelessWidget {
  const PinterestScreen({super.key});

  final String pinterestIconUrl =
      'https://img.icons8.com/ios-filled/100/FFFFFF/pinterest--v1.png';

  final List<Map<String, dynamic>> pins = const [
    {'title': 'Conceitos', 'height': 300.0},
    {'title': 'paisagem', 'height': 190.0},
    {'title': 'acessorios', 'height': 220.0},
    {'title': 'dicas', 'height': 240.0},
    {'title': 'carros', 'height': 210.0},
    {'title': 'codigos', 'height': 260.0},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff222222),
      body: Center(
        child: Container(
          width: 390,
          height: 844,
          color: Colors.black,
          child: Stack(
            children: [
              Column(
                children: [
                  topBar(),
                  categoryBar(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(6, 8, 6, 90),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 185,
                            child: Column(
                              children: [
                                pinCard(pins[0]),
                                pinCard(pins[2]),
                                pinCard(pins[4]),
                              ],
                            ),
                          ),
                          const SizedBox(width: 6),
                          SizedBox(
                            width: 185,
                            child: Column(
                              children: [
                                pinCard(pins[1]),
                                pinCard(pins[3]),
                                pinCard(pins[5]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              bottomFloatingBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget topBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 20, 16, 8),
      child: Row(
        children: [
          Image.network(
            pinterestIconUrl,
            width: 38,
            height: 38,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 6),
          const Text(
            'Pinterest',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.2,
            ),
          ),
          const Spacer(),
          const Icon(Icons.add, color: Colors.white, size: 38),
          const SizedBox(width: 22),
          Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
                size: 34,
              ),
              Positioned(
                top: -2,
                right: -2,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xffe60023),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget categoryBar() {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          const SizedBox(width: 18),
          categoryText('Para você', true),
          categoryText('Art', false),
          categoryText('tatuagem', false),
          categoryText('roupas', false),
        ],
      ),
    );
  }

  Widget categoryText(String text, bool selected) {
    return Container(
      margin: const EdgeInsets.only(right: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: selected ? FontWeight.bold : FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: selected ? 86 : 0,
            height: 3,
            color: selected ? Colors.white : Colors.transparent,
          ),
        ],
      ),
    );
  }

  Widget pinCard(Map<String, dynamic> pin) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 185,
            height: pin['height'],
            decoration: BoxDecoration(
              color: const Color(0xff2c2c2c),
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              if (pin['title'] != '')
                Expanded(
                  child: Text(
                    pin['title'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              else
                const Spacer(),
              const Icon(Icons.more_horiz, color: Colors.white, size: 25),
              const SizedBox(width: 4),
            ],
          ),
        ],
      ),
    );
  }

  Widget bottomFloatingBar() {
    return Positioned(
      bottom: 26,
      left: 96,
      child: Container(
        width: 198,
        height: 66,
        decoration: BoxDecoration(
          color: const Color(0xff25251f),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            bottomIcon(Icons.home_rounded, true),
            bottomIcon(Icons.search, false),
            profileIcon(),
          ],
        ),
      ),
    );
  }

  Widget bottomIcon(IconData icon, bool selected) {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: selected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Icon(
        icon,
        color: selected ? Colors.black : Colors.white,
        size: 32,
      ),
    );
  }

  Widget profileIcon() {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: const Color(0xff33332d),
        borderRadius: BorderRadius.circular(17),
      ),
      child: const Center(
        child: CircleAvatar(
          radius: 14,
          backgroundColor: Color(0xff777777),
          child: Icon(Icons.person, color: Colors.black, size: 18),
        ),
      ),
    );
  }
}
