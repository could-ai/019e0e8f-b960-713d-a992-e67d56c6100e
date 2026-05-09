import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class WorkspacePage extends StatefulWidget {
  const WorkspacePage({super.key});

  @override
  State<WorkspacePage> createState() => _WorkspacePageState();
}

class _WorkspacePageState extends State<WorkspacePage> {
  final TextEditingController _promptController = TextEditingController();
  final ScrollController _chatScrollController = ScrollController();
  bool _showSidebar = true;
  bool _showTerminal = true;
  int _activeTabIndex = 0;

  final List<Map<String, dynamic>> _chatMessages = [
    {
      'role': 'ai',
      'content': 'Welcome to NovaForge AI Workspace. What are we building today?',
      'isCode': false,
    },
  ];

  void _sendMessage() {
    if (_promptController.text.trim().isEmpty) return;

    setState(() {
      _chatMessages.add({
        'role': 'user',
        'content': _promptController.text,
        'isCode': false,
      });
      _promptController.clear();
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      _chatScrollController.animateTo(
        _chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    // Simulate AI response
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _chatMessages.add({
            'role': 'ai',
            'content': 'I am analyzing your request to generate the project structure. Setting up the environment...',
            'isCode': false,
          });
          _chatMessages.add({
            'role': 'ai',
            'content': '''// Generated Flutter App Structure
import 'package:flutter/material.dart';

void main() {
  runApp(const NovaApp());
}

class NovaApp extends StatelessWidget {
  const NovaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nova App',
      theme: ThemeData.dark(),
      home: const Scaffold(
        body: Center(child: Text('Hello NovaForge')),
      ),
    );
  }
}''',
            'isCode': true,
          });
        });
        Future.delayed(const Duration(milliseconds: 100), () {
          _chatScrollController.animateTo(
            _chatScrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;
    if (isMobile && _showSidebar) {
      _showSidebar = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Workspace', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF0F172A),
        elevation: 1,
        shadowColor: const Color(0xFF38BDF8).withOpacity(0.2),
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: Colors.white70),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          if (isMobile)
            IconButton(
              icon: const Icon(LucideIcons.menu, color: Colors.white70),
              onPressed: () {
                // Open mobile drawer
                Scaffold.of(context).openEndDrawer();
              },
            ),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(LucideIcons.play, color: Color(0xFF10B981), size: 18),
            label: const Text('Run', style: TextStyle(color: Color(0xFF10B981))),
          ),
          const SizedBox(width: 8),
          PopupMenuButton<String>(
            icon: const Icon(LucideIcons.download, color: Colors.white70),
            tooltip: 'Export Project',
            color: const Color(0xFF1E293B),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'apk',
                child: Row(
                  children: [
                    Icon(LucideIcons.smartphone, color: Color(0xFF38BDF8), size: 18),
                    SizedBox(width: 12),
                    Text('Export APK', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'zip',
                child: Row(
                  children: [
                    Icon(LucideIcons.fileArchive, color: Color(0xFF8B5CF6), size: 18),
                    SizedBox(width: 12),
                    Text('Export ZIP', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
        ],
      ),
      endDrawer: isMobile ? _buildSidebar() : null,
      body: Row(
        children: [
          // Sidebar (Desktop)
          if (!isMobile && _showSidebar)
            SizedBox(
              width: 260,
              child: _buildSidebar(),
            ),
          
          // Main Chat/Code Area
          Expanded(
            child: Column(
              children: [
                // Top Code/Preview Tabs & Area
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      // Chat Area
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              right: BorderSide(color: Color(0xFF334155), width: 1),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Color(0xFF334155), width: 1)),
                                  color: Color(0xFF0F172A),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(LucideIcons.bot, color: Color(0xFF8B5CF6), size: 20),
                                    SizedBox(width: 8),
                                    Text('Nova Assistant', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  controller: _chatScrollController,
                                  padding: const EdgeInsets.all(16),
                                  itemCount: _chatMessages.length,
                                  itemBuilder: (context, index) {
                                    final msg = _chatMessages[index];
                                    final isAi = msg['role'] == 'ai';
                                    final isCode = msg['isCode'] == true;

                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 16),
                                      alignment: isAi ? Alignment.centerLeft : Alignment.centerRight,
                                      child: Container(
                                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * (isMobile ? 0.8 : 0.6)),
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: isAi ? const Color(0xFF1E293B) : const Color(0xFF38BDF8).withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(12).copyWith(
                                            bottomLeft: isAi ? const Radius.circular(0) : const Radius.circular(12),
                                            bottomRight: !isAi ? const Radius.circular(0) : const Radius.circular(12),
                                          ),
                                          border: isAi 
                                            ? Border.all(color: const Color(0xFF334155))
                                            : Border.all(color: const Color(0xFF38BDF8).withOpacity(0.3)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  isAi ? LucideIcons.bot : LucideIcons.user,
                                                  size: 14,
                                                  color: isAi ? const Color(0xFF8B5CF6) : const Color(0xFF38BDF8),
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  isAi ? 'NOVA' : 'YOU',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: isAi ? const Color(0xFF8B5CF6) : const Color(0xFF38BDF8),
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            if (isCode) ...[
                                              Container(
                                                width: double.infinity,
                                                padding: const EdgeInsets.all(12),
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFF0F172A),
                                                  borderRadius: BorderRadius.circular(8),
                                                  border: Border.all(color: const Color(0xFF334155)),
                                                ),
                                                child: Text(
                                                  msg['content'],
                                                  style: const TextStyle(
                                                    fontFamily: 'monospace',
                                                    color: Color(0xFFE2E8F0),
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  TextButton.icon(
                                                    onPressed: () {},
                                                    icon: const Icon(LucideIcons.copy, size: 14, color: Colors.white70),
                                                    label: const Text('Copy', style: TextStyle(color: Colors.white70, fontSize: 12)),
                                                  ),
                                                ],
                                              )
                                            ] else ...[
                                              Text(
                                                msg['content'],
                                                style: const TextStyle(color: Color(0xFFF8FAFC), fontSize: 15, height: 1.5),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // Chat Input
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0F172A),
                                  border: Border(top: BorderSide(color: Color(0xFF334155), width: 1)),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(LucideIcons.paperclip, color: Colors.white54),
                                      onPressed: () {},
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF1E293B),
                                          borderRadius: BorderRadius.circular(24),
                                          border: Border.all(color: const Color(0xFF334155)),
                                        ),
                                        child: TextField(
                                          controller: _promptController,
                                          style: const TextStyle(color: Colors.white),
                                          decoration: const InputDecoration(
                                            hintText: 'Message NovaForge AI...',
                                            hintStyle: TextStyle(color: Colors.white38),
                                            border: InputBorder.none,
                                          ),
                                          onSubmitted: (_) => _sendMessage(),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [Color(0xFF8B5CF6), Color(0xFF38BDF8)],
                                        ),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF8B5CF6).withOpacity(0.3),
                                            blurRadius: 8,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                      child: IconButton(
                                        icon: const Icon(LucideIcons.send, color: Colors.white, size: 18),
                                        onPressed: _sendMessage,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Code Preview Area (Desktop only or shown via tabs on mobile)
                      if (!isMobile)
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Container(
                                height: 48,
                                decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Color(0xFF334155), width: 1)),
                                  color: Color(0xFF0F172A),
                                ),
                                child: Row(
                                  children: [
                                    _buildTab('main.dart', 0),
                                    _buildTab('pubspec.yaml', 1),
                                    _buildTab('Preview', 2, isPreview: true),
                                    const Spacer(),
                                    IconButton(
                                      icon: const Icon(LucideIcons.maximize2, color: Colors.white54, size: 16),
                                      onPressed: () {},
                                    ),
                                    const SizedBox(width: 8),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  color: const Color(0xFF0F172A),
                                  padding: const EdgeInsets.all(16),
                                  child: _activeTabIndex == 2
                                      ? Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Icon(LucideIcons.smartphone, size: 48, color: Color(0xFF334155)),
                                              const SizedBox(height: 16),
                                              Text('Live Preview Available in Full Build', style: TextStyle(color: Colors.white54)),
                                            ],
                                          ),
                                        )
                                      : const Text(
                                          '''import 'package:flutter/material.dart';

void main() {
  runApp(const NovaApp());
}

class NovaApp extends StatelessWidget {
  const NovaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nova App',
      theme: ThemeData.dark(),
      home: const Scaffold(
        body: Center(child: Text('Hello NovaForge')),
      ),
    );
  }
}''',
                                          style: TextStyle(
                                            fontFamily: 'monospace',
                                            color: Color(0xFFE2E8F0),
                                            fontSize: 14,
                                            height: 1.5,
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
                
                // Terminal Panel
                if (_showTerminal)
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: Color(0xFF334155), width: 1)),
                      color: Color(0xFF0B1120),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color(0xFF334155), width: 1)),
                            color: Color(0xFF0F172A),
                          ),
                          child: Row(
                            children: [
                              const Icon(LucideIcons.terminal, color: Colors.white54, size: 16),
                              const SizedBox(width: 8),
                              const Text('Terminal', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                              const Spacer(),
                              IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                icon: const Icon(LucideIcons.x, color: Colors.white54, size: 16),
                                onPressed: () {
                                  setState(() {
                                    _showTerminal = false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('\$ flutter pub get', style: TextStyle(color: Color(0xFF10B981), fontFamily: 'monospace', fontSize: 13)),
                                Text('Resolving dependencies...', style: TextStyle(color: Colors.white70, fontFamily: 'monospace', fontSize: 13)),
                                Text('Got dependencies!', style: TextStyle(color: Colors.white70, fontFamily: 'monospace', fontSize: 13)),
                                SizedBox(height: 8),
                                Text('\$ nova forge build --platform=web', style: TextStyle(color: Color(0xFF10B981), fontFamily: 'monospace', fontSize: 13)),
                                Text('Compiling application for the Web...', style: TextStyle(color: Colors.white70, fontFamily: 'monospace', fontSize: 13)),
                                Text('Build completed successfully in 4.2s', style: TextStyle(color: Color(0xFF38BDF8), fontFamily: 'monospace', fontSize: 13)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index, {bool isPreview = false}) {
    final isActive = _activeTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeTabIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF1E293B) : Colors.transparent,
          border: isActive
              ? const Border(top: BorderSide(color: Color(0xFF38BDF8), width: 2))
              : const Border(top: BorderSide(color: Colors.transparent, width: 2)),
        ),
        child: Row(
          children: [
            Icon(
              isPreview ? LucideIcons.playCircle : LucideIcons.fileCode2,
              size: 14,
              color: isActive ? (isPreview ? const Color(0xFF10B981) : const Color(0xFF38BDF8)) : Colors.white54,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.white54,
                fontSize: 13,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const SizedBox(width: 8),
            if (!isPreview)
              Icon(LucideIcons.x, size: 12, color: isActive ? Colors.white54 : Colors.transparent),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 260,
      decoration: const BoxDecoration(
        color: Color(0xFF0F172A),
        border: Border(right: BorderSide(color: Color(0xFF334155), width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF38BDF8).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(LucideIcons.layers, color: Color(0xFF38BDF8), size: 20),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Explorer',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('PROJECT FILES', style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
          ),
          _buildFileTreeItem('lib', isFolder: true, isOpen: true),
          _buildFileTreeItem('main.dart', isFolder: false, indent: 1, isActive: true),
          _buildFileTreeItem('theme.dart', isFolder: false, indent: 1),
          _buildFileTreeItem('screens', isFolder: true, indent: 1),
          _buildFileTreeItem('assets', isFolder: true),
          _buildFileTreeItem('pubspec.yaml', isFolder: false),
          _buildFileTreeItem('README.md', isFolder: false),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('RECENT CHATS', style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
          ),
          _buildHistoryItem('Flutter Auth Flow', '2 hrs ago'),
          _buildHistoryItem('React Dashboard', 'Yesterday'),
          _buildHistoryItem('Discord Bot Setup', '3 days ago'),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildFileTreeItem(String name, {bool isFolder = false, bool isOpen = false, int indent = 0, bool isActive = false}) {
    return Container(
      color: isActive ? const Color(0xFF38BDF8).withOpacity(0.1) : Colors.transparent,
      padding: EdgeInsets.only(
        left: 16.0 + (indent * 16.0),
        right: 16.0,
        top: 6.0,
        bottom: 6.0,
      ),
      child: Row(
        children: [
          Icon(
            isFolder ? (isOpen ? LucideIcons.chevronDown : LucideIcons.chevronRight) : LucideIcons.fileText,
            size: 14,
            color: isActive ? const Color(0xFF38BDF8) : Colors.white54,
          ),
          const SizedBox(width: 8),
          Icon(
            isFolder ? (isOpen ? LucideIcons.folderOpen : LucideIcons.folder) : LucideIcons.fileCode2,
            size: 14,
            color: isFolder ? const Color(0xFF8B5CF6) : (isActive ? const Color(0xFF38BDF8) : Colors.white54),
          ),
          const SizedBox(width: 8),
          Text(
            name,
            style: TextStyle(
              color: isActive ? const Color(0xFF38BDF8) : Colors.white70,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(String title, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          const Icon(LucideIcons.messageSquare, size: 14, color: Colors.white38),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            time,
            style: const TextStyle(color: Colors.white38, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
