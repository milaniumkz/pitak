import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ObRecord extends FirestoreRecord {
  ObRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "idUser" field.
  DocumentReference? _idUser;
  DocumentReference? get idUser => _idUser;
  bool hasIdUser() => _idUser != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  // "status" field.
  int? _status;
  int get status => _status ?? 0;
  bool hasStatus() => _status != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "data" field.
  DateTime? _data;
  DateTime? get data => _data;
  bool hasData() => _data != null;

  // "city" field.
  String? _city;
  String get city => _city ?? '';
  bool hasCity() => _city != null;

  // "kat" field.
  String? _kat;
  String get kat => _kat ?? '';
  bool hasKat() => _kat != null;

  // "phone" field.
  String? _phone;
  String get phone => _phone ?? '';
  bool hasPhone() => _phone != null;

  // "favorites" field.
  List<DocumentReference>? _favorites;
  List<DocumentReference> get favorites => _favorites ?? const [];
  bool hasFavorites() => _favorites != null;

  // "top" field.
  bool? _top;
  bool get top => _top ?? false;
  bool hasTop() => _top != null;

  // "color" field.
  bool? _color;
  bool get color => _color ?? false;
  bool hasColor() => _color != null;

  // "video" field.
  bool? _video;
  bool get video => _video ?? false;
  bool hasVideo() => _video != null;

  // "videoPath" field.
  String? _videoPath;
  String get videoPath => _videoPath ?? '';
  bool hasVideoPath() => _videoPath != null;

  // "podKat" field.
  String? _podKat;
  String get podKat => _podKat ?? '';
  bool hasPodKat() => _podKat != null;

  // "price" field.
  int? _price;
  int get price => _price ?? 0;
  bool hasPrice() => _price != null;

  // "wh" field.
  String? _wh;
  String get wh => _wh ?? '';
  bool hasWh() => _wh != null;

  // "insta" field.
  String? _insta;
  String get insta => _insta ?? '';
  bool hasInsta() => _insta != null;

  // "image1" field.
  String? _image1;
  String get image1 => _image1 ?? '';
  bool hasImage1() => _image1 != null;

  // "image2" field.
  String? _image2;
  String get image2 => _image2 ?? '';
  bool hasImage2() => _image2 != null;

  // "image3" field.
  String? _image3;
  String get image3 => _image3 ?? '';
  bool hasImage3() => _image3 != null;

  // "image4" field.
  String? _image4;
  String get image4 => _image4 ?? '';
  bool hasImage4() => _image4 != null;

  // "view" field.
  int? _view;
  int get view => _view ?? 0;
  bool hasView() => _view != null;

  // "call" field.
  int? _call;
  int get call => _call ?? 0;
  bool hasCall() => _call != null;

  // "whTap" field.
  int? _whTap;
  int get whTap => _whTap ?? 0;
  bool hasWhTap() => _whTap != null;

  // "inTap" field.
  int? _inTap;
  int get inTap => _inTap ?? 0;
  bool hasInTap() => _inTap != null;

  void _initializeFields() {
    _idUser = snapshotData['idUser'] as DocumentReference?;
    _title = snapshotData['title'] as String?;
    _text = snapshotData['text'] as String?;
    _status = castToType<int>(snapshotData['status']);
    _image = snapshotData['image'] as String?;
    _data = snapshotData['data'] as DateTime?;
    _city = snapshotData['city'] as String?;
    _kat = snapshotData['kat'] as String?;
    _phone = snapshotData['phone'] as String?;
    _favorites = getDataList(snapshotData['favorites']);
    _top = snapshotData['top'] as bool?;
    _color = snapshotData['color'] as bool?;
    _video = snapshotData['video'] as bool?;
    _videoPath = snapshotData['videoPath'] as String?;
    _podKat = snapshotData['podKat'] as String?;
    _price = castToType<int>(snapshotData['price']);
    _wh = snapshotData['wh'] as String?;
    _insta = snapshotData['insta'] as String?;
    _image1 = snapshotData['image1'] as String?;
    _image2 = snapshotData['image2'] as String?;
    _image3 = snapshotData['image3'] as String?;
    _image4 = snapshotData['image4'] as String?;
    _view = castToType<int>(snapshotData['view']);
    _call = castToType<int>(snapshotData['call']);
    _whTap = castToType<int>(snapshotData['whTap']);
    _inTap = castToType<int>(snapshotData['inTap']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('ob');

  static Stream<ObRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ObRecord.fromSnapshot(s));

  static Future<ObRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ObRecord.fromSnapshot(s));

  static ObRecord fromSnapshot(DocumentSnapshot snapshot) => ObRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ObRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ObRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ObRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ObRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createObRecordData({
  DocumentReference? idUser,
  String? title,
  String? text,
  int? status,
  String? image,
  DateTime? data,
  String? city,
  String? kat,
  String? phone,
  bool? top,
  bool? color,
  bool? video,
  String? videoPath,
  String? podKat,
  int? price,
  String? wh,
  String? insta,
  String? image1,
  String? image2,
  String? image3,
  String? image4,
  int? view,
  int? call,
  int? whTap,
  int? inTap,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'idUser': idUser,
      'title': title,
      'text': text,
      'status': status,
      'image': image,
      'data': data,
      'city': city,
      'kat': kat,
      'phone': phone,
      'top': top,
      'color': color,
      'video': video,
      'videoPath': videoPath,
      'podKat': podKat,
      'price': price,
      'wh': wh,
      'insta': insta,
      'image1': image1,
      'image2': image2,
      'image3': image3,
      'image4': image4,
      'view': view,
      'call': call,
      'whTap': whTap,
      'inTap': inTap,
    }.withoutNulls,
  );

  return firestoreData;
}

