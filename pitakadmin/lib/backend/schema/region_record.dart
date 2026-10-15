import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RegionRecord extends FirestoreRecord {
  RegionRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "parent" field.
  String? _parent;
  String get parent => _parent ?? '';
  bool hasParent() => _parent != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _parent = snapshotData['parent'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('region');

  static Stream<RegionRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RegionRecord.fromSnapshot(s));

  static Future<RegionRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RegionRecord.fromSnapshot(s));

  static RegionRecord fromSnapshot(DocumentSnapshot snapshot) => RegionRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RegionRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RegionRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RegionRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RegionRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRegionRecordData({
  String? title,
  String? parent,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'parent': parent,
    }.withoutNulls,
  );

  return firestoreData;
}

class RegionRecordDocumentEquality implements Equality<RegionRecord> {
  const RegionRecordDocumentEquality();

  @override
  bool equals(RegionRecord? e1, RegionRecord? e2) {
    return e1?.title == e2?.title && e1?.parent == e2?.parent;
  }

  @override
  int hash(RegionRecord? e) => const ListEquality().hash([e?.title, e?.parent]);

  @override
  bool isValidKey(Object? o) => o is RegionRecord;
}
