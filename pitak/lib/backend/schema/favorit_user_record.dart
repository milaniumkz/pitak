import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FavoritUserRecord extends FirestoreRecord {
  FavoritUserRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "iduser" field.
  DocumentReference? _iduser;
  DocumentReference? get iduser => _iduser;
  bool hasIduser() => _iduser != null;

  // "idOb" field.
  DocumentReference? _idOb;
  DocumentReference? get idOb => _idOb;
  bool hasIdOb() => _idOb != null;

  void _initializeFields() {
    _iduser = snapshotData['iduser'] as DocumentReference?;
    _idOb = snapshotData['idOb'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('favoritUser');

  static Stream<FavoritUserRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => FavoritUserRecord.fromSnapshot(s));

  static Future<FavoritUserRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => FavoritUserRecord.fromSnapshot(s));

  static FavoritUserRecord fromSnapshot(DocumentSnapshot snapshot) =>
      FavoritUserRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static FavoritUserRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      FavoritUserRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'FavoritUserRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is FavoritUserRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createFavoritUserRecordData({
  DocumentReference? iduser,
  DocumentReference? idOb,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'iduser': iduser,
      'idOb': idOb,
    }.withoutNulls,
  );

  return firestoreData;
}

class FavoritUserRecordDocumentEquality implements Equality<FavoritUserRecord> {
  const FavoritUserRecordDocumentEquality();

  @override
  bool equals(FavoritUserRecord? e1, FavoritUserRecord? e2) {
    return e1?.iduser == e2?.iduser && e1?.idOb == e2?.idOb;
  }

  @override
  int hash(FavoritUserRecord? e) =>
      const ListEquality().hash([e?.iduser, e?.idOb]);

  @override
  bool isValidKey(Object? o) => o is FavoritUserRecord;
}
