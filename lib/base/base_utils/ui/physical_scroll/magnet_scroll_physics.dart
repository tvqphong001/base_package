import 'dart:math' as math;
import 'package:base_package/base/base.dart';
import 'package:flutter/physics.dart';

/// A scroll physics that always lands on specific points.
class MagnetScrollPhysics extends ScrollPhysics {
  /// The fixed item size.
  final double itemSize;

  /// Creates a new magnet scroll physics instance.
  const MagnetScrollPhysics({
    ScrollPhysics? parent,
    required this.itemSize,
  }) : super(parent: parent);

  @override
  MagnetScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return MagnetScrollPhysics(
      parent: buildParent(ancestor),
      itemSize: itemSize,
    );
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    // Scenario 1:
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at the scrollable's boundary.
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) || (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }

    // Create a test simulation to see where it would have ballistically fallen
    // naturally without settling onto items.
    final Simulation? testFrictionSimulation = super.createBallisticSimulation(position, velocity);

    // Scenario 2:
    // If it was going to end up past the scroll extent, defer back to the
    // parent physics' ballistics again which should put us on the scrollable's
    // boundary.
    if (testFrictionSimulation != null && (testFrictionSimulation.x(double.infinity) == position.minScrollExtent || testFrictionSimulation.x(double.infinity) == position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }

    // From the natural final position, find the nearest item it should have
    // settled to.
    final int settlingItemIndex = _getItemFromOffset(
      offset: testFrictionSimulation?.x(double.infinity) ?? position.pixels,
      minScrollExtent: position.minScrollExtent,
      maxScrollExtent: position.maxScrollExtent,
    );

    final double settlingPixels = settlingItemIndex * itemSize;

    // Scenario 3:
    // If there's no velocity and we're already at where we intend to land,
    // do nothing.
    if (velocity.abs() < tolerance.velocity && (settlingPixels - position.pixels).abs() < tolerance.distance) {
      return null;
    }

    // Scenario 4:
    // If we're going to end back at the same item because initial velocity
    // is too low to break past it, use a spring simulation to get back.
    if (settlingItemIndex ==
        _getItemFromOffset(
          offset: position.pixels,
          minScrollExtent: position.minScrollExtent,
          maxScrollExtent: position.maxScrollExtent,
        )) {
      return SpringSimulation(
        spring,
        position.pixels,
        settlingPixels,
        velocity,
        tolerance: tolerance,
      );
    }

    // Scenario 5:
    // Create a new friction simulation except the drag will be tweaked to land
    // exactly on the item closest to the natural stopping point.
    return FrictionSimulation.through(
      position.pixels,
      settlingPixels,
      velocity,
      tolerance.velocity * velocity.sign,
    );
  }

  /// Returns the item index from the specified offset.
  int _getItemFromOffset({
    double? offset,
    double? minScrollExtent,
    double? maxScrollExtent,
  }) =>
      (_clipOffsetToScrollableRange(offset??0, minScrollExtent??0, maxScrollExtent??0) / itemSize).round();

  /// Clips the specified offset to the scrollable range.
  double _clipOffsetToScrollableRange(
      double offset,
      double minScrollExtent,
      double maxScrollExtent,
      ) =>
      math.min(math.max(offset, minScrollExtent), maxScrollExtent);
}