import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class KatRecord extends FirestoreRecord {
  KatRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "icon" field.
  String? _icon;
  String get icon => _icon ?? '';
  bool hasIcon() => _icon != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _icon = snapshotData['icon'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('kat');

  static Stream<KatRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => KatRecord.fromSnapshot(s));

  static Future<KatRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => KatRecord.fromSnapshot(s));

  static KatRecord fromSnapshot(DocumentSnapshot snapshot) => KatRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static KatRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      KatRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'KatRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is KatRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createKatRecordData({
  String? title,
  String? icon,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'icon': icon,
    }.withoutNulls,
  );

  return firestoreData;
}

class KatRecordDocumentEquality implements Equality<KatRecord> {
  const KatRecordDocumentEquality();

  @override
  bool equals(KatRecord? e1, KatRecord? e2) {
    return e1?.title == e2?.title && e1?.icon == e2?.icon;
  }

  @override
  int hash(KatRecord? e) => const ListEquality().hash([e?.title, e?.icon]);

  @override
  bool isValidKey(Object? o) => o is KatRecord;
}
