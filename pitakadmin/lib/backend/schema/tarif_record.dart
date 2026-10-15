import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TarifRecord extends FirestoreRecord {
  TarifRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "ob" field.
  int? _ob;
  int get ob => _ob ?? 0;
  bool hasOb() => _ob != null;

  // "top" field.
  int? _top;
  int get top => _top ?? 0;
  bool hasTop() => _top != null;

  // "color" field.
  int? _color;
  int get color => _color ?? 0;
  bool hasColor() => _color != null;

  void _initializeFields() {
    _ob = castToType<int>(snapshotData['ob']);
    _top = castToType<int>(snapshotData['top']);
    _color = castToType<int>(snapshotData['color']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('tarif');

  static Stream<TarifRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TarifRecord.fromSnapshot(s));

  static Future<TarifRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TarifRecord.fromSnapshot(s));

  static TarifRecord fromSnapshot(DocumentSnapshot snapshot) => TarifRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TarifRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TarifRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TarifRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TarifRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTarifRecordData({
  int? ob,
  int? top,
  int? color,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'ob': ob,
      'top': top,
      'color': color,
    }.withoutNulls,
  );

  return firestoreData;
}

class TarifRecordDocumentEquality implements Equality<TarifRecord> {
  const TarifRecordDocumentEquality();

  @override
  bool equals(TarifRecord? e1, TarifRecord? e2) {
    return e1?.ob == e2?.ob && e1?.top == e2?.top && e1?.color == e2?.color;
  }

  @override
  int hash(TarifRecord? e) =>
      const ListEquality().hash([e?.ob, e?.top, e?.color]);

  @override
  bool isValidKey(Object? o) => o is TarifRecord;
}
