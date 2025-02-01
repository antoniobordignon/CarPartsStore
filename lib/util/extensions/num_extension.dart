extension Between on num {
  bool between(num from, num to, {bool inclusive = false}) {
    if (inclusive) {
      return this >= from && this <= to;
    }
    return this > from && this < to;
  }
}
