import 'package:flutter/material.dart';

void main() {
  runApp(const PinterestApp());
}

// ─── Aplicativo raiz ───────────────────────────────────────────────────────────
class PinterestApp extends StatelessWidget {
  const PinterestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PinterestScreen(),
    );
  }
}

// ─── Tela principal ────────────────────────────────────────────────────────────
class PinterestScreen extends StatelessWidget {
  const PinterestScreen({super.key});

  // Lista de pins com título, altura do card e URL da imagem (picsum.photos)
  static const List<Map<String, dynamic>> pins = [
    {
      'title': 'Tattoo',
      'height': 300.0,
      'imageUrl': 'https://tse2.mm.bing.net/th/id/OIP.MIiB9lzyFrK3zZ_MkxN88AAAAA?r=0&rs=1&pid=ImgDetMain&o=7&rm=3',
    },
    {
      'title': 'Code',
      'height': 190.0,
      'imageUrl': 'https://th.bing.com/th/id/OIP.seA5iWlLDUGnk4OJ7tIYcQHaEK?r=0&o=7rm=3&rs=1&pid=ImgDetMain&o=7&rm=3',
    },
    {
      'title': 'fallen do cs',
      'height': 220.0,
      'imageUrl': 'https://tse3.mm.bing.net/th/id/OIP.n3WUDRYNxN_nyFkAXdg18AHaEK?r=0&rs=1&pid=ImgDetMain&o=7&rm=3',
    },
    {
      'title': 'six seven',
      'height': 240.0,
      'imageUrl': 'https://th.bing.com/th/id/OIP.yj42VMJmwCkkZuoyxZL42QHaHa?w=169&h=180&c=7&r=0&o=7&pid=1.7&rm=3',
    },
    {
      'title': 'meme',
      'height': 210.0,
      'imageUrl': 'https://img2.lovecell.com.br/9523a9ec001b3271199682267460e04306c8eec3d4cabc03c60cf4bf5bfdde3f.webp',
    },
    {
      'title': 'paisagem',
      'height': 260.0,
      'imageUrl': 'https://picsum.photos/seed/coding/400/520',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Largura real da tela — base para todos os cálculos responsivos
    final double screenWidth = MediaQuery.of(context).size.width;

    // Largura de cada coluna: metade da tela menos padding lateral e espaço central
    final double colWidth = (screenWidth - 18) / 2;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            children: [
              // Barra de topo com logo e ícones
              _topBar(),

              // Barra de categorias horizontais
              _categoryBar(),

              // Grade de pins em duas colunas (scroll vertical)
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(6, 8, 6, 90),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Coluna da esquerda: pins de índice par
                      SizedBox(
                        width: colWidth,
                        child: Column(
                          children: [
                            _pinCard(pins[0], colWidth),
                            _pinCard(pins[2], colWidth),
                            _pinCard(pins[4], colWidth),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      // Coluna da direita: pins de índice ímpar
                      SizedBox(
                        width: colWidth,
                        child: Column(
                          children: [
                            _pinCard(pins[1], colWidth),
                            _pinCard(pins[3], colWidth),
                            _pinCard(pins[5], colWidth),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Barra de navegação flutuante centralizada na parte inferior
          _bottomFloatingBar(screenWidth),
        ],
      ),
    );
  }

  // ── Barra superior: logo do Pinterest + ícones de ação ──────────────────────
  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 48, 16, 8),
      child: Row(
        children: [
          // Ícone do Pinterest carregado da web
          Image.network(
            'https://img.icons8.com/ios-filled/100/FFFFFF/pinterest--v1.png',
            width: 36,
            height: 36,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 6),
          const Text(
            'Pinterest',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.2,
            ),
          ),
          const Spacer(),

          // Botão "+" — Material transparente permite o efeito ripple aparecer
          _iconButton(child: const Icon(Icons.add, color: Colors.white, size: 36)),
          const SizedBox(width: 12),

          // Botão de mensagens com badge de notificação
          _iconButton(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 32),
                // Badge vermelho indicando mensagem não lida
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xffe60023), // vermelho característico do Pinterest
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Helper: botão com efeito ripple ao toque ─────────────────────────────────
  // InkWell precisa de um Material acima para renderizar o efeito de onda
  Widget _iconButton({required Widget child}) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: child,
        ),
      ),
    );
  }

  // ── Barra de categorias: abas de filtro horizontal ───────────────────────────
  Widget _categoryBar() {
    return SizedBox(
      height: 48,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 18),
        child: Row(
          children: [
            _categoryItem('Para você', selected: true),
            _categoryItem('Arte'),
            _categoryItem('Tatuagem'),
            _categoryItem('Roupas'),
            _categoryItem('Viagem'),
          ],
        ),
      ),
    );
  }

  // ── Item individual da barra de categorias ───────────────────────────────────
  Widget _categoryItem(String label, {bool selected = false}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.only(right: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              // Linha indicadora embaixo da aba ativa
              Container(
                width: selected ? 70.0 : 0,
                height: 3,
                decoration: BoxDecoration(
                  color: selected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Card de pin: imagem com cantos arredondados + título e menu ──────────────
  Widget _pinCard(Map<String, dynamic> pin, double width) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagem clicável com efeito ripple e cantos arredondados
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(18),
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () {},
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(
                  pin['imageUrl'],
                  width: width,
                  height: pin['height'],
                  fit: BoxFit.cover,
                  // Placeholder cinza enquanto a imagem carrega
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      width: width,
                      height: pin['height'],
                      color: const Color(0xff2c2c2c),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white54,
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  },
                  // Bloco cinza se a imagem falhar ao carregar
                  errorBuilder: (context, error, stack) => Container(
                    width: width,
                    height: pin['height'],
                    color: const Color(0xff2c2c2c),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),

          // Linha com título e botão de opções (...)
          Row(
            children: [
              Expanded(
                child: Text(
                  pin['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Botão "..." com ripple
              _iconButton(
                child: const Icon(Icons.more_horiz, color: Colors.white, size: 22),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Barra de navegação flutuante centralizada na base da tela ────────────────
  Widget _bottomFloatingBar(double screenWidth) {
    const double barWidth = 198;

    return Positioned(
      bottom: 26,
      // Centraliza a barra independente do tamanho da tela
      left: (screenWidth / 2) - (barWidth / 2),
      child: Container(
        width: barWidth,
        height: 66,
        decoration: BoxDecoration(
          color: const Color(0xff25251f),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navIcon(Icons.home_rounded, selected: true),
            _navIcon(Icons.search),
            _profileIcon(),
          ],
        ),
      ),
    );
  }

  // ── Ícone de navegação com destaque quando ativo ─────────────────────────────
  Widget _navIcon(IconData icon, {bool selected = false}) {
    // Material com a cor de fundo permite o ripple aparecer sobre o background
    return Material(
      color: selected ? Colors.white : Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: SizedBox(
          width: 52,
          height: 52,
          child: Icon(
            icon,
            color: selected ? Colors.black : Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }

  // ── Ícone de perfil do usuário na barra de navegação ─────────────────────────
  Widget _profileIcon() {
    return Material(
      color: const Color(0xff33332d),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: const SizedBox(
          width: 52,
          height: 52,
          child: Center(
            child: CircleAvatar(
              radius: 14,
              backgroundColor: Color(0xff777777),
              child: Icon(Icons.person, color: Colors.black, size: 18),
            ),
          ),
        ),
      ),
    );
  }
}
