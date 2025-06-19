/// Represents the safe training zone for heart rate and pace.
/// Use this for smart avatar/coach logic.
class RunZone {
  /// Zone 2 lower bound (inclusive) for heart rate (bpm).
  static const int minSafeHR = 120;

  /// Zone 2 upper bound (inclusive) for heart rate (bpm).
  static const int maxSafeHR = 150;

  /// Minimum safe pace (min/km).
  static const double minPace = 6.0;

  /// Maximum safe pace (min/km).
  static const double maxPace = 8.0;

  /// Target session duration.
  static const Duration sessionGoalTime = Duration(minutes: 40);

  /// Returns true if [hr] is within the safe heart rate zone.
  static bool isSafeHR(int hr) => hr >= minSafeHR && hr <= maxSafeHR;

  /// Returns true if [pace] is within the safe pace zone.
  static bool isSafePace(double pace) => pace >= minPace && pace <= maxPace;
}
