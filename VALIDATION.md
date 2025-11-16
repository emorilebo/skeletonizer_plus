# Validation Guide

This document describes how to verify that `skeletonizer_plus` is working correctly.

## Prerequisites

1. Flutter SDK installed (>=3.3.0)
2. Dart SDK (>=3.0.0)
3. A device or emulator for testing

## Setup

1. Navigate to the package directory:
   ```bash
   cd skeletonizer_plus
   ```

2. Get dependencies:
   ```bash
   flutter pub get
   ```

3. Navigate to the example directory:
   ```bash
   cd example
   flutter pub get
   ```

## Validation Steps

### 1. Shimmer Animation Verification

**Test**: Verify that shimmer animations are smooth and visible.

**Steps**:
1. Run the example app:
   ```bash
   flutter run
   ```
2. Navigate to the "Automatic" tab
3. Observe the skeleton loading state
4. Verify:
   - Shimmer effect moves smoothly across bones
   - Animation loops continuously
   - Colors transition smoothly between base and highlight

**Expected Result**: Smooth, continuous shimmer animation across all skeleton bones.

### 2. Bone Rendering Verification

**Test**: Verify that bones correctly match widget shapes.

**Steps**:
1. In the example app, navigate to the "Automatic" tab
2. Observe the skeleton bones
3. Verify:
   - Text elements render as rectangular bones with appropriate spacing
   - Circle avatars render as circular bones
   - Images render as rectangular bones
   - Overall layout matches the original widget structure

**Expected Result**: Skeleton bones accurately represent the shape and layout of the original widgets.

### 3. Custom Bone Layout

**Test**: Verify custom bone layouts work correctly.

**Steps**:
1. Navigate to the "Custom" tab in the example app
2. Observe the custom bone layout
3. Verify:
   - `BoneCircle` renders as a circle
   - `BoneText` renders with correct word count and lines
   - `BoneRect` renders with specified dimensions
   - `BoneIcon` renders as a square with rounded corners

**Expected Result**: All custom bone types render correctly with specified parameters.

### 4. Performance Settings

**Test**: Verify performance optimizations work.

**Steps**:
1. Open Flutter DevTools
2. Navigate to the Performance tab
3. Run the example app with `optimizeForPerformance: true`
4. Monitor GPU usage
5. Compare with `optimizeForPerformance: false`

**Expected Result**: Reduced GPU usage when `optimizeForPerformance` is enabled.

### 5. Theme Support

**Test**: Verify light/dark theme adaptation.

**Steps**:
1. In the example app, switch between light and dark themes
2. Observe skeleton colors
3. Verify:
   - Light theme: lighter base colors (grey[300])
   - Dark theme: darker base colors (grey[800])
   - Colors adapt automatically

**Expected Result**: Skeleton colors adapt correctly to theme brightness.

### 6. Sliver Support

**Test**: Verify sliver widgets work correctly.

**Steps**:
1. Navigate to the "Sliver" tab in the example app
2. Scroll the list
3. Verify:
   - Skeleton appears when loading
   - Sliver scrolling works correctly
   - Skeleton disappears when data loads

**Expected Result**: Sliver skeletons work correctly in scrollable views.

### 7. Enable/Disable Toggle

**Test**: Verify skeleton can be toggled on/off.

**Steps**:
1. Use the play/pause button in the app bar
2. Toggle loading state
3. Verify:
   - Skeleton appears when enabled
   - Original content appears when disabled
   - Transition is smooth

**Expected Result**: Skeleton can be toggled without affecting the underlying widget.

### 8. Animation Configuration

**Test**: Verify animation parameters work.

**Steps**:
1. Check the "Custom" tab which uses custom animation config
2. Verify:
   - Speed: Animation speed matches `Duration(milliseconds: 800)`
   - Colors: Custom base/highlight colors are applied
   - Direction: Shimmer moves in the specified direction

**Expected Result**: All animation parameters are respected.

### 9. ListView Integration

**Test**: Verify ListView skeletons work correctly.

**Steps**:
1. Navigate to the "List" tab
2. Wait for loading to complete
3. Verify:
   - Skeleton appears during loading
   - List items appear after loading
   - No layout issues

**Expected Result**: ListView skeletons work seamlessly.

### 10. Code Analysis

**Test**: Verify code quality.

**Steps**:
1. Run analysis:
   ```bash
   flutter analyze
   ```
2. Verify no errors (warnings about missing Flutter SDK in analysis context are expected)

**Expected Result**: Code passes analysis with no critical errors.

### 11. Tests

**Test**: Verify all tests pass.

**Steps**:
1. Run tests:
   ```bash
   flutter test
   ```
2. Verify all tests pass

**Expected Result**: All widget tests pass successfully.

## Common Issues

### Issue: Shimmer not visible
**Solution**: Check that `enabled` is `true` and colors are not transparent.

### Issue: Bones not matching widget shape
**Solution**: The automatic analyzer may not detect all widget types. Use custom bones for precise control.

### Issue: Performance issues
**Solution**: Enable `optimizeForPerformance: true` and `clipToBounds: true`.

### Issue: Colors not adapting to theme
**Solution**: Ensure `Theme.of(context)` is available or provide a custom `theme` parameter.

## Performance Benchmarks

Expected performance characteristics:
- **Frame Rate**: 60 FPS on modern devices
- **Memory Usage**: Minimal overhead (<5MB for typical use)
- **GPU Usage**: Reduced by 20-30% with `optimizeForPerformance: true`

## Conclusion

If all validation steps pass, the package is working correctly and ready for use. For issues or questions, please refer to the README or open an issue on GitHub.

