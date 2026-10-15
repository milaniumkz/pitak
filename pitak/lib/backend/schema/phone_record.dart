import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PhoneRecord extends FirestoreRecord {
  PhoneRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "phone" field.
  int? _phone;
  int get phone => _phone ?? 0;
  bool hasPhone() => _phone != null;

  void _initializeFields() {
    _phone = castToType<int>(snapshotData['phone']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('phone');

  static Stream<PhoneRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PhoneRecord.fromSnapshot(s));

  static Future<PhoneRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PhoneRecord.fromSnapshot(s));

  static PhoneRecord fromSnapshot(DocumentSnapshot snapshot) => PhoneRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PhoneRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PhoneRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PhoneRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PhoneRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPhoneRecordData({
  int? phone,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'phone': phone,
    }.withoutNulls,
  );

  return firestoreData;
}

class PhoneRecordDocumentEquality implements Equality<PhoneRecord> {
  const PhoneRecordDocumentEquality();

  @override
  bool equals(PhoneRecord? e1, PhoneRecord? e2) {
    return e1?.phone == e2?.phone;
  }

  @override
  int hash(PhoneRecord? e) => const ListEquality().hash([e?.phone]);

  @override
  bool isValidKey(Object? o) => o is PhoneRecord;
}
