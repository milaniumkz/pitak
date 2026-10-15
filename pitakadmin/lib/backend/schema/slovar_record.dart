import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SlovarRecord extends FirestoreRecord {
  SlovarRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('slovar');

  static Stream<SlovarRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SlovarRecord.fromSnapshot(s));

  static Future<SlovarRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SlovarRecord.fromSnapshot(s));

  static SlovarRecord fromSnapshot(DocumentSnapshot snapshot) => SlovarRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SlovarRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SlovarRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SlovarRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SlovarRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSlovarRecordData({
  String? title,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
    }.withoutNulls,
  );

  return firestoreData;
}

class SlovarRecordDocumentEquality implements Equality<SlovarRecord> {
  const SlovarRecordDocumentEquality();

  @override
  bool equals(SlovarRecord? e1, SlovarRecord? e2) {
    return e1?.title == e2?.title;
  }

  @override
  int hash(SlovarRecord? e) => const ListEquality().hash([e?.title]);

  @override
  bool isValidKey(Object? o) => o is SlovarRecord;
}
