import 'cut.dart';

class Range<C extends Comparable> {
  final Cut<C> lowerBound;
  final Cut<C> upperBound;

  Range(this.lowerBound, this.upperBound) {
    if (this.lowerBound == null || this.upperBound == null) {
      throw Exception("Invalid range: ");
    }

//    this.lowerBound = checkNotNull(lowerBound);
//    this.upperBound = checkNotNull(upperBound);
//    if (lowerBound.compareTo(upperBound) > 0
//        || lowerBound == Cut.<C>aboveAll()
//    || upperBound == Cut.<C>belowAll()) {
//    throw new IllegalArgumentException("Invalid range: " + toString(lowerBound, upperBound));
//    }
  }

  static Range<C> create<C extends Comparable<Object>>(
      Cut<C> lowerBound, Cut<C> upperBound) {
    return new Range<C>(lowerBound, upperBound);
  }

  static Range<C> closedOpen<C extends Comparable<Object>>(C lower, C upper) {
    return create(Cut.belowValue(lower), Cut.belowValue(upper));
  }

  static Range<C> openClosed<C extends Comparable<Object>>(C lower, C upper) {
    return create(Cut.aboveValue(lower), Cut.aboveValue(upper));
  }

  static int compareOrThrow(Comparable left, Comparable right) {
    return left.compareTo(right);
  }
}
