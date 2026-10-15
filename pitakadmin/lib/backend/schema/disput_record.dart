import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DisputRecord extends FirestoreRecord {
  DisputRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "idOb" field.
  DocumentReference? _idOb;
  DocumentReference? get idOb => _idOb;
  bool hasIdOb() => _idOb != null;

  // "idUser" field.
  DocumentReference? _idUser;
  DocumentReference? get idUser => _idUser;
  bool hasIdUser() => _idUser != null;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  void _initializeFields() {
    _idOb = snapshotData['idOb'] as DocumentReference?;
    _idUser = snapshotData['idUser'] as DocumentReference?;
    _text = snapshotData['text'] as String?;
    _image = snapshotData['image'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('disput');

  static Stream<DisputRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DisputRecord.fromSnapshot(s));

  static Future<DisputRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DisputRecord.fromSnapshot(s));

  static DisputRecord fromSnapshot(DocumentSnapshot snapshot) => DisputRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DisputRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DisputRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DisputRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DisputRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDisputRecordData({
  DocumentReference? idOb,
  DocumentReference? idUser,
  String? text,
  String? image,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'idOb': idOb,
      'idUser': idUser,
      'text': text,
      'image': image,
    }.withoutNulls,
  );

  return firestoreData;
}

class DisputRecordDocumentEquality implements Equality<DisputRecord> {
  const DisputRecordDocumentEquality();

  @override
  bool equals(DisputRecord? e1, DisputRecord? e2) {
    return e1?.idOb == e2?.idOb &&
        e1?.idUser == e2?.idUser &&
        e1?.text == e2?.text &&
        e1?.image == e2?.image;
  }

  @override
  int hash(DisputRecord? e) =>
      const ListEquality().hash([e?.idOb, e?.idUser, e?.text, e?.image]);

  @override
  bool isValidKey(Object? o) => o is DisputRecord;
}
