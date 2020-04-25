

class PageList<T> {

  int count;

  List<T> results;

  PageList({this.count, this.results});

  @override
  String toString() {
    return 'PageList{count: $count, results: $results}';
  }

}
