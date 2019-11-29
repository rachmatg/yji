import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yji5/style/theme.dart' as Theme;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:yji5/models/user_profile.dart';
import 'package:yji5/models/province.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mmkv_flutter/mmkv_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'package:yji5/service/firebase_firestore_service.dart';


class NewProfilePage extends StatefulWidget
{
  NewProfilePage({Key key}) : super(key: key);

  @override
  NewProfilePageState createState() => new NewProfilePageState();
}

class NewProfilePageState extends State<NewProfilePage> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  StreamSubscription<QuerySnapshot> noteSub;
  List<UserProfile> userProfiles;
  FirebaseFirestoreService db = new FirebaseFirestoreService();

  TextEditingController signupMobileController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupBirthDateController = new TextEditingController();
  TextEditingController signupBirthPlaceController = new TextEditingController();
  TextEditingController signupWeightController = new TextEditingController();
  TextEditingController signupHeightController = new TextEditingController();
  TextEditingController signupAddressController = new TextEditingController();
  TextEditingController signupClubTypeController = new TextEditingController();
  TextEditingController signupClubNameController = new TextEditingController();
  TextEditingController signupNoMemberController = new TextEditingController();
  TextEditingController signupKodePosController = new TextEditingController();

  Color left;
  Color right;
  final FocusNode myFocusNodeMobile= FocusNode();
  final FocusNode myFocusNodeBirthDate = FocusNode();
  final FocusNode myFocusNodePlaceDate = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();
  final FocusNode myFocusNodeWeight= FocusNode();
  final FocusNode myFocusNodeHeight = FocusNode();
  final FocusNode myFocusNodeAddress = FocusNode();
  final FocusNode myFocusNodeClubType = FocusNode();

  UserProfile userProfile = new UserProfile();
  ProvinceCity _provinceCity = new ProvinceCity();
  List provinceCityData = List();
  List citiesData = List();
  List kecamatanData = List();
  List clubNameDataKJR = List();
  List clubNameDataKJS = List();
  bool _merokok = false;
  bool _pria = false;
  bool _member = true;
  String jenisclub = 'Non Club';
  String golDarah ='O';
  String _myProvice;
  String _myCity;
  String _myProvinceClub;
  String _myCityClub;
  String _myRegionClub;
  String _namaClub;
  String penyakit1 = "Jantung";
  String penyakit2 = "Kolesterol";
  String penyakit3 = "Darah Tinggi";
  String penyakit4 = "Diabetes";
  List<dynamic> _listPenyakit;

  NewProfilePageState();


  bool isChecked(String value) => _listPenyakit.contains(value);

  @override
  void dispose() {
    myFocusNodeMobile.dispose();
    myFocusNodeBirthDate.dispose();
    myFocusNodeName.dispose();
    myFocusNodePlaceDate.dispose();
    myFocusNodeWeight.dispose();
    myFocusNodeHeight.dispose();
    myFocusNodeClubType.dispose();
    signupMobileController.dispose();
    signupNameController.dispose();
    signupEmailController.dispose();
    signupBirthDateController.dispose();
    signupBirthPlaceController.dispose();
    signupWeightController.dispose();
    signupHeightController.dispose();
    signupAddressController.dispose();
    signupClubTypeController.dispose();
    signupClubNameController.dispose();
    signupNoMemberController.dispose();
    signupKodePosController.dispose();
    noteSub?.cancel();
    super.dispose();
  }

  @override
  void initState()
  {
      userProfiles = new List();
      provinceCityData = _provinceCity.getProvince();
      citiesData = _provinceCity.getCities();
      kecamatanData = _provinceCity.getKecamatan();
      clubNameDataKJS = _provinceCity.getClubNameKJS();
      clubNameDataKJR = _provinceCity.getClubNameKJR();
      _listPenyakit = <String>[];
  }

  void showCheckedMenuSelections(String value) {
    if (_listPenyakit.contains(value))
      _listPenyakit.remove(value);
    else
      _listPenyakit.add(value);
  }

  Future _chooseDate(BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var initialDate = convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now) ? initialDate : now);

    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now());

    if (result == null) return;
    setState(() {
      signupBirthDateController.text = new DateFormat("dd/MM/yyyy").format(result);
    });
  }

  DateTime convertToDate(String input) {
    try
    {
      var d = new DateFormat("dd/MM/yyyy").parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            title: Text("Registrasi")
        ),
        key: _scaffoldKey,
        body: new Container (
            child: Form(
                key: _formKey,
                autovalidate: true,
                child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    children: <Widget>[
                      SizedBox(height:24.0),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        style: TextStyle(
                            fontFamily: "WorkSansSemi",
                            fontSize: Theme.Colors.text_size_profile,
                            color: Colors.black
                        ),
                        controller: signupNameController,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            icon: Icon(FontAwesomeIcons.user,
                                color: Colors.red),
                            hintText: 'Nama lengkap Anda',
                            labelText: 'Nama *',
                            enabledBorder: new UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,
                                  width: 1.0, style: BorderStyle.solid ),
                            )
                        ),
                        onSaved: (val)=>userProfile.name = val,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Nama tidak boleh kosong';
                          }
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                            fontFamily: "WorkSansSemi",
                            fontSize: Theme.Colors.text_size_profile,
                            color: Colors.black
                        ),
                        controller: signupEmailController,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            icon: Icon(Icons.email,
                                color: Colors.red),
                            hintText: 'Email Anda',
                            labelText: 'Email',
                            enabledBorder: new UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,
                                  width: 1.0, style: BorderStyle.solid ),
                            )
                        ),
                        onSaved: (val)=>userProfile.email = val,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: signupMobileController,
                        style: TextStyle(
                            fontFamily: "WorkSansSemi",
                            fontSize: Theme.Colors.text_size_profile,
                            color: Colors.black
                        ),
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            icon: Icon(FontAwesomeIcons.mobile,
                                color: Colors.red),
                            hintText: 'Nomor HP yang digunakan',
                            labelText: 'Nomor HP *',
                            //prefixText: '+62',
                            enabledBorder: new UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,
                                  width: 1.0, style: BorderStyle.solid ),
                            )
                        ),
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly,
                        ],
                        onSaved: (val)=>userProfile.mobile = '+62'+val,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'No HP wajib diisi.';
                          }
                        },
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.datetime,
                              controller: signupBirthDateController,
                              style: TextStyle(
                                  fontFamily: "WorkSansSemi",
                                  fontSize: Theme.Colors.text_size_profile,
                                  color: Colors.black
                              ),
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  icon: Icon(FontAwesomeIcons.calendar,
                                      color: Colors.red),
                                  hintText: 'Tgl Lahir',
                                  labelText: 'Tgl Lahir',
                                  enabledBorder: new UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white,
                                        width: 1.0, style: BorderStyle.solid ),
                                  )
                              ),
                              onSaved: (val)=>userProfile.dob = val,
                            ),
                          ),
                          IconButton(
                            icon: new Icon(Icons.date_range,color: Colors.red),
                            tooltip: 'Pilih Tanggal',
                            onPressed: (() {
                              _chooseDate(context, signupBirthDateController.text);
                            }),
                          )
                        ],
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: signupHeightController,
                        style: TextStyle(
                            fontFamily: "WorkSansSemi",
                            fontSize: Theme.Colors.text_size_profile,
                            color: Colors.black
                        ),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(Icons.vertical_align_top,//FontAwesomeIcons.arrowUp,
                                color: Colors.red),
                            hintText: 'Tinggi Badan (cm)',
                            labelText: 'Tinggi (cm)',
                            enabledBorder: new UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,
                                  width: 1.0, style: BorderStyle.solid ),
                            )
                        ),
                        onSaved: (val)=>userProfile.height = double.parse(val),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: signupWeightController,
                        style: TextStyle(
                            fontFamily: "WorkSansSemi",
                            fontSize: Theme.Colors.text_size_profile,
                            color: Colors.black
                        ),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(FontAwesomeIcons.weight,
                                color: Colors.red),
                            hintText: 'Berat Badan (kg)',
                            labelText: 'Berat (kg)',
                            enabledBorder: new UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,
                                  width: 1.0, style: BorderStyle.solid ),
                            )
                        ),
                        onSaved: (val)=>userProfile.weight = double.parse(val),
                      ),
                      SizedBox(height:24.0),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget> [
                            Icon(Icons.location_city,
                                color: Theme.Colors.icon_home,
                                size:Theme.Colors.icon_size_home),
                            Text('Alamat',
                              style: TextStyle(
                                  fontFamily: "WorkSansSemi",
                                  fontSize: Theme.Colors.text_size_profile,
                                  color: Colors.black
                              ),
                            ),
                          ]
                      ),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        textCapitalization: TextCapitalization.words,
                        controller: signupAddressController,
                        style: TextStyle(
                            fontFamily: "WorkSansSemi",
                            fontSize: Theme.Colors.text_size_profile,
                            color: Colors.black
                        ),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            //icon: Icon(Icons.place,//FontAwesomeIcons.searchLocation,
                            //    color: Colors.red),
                            hintText: 'Masukkan nama jalan',
                            labelText: 'Alamat (Nama Jalan)',
                            enabledBorder: new UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,
                                  width: 1.0, style: BorderStyle.solid ),
                            )
                        ),
                        maxLines: 3,
                        onSaved: (val)=>userProfile.address = val,
                      ),
                      Row(
                        children: <Widget>[
                          Text("Propinsi",
                              style: TextStyle(
                                  fontFamily: "WorkSansSemi",
                                  fontSize: Theme.Colors.text_size_profile,
                                  color: Colors.black
                              )
                          ),
                          Spacer(),
                          DropdownButton(
                            style: TextStyle(
                                fontFamily: "WorkSansSemi",
                                fontSize: Theme.Colors.text_size_profile,
                                color: Colors.black
                            ),
                            hint: Text('Pilih Provinsi'),
                            items: provinceCityData.map((item){
                              //print(item);
                              return new DropdownMenuItem(
                                child: new Text(item['name']),
                                value: item['id'].toString(),
                              );
                            }).toList(),
                            onChanged: (newVal) {
                              setState(() {
                                _myProvice = newVal;
                                userProfile.propinsi = newVal;
                                userProfile.kota = null;
                                _myCity = null;
                              });
                            },
                            value: _myProvice,

                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text("Kab/Kota",
                              style: TextStyle(
                                  fontFamily: "WorkSansSemi",
                                  fontSize: Theme.Colors.text_size_profile,
                                  color: Colors.black
                              )
                          ),
                          Spacer(),
                          DropdownButton(
                            style: TextStyle(
                                fontFamily: "WorkSansSemi",
                                fontSize: Theme.Colors.text_size_profile,
                                color: Colors.black
                            ),
                            hint: Text('Pilih Kota'),
                            items: citiesData.where((d)=>d['state_id']==_myProvice).map((item){
                              //print(item);
                              return new DropdownMenuItem(
                                child: new Text(item['name']),
                                value: item['id'].toString(),
                              );
                            }).toList(),
                            onChanged: (newVal) {
                              setState(() {
                                _myCity= newVal;
                                userProfile.kota = newVal;
                              });
                            },
                            value: _myCity,
                          ),
                        ],
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization.words,
                        controller: signupKodePosController,
                        style: TextStyle(
                            fontFamily: "WorkSansSemi",
                            fontSize: Theme.Colors.text_size_profile,
                            color: Colors.black
                        ),
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Kode Pos',
                            labelText: 'Kode Pos',
                            enabledBorder: new UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,
                                  width: 1.0, style: BorderStyle.solid ),
                            )
                        ),
                        onSaved: (val)=>userProfile.kodepos = val,
                      ),
