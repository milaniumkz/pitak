import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PolitikaRecord extends FirestoreRecord {
  PolitikaRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  void _initializeFields() {
    _text = snapshotData['text'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('politika');

  static Stream<PolitikaRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PolitikaRecord.fromSnapshot(s));

  static Future<PolitikaRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PolitikaRecord.fromSnapshot(s));

  static PolitikaRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PolitikaRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PolitikaRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PolitikaRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PolitikaRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PolitikaRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPolitikaRecordData({
  String? text,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'text': text,
    }.withoutNulls,
  );

  return firestoreData;
}

class PolitikaRecordDocumentEquality implements Equality<PolitikaRecord> {
  const PolitikaRecordDocumentEquality();

  @override
  bool equals(PolitikaRecord? e1, PolitikaRecord? e2) {
    return e1?.text == e2?.text;
  }

  @override
  int hash(PolitikaRecord? e) => const ListEquality().hash([e?.text]);

  @override
  bool isValidKey(Object? o) => o is PolitikaRecord;
}
