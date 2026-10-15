import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OtzyvRecord extends FirestoreRecord {
  OtzyvRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  // "idUser" field.
  DocumentReference? _idUser;
  DocumentReference? get idUser => _idUser;
  bool hasIdUser() => _idUser != null;

  void _initializeFields() {
    _text = snapshotData['text'] as String?;
    _idUser = snapshotData['idUser'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('otzyv');

  static Stream<OtzyvRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => OtzyvRecord.fromSnapshot(s));

  static Future<OtzyvRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => OtzyvRecord.fromSnapshot(s));

  static OtzyvRecord fromSnapshot(DocumentSnapshot snapshot) => OtzyvRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static OtzyvRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      OtzyvRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'OtzyvRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is OtzyvRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createOtzyvRecordData({
  String? text,
  DocumentReference? idUser,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'text': text,
      'idUser': idUser,
    }.withoutNulls,
  );

  return firestoreData;
}

class OtzyvRecordDocumentEquality implements Equality<OtzyvRecord> {
  const OtzyvRecordDocumentEquality();

  @override
  bool equals(OtzyvRecord? e1, OtzyvRecord? e2) {
    return e1?.text == e2?.text && e1?.idUser == e2?.idUser;
  }

  @override
  int hash(OtzyvRecord? e) => const ListEquality().hash([e?.text, e?.idUser]);

  @override
  bool isValidKey(Object? o) => o is OtzyvRecord;
}
