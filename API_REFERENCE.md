# Skeletonizer Plus - API Reference

This document provides a detailed reference of all classes, methods, and parameters available in Skeletonizer Plus (version 1.0.0).

## Table of Contents

- [SkeletonizerPlus](#skeletonizerplus)
- [SliverSkeletonizerPlus](#sliverskeletonizerplus)
- [Bone](#bone)
- [BoneText](#bonetext)
- [BoneCircle](#bonecircle)
- [BoneRect](#bonerect)
- [BoneIcon](#boneicon)
- [AnimationConfig](#animationconfig)
- [ShimmerDirection](#shimmerdirection)

## SkeletonizerPlus

The main widget that wraps a child and displays skeleton loading state.

### Constructors

#### `SkeletonizerPlus()`

Creates a `SkeletonizerPlus` that automatically generates bones from the child widget.

```dart
SkeletonizerPlus({
  required Widget child,
  bool enabled = true,
  Color? baseColor,
  Color? highlightColor,
  Duration speed = const Duration(milliseconds: 1200),
  ShimmerDirection direction = ShimmerDirection.ltr,
  bool loop = true,
  int? loopCount,
  bool clipToBounds = true,
  bool optimizeForPerformance = false,
  ThemeData? theme,
  Key? key,
})
```

**Parameters:**

| Parameter              | Type             | Default     | Description                                    |
| ---------------------- | ---------------- | ----------- | ---------------------------------------------- |
| `child`                | `Widget`         | (required)  | Child widget to generate skeleton from         |
| `enabled`              | `bool`           | `true`      | Whether to show skeleton                       |
| `baseColor`            | `Color?`         | Theme-based | Base color of skeleton                         |
| `highlightColor`       | `Color?`         | Theme-based | Highlight color of shimmer                     |
| `speed`                | `Duration`       | `1200ms`    | Animation speed                                |
| `direction`            | `ShimmerDirection` | `ltr`    | Shimmer direction                              |
| `loop`                 | `bool`           | `true`      | Whether to loop infinitely                     |
| `loopCount`            | `int?`           | `null`      | Number of loops if `loop` is false             |
| `clipToBounds`         | `bool`           | `true`      | Clip skeleton to bounds                       |
| `optimizeForPerformance` | `bool`        | `false`     | Enable performance optimizations               |
| `theme`                | `ThemeData?`    | `null`      | Theme override                                 |

**Example:**

```dart
SkeletonizerPlus(
  enabled: isLoading,
  child: ListView.builder(
    itemCount: items.length,
    itemBuilder: (context, index) => Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(Icons.person)),
        title: Text(items[index].title),
      ),
    ),
  ),
)
```

#### `SkeletonizerPlus.custom()`

Creates a `SkeletonizerPlus` with a custom bone layout.

```dart
SkeletonizerPlus.custom({
  required List<Bone> bones,
  bool enabled = true,
  Color? baseColor,
  Color? highlightColor,
  Duration speed = const Duration(milliseconds: 1200),
  ShimmerDirection direction = ShimmerDirection.ltr,
  bool loop = true,
  int? loopCount,
  bool clipToBounds = true,
  bool optimizeForPerformance = false,
  ThemeData? theme,
  Key? key,
})
```

**Parameters:**

| Parameter              | Type             | Default     | Description                                    |
| ---------------------- | ---------------- | ----------- | ---------------------------------------------- |
| `bones`                | `List<Bone>`     | (required)  | Custom bone layout                             |
| `enabled`              | `bool`           | `true`      | Whether to show skeleton                       |
| `baseColor`            | `Color?`         | Theme-based | Base color of skeleton                         |
| `highlightColor`       | `Color?`         | Theme-based | Highlight color of shimmer                     |
| `speed`                | `Duration`       | `1200ms`    | Animation speed                                |
| `direction`            | `ShimmerDirection` | `ltr`    | Shimmer direction                              |
| `loop`                 | `bool`           | `true`      | Whether to loop infinitely                     |
| `loopCount`            | `int?`           | `null`      | Number of loops if `loop` is false             |
| `clipToBounds`         | `bool`           | `true`      | Clip skeleton to bounds                       |
| `optimizeForPerformance` | `bool`        | `false`     | Enable performance optimizations               |
| `theme`                | `ThemeData?`    | `null`      | Theme override                                 |

**Example:**

```dart
SkeletonizerPlus.custom(
  enabled: isLoading,
  bones: [
    BoneCircle(radius: 24),
    BoneText(words: 3, lines: 2),
    BoneRect(width: 200, height: 100, radius: 8),
  ],
)
```

#### `SkeletonizerPlus.withConfig()`

Creates a `SkeletonizerPlus` with full animation configuration.

```dart
SkeletonizerPlus.withConfig({
  required Widget child,
  bool enabled = true,
  AnimationConfig? animationConfig,
  bool clipToBounds = true,
  bool optimizeForPerformance = false,
  ThemeData? theme,
  Key? key,
})
```

**Parameters:**

| Parameter              | Type             | Default     | Description                                    |
| ---------------------- | ---------------- | ----------- | ---------------------------------------------- |
| `child`                | `Widget`         | (required)  | Child widget to generate skeleton from         |
| `enabled`              | `bool`           | `true`      | Whether to show skeleton                       |
| `animationConfig`      | `AnimationConfig?` | `null`    | Full animation configuration                   |
| `clipToBounds`         | `bool`           | `true`      | Clip skeleton to bounds                       |
| `optimizeForPerformance` | `bool`        | `false`     | Enable performance optimizations               |
| `theme`                | `ThemeData?`    | `null`      | Theme override                                 |

**Example:**

```dart
SkeletonizerPlus.withConfig(
  enabled: isLoading,
  animationConfig: AnimationConfig(
    speed: Duration(milliseconds: 800),
    baseColor: Colors.blue[200],
    highlightColor: Colors.blue[50],
    direction: ShimmerDirection.rtl,
  ),
  child: YourWidget(),
)
```

## SliverSkeletonizerPlus

Sliver version of `SkeletonizerPlus` for use in `CustomScrollView`.

### Constructors

#### `SliverSkeletonizerPlus()`

Creates a `SliverSkeletonizerPlus` that automatically generates bones from the child widget.

```dart
SliverSkeletonizerPlus({
  required Widget child,
  bool enabled = true,
  Color? baseColor,
  Color? highlightColor,
  Duration speed = const Duration(milliseconds: 1200),
  ShimmerDirection direction = ShimmerDirection.ltr,
  bool loop = true,
  int? loopCount,
  bool clipToBounds = true,
  bool optimizeForPerformance = false,
  ThemeData? theme,
  Key? key,
})
```

**Parameters:** Same as `SkeletonizerPlus()` constructor.

**Example:**

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

#### `SliverSkeletonizerPlus.custom()`

Creates a `SliverSkeletonizerPlus` with a custom bone layout.

```dart
SliverSkeletonizerPlus.custom({
  required List<Bone> bones,
  bool enabled = true,
  Color? baseColor,
  Color? highlightColor,
  Duration speed = const Duration(milliseconds: 1200),
  ShimmerDirection direction = ShimmerDirection.ltr,
  bool loop = true,
  int? loopCount,
  bool clipToBounds = true,
  bool optimizeForPerformance = false,
  ThemeData? theme,
  Key? key,
})
```

#### `SliverSkeletonizerPlus.withConfig()`

Creates a `SliverSkeletonizerPlus` with full animation configuration.

```dart
SliverSkeletonizerPlus.withConfig({
  required Widget child,
  bool enabled = true,
  AnimationConfig? animationConfig,
  bool clipToBounds = true,
  bool optimizeForPerformance = false,
  ThemeData? theme,
  Key? key,
})
```

## Bone

Abstract base class for all skeleton bone shapes.

### Properties

| Property       | Type      | Description                                    |
| -------------- | --------- | ---------------------------------------------- |
| `width`        | `double?` | Optional fixed width                           |
| `height`       | `double?` | Optional fixed height                          |
| `radius`       | `double?` | Optional border radius for rounded rectangles  |
| `customShape`  | `Path?`   | Custom shape path (overrides default shape)    |

### Methods

#### `build(BuildContext context, Size size)`

Creates a widget representation of this bone.

```dart
Widget build(BuildContext context, Size size)
```

**Parameters:**

| Parameter | Type            | Description                    |
| --------- | --------------- | ------------------------------ |
| `context` | `BuildContext`  | The build context              |
| `size`    | `Size`          | Available size for the bone    |

**Returns:** `Widget` - The widget representation of the bone

## BoneText

A bone shape that mimics text with multiple words and lines.

### Constructor

```dart
BoneText({
  int words = 1,
  double wordSpacing = 8.0,
  double lineHeight = 16.0,
  double lineSpacing = 4.0,
  int lines = 1,
  double? width,
  double? height,
  double? radius,
})
```

**Parameters:**

| Parameter     | Type      | Default | Description                    |
| ------------- | --------- | ------- | ------------------------------ |
| `words`       | `int`     | `1`     | Number of words per line        |
| `wordSpacing` | `double`  | `8.0`   | Spacing between words           |
| `lineHeight`  | `double`  | `16.0`  | Height of each text line        |
| `lineSpacing` | `double`  | `4.0`   | Spacing between lines           |
| `lines`       | `int`     | `1`     | Number of lines                 |
| `width`       | `double?` | `null`  | Optional fixed width            |
| `height`      | `double?` | `null`  | Optional fixed height           |
| `radius`      | `double?` | `null`  | Border radius (default: 4.0)    |

**Example:**

```dart
BoneText(
  words: 3,
  lines: 2,
  wordSpacing: 8.0,
  lineHeight: 16.0,
  lineSpacing: 4.0,
  radius: 4.0,
)
```

## BoneCircle

A bone shape that renders as a circle.

### Constructor

```dart
BoneCircle({
  double? radius,
  double? width,
  double? height,
})
```

**Parameters:**

| Parameter | Type      | Description                                    |
| --------- | --------- | ---------------------------------------------- |
| `radius`  | `double?` | Radius of the circle (if null, uses min(width, height)) |
| `width`   | `double?` | Optional fixed width                           |
| `height`  | `double?` | Optional fixed height                          |

**Example:**

```dart
BoneCircle(radius: 24.0)
```

## BoneRect

A bone shape that renders as a rectangle.

### Constructor

```dart
BoneRect({
  double? width,
  double? height,
  double? radius,
  Path? customShape,
})
```

**Parameters:**

| Parameter     | Type      | Description                                    |
| ------------- | --------- | ---------------------------------------------- |
| `width`       | `double?` | Optional fixed width                           |
| `height`      | `double?` | Optional fixed height                          |
| `radius`      | `double?` | Border radius (default: 0.0)                   |
| `customShape` | `Path?`   | Custom shape path (overrides default shape)    |

**Example:**

```dart
BoneRect(
  width: 100.0,
  height: 50.0,
  radius: 8.0,
)
```

## BoneIcon

A bone shape that mimics an icon (typically square with rounded corners).

### Constructor

```dart
BoneIcon({
  double size = 24.0,
  double? radius,
})
```

**Parameters:**

| Parameter | Type      | Default | Description                    |
| --------- | --------- | ------- | ------------------------------ |
| `size`    | `double`  | `24.0`  | Size (both width and height)   |
| `radius`  | `double?` | `null`  | Border radius (default: 4.0)    |

**Example:**

```dart
BoneIcon(size: 32.0, radius: 4.0)
```

## AnimationConfig

Configuration for skeleton shimmer animation.

### Constructor

```dart
AnimationConfig({
  Duration speed = const Duration(milliseconds: 1200),
  Color? baseColor,
  Color? highlightColor,
  ShimmerDirection direction = ShimmerDirection.ltr,
  bool loop = true,
  int? loopCount,
})
```

**Parameters:**

| Parameter        | Type             | Default     | Description                                    |
| ---------------- | ---------------- | ----------- | ---------------------------------------------- |
| `speed`          | `Duration`       | `1200ms`    | Animation speed/duration for one shimmer cycle |
| `baseColor`      | `Color?`         | Theme-based | Base color of the skeleton (darker)            |
| `highlightColor` | `Color?`         | Theme-based | Highlight color of the shimmer (lighter)       |
| `direction`      | `ShimmerDirection` | `ltr`    | Direction of the shimmer animation            |
| `loop`           | `bool`           | `true`      | Whether to loop infinitely                     |
| `loopCount`      | `int?`           | `null`      | Number of loops if `loop` is false             |

**Note:** If `loop` is `false`, `loopCount` must be provided.

**Example:**

```dart
AnimationConfig(
  speed: Duration(milliseconds: 800),
  baseColor: Colors.grey[300],
  highlightColor: Colors.grey[100],
  direction: ShimmerDirection.ltr,
  loop: true,
)
```

### Methods

#### `copyWith()`

Creates a copy with modified fields.

```dart
AnimationConfig copyWith({
  Duration? speed,
  Color? baseColor,
  Color? highlightColor,
  ShimmerDirection? direction,
  bool? loop,
  int? loopCount,
})
```

**Example:**

```dart
final config = AnimationConfig();
final newConfig = config.copyWith(
  speed: Duration(milliseconds: 2000),
  direction: ShimmerDirection.rtl,
);
```

## ShimmerDirection

Enumeration of shimmer animation directions.

### Values

- `ShimmerDirection.ltr` - Left to right
- `ShimmerDirection.rtl` - Right to left
- `ShimmerDirection.topDown` - Top to bottom
- `ShimmerDirection.bottomUp` - Bottom to top

**Example:**

```dart
SkeletonizerPlus(
  enabled: isLoading,
  direction: ShimmerDirection.rtl,
  child: YourWidget(),
)
```

## Error Handling

All widgets handle errors gracefully. If skeleton generation fails, the original child widget is displayed.

## Platform Support

All classes and methods work across all Flutter-supported platforms:
- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

---

This API reference is based on version 1.0.0 of Skeletonizer Plus. For the latest documentation, please refer to the [GitHub repository](https://github.com/emorilebo/skeletonizer_plus).

