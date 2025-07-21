# Constants Organization

This directory contains all the centralized constants used throughout the portfolio application. Each constant file serves a specific purpose to maintain clean, organized, and maintainable code.

## File Structure

### 📁 animations.dart

- Animation durations and delays
- Consistent timing across the app
- Hover effects and transitions

### 📁 assets.dart

- Image paths and URLs
- Placeholder URLs for projects
- Centralized asset management

### 📁 colors.dart

- Theme colors (primary, secondary, accent)
- Glassmorphism colors
- Text and border colors
- Shadow definitions
- Gradient definitions

### 📁 dimensions.dart

- Layout dimensions (widths, heights)
- Border radius values
- Icon sizes
- Spacing multipliers
- Responsive breakpoints

### 📁 icons.dart

- Navigation icons
- Social media icons
- UI/Feedback icons
- Action icons
- Centralized icon management

### 📁 spacing.dart

- Padding values
- Margin values
- Section spacing
- Component spacing
- Responsive spacing helpers

### 📁 strings.dart

- All UI text content
- Navigation labels
- Section titles and descriptions
- Form labels and errors
- Footer content

### 📁 theme.dart

- App theme configuration
- Dark theme setup
- Text theme definitions

### 📁 typography.dart

- Text styles
- Font configurations
- Responsive text sizing
- Gradient text utilities

## Best Practices

1. **Never hardcode values**: Always use constants from these files
2. **Consistent naming**: Use descriptive names with proper prefixes
3. **Grouped by context**: Related constants are grouped together
4. **Responsive helpers**: Use responsive methods where provided
5. **Type safety**: All constants are strongly typed

## Usage Examples

```dart
// Colors
color: AppColors.primary

// Spacing
padding: EdgeInsets.all(AppSpacing.paddingMedium)

// Dimensions
height: AppDimensions.navBarHeightMobile

// Strings
Text(AppStrings.navHome)

// Icons
Icon(AppIcons.navMenu)

// Typography
style: AppTypography.headingLarge(context)
```

## Maintenance

- When adding new constants, place them in the appropriate file
- Follow the existing naming conventions
- Add comments for complex or non-obvious values
- Consider responsive alternatives for dimensional values
