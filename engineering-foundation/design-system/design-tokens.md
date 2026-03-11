# Design Tokens

## Token Categories
- Color tokens
- Typography tokens
- Spacing tokens
- Radius tokens
- Elevation tokens
- Motion tokens

## Example Token Set
```yaml
color:
  brandPrimary: "#1B5E20"
  brandSecondary: "#1565C0"
  surface: "#FFFFFF"
  background: "#F5F7FA"
  textPrimary: "#111827"
  textSecondary: "#4B5563"
  danger: "#B91C1C"
  warning: "#B45309"
  success: "#047857"
typography:
  titleLarge: {fontSize: 22, fontWeight: 700}
  titleMedium: {fontSize: 18, fontWeight: 600}
  bodyMedium: {fontSize: 14, fontWeight: 400}
  labelSmall: {fontSize: 12, fontWeight: 500}
spacing:
  xs: 4
  sm: 8
  md: 12
  lg: 16
  xl: 24
radius:
  sm: 8
  md: 12
  lg: 16
```

## Token Rules
- No raw color values in feature widgets.
- Size/spacing must map to token scales.
- Component variants may not introduce new token categories without design review.

## Theming Strategy
- Light and dark palettes from the same semantic tokens.
- Campus-specific accents allowed only through approved token overrides.
