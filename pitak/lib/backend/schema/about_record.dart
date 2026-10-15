import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AboutRecord extends FirestoreRecord {
  AboutRecord._(
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
      FirebaseFirestore.instance.collection('about');

  static Stream<AboutRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AboutRecord.fromSnapshot(s));

  static Future<AboutRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AboutRecord.fromSnapshot(s));

  static AboutRecord fromSnapshot(DocumentSnapshot snapshot) => AboutRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AboutRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AboutRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AboutRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AboutRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAboutRecordData({
  String? text,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'text': text,
    }.withoutNulls,
  );

  return firestoreData;
}

class AboutRecordDocumentEquality implements Equality<AboutRecord> {
  const AboutRecordDocumentEquality();

  @override
  bool equals(AboutRecord? e1, AboutRecord? e2) {
    return e1?.text == e2?.text;
  }

  @override
  int hash(AboutRecord? e) => const ListEquality().hash([e?.text]);

  @override
  bool isValidKey(Object? o) => o is AboutRecord;
}
