import 'bound_type.dart';
import 'range.dart';

class AboveValue<C extends Comparable> extends Cut<C> {
  AboveValue(C endpoint) : super(endpoint) {
//    super(checkNotNull(endpoint));
  }

  @override
  bool isLessThan(C value) {
    return Range.compareOrThrow(endpoint, value) < 0;
  }

  @override
  BoundType typeAsLowerBound() {
    return BoundType.OPEN;
  }

  @override
  BoundType typeAsUpperBound() {
    return BoundType.CLOSED;
  }
}

class BelowValue<C extends Comparable> extends Cut<C> {
  BelowValue(C endpoint) : super(endpoint) {
//    super(checkNotNull(endpoint));
  }

  @override
  bool isLessThan(C value) {
    return Range.compareOrThrow(endpoint, value) <= 0;
  }

  @override
  BoundType typeAsLowerBound() {
    return BoundType.CLOSED;
  }

  @override
  BoundType typeAsUpperBound() {
    return BoundType.OPEN;
  }
}

class AboveAll extends Cut<Comparable<dynamic>> {
  static final AboveAll INSTANCE = AboveAll();

  AboveAll() : super(null) {
    //super(null);
  }

  @override
  Comparable<dynamic> getEndpoint() {
    throw ArgumentError("range unbounded on this side");
  }

  @override
  int compareTo(Cut<Comparable<dynamic>> o) {
    return (o == this) ? 0 : 1;
  }
}

class BelowAll extends Cut<Comparable<dynamic>> {
  static final BelowAll INSTANCE = BelowAll();

  BelowAll() : super(null);

  @override
  Comparable<dynamic> getEndpoint() {
    throw ArgumentError("range unbounded on this side");
  }

  @override
  bool isLessThan(Comparable<dynamic> value) {
    return true;
  }

  @override
  int compareTo(Cut<Comparable<dynamic>> o) {
    return (o == this) ? 0 : -1;
  }
}

abstract class Cut<C extends Comparable> implements Comparable<Cut<C>> {
  final C endpoint;

  Cut(this.endpoint) {
//    this.endpoint = endpoint;
  }

  static Cut<C> aboveValue<C extends Comparable>(Comparable endpoint) {
    return AboveValue<C>(endpoint);
  }

  static Cut<C> belowValue<C extends Comparable>(C endpoint) {
    return new BelowValue<C>(endpoint);
  }

  static Cut<C> aboveAll<C extends Comparable>() {
//  return (Cut<C>) AboveAll.INSTANCE;
    return AboveAll.INSTANCE as Cut<C>;
  }

  static Cut<C> belowAll<C extends Comparable>() {
//    return (Cut < C>) BelowAll.INSTANCE;
    return BelowAll.INSTANCE as Cut<C>;
  }

  @override
  int compareTo(Cut<C> that) {
    if (that == belowAll()) {
      return 1;
    }
    if (that == aboveAll()) {
      return -1;
    }
    int result = Range.compareOrThrow(endpoint, that.endpoint);
    if (result != 0) {
      return result;
    }
    // same value. below comes before above
//    return Booleans.compare(this instanceof AboveValue, that instanceof AboveValue);
    return 0;
  }

  C getEndpoint() {
    return endpoint;
  }
}
