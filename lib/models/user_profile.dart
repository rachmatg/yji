import 'package:cloud_firestore/cloud_firestore.dart';


class UserProfile {
  String _id;
  String name = '';
  String email = '';
  String mobile = '';
  String dob;
  String pob;
  double height = 0.0;
  double weight = 0.0;
  String address = '';
  String kota = '';
  String propinsi = '';
  String kodepos = '';
  String golDarah = 'O';
  String noInstruktur = '';
  String penyakit = '';
  bool merokok = true;
  bool pria = true;
  bool member = true;
  String jenisClub = '';
  String namaClub = '';
  String propinsiClub= '';
  String kotaClub= '';
  String kecamatanClub= '';
  String noClub;
  String created_at;

  UserProfile()
  {
    _id = '';
    name = '';
    email = '';
    mobile = '';
    dob ='';
    //pob='';
    height = 0.0;
    weight = 0.0;
    address = '';
    kota = '';
    propinsi = '';
    kodepos = '';
    golDarah = 'O';
    noInstruktur = '';
    penyakit = '';
    merokok = true;
    pria = true;
    member = true;
    jenisClub = '';
    namaClub = '';
    propinsiClub= '';
    kotaClub= '';
    kecamatanClub= '';
    noClub='';
    created_at='';
  }

  /*UserProfile(
    this._id,
    this.name,
    this.email,
    this.mobile,
    this.dob,
    this.pob,
    this.height,
    this.weight,
    this.address,
    this.kota,
    this.propinsi,
    this.kodepos,
    this.golDarah,
    this.noInstruktur,
    this.penyakit,
    this.merokok,
    this.pria,
    this.member,
    this.jenisClub,
    this.namaClub,
    this.propinsiClub,
    this.kotaClub,
    this.kecamatanClub,
    this.noClub,
  );*/

  String get getPhone => mobile;
  String get getName => name;
  String get id => _id;
  setID(id) => _id=id;


  UserProfile.map(dynamic obj)
  {
    this._id=obj['id'];
    this.name=obj['name'];
    this.email=obj['email'];
    this.mobile=obj['mobile'];
    this.dob=obj['dob'];
    //this.pob=obj['pob'];
    this.height=obj['height'];
    this.weight=obj['weight'];
    this.address=obj['address'];
    this.kota=obj['kota'];
    this.propinsi=obj['propinsi'];
    this.kodepos=obj['kodepos'];
    this.golDarah=obj['golDarah'];
    this.noInstruktur=obj['noInstruktur'];
    this.penyakit=obj['penyakit'];
    this.merokok=obj['merokok'];
    this.pria=obj['pria'];
    this.member=obj['member'];
    this.jenisClub=obj['jenisClub'];
    this.namaClub=obj['namaClub'];
    this.propinsiClub=obj['propinsiClub'];
    this.kotaClub=obj['kotaClub'];
    this.kecamatanClub=obj['kecamatanClub'];
    this.noClub=obj['noClub'];
    this.created_at=obj['created_at'];

  }

  UserProfile.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._id=map['id'];
    this.name=map['name'];
    this.email=map['email'];
    this.mobile=map['mobile'];
    this.dob=map['dob'];
    //this.pob=map['pob'];
    this.height=map['height'];
    this.weight=map['weight'];
    this.address=map['address'];
    this.kota=map['kota'];
    this.propinsi=map['propinsi'];
    this.kodepos=map['kodepos'];
    this.golDarah=map['golDarah'];
    this.noInstruktur=map['noInstruktur'];
    this.penyakit=map['penyakit'];
    this.merokok=map['merokok'];
    this.pria=map['pria'];
    this.member=map['member'];
    this.jenisClub=map['jenisClub'];
    this.namaClub=map['namaClub'];
    this.propinsiClub=map['propinsiClub'];
    this.kotaClub=map['kotaClub'];
    this.kecamatanClub=map['kecamatanClub'];
    this.noClub=map['noClub'];
    this.created_at=map['created_at'];
  }

  Map<String, dynamic> toMap()
  {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['id']=this._id;
    map['name']=this.name;
    map['email']=this.email;
    map['mobile']=this.mobile;
    map['dob']=this.dob;
    //map['pob']=this.pob;
    map['height']=this.height;
    map['weight']=this.weight;
    map['address']=this.address;
    map['kota']=this.kota;
    map['propinsi']=this.propinsi;
    map['kodepos']=this.kodepos;
    map['golDarah']=this.golDarah;
    map['noInstruktur']=this.noInstruktur;
    map['penyakit']=this.penyakit;
    map['merokok']=this.merokok;
    map['pria']=this.pria;
    map['member']=this.member;
    map['jenisClub']=this.jenisClub;
    map['namaClub']=this.namaClub;
    map['propinsiClub']=this.propinsiClub;
    map['kotaClub']=this.kotaClub;
    map['kecamatanClub']=this.kecamatanClub;
    map['noClub']=this.noClub;
    map['created_at'] = this.created_at;
    return map;
  }

  String toString()
  {
    return "id:  ${this._id}, name:  ${this.name}, email: ${this.email}, mobile: ${this.mobile}";
  }
}