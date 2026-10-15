# plant_app

Flutter recreation of the two-screen plant shopping UI reference
(product details "Strelitzia" + listing "Decorative flowers"), built with real
widgets, `CustomPainter` for the curved shapes, and local PNG assets.

## Run

```bash
cd plant_app
flutter create --platforms=android .   # generates the android/ folder only; keeps lib/ and pubspec.yaml
flutter pub get
flutter run                            # with an Android emulator running
```

Open the `plant_app` folder in Android Studio and run on an emulator.
`flutter create .` is needed because platform folders (android/) were not
generated in the environment that produced this project (no Flutter SDK).
It does not overwrite existing `lib/`, `pubspec.yaml` or `test/` files.

## Modes

A segmented control at the top (outside the phone artwork) switches:

- **Preview** - both phones side by side on the green background (width >= 900).
  On narrow screens the two phones are stacked vertically instead.
- **Detail** - the product screen alone, scaled to fit, aspect ratio preserved.
- **Listing** - the listing screen alone.

## Interactions

- M / L / XL: selector highlights and the plant animates to a new scale,
  anchored at the pot so it never leaves its area (the circular next button
  cycles M -> L -> XL).
- Quantity starts at 2; `+` / `-` update `x2` live, never below 1.
- Listing cards: `-` / `+` and the bag tab change each card's quantity (min 0).

## Structure

```
lib/
  main.dart
  screens/   design_preview_screen, plant_detail_screen, plant_listing_screen
  painters/  curved_surface (white egg surface), bottom_navigation (lobes + bag tab),
             plant_detail_background (+ quantity blob), plant_listing_background,
             action_tab (card tab), preview_background
  widgets/   plant_product_card, plant_image, plant_size_selector,
             quantity_control, product_rating
  models/    plant_product, plant_detail_controller (ChangeNotifier)
  theme/     plant_colors, plant_dimensions, plant_text
assets/images/plants/  strelitzia, strelitzia_card, banana_tree, peperomia, sansevieria
```

All geometry is authored in a 375 x 812 phone design space and scaled
proportionally; no third-party packages.

## Asset sources and licenses - IMPORTANT

The build environment had no internet access, so no stock photos could be
downloaded. The PNGs in `assets/images/plants/` were **cut out of the supplied
reference image** (background keyed to transparency):

- They are low resolution (the small listing plants are ~60 px in the source
  and are upscaled), and cut-out edges are rough in places.
- Their copyright/license is **unknown** (whatever applies to the reference).
  Use them for development only and replace them with properly licensed
  isolated plant PNGs (e.g. from Unsplash / Pexels / Pixabay) before any
  public use. Keep the same file names and aspect ratios; for the large
  `strelitzia.png` keep the pot bottom near pixel (145, 610) of a 430 x 625
  image or adjust `PlantDimensions.plantImageAnchorPx`.
- `strelitzia_card.png` is a separate crop (not the same file as the large one).

## Fonts

No font file is bundled. Serif text uses the platform serif (Noto Serif on
Android), which is close to but not identical to the reference typeface. To
match more closely, add e.g. Marcellus (OFL) under `assets/fonts/`, register
it in `pubspec.yaml`, and set the family in `lib/theme/plant_text.dart`.

## Verification status

This project has NOT been compiled, run on an emulator, or visually compared
with the reference in the environment that produced it. Expect small
compile-time or layout fixes and some tuning of the numbers in
`plant_dimensions.dart` and the painter paths.

## Listing screen: identical cards + swipe to reveal

- **Identical cards.** One `PlantProductCard` is used for all four products.
  Size, radius, padding, gap and image width come from shared constants in
  `lib/theme/plant_dimensions.dart` (`listCard*`); nothing depends on the
  product name. The old oversized floating Strelitzia card and its separate
  plant overlay were removed.
- **Swipe right to reveal.** Drag a card to the right and its plant travels to
  the right edge, scales up (1.0 -> 1.3) and progressively emerges past the
  card edge; the card itself slides slightly. On release it settles to the
  revealed or the idle state (distance threshold or fling velocity). Dragging
  back restores it. In the idle state no plant is outside its card.
- **Layers** (in `lib/widgets/plant_product_card.dart`): white surface ->
  plant clipped by `_RevealClipper` (the card's rounded rect when idle, growing
  past the right edge as the drag progresses) -> text/stepper/action tab
  clipped to the card. Driven by one `AnimationController` per card, disposed
  with the card. Tuning constants are fractions of the card size at the top of
  the state class.
- While a card is revealed the plant is drawn under the text and the green
  action tab, so it partly sits behind the tab; the tab stays tappable.
- Changed files: `plant_product_card.dart`, `plant_listing_screen.dart`,
  `plant_dimensions.dart` (listing constants only). Detail screen, Preview
  screen, painters, models and assets are untouched.

Run: `flutter pub get`, then `flutter run` on an Android emulator.
Not verified by running: this change was written without a Flutter SDK, so it
has not been compiled or tested on a device.
