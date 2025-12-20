import 'package:flutter/material.dart';
import 'package:skeletonizer_plus/skeletonizer_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skeletonizer Plus Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Simulate loading
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skeletonizer Plus Example'),
        actions: [
          IconButton(
            icon: Icon(_isLoading ? Icons.pause : Icons.play_arrow),
            onPressed: _toggleLoading,
            tooltip: 'Toggle Loading',
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          AutomaticSkeletonExample(),
          CustomBonesExample(),
          ListViewExample(),
          SliverExample(),
          NewFeaturesExample(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.auto_awesome),
            label: 'Automatic',
          ),
          NavigationDestination(
            icon: Icon(Icons.build),
            label: 'Custom',
          ),
          NavigationDestination(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          NavigationDestination(
            icon: Icon(Icons.view_carousel),
            label: 'Sliver',
          ),
          NavigationDestination(
            icon: Icon(Icons.new_releases),
            label: 'New Features',
          ),
        ],
      ),
    );
  }
}

class AutomaticSkeletonExample extends StatelessWidget {
  const AutomaticSkeletonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Automatic Skeleton Generation',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SkeletonizerPlus(
            enabled: true,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 24,
                          child: Icon(Icons.person),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'John Doe',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text('Software Engineer'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'This is a sample card with multiple text elements and an avatar. The skeletonizer will automatically detect and create bones for each element.',
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'You can see how it adapts to different widget types automatically.',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomBonesExample extends StatelessWidget {
  const CustomBonesExample({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Custom Bone Layout',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SkeletonizerPlus.custom(
            enabled: true,
            bones: const [
              BoneCircle(radius: 30),
              BoneText(words: 4, lines: 1),
              BoneText(words: 6, lines: 2),
              BoneRect(width: 300, height: 200, radius: 12),
              BoneIcon(size: 32),
            ],
            baseColor: Colors.blue[200],
            highlightColor: Colors.blue[50],
            speed: const Duration(milliseconds: 800),
          ),
        ],
      ),
    );
  }
}

class ListViewExample extends StatefulWidget {
  const ListViewExample({super.key});

  @override
  State<ListViewExample> createState() => _ListViewExampleState();
}

class _ListViewExampleState extends State<ListViewExample> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SkeletonizerPlus(
      enabled: _isLoading,
      child: ListView.builder(
        itemCount: _isLoading ? 0 : 20,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text('Item ${index + 1}'),
              subtitle: Text('This is item number ${index + 1}'),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          );
        },
      ),
    );
  }
}

class SliverExample extends StatefulWidget {
  const SliverExample({super.key});

  @override
  State<SliverExample> createState() => _SliverExampleState();
}

class _SliverExampleState extends State<SliverExample> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 200,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('Sliver Example'),
            background: Container(
              color: Colors.blue,
            ),
          ),
        ),
        SliverSkeletonizerPlus(
          enabled: _isLoading,
          child: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text('Item ${index + 1}'),
                    subtitle: Text('This is item number ${index + 1}'),
                  ),
                );
              },
              childCount: _isLoading ? 0 : 20,
            ),
          ),
        ),
      ],
    );
  }
}

class NewFeaturesExample extends StatelessWidget {
  const NewFeaturesExample({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'New Features',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text('SkeletonIgnore', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SkeletonizerPlus(
            enabled: true,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.person, size: 40),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Skeletonized Text'),
                          const SizedBox(height: 8),
                          SkeletonIgnore(
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('I am Ignored!'),
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
          const SizedBox(height: 24),
          const Text('SkeletonUnite', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SkeletonizerPlus(
            enabled: true,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Below items are united into one bone:'),
                    const SizedBox(height: 8),
                    SkeletonUnite(
                      child: Row(
                        children: const [
                          Icon(Icons.star),
                          SizedBox(width: 8),
                          Icon(Icons.star),
                          SizedBox(width: 8),
                          Icon(Icons.star),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Pulse Animation', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SkeletonizerPlus.withConfig(
            enabled: true,
            animationConfig: const AnimationConfig(
              type: AnimationType.pulse,
            ),
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('Pulsing Skeleton'),
                subtitle: const Text('This uses opacity fade instead of shimmer.'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
