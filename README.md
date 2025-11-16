# Skeletonizer Plus

A production-quality Flutter package for automatic skeleton loading states with shimmer animations, theme support, and performance optimizations.

## Features

- 🎨 **Automatic Skeleton Generation**: Automatically introspects widget trees to generate skeleton "bones"
- 🎭 **Custom Bone Layouts**: Create custom skeleton layouts with predefined bone types
- ✨ **Shimmer Animations**: Beautiful shimmer effects with configurable speed, colors, and direction
- 🌓 **Theme Integration**: Automatic light/dark theme support
- ⚡ **Performance Optimized**: Viewport visibility detection and GPU optimizations
- 📱 **Sliver Support**: Built-in support for sliver-based widgets (CustomScrollView, SliverList, etc.)

## Installation

Add `skeletonizer_plus` to your `pubspec.yaml`:

```yaml
dependencies:
  skeletonizer_plus: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Quick Start

### Automatic Skeleton Generation

Wrap any widget with `SkeletonizerPlus` to automatically generate skeleton bones:

```dart
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

### Custom Bone Layout

Create custom skeleton layouts with predefined bone types:

```dart
SkeletonizerPlus.custom(
  enabled: isLoading,
  bones: [
    BoneCircle(radius: 24),
    BoneText(words: 3, lines: 2),
    BoneRect(width: 200, height: 100, radius: 8),
    BoneIcon(size: 32),
  ],
  baseColor: Colors.grey[300],
  highlightColor: Colors.grey[100],
  speed: Duration(milliseconds: 1200),
)
```

### Sliver Support

Use `SliverSkeletonizerPlus` for sliver-based widgets:

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

## API Reference

### SkeletonizerPlus

Main widget that wraps a child and displays skeleton loading state.

#### Constructors

- `SkeletonizerPlus()` - Automatic skeleton generation from child widget
- `SkeletonizerPlus.custom()` - Custom bone layout
- `SkeletonizerPlus.withConfig()` - Full animation configuration

#### Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `enabled` | `bool` | `true` | Whether to show skeleton |
| `child` | `Widget?` | `null` | Child widget to generate skeleton from |
| `bones` | `List<Bone>?` | `null` | Custom bone layout (for `.custom()` constructor) |
| `baseColor` | `Color?` | Theme-based | Base color of skeleton |
| `highlightColor` | `Color?` | Theme-based | Highlight color of shimmer |
| `speed` | `Duration` | `1200ms` | Animation speed |
| `direction` | `ShimmerDirection` | `ltr` | Shimmer direction |
| `loop` | `bool` | `true` | Whether to loop infinitely |
| `loopCount` | `int?` | `null` | Number of loops if `loop` is false |
| `clipToBounds` | `bool` | `true` | Clip skeleton to bounds |
| `optimizeForPerformance` | `bool` | `false` | Enable performance optimizations |
| `theme` | `ThemeData?` | `null` | Theme override |

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

## Examples

### Basic Usage

```dart
SkeletonizerPlus(
  enabled: isLoading,
  child: Card(
    child: Column(
      children: [
        Text('Title'),
        Text('Subtitle'),
        Image.network('https://example.com/image.jpg'),
      ],
    ),
  ),
)
```

### Custom Colors

```dart
SkeletonizerPlus(
  enabled: isLoading,
  baseColor: Colors.blue[200],
  highlightColor: Colors.blue[50],
  child: YourWidget(),
)
```

### Performance Optimization

```dart
SkeletonizerPlus(
  enabled: isLoading,
  optimizeForPerformance: true,
  clipToBounds: true,
  child: YourWidget(),
)
```

### Dark Theme

The package automatically adapts to light/dark themes:

```dart
MaterialApp(
  theme: ThemeData.light(),
  darkTheme: ThemeData.dark(),
  themeMode: ThemeMode.system,
  // SkeletonizerPlus will automatically use appropriate colors
)
```

## Performance Considerations

- Use `optimizeForPerformance: true` for large lists or complex layouts
- Use `clipToBounds: true` to prevent overflow rendering
- The package only animates visible skeleton bones when possible
- Consider using `RepaintBoundary` for complex widget trees

## Testing

Run tests with:

```bash
flutter test
```

The package includes widget tests for:
- Skeleton appearance/disappearance
- Custom bone layouts
- Theme integration
- Animation configuration

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## When to Use vs Simpler Packages

Use `skeletonizer_plus` when you need:
- Automatic skeleton generation from existing widgets
- Advanced customization options
- Theme integration
- Performance optimizations
- Sliver support

For simpler use cases, consider:
- `shimmer` - Basic shimmer effect
- `skeleton_loader` - Simple skeleton loaders

## Validation

To verify the package works correctly:

1. **Shimmer Animation**: Run the example app and toggle loading - you should see smooth shimmer animations
2. **Bone Rendering**: Check that bones match the shape of your widgets (text, circles, rectangles)
3. **Performance Settings**: Enable `optimizeForPerformance` and verify reduced GPU usage in Flutter DevTools
4. **Theme Support**: Switch between light/dark mode and verify colors adapt correctly
5. **Sliver Support**: Test with `CustomScrollView` and verify sliver skeletons work correctly

