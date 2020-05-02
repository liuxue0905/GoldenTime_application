class BoundType {
  static BoundType OPEN = BoundType(false);
  static BoundType CLOSED = BoundType(true);

  final bool inclusive;

//  BoundType._(this.inclusive);

  BoundType(this.inclusive) {
//    this.inclusive = inclusive;
  }

  /** Returns the bound type corresponding to a boolean value for inclusivity. */
  static BoundType forBoolean(bool inclusive) {
    return inclusive ? CLOSED : OPEN;
  }

  BoundType flip() {
    return forBoolean(!inclusive);
  }
}
