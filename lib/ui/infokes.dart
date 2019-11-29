import 'package:flutter/material.dart';
import 'package:yji5/style/theme.dart' as Theme;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yji5/ui/login_page.dart';
import 'package:flutter_html/flutter_html.dart';

class InfokesPage extends StatelessWidget {
  String html= '<p><img src="http://www.inaheart.or.id/wp-content/uploads/49333774-e0cd-406f-a8cf-8fc7bf9cb821.jpg"/></p>'
      '<p style="text-align: left;">Jakarta, 05 September 2018. Yayasan Jantung Indonesia (YJI) hari ini melantik Ketua Umum Baru untuk masa bakti 2018-2023. Ketua Umum baru, Esti Nurjadin yang dilantik oleh Dewan Pembina dan disaksikan oleh jajaran Pengurus, Pengawas dan Pembina YJI, menggantikan Syahlina Zuhal yang telah menyelesaikan periode masa baktinya di tahun 2018 ini.</p>'
  '<p style="text-align: left;">“Ini merupakan suatu tugas yang sangat mulia. Saya merasa sangat terhormat dan berterima kasih atas keputusan Yayasan Jantung Indonesia telah mempercayakan jabatan Ketua Umum kepada saya. Tentunya dalam mengemban jabatan ini saya akan meneruskan legacy Yayasan yang telah didirikan sejak 1974 dan saya tetap membutuhkan bimbingan senior pendahulu saya maupun pengurus lainnya serta jajaran pendukung nantinya”, ujar Esti Nurjadin, Ketua Umum Yayasan Jantung Indonesia yang baru saja diangkat dan dilantik.</p>'
  '<p style="text-align: left;">Pelantikan dan pengukuhan Ketua Umum serta pengurus Yayasan Jantung Indonesia tersebut, berlangsung di Kantor Pusat YJI, Jl. Teuku Umar no 8, Menteng, Jakarta, dan dihadiri oleh para pengurus lama dan pengurus baru yang ditunjuk.</p>'
  '<p style="text-align: left;">“Visi Yayasan jantung sebagai pelopor gaya hidup sehat akan kami kembangkan lebih luas lagi dalam penerapannya. Dengan merangkul berbagai pihak, komunitas muda dan para millennial agar memiliki kesadaran sejak dini serta menularkannya kepada kawan-kawan mereka”, imbuh Esti.</p>'
  '<p style="text-align: left;">Sesuai dengan komitmen, visi dan misi Yayasan Jantung Indonesia, memang sasaran program promotif dan preventif YJI adalah kelompok usia remaja, anak-anak, dan perempuan, serta program kuratif YJI menjangkau anak-anak yang lahir dengan penyakit jantung bawaan dari keluarga prasejahtera, sehingga mereka memiliki harapan masa depan.</p>'
  '<p style="text-align: left;">Esti menuturkan bahwa dalam rangka menyongsong bonus demografis Indonesia di tahun 2030 yang akan datang, Yayasan Jantung Indonesia harus meningkatkan kesadaran akan gaya hidup sehat kelompok usia remaja dan anak-anak, agar Indonesia memiliki kelompok usia produktif yang sehat sehingga dapat mendorong roda perekonomian Indonesia. Tentunya tetap melaksanakannya dengan tata kelola organisasi berpegang pada prinsip good governance, dan di dalam jajarannya Esti akan membuat YJI lebih lini dan dikelola secara professional melibatkan generasi yang lebih muda. Bersama YJI akan terus membangun kemitraan dengan seluruh pemangku kepentingan agar ke depannya dapat merangkul lebih banyak pihak dan membantu lebih banyak lagi pasien jantung dari</p>'
  '<p style="text-align: left;">SiaranPers_Pelantikan Ketua Umum Baru 2018-2023_YJI | 2</p>'
  '<p style="text-align: left;">keluarga prasejahtera serta mengangkat YJI menjadi sebuah yayasan sosial di bidang kesehatan yang makin berpengaruh.</p>'
  '<p style="text-align: left;">Sementara itu, Syahlina Zuhal menyampaikan selamat bekerja kepada pengurus yang baru dengan semangat dan darah yang baru, yang diharapkan dapat memberikan warna yang lebih baik bagi Yayasan Jantung Indonesia.</p>'
      '<p style="text-align: left;">*****<br />'
      'Tentang Esti Nurjadin Esti Nurjadin yang lahir pada 20 Oktober 1972 ini telah bergabung dengan Yayasan Jantung Indonesia sejak 2010 pernah menjabat bidang dan sebagai anggota Divisi Komunikasi Informasi dan Edukasi (KIE), pada Divisi Hubungan Masyarakat dan terakhir sebagai Ketua Divisi Pengembangan Dana. Latar belakang pendidikan di bidang hukum, mendapatkan gelar Sarjana Hukum dari Universitas Indonesia pada tahun 1995 dan gelar MKn (Magister Kenotariatan) dari Universitas Indonesia di tahun 2006. Keseharian Esti adalah sebagai pemilik dan pengelola D Gallerie yang mengangkat seniman-seniman muda Indonesia agar karya-karyanya lebih diapresiasi baik di Indonesia dan bahkan membawa mereka untuk ikut berpameran di kancah seni internasional serta ikut mengembangkan senirupa kontemporer di Indonesia</p>';
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: Text("Info Kesehatan")
      ),
      body: new Container (
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Center(
              child: new Html(data: html)
          ),
        ),
      ),
    );
  }
}