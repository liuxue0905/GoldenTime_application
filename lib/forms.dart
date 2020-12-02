class FormObject {}

class PaginatedFormObject extends FormObject {
  int offset;
  int limit;

  PaginatedFormObject({this.offset = 0, this.limit = 40}):super();

  @override
  String toString() {
    return 'PaginatedFormObject{offset: $offset, limit: $limit}';
  }
}

class RecordsFormObject extends PaginatedFormObject {
  String title;
  int format;
  String year;
  int companyId;

  RecordsFormObject({this.title, this.format, this.year, this.companyId}):super();

  @override
  String toString() {
    return 'RecordsFormObject{${super.toString()} title: $title, format: $format, year: $year, companyId: $companyId}';
  }
}

class ArtistsFormObject extends PaginatedFormObject {
  String name;
  int type;
  bool recordIsNull;

  ArtistsFormObject({this.name, this.type, this.recordIsNull}):super();

  @override
  String toString() {
    return 'ArtistsFormObject{name: $name, type: $type, recordIsNull: $recordIsNull}';
  }
}

class SongsFormObject extends PaginatedFormObject {
  String title;

  SongsFormObject({this.title, int limit = 40}):super(limit: limit);

  @override
  String toString() {
    return 'SongsFormObject{title: $title}';
  }
}