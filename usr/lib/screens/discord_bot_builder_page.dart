import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DiscordBotBuilderPage extends StatefulWidget {
  const DiscordBotBuilderPage({super.key});

  @override
  State<DiscordBotBuilderPage> createState() => _DiscordBotBuilderPageState();
}

class _DiscordBotBuilderPageState extends State<DiscordBotBuilderPage> {
  final TextEditingController _botNameController = TextEditingController();
  final TextEditingController _promptController = TextEditingController();
  
  final List<Map<String, dynamic>> _templates = [
    {
      'title': 'Economy System',
      'icon': LucideIcons.coins,
      'color': Colors.amber,
      'description': 'Advanced economy with shop, daily rewards, and leaderboards.'
    },
    {
      'title': 'Moderation',
      'icon': LucideIcons.shieldAlert,
      'color': Colors.redAccent,
      'description': 'Auto-mod, kick, ban, mute, and warn commands.'
    },
    {
      'title': 'Ticket System',
      'icon': LucideIcons.ticket,
      'color': Colors.greenAccent,
      'description': 'Create support channels, transcripts, and staff panels.'
    },
    {
      'title': 'Anime/Waifu Bot',
      'icon': LucideIcons.heart,
      'color': Colors.pinkAccent,
      'description': 'Image reactions, waifu rolls, and relationship systems.'
    },
    {
      'title': 'Music Player',
      'icon': LucideIcons.music,
      'color': Colors.blueAccent,
      'description': 'High-quality audio streaming with queue and playlists.'
    },
    {
      'title': 'RPG Leveling',
      'icon': LucideIcons.swords,
      'color': Colors.orangeAccent,
      'description': 'XP system, classes, skills, and boss battles.'
    },
  ];

  @override
  void dispose() {
    _botNameController.dispose();
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F111A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF161925),
        title: Text('Discord Bot Builder', style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(LucideIcons.download, color: Colors.white, size: 18),
            label: const Text('Export ZIP', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6B4BFF),
              foregroundColor: Colors.white,
            ),
            icon: const Icon(LucideIcons.play, size: 18),
            label: const Text('Deploy Bot'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Row(
        children: [
          // Main Configuration Area
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bot Configuration',
                    style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 24),
                  _buildTextField('Bot Name', 'e.g., NovaBot', _botNameController, LucideIcons.bot),
                  const SizedBox(height: 16),
                  _buildTextField('Custom Instructions', 'Describe what your bot should do...', _promptController, LucideIcons.messageSquare, maxLines: 4),
                  const SizedBox(height: 32),
                  Text(
                    'Quick Templates',
                    style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.5,
                      ),
                      itemCount: _templates.length,
                      itemBuilder: (context, index) {
                        final template = _templates[index];
                        return _buildTemplateCard(template);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Preview / Settings Sidebar
          Container(
            width: 350,
            decoration: const BoxDecoration(
              color: Color(0xFF161925),
              border: Border(left: BorderSide(color: Color(0xFF2A2D3E))),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Features Included',
                    style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      _buildFeatureToggle('Slash Commands', true),
                      _buildFeatureToggle('Context Menus', true),
                      _buildFeatureToggle('MongoDB Database', false),
                      _buildFeatureToggle('Redis Caching', false),
                      _buildFeatureToggle('Web Dashboard', true),
                      const SizedBox(height: 24),
                      Text(
                        'Framework',
                        style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white70),
                      ),
                      const SizedBox(height: 8),
                      _buildFrameworkSelector('Discord.js (v14)', true),
                      _buildFrameworkSelector('Discord.py', false),
                      _buildFrameworkSelector('JDA (Java)', false),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Color(0xFF0F111A),
                    border: Border(top: BorderSide(color: Color(0xFF2A2D3E))),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6B4BFF),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text('Generate Bot Source', style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller, IconData icon, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.outfit(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white70)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white30),
            prefixIcon: maxLines == 1 ? Icon(icon, color: Colors.white50, size: 20) : null,
            filled: true,
            fillColor: const Color(0xFF161925),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2A2D3E)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2A2D3E)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF6B4BFF)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTemplateCard(Map<String, dynamic> template) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161925),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2A2D3E)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: template['color'].withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(template['icon'], color: template['color'], size: 20),
              ),
              const Spacer(),
              const Icon(LucideIcons.plusCircle, color: Colors.white30, size: 20),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            template['title'],
            style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              template['description'],
              style: const TextStyle(fontSize: 12, color: Colors.white54),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureToggle(String title, bool isEnabled) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(isEnabled ? LucideIcons.checkSquare : LucideIcons.square, 
               color: isEnabled ? const Color(0xFF6B4BFF) : Colors.white30, size: 20),
          const SizedBox(width: 12),
          Text(title, style: TextStyle(color: isEnabled ? Colors.white : Colors.white54)),
        ],
      ),
    );
  }

  Widget _buildFrameworkSelector(String title, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF6B4BFF).withOpacity(0.1) : const Color(0xFF0F111A),
        border: Border.all(color: isSelected ? const Color(0xFF6B4BFF) : const Color(0xFF2A2D3E)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(isSelected ? LucideIcons.checkCircle2 : LucideIcons.circle, 
               color: isSelected ? const Color(0xFF6B4BFF) : Colors.white30, size: 18),
          const SizedBox(width: 12),
          Text(title, style: TextStyle(color: isSelected ? Colors.white : Colors.white54, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
