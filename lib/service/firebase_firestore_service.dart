import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yji5/models/user_profile.dart';

final CollectionReference userCollection = Firestore.instance.collection('user_profile');

class FirebaseFirestoreService {

  static final FirebaseFirestoreService _instance = new FirebaseFirestoreService.internal();

  factory FirebaseFirestoreService() => _instance;

  FirebaseFirestoreService.internal();

  Future<UserProfile> createUser({
        String name,
        String email,
        String mobile,
        String dob,
        //String pob,
        double height,
        double weight,
        String address,
        String kota,
        String propinsi,
        String kodepos,
        String golDarah,
        String noInstruktur,
        String penyakit,
        bool merokok,
        bool pria,
        bool member,
        String jenisClub,
        String namaClub,
        String propinsiClub,
        String kotaClub,
        String kecamatanClub,
        String noClub,
        String created_at
      }
    ) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(userCollection.document());

      final UserProfile user = new UserProfile();
      user.setID(ds.documentID);
      user.name = name;
      user.email = email;
      user.mobile = mobile;
      user.dob = dob;
      //user.pob = pob;
      user.height = height;
      user.weight = weight;
      user.address = address;
      user.kota = kota;
      user.propinsi = propinsi;
      user.kodepos = kodepos;
      user.golDarah = golDarah;
      user.noInstruktur = noInstruktur;
      user.penyakit = penyakit;
      user.merokok = merokok;
      user.pria = pria;
      user.member = member;
      user.jenisClub = jenisClub;
      user.namaClub = namaClub;
      user.propinsiClub = propinsiClub;
      user.kotaClub = kotaClub;
      user.kecamatanClub = kecamatanClub;
      user.noClub = noClub;
      user.created_at = created_at;

      final Map<String, dynamic> data = user.toMap();
      //print(data);

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return UserProfile.fromMap(mapData);
    }).catchError((error) {
      print('Error Service: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getUserList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = userCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Stream<QuerySnapshot> getUserProfile(String phoneNumber) {
    CollectionReference thisUser= Firestore.instance.collection('user_profile').where("mobile",isEqualTo:phoneNumber);
    Stream<QuerySnapshot> snapshots = thisUser.snapshots();
    return snapshots;
  }

  Future<dynamic> updateUser(UserProfile user) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(userCollection.document(user.id));

      await tx.update(ds.reference, user.toMap());
      return {'updated': true};
    };

    return Firestore.instance
        .runTransaction(updateTransaction)
        .then((result) => result['updated'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

  Future<dynamic> deleteUser(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(userCollection.document(id));

      await tx.delete(ds.reference);
      return {'deleted': true};
    };

    return Firestore.instance
        .runTransaction(deleteTransaction)
        .then((result) => result['deleted'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }
}