class ObRecordDocumentEquality implements Equality<ObRecord> {
  const ObRecordDocumentEquality();

  @override
  bool equals(ObRecord? e1, ObRecord? e2) {
    const listEquality = ListEquality();
    return e1?.idUser == e2?.idUser &&
        e1?.title == e2?.title &&
        e1?.text == e2?.text &&
        e1?.status == e2?.status &&
        e1?.image == e2?.image &&
        e1?.data == e2?.data &&
        e1?.city == e2?.city &&
        e1?.kat == e2?.kat &&
        e1?.phone == e2?.phone &&
        listEquality.equals(e1?.favorites, e2?.favorites) &&
        e1?.top == e2?.top &&
        e1?.color == e2?.color &&
        e1?.video == e2?.video &&
        e1?.videoPath == e2?.videoPath &&
        e1?.podKat == e2?.podKat &&
        e1?.price == e2?.price &&
        e1?.wh == e2?.wh &&
        e1?.insta == e2?.insta &&
        e1?.image1 == e2?.image1 &&
        e1?.image2 == e2?.image2 &&
        e1?.image3 == e2?.image3 &&
        e1?.image4 == e2?.image4 &&
        e1?.view == e2?.view &&
        e1?.call == e2?.call &&
        e1?.whTap == e2?.whTap &&
        e1?.inTap == e2?.inTap;
  }

  @override
  int hash(ObRecord? e) => const ListEquality().hash([
        e?.idUser,
        e?.title,
        e?.text,
        e?.status,
        e?.image,
        e?.data,
        e?.city,
        e?.kat,
        e?.phone,
        e?.favorites,
        e?.top,
        e?.color,
        e?.video,
        e?.videoPath,
        e?.podKat,
        e?.price,
        e?.wh,
        e?.insta,
        e?.image1,
        e?.image2,
        e?.image3,
        e?.image4,
        e?.view,
        e?.call,
        e?.whTap,
        e?.inTap
      ]);

  @override
  bool isValidKey(Object? o) => o is ObRecord;
}
