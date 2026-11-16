Nama : Rama

NPM : 2506606490

Kelas : PBP D


## Instruksi Setup Menjalankan Proyek
Untuk run proyek aplikasi mobile Flutter ini secara lokal, lakukan langkah-langkah berikut:
1. Pull versi terbaru atau clone repositori ini.
2. Buka terminal dan arahkan ke dalam root direktori proyek (`myportofolio_mobile`).
3. Pastikan Flutter SDK sudah terinstal dan terdaftar di PATH, lalu cek dengan command: `flutter doctor`
4. Unduh seluruh dependensi proyek dengan command: `flutter pub get`
5. Cek kebersihan kode dengan command: `flutter analyze` (harus menampilkan "No issues found!")
6. Jalankan aplikasi di Google Chrome dengan command: `flutter run -d chrome`
7. Untuk menjalankan di Android Emulator atau perangkat fisik (USB Debugging aktif), pastikan perangkat terdeteksi lewat `flutter devices`, lalu jalankan: `flutter run`
8. Saat aplikasi berjalan, tekan `r` di terminal untuk Hot Reload atau `R` untuk Hot Restart.

### Tugas 7

1. Widget tree adalah susunan widget berbentuk pohon. Di Flutter hampir semua tampilan adalah widget dan sebuah widget bisa berisi widget lain. Widget yang membungkus disebut parent dan yang dibungkus disebut child. Di proyek ini, akarnya adalah `MaterialApp` yang punya child `MyHomePage`, lalu `Scaffold`, lalu `AppBar` dan `Padding` yang berisi `Column`, dan seterusnya sampai ke `InfoCard` dan `ItemCard`. Parent yang memberi batas ukuran dan menentukan posisi child-nya, sedangkan data diturunkan dari parent ke child lewat konstruktor, contohnya `InfoCard(title: 'NPM', content: npm)`. Kalau ada yang perlu berubah, Flutter hanya membangun ulang bagian pohon yang terkait.

2. Widget yang saya gunakan di proyek ini:
   - `MyApp`: widget root buatan sendiri yang mengembalikan `MaterialApp`.
   - `MaterialApp`: pembungkus aplikasi bergaya Material, mengatur tema dan halaman awal (`home`).
   - `MyHomePage`: halaman menu utama yang merakit seluruh tampilan.
   - `Scaffold`: kerangka dasar halaman (AppBar, body, dan tempat SnackBar muncul).
   - `AppBar`: bar judul di bagian atas halaman.
   - `Text`: menampilkan teks seperti judul kartu, isi kartu, pesan sambutan, dan nama tombol.
   - `Padding`: memberi jarak di sekeliling child, juga dipakai sebagai spasi kecil antara ikon dan teks.
   - `Column`: menyusun child secara vertikal.
   - `Row`: menyusun tiga `InfoCard` secara horizontal.
   - `SizedBox`: memberi jarak kosong dengan ukuran tetap.
   - `Center`: menaruh child di tengah.
   - `GridView.count`: menampilkan tombol dalam kisi 3 kolom.
   - `InfoCard`: widget reusable buatan sendiri untuk kartu NPM, Name, dan Class.
   - `Card`: kartu ber-elevasi yang menjadi dasar `InfoCard`.
   - `Container`: kotak yang mengatur lebar dan padding di dalam `InfoCard` dan `ItemCard`.
   - `ItemCard`: widget reusable buatan sendiri untuk tombol aksi.
   - `Material`: permukaan yang memberi warna latar (`item.color`) dan sudut membulat pada `ItemCard`.
   - `InkWell`: area yang bisa ditekan dengan efek ripple dan menjalankan `onTap`.
   - `Icon`: menampilkan ikon pada tombol.
   - `ScaffoldMessenger` dan `SnackBar`: menampilkan pesan singkat di bawah layar saat tombol ditekan.

   `ItemHomepage` bukan widget, tapi kelas model yang menyimpan nama, ikon, dan warna tiap tombol.

3. `MaterialApp` berfungsi menyiapkan hal-hal yang dibutuhkan aplikasi bergaya Material Design, seperti tema (`ThemeData` dan `colorScheme`), navigasi antarhalaman, `MediaQuery`, dan `ScaffoldMessenger` yang dipakai oleh `SnackBar`. Lewat properti `home` kita menentukan halaman pertama yang tampil, yaitu `MyHomePage`. Widget seperti `Scaffold`, `AppBar`, `Card`, dan `SnackBar` mengambil tema dan konteks dari widget di atasnya. Karena itu `MaterialApp` ditaruh sebagai root supaya semua widget di bawahnya bisa mengakses tema dan navigasi yang sama.

4. `StatelessWidget` adalah widget yang tampilannya hanya bergantung pada data yang diterimanya dan tidak punya state yang berubah. `StatefulWidget` punya objek `State` yang bertahan antar-rebuild, dan tampilannya diperbarui dengan `setState()`. Kita memilih `StatelessWidget` untuk tampilan yang statis, seperti `MyHomePage`, `InfoCard`, dan `ItemCard` di proyek ini karena datanya tetap. Kita memakai `StatefulWidget` kalau ada data lokal yang berubah dan memengaruhi tampilan, contohnya counter bawaan Flutter yang angkanya bertambah saat tombol ditekan, isian form, atau animasi.

5. `BuildContext` adalah penanda posisi sebuah widget di dalam widget tree. Dengan context, sebuah widget bisa mencari data atau widget di atasnya (ancestor), misalnya lewat `Theme.of(context)`, `MediaQuery.of(context)`, dan `ScaffoldMessenger.of(context)`. Context ini diberikan Flutter sebagai parameter di method `build(BuildContext context)`. Di proyek ini, `MyHomePage` memakai `Theme.of(context).colorScheme.primary` untuk warna `AppBar`, `InfoCard` memakai `MediaQuery.of(context).size.width / 3.5` untuk lebar kartu, dan `ItemCard` memakai `ScaffoldMessenger.of(context)` untuk menampilkan `SnackBar`.

6. Hot reload memasukkan kode Dart yang baru ke aplikasi yang sedang berjalan lalu membangun ulang tampilannya, dan state aplikasi tetap dipertahankan sehingga prosesnya sangat cepat. Hot restart memuat ulang seluruh kode dan menjalankan `main()` dari awal sehingga state hilang, tapi masih lebih cepat daripada menjalankan ulang aplikasi. Kita tidak bisa hanya mengandalkan hot reload ketika mengubah `main()`, variabel global atau static, `initState`, atau mengubah `StatefulWidget` menjadi `StatelessWidget` (seperti yang dilakukan di Tutorial 08) karena butuh hot restart. Full restart (stop lalu `flutter run` lagi) diperlukan ketika mengubah `pubspec.yaml` (dependensi atau aset) atau konfigurasi native seperti `AndroidManifest.xml` dan Gradle.


#### Disclosure AI
Saya menggunakan Claude AI untuk membantu dalam pembuatan dokumentasi di README.md, terutama dalam pembuatan instruksi untuk menjalankan projek ini di lokal.
https://claude.ai/share/044cf670-3a92-4bc6-a097-09955270dcf0