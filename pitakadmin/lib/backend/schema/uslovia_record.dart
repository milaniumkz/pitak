import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsloviaRecord extends FirestoreRecord {
  UsloviaRecord._(
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
      FirebaseFirestore.instance.collection('uslovia');

  static Stream<UsloviaRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsloviaRecord.fromSnapshot(s));

  static Future<UsloviaRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsloviaRecord.fromSnapshot(s));

  static UsloviaRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UsloviaRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsloviaRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsloviaRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsloviaRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsloviaRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsloviaRecordData({
  String? text,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'text': text,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsloviaRecordDocumentEquality implements Equality<UsloviaRecord> {
  const UsloviaRecordDocumentEquality();

  @override
  bool equals(UsloviaRecord? e1, UsloviaRecord? e2) {
    return e1?.text == e2?.text;
  }

  @override
  int hash(UsloviaRecord? e) => const ListEquality().hash([e?.text]);

  @override
  bool isValidKey(Object? o) => o is UsloviaRecord;
}