/*                TextFormField(
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  controller: signupBirthPlaceController,
                  style: TextStyle(
                      fontFamily: "WorkSansSemi",
                      fontSize: Theme.Colors.text_size_profile,
                      color: Colors.black
                  ),
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      icon: Icon(Icons.add_location,//FontAwesomeIcons.mapPin,
                          color: Colors.red),
                      hintText: 'Masukkan kota kelahiran',
                      labelText: 'Tempat Lahir',
                      enabledBorder: new UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white,
                            width: 1.0, style: BorderStyle.solid ),
                      )
                  ),
                  onSaved: (val)=>userProfile.pob = val,
                ),*/
                      SizedBox(height: 24.0,),
                      SwitchListTile(
                        title: Text(_merokok?'Merokok':'Tidak merokok',
                            style: TextStyle(
                                fontFamily: "WorkSansSemi",
                                fontSize: Theme.Colors.text_size_profile,
                                color: Colors.black
                            )
                        ),
                        selected: _merokok,
                        secondary: const Icon(Icons.smoking_rooms,
                            color: Colors.red
                        ),
                        value: _merokok,
                        onChanged: (i) {
                          if (i) {
                            setState(() {
                              _merokok = true;
                              userProfile.merokok = true;
                            });
                          } else {
                            setState(() {
                              _merokok = false;
                              userProfile.merokok = false;
                            });
                          }
                        },
                      ),
                      SwitchListTile(
                        title: Text(_pria?'Pria':'Wanita',
                            style: TextStyle(
                                fontFamily: "WorkSansSemi",
                                fontSize: Theme.Colors.text_size_profile,
                                color: Colors.black
                            )
                        ),
                        selected: _pria,
                        secondary: const Icon(Icons.people,
                            color: Colors.red
                        ),
                        value: _pria,
                        onChanged: (i) {
                          if (i) {
                            setState(() {
                              _pria = true;
                              userProfile.pria = true;
                            });
                          } else {
                            setState(() {
                              _pria = false;
                              userProfile.pria = false;
                            });
                          }
                        },
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: new Icon(Icons.add_circle,
                                color: Colors.red),
                          ),
                          Text("Golongan Darah",
                              style: TextStyle(
                                  fontFamily: "WorkSansSemi",
                                  fontSize: Theme.Colors.text_size_profile,
                                  color: Colors.black
                              )
                          ),
                          Spacer(),
                          DropdownButton(
                            hint:Text('Gol Darah'),
                            items: [
                              DropdownMenuItem(
                                child:const Text('A'),
                                value: 'A',
                              ),
                              DropdownMenuItem(
                                child:const Text('B'),
                                value: 'B',
                              ),
                              DropdownMenuItem(
                                child:const Text('AB'),
                                value: 'AB',
                              ),
                              DropdownMenuItem(
                                child:const Text('O'),
                                value: 'O',
                              ),
                            ],
                            value: golDarah,
                            onChanged: (T){
                              setState(
                                      (){
                                    golDarah= T;
                                    userProfile.golDarah = golDarah;
                                  }
                              );
                            },
                            elevation: 24,
                            style: TextStyle(
                                fontFamily: "WorkSansSemi",
                                fontSize: Theme.Colors.text_size_profile,
                                color: Colors.black
                            ),
                          ),
                        ],
                      ),
                      ListTile(
                        title:Text('Jenis Penyakit'),
                        leading: const Icon(Icons.child_care, color: Colors.red),
                        trailing:PopupMenuButton<String>(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.arrow_drop_down),
                            onSelected: showCheckedMenuSelections,
                            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                              CheckedPopupMenuItem<String>(
                                  value: penyakit1,
                                  checked: isChecked(penyakit1),
                                  child: Text(penyakit1)
                              ),
                              CheckedPopupMenuItem<String>(
                                  value: penyakit2,
                                  enabled: false,
                                  checked: isChecked(penyakit2),
                                  child: Text(penyakit2)
                              ),
                              CheckedPopupMenuItem<String>(
                                  value: penyakit3,
                                  checked: isChecked(penyakit3),
                                  child: Text(penyakit3)
                              ),
                              CheckedPopupMenuItem<String>(
                                  value: penyakit4,
                                  checked: isChecked(penyakit4),
                                  child: Text(penyakit4)
                              ),
                            ]
                        ),
                      ),
                      Text(_listPenyakit.toString(), style: TextStyle(color: Colors.grey)),
                      SizedBox(height: 24.0,),
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: new Icon(Icons.healing,
                                color: Colors.red),
                          ),
                          Text("Jenis Klub",
                              style: TextStyle(
                                  fontFamily: "WorkSansSemi",
                                  fontSize: Theme.Colors.text_size_profile,
                                  color: Colors.black
                              )
                          ),
                          Spacer(),
                          DropdownButton(
                            hint:Text('Jenis Club'),
                            items: [
                              DropdownMenuItem(
                                child:const Text('Non Club'),
                                value: 'Non Club',
                              ),
                              DropdownMenuItem(
                                child:const Text('KJS'),
                                value: 'KJS',
                              ),
                              DropdownMenuItem(
                                child:const Text('KJR'),
                                value: 'KJR',
                              ),
                            ],
                            value: jenisclub,
                            onChanged: (T){
                              setState(
                                      (){
                                    jenisclub= T;
                                    userProfile.jenisClub = jenisclub;
                                    _myProvinceClub = null;
                                    _myCityClub = null;
                                    _myRegionClub = null;
                                    _namaClub = null;
                                  }
                              );
                            },
                            elevation: 24,
                            style: TextStyle(
                                fontFamily: "WorkSansSemi",
                                fontSize: Theme.Colors.text_size_profile,
                                color: Colors.black
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.0),
                      jenisclub=='Non Club'?Container():buildClubName(),
                      RaisedButton.icon(
                        highlightColor: Colors.transparent,
                        splashColor: Theme.Colors.loginGradientEnd,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                        label: new Text('Rekam',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: Theme.Colors.text_size_profile,
                                fontFamily: "WorkSansSemi")
                        ),
                        icon: Icon(Icons.save),
                        onPressed: _submitForm,
                      ),
                      SizedBox(height: 24.0),

                    ]
                )
            )
        )
    );
  }

  Widget buildClubName()
  {
    return Container(
        child: CustomPaint(
            child:Column(
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget> [
                        Icon(Icons.location_city,
                            color: Theme.Colors.icon_home,
                            size:Theme.Colors.icon_size_home),
                        Text('Alamat Klub',
                          style: TextStyle(
                              fontFamily: "WorkSansSemi",
                              fontSize: Theme.Colors.text_size_profile,
                              color: Colors.black
                          ),
                        ),
                      ]
                  ),
                  Row(
                    children: <Widget>[
                      Text("Propinsi",
                          style: TextStyle(
                              fontFamily: "WorkSansSemi",
                              fontSize: Theme.Colors.text_size_profile,
                              color: Colors.black
                          )
                      ),
                      Spacer(),
                      DropdownButton(
                        style: TextStyle(
                            fontFamily: "WorkSansSemi",
                            fontSize: Theme.Colors.text_size_profile,
                            color: Colors.black
                        ),
                        hint: Text('Pilih Propinsi'),
                        items: provinceCityData.map((item){
                          //print(item);
                          return new DropdownMenuItem(
                            child: new Text(item['name']),
                            value: item['id'].toString(),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            _myProvinceClub = newVal;
                            userProfile.propinsiClub = newVal;
                            userProfile.kotaClub = null;
                            _myCityClub = null;
                            _myRegionClub = null;
                            _namaClub = null;
                          });
                        },
                        value: _myProvinceClub,

                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Kota",
                          style: TextStyle(
                              fontFamily: "WorkSansSemi",
                              fontSize: Theme.Colors.text_size_profile,
                              color: Colors.black
                          )
                      ),
                      Spacer(),
                      DropdownButton(
                        style: TextStyle(
                            fontFamily: "WorkSansSemi",
                            fontSize: Theme.Colors.text_size_profile,
                            color: Colors.black
                        ),
                        hint: Text('Pilih Kota'),
                        items: citiesData.where((d)=>d['state_id']==_myProvinceClub).map((item){
                          //print(item);
                          return new DropdownMenuItem(
                            child: new Text(item['name']),
                            value: item['id'].toString(),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            _myCityClub = newVal;
                            //print(_myCityClub );
                            userProfile.kotaClub = newVal;
                            _namaClub = null;
                            _myRegionClub = null;
//                      print(userProfile.kotaClub);
                          });
                        },
                        value: _myCityClub,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Kecamatan",
                          style: TextStyle(
                              fontFamily: "WorkSansSemi",
                              fontSize: Theme.Colors.text_size_profile,
                              color: Colors.black
                          )
                      ),
                      Spacer(),
                      DropdownButton(
                        style: TextStyle(
                            fontFamily: "WorkSansSemi",
                            fontSize: Theme.Colors.text_size_profile,
                            color: Colors.black
                        ),
                        hint: Text('Pilih Kecamatan'),
                        items: kecamatanData.where((d)=>d['city_id']==_myCityClub).map((item){
                          //print(item);
                          return new DropdownMenuItem(
                            child: new Text(item['name']),
                            value: item['id'].toString(),
                          );
                        }).toList(),
                        onChanged: (newVal) {
                          setState(() {
                            _myRegionClub = newVal;
                            userProfile.kecamatanClub= newVal;
                            _namaClub = null;
//                      print(userProfile.kotaClub);
                          });
                        },
                        value: _myRegionClub,
                      ),
                    ],
                  ),
                  Row(
                      children: <Widget>[
                        Text("Nama Klub",
                            style: TextStyle(
                                fontFamily: "WorkSansSemi",
                                fontSize: Theme.Colors.text_size_profile,
                                color: Colors.black
                            )
                        ),
                        Spacer(),
                        DropdownButton(
                            style: TextStyle(
                                fontFamily: "WorkSansSemi",
                                fontSize: Theme.Colors.text_size_profile,
                                color: Colors.black
                            ),
                            hint: Text('Nama Klub'),
                            items: (jenisclub=='KJS'?clubNameDataKJS:clubNameDataKJR).where((d)=>d['region_id']==_myRegionClub).map((item){
                              //print(item);
                              return new DropdownMenuItem(
                                child: new Text(item['name']),
                                value: item['id'].toString(),
                              );
                            }).toList(),
                            onChanged: (newVal) {
                              setState(() {
                                _namaClub = newVal;//userProfile.namaClub= newVal;
                              });
                            },
                            value: _namaClub//userProfile.namaClub,
                        ),
                      ]
                  ),
                  SwitchListTile(
                    title: Text(_member?'Member':'Instruktur',
                        style: TextStyle(
                            fontFamily: "WorkSansSemi",
                            fontSize: Theme.Colors.text_size_profile,
                            color: Colors.black
                        )
                    ),
                    selected: _member,
                    secondary: const Icon(Icons.card_membership,
                        color: Colors.red
                    ),
                    value: _member,
                    onChanged: (i) {
                      if (i) {
                        setState(() {
                          _member = true;
                          userProfile.member = true;
                        });
                      } else {
                        setState(() {
                          _member = false;
                          userProfile.member = false;
                        });
                      }
                    },
                  ),
                  _member?Container():
                  TextFormField(
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    controller: signupNoMemberController,
                    style: TextStyle(
                        fontFamily: "WorkSansSemi",
                        fontSize: Theme.Colors.text_size_profile,
                        color: Colors.black
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(FontAwesomeIcons.objectGroup,
                            color: Colors.red),
                        hintText: 'Nomor Instruktur',
                        enabledBorder: new UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,
                              width: 1.0, style: BorderStyle.solid ),
                        )
                    ),
                    onSaved: (val)=>userProfile.noInstruktur = val,
                    /*validator: (value) {
                      if ((value.isEmpty) && (!_member)) {
                        return 'Nomor tidak boleh kosong';
                      }
                    }*/
                  ),
                ]
            )
        )
    );
  }

  final Firestore firestore = Firestore.instance;

  Future<void> _updateMMKV() async {
    MmkvFlutter mmkv = await MmkvFlutter.getInstance();
    await mmkv.setString('phone','+62' + signupMobileController.text);
  }

  Future<void> _addUser(UserProfile user) async {
    // ignore: extra_positional_arguments_could_be_named
    //print(signupNameController.text);
    db.createUser(
        name: signupNameController.text,
        email: signupEmailController.text,
        address: signupAddressController.text,
        kota: _myCity,
        propinsi: _myProvice,
        kodepos: signupKodePosController.text,
        weight: double.parse(signupWeightController.text),
        height: double.parse(signupHeightController.text),
        pria: _pria,
        golDarah: golDarah,
        //pob: signupBirthPlaceController.text,
        dob: signupBirthDateController.text,
        merokok: _merokok,
        penyakit: json.encode(_listPenyakit),
        mobile: '+62' + signupMobileController.text,
        jenisClub: jenisclub,
        member: _member,
        namaClub: _namaClub,
        noInstruktur: signupNoMemberController.text,
        propinsiClub: _myProvinceClub,
        kotaClub: _myCityClub,
        kecamatanClub: _myRegionClub,
        noClub: signupNoMemberController.text,
        created_at: DateTime.now().toString()
    ).whenComplete(() {
      print("Selesai");
    });
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

/*    await user_profile.add(<String, dynamic>{
    });
    await mmkv.setString('email',signupEmailController.text);
  }
*/
  void _submitForm() {
    final FormState form = _formKey.currentState;
    form.save(); //This invokes each onSaved event
    _addUser(userProfile).catchError((e){
      print("Error $e");
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Rekaman Error. Silakan ulangi.")));
    }).whenComplete(() {
      _updateMMKV();
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Rekaman Selesai. Silakan kembali.")));
      //Navigator.pop(context);
    });
  }
}
