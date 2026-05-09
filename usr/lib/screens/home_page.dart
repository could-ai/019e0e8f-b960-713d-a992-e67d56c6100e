import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LayoutWrapper extends StatelessWidget {
  final Widget child;

  const LayoutWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF090A0F),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF090A0F).withOpacity(0.8),
            border: const Border(
              bottom: BorderSide(
                color: Color(0xFF1E2030),
                width: 1,
              ),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6B46C1).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFF6B46C1).withOpacity(0.5),
                          ),
                        ),
                        child: const Icon(
                          LucideIcons.cpu,
                          color: Color(0xFFA78BFA),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'NovaForge AI',
                        style: GoogleFonts.outfit(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (MediaQuery.of(context).size.width > 800) ...[
                    _NavBarItem(
                      title: 'Workspace',
                      icon: LucideIcons.terminal,
                      onTap: () => Navigator.pushReplacementNamed(context, '/workspace'),
                    ),
                    const SizedBox(width: 24),
                    _NavBarItem(
                      title: 'Bot Builder',
                      icon: LucideIcons.bot,
                      onTap: () => Navigator.pushReplacementNamed(context, '/bot-builder'),
                    ),
                    const SizedBox(width: 32),
                    ElevatedButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, '/workspace'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6B46C1),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Get Started Free',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ] else ...[
                    IconButton(
                      icon: const Icon(LucideIcons.menu, color: Colors.white),
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
      endDrawer: MediaQuery.of(context).size.width <= 800
          ? Drawer(
              backgroundColor: const Color(0xFF090A0F),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        children: [
                          const Icon(
                            LucideIcons.cpu,
                            color: Color(0xFFA78BFA),
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'NovaForge AI',
                            style: GoogleFonts.outfit(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Color(0xFF1E2030)),
                    ListTile(
                      leading: const Icon(LucideIcons.home, color: Colors.white70),
                      title: Text(
                        'Home',
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context, '/');
                      },
                    ),
                    ListTile(
                      leading: const Icon(LucideIcons.terminal, color: Colors.white70),
                      title: Text(
                        'Workspace',
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context, '/workspace');
                      },
                    ),
                    ListTile(
                      leading: const Icon(LucideIcons.bot, color: Colors.white70),
                      title: Text(
                        'Bot Builder',
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 16),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context, '/bot-builder');
                      },
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, '/workspace');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6B46C1),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Get Started Free',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
      body: child,
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: Colors.white70,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.inter(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutWrapper(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const _HeroSection(),
            const _StatsSection(),
            const _FeaturesSection(),
            const _TestimonialsSection(),
            _FooterSection(),
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 64,
        vertical: isMobile ? 60 : 120,
      ),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0, -0.5),
          radius: 1.5,
          colors: [
            const Color(0xFF6B46C1).withOpacity(0.15),
            const Color(0xFF090A0F),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF6B46C1).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFF6B46C1).withOpacity(0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF10B981),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF10B981),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'NovaForge AI v2.0 is live',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFA78BFA),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Build Anything\nWith AI',
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(
              fontSize: isMobile ? 48 : 84,
              fontWeight: FontWeight.w800,
              height: 1.1,
              letterSpacing: -1,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'The ultimate AI platform for generating Discord bots, mobile apps,\nwebsites, and full-stack applications. Completely free forever.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: isMobile ? 16 : 20,
              color: Colors.white60,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 48),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => Navigator.pushReplacementNamed(context, '/workspace'),
                icon: const Icon(LucideIcons.sparkles),
                label: const Text('Start Building Free'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B46C1),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 24 : 32,
                    vertical: isMobile ? 16 : 24,
                  ),
                  textStyle: GoogleFonts.inter(
                    fontSize: isMobile ? 16 : 18,
                    fontWeight: FontWeight.w600,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 8,
                  shadowColor: const Color(0xFF6B46C1).withOpacity(0.5),
                ),
              ),
              if (!isMobile) ...[
                const SizedBox(width: 16),
                OutlinedButton.icon(
                  onPressed: () => Navigator.pushReplacementNamed(context, '/bot-builder'),
                  icon: const Icon(LucideIcons.bot),
                  label: const Text('Discord Bot Builder'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFF374151)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 24,
                    ),
                    textStyle: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (isMobile) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pushReplacementNamed(context, '/bot-builder'),
                icon: const Icon(LucideIcons.bot),
                label: const Text('Discord Bot Builder'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFF374151)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatsSection extends StatelessWidget {
  const _StatsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFF1E2030)),
          bottom: BorderSide(color: Color(0xFF1E2030)),
        ),
        color: Color(0xFF0C0E14),
      ),
      child: Center(
        child: Wrap(
          spacing: 64,
          runSpacing: 48,
          alignment: WrapAlignment.center,
          children: const [
            _StatItem(value: '1.2M+', label: 'Projects Generated'),
            _StatItem(value: '500k+', label: 'Active Developers'),
            _StatItem(value: '100%', label: 'Free Forever'),
            _StatItem(value: '50ms', label: 'Generation Time'),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 48,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 16,
            color: const Color(0xFFA78BFA),
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}

class _FeaturesSection extends StatelessWidget {
  const _FeaturesSection();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    int crossAxisCount = 1;
    if (width > 1200) crossAxisCount = 3;
    else if (width > 800) crossAxisCount = 2;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width < 800 ? 24 : 64,
        vertical: 96,
      ),
      child: Column(
        children: [
          Text(
            'Everything you need to build',
            style: GoogleFonts.outfit(
              fontSize: width < 800 ? 32 : 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Powerful AI models tuned specifically for writing production-ready code.',
            style: GoogleFonts.inter(
              fontSize: width < 800 ? 16 : 20,
              color: Colors.white60,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 64),
          GridView.count(
            crossAxisCount: crossAxisCount,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            childAspectRatio: width < 600 ? 1.5 : 1.2,
            children: const [
              _FeatureCard(
                icon: LucideIcons.smartphone,
                title: 'Mobile App Creator',
                description: 'Generate beautiful, responsive Flutter apps ready for iOS and Android deployment.',
                color: Color(0xFF3B82F6),
              ),
              _FeatureCard(
                icon: LucideIcons.bot,
                title: 'Discord Bot Builder',
                description: 'Create advanced Discord bots with complex commands, databases, and AI features.',
                color: Color(0xFF10B981),
              ),
              _FeatureCard(
                icon: LucideIcons.globe,
                title: 'Website Generator',
                description: 'Build modern React, Vue, or Next.js websites with pixel-perfect designs.',
                color: Color(0xFFF59E0B),
              ),
              _FeatureCard(
                icon: LucideIcons.bug,
                title: 'AI Debugging Assistant',
                description: 'Paste your errors and let our AI instantly find and fix the bugs in your code.',
                color: Color(0xFFEF4444),
              ),
              _FeatureCard(
                icon: LucideIcons.fileCode,
                title: 'Multi-language Support',
                description: 'Write in Python, JS, Go, Rust, and 40+ other languages with perfect syntax.',
                color: Color(0xFF8B5CF6),
              ),
              _FeatureCard(
                icon: LucideIcons.laptop,
                title: 'Live Live Preview',
                description: 'See your UI components, websites, and apps render live as the AI generates code.',
                color: Color(0xFFEC4899),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF12141D),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF1E2030)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Text(
              description,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: Colors.white60,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TestimonialsSection extends StatelessWidget {
  const _TestimonialsSection();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width < 800 ? 24 : 64,
        vertical: 96,
      ),
      color: const Color(0xFF0C0E14),
      child: Column(
        children: [
          Text(
            'Loved by developers',
            style: GoogleFonts.outfit(
              fontSize: width < 800 ? 32 : 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 64),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: const [
              _TestimonialCard(
                name: 'Sarah Chen',
                role: 'Full Stack Developer',
                text: 'NovaForge has completely changed how I prototype. I can spin up a full React app with a Supabase backend in minutes instead of days.',
              ),
              _TestimonialCard(
                name: 'Marcus Johnson',
                role: 'Discord Bot Creator',
                text: 'The Discord bot builder is insane. The AI understands complex command structures and event handling out of the box.',
              ),
              _TestimonialCard(
                name: 'Elena Rodriguez',
                role: 'Indie Hacker',
                text: 'I built my entire startup MVP using the mobile app creator. The fact that this tool is completely free is mind-blowing.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final String name;
  final String role;
  final String text;

  const _TestimonialCard({
    required this.name,
    required this.role,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF151822),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF232635)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6B46C1), Color(0xFF3B82F6)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: Text(
                    name[0],
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    role,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: const Color(0xFFA78BFA),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            '"$text"',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.white70,
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: const BoxDecoration(
        color: Color(0xFF090A0F),
        border: Border(
          top: BorderSide(color: Color(0xFF1E2030)),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                LucideIcons.cpu,
                color: Color(0xFFA78BFA),
                size: 32,
              ),
              const SizedBox(width: 12),
              Text(
                'NovaForge AI',
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            '© 2026 NovaForge AI. All rights reserved. Built with CouldAI.',
            style: GoogleFonts.inter(
              color: Colors.white54,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
