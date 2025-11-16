# ✨ Skeletonizer Plus

[![pub package](https://img.shields.io/pub/v/skeletonizer_plus.svg)](https://pub.dev/packages/skeletonizer_plus)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![CI](https://github.com/emorilebo/skeletonizer_plus/actions/workflows/ci.yml/badge.svg)](https://github.com/emorilebo/skeletonizer_plus/actions/workflows/ci.yml)

> **Production-quality skeleton loading states with automatic generation, shimmer animations, and performance optimizations**

Transform your app's loading experience with intelligent skeleton screens that automatically adapt to your widgets. `skeletonizer_plus` provides a comprehensive solution for creating beautiful, performant loading states that match your UI perfectly.

## ✨ What Makes This Package Special?

This isn't just another shimmer loader. We've built a complete solution that combines:

- **🎨 Automatic Skeleton Generation**: Intelligently introspects your widget trees to generate skeleton "bones" that match your UI structure
- **🎭 Custom Bone Layouts**: Create precise skeleton layouts with predefined bone types (text, circles, rectangles, icons)
- **✨ Beautiful Shimmer Animations**: Smooth, configurable shimmer effects with multiple directions and customizable colors
- **🌓 Smart Theme Integration**: Automatically adapts to light/dark themes with appropriate colors
- **⚡ Performance Optimized**: Built-in optimizations for large lists and complex layouts
- **📱 Sliver Support**: Seamless integration with CustomScrollView and sliver-based widgets

Perfect for social media feeds, e-commerce product lists, news articles, or any app that needs professional loading states.

## 🚀 Quick Start

### Installation

Add `skeletonizer_plus` to your `pubspec.yaml`:

```yaml
dependencies:
  skeletonizer_plus: ^1.0.0
```

Then run:

```bash
flutter pub get
```

### Basic Usage

Wrap any widget with `SkeletonizerPlus` to automatically generate skeleton bones:

```dart
import 'package:skeletonizer_plus/skeletonizer_plus.dart';

SkeletonizerPlus(
  enabled: isLoading,
  child: ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) => Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(Icons.person)),
        title: Text(items[index].title),
        subtitle: Text(items[index].subtitle),
      ),
    ),
  ),
)
```

That's it! The package automatically detects your widgets and creates matching skeleton bones.

## 🎨 Features in Detail

### Automatic Skeleton Generation

The package intelligently analyzes your widget tree and generates skeleton bones that match your UI:

```dart
SkeletonizerPlus(
  enabled: isLoading,
  child: Card(
    child: Column(
      children: [
        CircleAvatar(child: Icon(Icons.person)),  // → BoneCircle
        Text('John Doe'),                          // → BoneText
        Text('Software Engineer'),                 // → BoneText
        Image.network('...'),                      // → BoneRect
      ],
    ),
  ),
)
```

The analyzer automatically detects:
- **Text widgets** → `BoneText` with appropriate word count
- **Icons** → `BoneIcon` with matching size
- **Images** → `BoneRect` with rounded corners
- **Containers/Cards** → `BoneRect` with appropriate border radius
- **ListTiles** → Multiple bones for leading, title, and subtitle

### Custom Bone Layouts

For precise control, create custom skeleton layouts:

```dart
SkeletonizerPlus.custom(
  enabled: isLoading,
  bones: [
    BoneCircle(radius: 30),
    BoneText(words: 4, lines: 2),
    BoneRect(width: 200, height: 100, radius: 12),
    BoneIcon(size: 32),
  ],
  baseColor: Colors.grey[300],
  highlightColor: Colors.grey[100],
  speed: Duration(milliseconds: 1200),
)
```

### Shimmer Animations

Beautiful, smooth shimmer effects with full customization:

```dart
SkeletonizerPlus(
  enabled: isLoading,
  baseColor: Colors.blue[200],
  highlightColor: Colors.blue[50],
  speed: Duration(milliseconds: 800),
  direction: ShimmerDirection.ltr,  // ltr, rtl, topDown, bottomUp
  loop: true,                        // Infinite loop
  child: YourWidget(),
)
```

### Sliver Support

Perfect for scrollable content with `CustomScrollView`:

```dart
CustomScrollView(
  slivers: [
    SliverSkeletonizerPlus(
      enabled: isLoading,
      child: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => ListTile(title: Text('Item $index')),
          childCount: items.length,
        ),
      ),
    ),
  ],
)
```

## 💡 Real-World Use Cases

### Social Media Feed

```dart
SkeletonizerPlus(
  enabled: isLoading,
  child: ListView.builder(
    itemCount: posts.length,
    itemBuilder: (context, index) => Card(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(...),
            title: Text(posts[index].author),
            subtitle: Text(posts[index].time),
          ),
          Image.network(posts[index].imageUrl),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(posts[index].caption),
          ),
        ],
      ),
    ),
  ),
)
```

### E-commerce Product List

```dart
SkeletonizerPlus(
  enabled: isLoading,
  child: GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
    ),
    itemBuilder: (context, index) => ProductCard(
      image: products[index].image,
      title: products[index].name,
      price: products[index].price,
    ),
  ),
)
```

### News Article

```dart
SkeletonizerPlus(
  enabled: isLoading,
  child: Column(
    children: [
      Image.network(article.imageUrl),
      Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(article.title, style: TextStyle(fontSize: 24)),
            SizedBox(height: 8),
            Text(article.author),
            SizedBox(height: 16),
            Text(article.content),
          ],
        ),
      ),
    ],
  ),
)
```

## 🛠️ API Reference

### SkeletonizerPlus

Main widget that wraps a child and displays skeleton loading state.

#### Constructors

- `SkeletonizerPlus()` - Automatic skeleton generation from child widget
- `SkeletonizerPlus.custom()` - Custom bone layout
- `SkeletonizerPlus.withConfig()` - Full animation configuration

#### Parameters

| Parameter              | Type             | Default     | Description                                    |
| ---------------------- | ---------------- | ----------- | ---------------------------------------------- |
| `enabled`              | `bool`           | `true`      | Whether to show skeleton                       |
| `child`                | `Widget?`        | `null`      | Child widget to generate skeleton from         |
| `bones`                | `List<Bone>?`    | `null`      | Custom bone layout (for `.custom()` constructor) |
| `baseColor`            | `Color?`         | Theme-based | Base color of skeleton                         |
| `highlightColor`       | `Color?`         | Theme-based | Highlight color of shimmer                     |
| `speed`                | `Duration`      | `1200ms`    | Animation speed                                |
| `direction`            | `ShimmerDirection` | `ltr`    | Shimmer direction                              |
| `loop`                 | `bool`           | `true`      | Whether to loop infinitely                     |
| `loopCount`            | `int?`           | `null`      | Number of loops if `loop` is false             |
| `clipToBounds`         | `bool`           | `true`      | Clip skeleton to bounds                       |
| `optimizeForPerformance` | `bool`        | `false`     | Enable performance optimizations               |
| `theme`                | `ThemeData?`    | `null`      | Theme override                                 |

### Bone Types

#### BoneText

Mimics text with multiple words and lines.

```dart
BoneText(
  words: 3,        // Number of words per line
  lines: 2,        // Number of lines
  wordSpacing: 8.0,
  lineHeight: 16.0,
  lineSpacing: 4.0,
  radius: 4.0,     // Border radius
)
```

#### BoneCircle

Renders as a circle.

```dart
BoneCircle(
  radius: 24.0,    // Radius of the circle
)
```

#### BoneRect

Renders as a rectangle.

```dart
BoneRect(
  width: 100.0,
  height: 50.0,
  radius: 8.0,     // Border radius
)
```

#### BoneIcon

Mimics an icon (typically square with rounded corners).

```dart
BoneIcon(
  size: 24.0,      // Size (both width and height)
  radius: 4.0,     // Border radius
)
```

### AnimationConfig

Full animation configuration.

```dart
AnimationConfig(
  speed: Duration(milliseconds: 1200),
  baseColor: Colors.grey[300],
  highlightColor: Colors.grey[100],
  direction: ShimmerDirection.ltr,
  loop: true,
  loopCount: null,
)
```

### ShimmerDirection

- `ShimmerDirection.ltr` - Left to right
- `ShimmerDirection.rtl` - Right to left
- `ShimmerDirection.topDown` - Top to bottom
- `ShimmerDirection.bottomUp` - Bottom to top

For detailed API documentation, see [API_REFERENCE.md](API_REFERENCE.md).

## ⚡ Performance Tips

1. **Enable Performance Optimizations**
   ```dart
   SkeletonizerPlus(
     enabled: isLoading,
     optimizeForPerformance: true,
     clipToBounds: true,
     child: YourWidget(),
   )
   ```

2. **Use for Large Lists**
   - The package automatically optimizes for viewport visibility
   - Only visible bones are animated when possible

3. **Consider RepaintBoundary**
   - For complex widget trees, wrap with `RepaintBoundary` for additional optimization

## 🌓 Theme Integration

The package automatically adapts to your app's theme:

```dart
MaterialApp(
  theme: ThemeData.light(),
  darkTheme: ThemeData.dark(),
  themeMode: ThemeMode.system,
  // SkeletonizerPlus automatically uses appropriate colors
  home: MyApp(),
)
```

**Light Theme**: Uses `Colors.grey[300]` as base, `Colors.grey[100]` as highlight  
**Dark Theme**: Uses `Colors.grey[800]` as base, `Colors.grey[700]` as highlight

You can override these defaults:

```dart
SkeletonizerPlus(
  enabled: isLoading,
  baseColor: Colors.blue[200],
  highlightColor: Colors.blue[50],
  child: YourWidget(),
)
```

## 🧪 Testing

Run tests with:

```bash
flutter test
```

The package includes comprehensive widget tests for:
- Skeleton appearance/disappearance
- Custom bone layouts
- Theme integration
- Animation configuration
- Sliver support

## 🐛 Troubleshooting

### Skeleton Not Appearing

- ✅ Ensure `enabled` is `true`
- ✅ Verify child widget is not null
- ✅ Check that bones are being generated (use custom bones for debugging)

### Performance Issues

- ✅ Enable `optimizeForPerformance: true`
- ✅ Set `clipToBounds: true`
- ✅ Consider reducing animation speed for large lists

### Colors Not Adapting to Theme

- ✅ Ensure `Theme.of(context)` is available
- ✅ Or provide explicit `theme` parameter
- ✅ Check that `baseColor` and `highlightColor` are not overriding theme

### Sliver Not Working

- ✅ Use `SliverSkeletonizerPlus` instead of `SkeletonizerPlus`
- ✅ Ensure it's inside a `CustomScrollView`
- ✅ Check that child is a valid sliver widget

## 📱 Platform Support

| Platform | Support |
|----------|---------|
| Android  | ✅ Full support |
| iOS      | ✅ Full support |
| Web      | ✅ Full support |
| macOS    | ✅ Full support |
| Windows  | ✅ Full support |
| Linux    | ✅ Full support |

## 👨‍💻 Author

**Godfrey Lebo** - Fullstack Developer & Technical PM

> With **9+ years of industry experience**, I specialize in building AI-powered applications, scalable mobile solutions, and secure backend systems. I've led teams delivering marketplaces, fintech platforms, and AI applications serving thousands of users.

- 📧 **Email**: [emorylebo@gmail.com](mailto:emorylebo@gmail.com)
- 💼 **LinkedIn**: [godfreylebo](https://www.linkedin.com/in/godfreylebo/)
- 🌐 **Portfolio**: [godfreylebo.dev](https://www.godfreylebo.dev/)
- 🐙 **GitHub**: [@emorilebo](https://github.com/emorilebo)

## 🤝 Contributing

We welcome contributions! Whether you're fixing bugs, adding features, or improving documentation, your help makes this package better for everyone.

**Ways to contribute:**
- 🐛 Report bugs
- 💡 Suggest new features
- 📝 Improve documentation
- 🔧 Submit pull requests

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📚 Additional Resources

- [API_REFERENCE.md](API_REFERENCE.md) - Detailed API documentation
- [CHANGELOG.md](CHANGELOG.md) - Version history and updates
- [VALIDATION.md](VALIDATION.md) - Validation and testing guide
- [GitHub Repository](https://github.com/emorilebo/skeletonizer_plus) - Source code and issues

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Community contributors and users
- Inspiration from various skeleton loading implementations

---

**Made with ❤️ by [Godfrey Lebo](https://www.godfreylebo.dev/)**

If this package helps improve your app's loading experience, consider giving it a ⭐ on GitHub!
