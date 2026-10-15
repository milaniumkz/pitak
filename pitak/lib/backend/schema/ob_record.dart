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

  // "isLike" field.
  List<DocumentReference>? _isLike;
  List<DocumentReference> get isLike => _isLike ?? const [];
  bool hasIsLike() => _isLike != null;

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
    _isLike = getDataList(snapshotData['isLike']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('ob');

  static Stream<ObRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ObRecord.fromSnapshot(s));

  static Future<ObRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ObRecord.fromSnapshot(s));

  static ObRecord fromSnapshot(DocumentSnapshot snapshot) => ObRecord._(
        snapshot.reference,
        mapFromFirestore((snapshot.data() as Map<String, dynamic>?) ??
            (throw StateError('Объявление удалено'))),
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
        listEquality.equals(e1?.isLike, e2?.isLike);
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
        e?.isLike
      ]);

  @override
  bool isValidKey(Object? o) => o is ObRecord;
}
