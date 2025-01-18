import 'package:flutter/material.dart';
import 'package:my_project/Authorized/addform.dart';
import 'package:my_project/Authorized/panduan.dart';
import 'package:my_project/services/api_service.dart';
import 'package:my_project/ui/landingpage.dart';
import 'package:file_picker/file_picker.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<dynamic>> _questions;
  int hoveredIndex = -1; // Variabel untuk melacak indeks yang di-hover
  List<dynamic> filteredQuestions = [];
  String searchQuery = '';
  bool isHoveringDataInformasi = false;
  bool isHoveringLogout = false;
  bool isHoveringPanduan = false;

  @override
  void initState() {
    super.initState();
    _questions = _apiService.getQuestionsWithAnswers();
  }

  Future<void> _pickAndUploadFile() async {
    try {
      // Buka dialog untuk memilih file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
        withData: true, // Tambahkan ini untuk mendapatkan 'bytes'
      );

      if (result != null) {
        // Ambil bytes dari file yang dipilih
        final bytes = result.files.single.bytes;

        // Periksa apakah bytes tidak null
        if (bytes != null) {
          // Ambil ekstensi file
          String? fileExtension = result.files.single.extension;

          // Validasi ekstensi file
          if (fileExtension != null && (fileExtension == 'xlsx')) {
            // Upload file ke server
            await _apiService.uploadExcel(bytes);
            print('File uploaded successfully!');
          } else {
            print('Invalid file extension.');
          }
        } else {
          print('File bytes are null.');
        }
      } else {
        print('No file selected.');
      }
    } catch (e) {
      print('Error: $e');
    }

    setState(() {
      _questions = _apiService.getQuestionsWithAnswers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 250,
            color: Colors.grey[300],
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Text(
                      'Chatty Muda',
                      style: TextStyle(
                        color: Color.fromARGB(255, 144, 36, 36),
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: ListView(
                    children: [
                      MouseRegion(
                        onEnter: (event) =>
                            setState(() => isHoveringDataInformasi = true),
                        onExit: (event) =>
                            setState(() => isHoveringDataInformasi = false),
                        child: ListTile(
                          leading: Icon(Icons.info,
                              color: isHoveringDataInformasi
                                  ? Colors.red
                                  : Colors.red[400]),
                          title: Text(
                            'Data Informasi',
                            style: TextStyle(
                              color: isHoveringDataInformasi
                                  ? Color.fromARGB(
                                      255, 255, 0, 0) // Warna merah saat hover
                                  : Colors.red[300],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MouseRegion(
                        onEnter: (event) =>
                            setState(() => isHoveringPanduan = true),
                        onExit: (event) =>
                            setState(() => isHoveringPanduan = false),
                        child: ListTile(
                          leading: Icon(Icons.menu_book_outlined,
                              color: isHoveringPanduan
                                  ? Colors.red
                                  : Colors.black),
                          title: Text(
                            'Panduan Form Excel',
                            style: TextStyle(
                              color: isHoveringPanduan
                                  ? Color.fromARGB(
                                      255, 255, 0, 0) // Warna merah saat hover
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PanduanScreen()),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      // ListTile untuk Logout
                      MouseRegion(
                        onEnter: (event) =>
                            setState(() => isHoveringLogout = true),
                        onExit: (event) =>
                            setState(() => isHoveringLogout = false),
                        child: ListTile(
                          leading: Icon(Icons.logout,
                              color:
                                  isHoveringLogout ? Colors.red : Colors.black),
                          title: Text(
                            'Logout',
                            style: TextStyle(
                              color:
                                  isHoveringLogout ? Colors.red : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LandingPage()),
                              (Route<dynamic> route) =>
                                  false, // Menghapus semua rute sebelumnya
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Konten Utama
          Expanded(
            child: Column(
              children: [
                // AppBar
                Container(
                  color: const Color.fromARGB(255, 74, 116, 74),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Data Informasi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // Konten
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddFormScreen()));
                              },
                              icon: const Icon(Icons.add, color: Colors.white),
                              label: const Text(
                                "Tambah Data",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                                backgroundColor:
                                    const Color.fromARGB(255, 74, 116, 74),
                              ),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton.icon(
                              onPressed: _pickAndUploadFile,
                              icon: const Icon(Icons.upload_file,
                                  color: Colors.white),
                              label: const Text("Import Excel",
                                  style: TextStyle(
                                    color: Colors.white,
                                  )),
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                                backgroundColor:
                                    const Color.fromARGB(255, 74, 116, 74),
                              ),
                            ),
                            const SizedBox(width: 700),
                            SizedBox(
                              width: 200,
                              child: TextField(
                                decoration: const InputDecoration(
                                  hintText: 'Cari Pertanyaan...',
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 12),
                                  isDense: true,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    searchQuery = value
                                        .toLowerCase(); // Simpan input pencarian
                                    _questions.then((questions) {
                                      filteredQuestions =
                                          questions.where((question) {
                                        final questionText =
                                            question['question_text']
                                                .toLowerCase();
                                        return questionText
                                            .contains(searchQuery);
                                      }).toList();
                                    });
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Bagian daftar data
                      Expanded(
                        child: Center(
                          child: Card(
                            color: Colors.grey[300],
                            elevation: 4,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: FutureBuilder<List<dynamic>>(
                                future: _questions,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text('Error: ${snapshot.error}'),
                                    );
                                  } else if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return const Center(
                                      child: Text('No data available'),
                                    );
                                  }

                                  final displayedQuestions = searchQuery.isEmpty
                                      ? snapshot.data!
                                      : filteredQuestions;

                                  if (searchQuery.isNotEmpty &&
                                      displayedQuestions.isEmpty) {
                                    return const Center(
                                      child: Text(
                                        'Data tidak ditemukan',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  }

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: displayedQuestions.length,
                                    itemBuilder: (context, index) {
                                      final question =
                                          displayedQuestions[index];
                                      final answers = question['answers'] ?? [];

                                      return MouseRegion(
                                        onEnter: (event) {
                                          setState(() {
                                            hoveredIndex = index;
                                          });
                                        },
                                        onExit: (event) {
                                          setState(() {
                                            hoveredIndex = -1;
                                          });
                                        },
                                        child: Card(
                                          color: hoveredIndex == index
                                              ? Colors.grey[100]
                                              : Colors.white,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Question: ${question['question_text']}',
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16.0,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 8.0),
                                                      ...answers.map<Widget>(
                                                          (answer) {
                                                        return Text(
                                                          'Answer: ${answer['answer_text']}',
                                                        );
                                                      }).toList(),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.edit),
                                                      onPressed: () {
                                                        TextEditingController
                                                            questionController =
                                                            TextEditingController(
                                                                text: question[
                                                                    'question_text']);
                                                        TextEditingController
                                                            answerController =
                                                            TextEditingController(
                                                                text: question['answers'] !=
                                                                            null &&
                                                                        question['answers']
                                                                            .isNotEmpty
                                                                    ? question['answers']
                                                                            [0][
                                                                        'answer_text']
                                                                    : '');

                                                        showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              AlertDialog(
                                                            backgroundColor:
                                                                const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    186,
                                                                    199,
                                                                    188),
                                                            title: const Text(
                                                                "Edit Data",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        18)),
                                                            content:
                                                                SingleChildScrollView(
                                                              child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            8.0),
                                                                    child:
                                                                        TextField(
                                                                      controller:
                                                                          questionController,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            'Pertanyaan',
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(12),
                                                                        ),
                                                                        filled:
                                                                            true,
                                                                        fillColor:
                                                                            Colors.grey[200],
                                                                      ),
                                                                      maxLines:
                                                                          2,
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            8.0),
                                                                    child:
                                                                        TextField(
                                                                      controller:
                                                                          answerController,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        labelText:
                                                                            'Jawaban',
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(12),
                                                                        ),
                                                                        filled:
                                                                            true,
                                                                        fillColor:
                                                                            Colors.grey[200],
                                                                      ),
                                                                      maxLines:
                                                                          4,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            actions: [
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                ),
                                                                child: const Text(
                                                                    "Batal",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                              ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  print(
                                                                      'Tombol Simpan ditekan');
                                                                  try {
                                                                    await _apiService
                                                                        .updateQuestion(
                                                                      question[
                                                                          'id'],
                                                                      {
                                                                        'question_text':
                                                                            questionController.text,
                                                                        'answer_text':
                                                                            answerController.text
                                                                      },
                                                                    );
                                                                    print(
                                                                        'Update berhasil');
                                                                    setState(
                                                                        () {
                                                                      _questions =
                                                                          _apiService
                                                                              .getQuestionsWithAnswers();
                                                                    });
                                                                    Navigator.pop(
                                                                        context);
                                                                  } catch (e) {
                                                                    print(
                                                                        'Terjadi kesalahan: $e');
                                                                  }
                                                                },
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                ),
                                                                child: const Text(
                                                                    "Simpan",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.delete),
                                                      onPressed: () async {
                                                        final confirm =
                                                            await showDialog<
                                                                bool>(
                                                          context: context,
                                                          builder: (context) =>
                                                              AlertDialog(
                                                            title: const Text(
                                                                'Konfirmasi Hapus'),
                                                            content: const Text(
                                                                'Apakah Anda yakin ingin menghapus pertanyaan ini?'),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(
                                                                            false),
                                                                child:
                                                                    const Text(
                                                                        'Batal'),
                                                              ),
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(
                                                                            true),
                                                                child:
                                                                    const Text(
                                                                        'Hapus'),
                                                              ),
                                                            ],
                                                          ),
                                                        );

                                                        if (confirm == true) {
                                                          try {
                                                            await _apiService
                                                                .deleteQuestion(
                                                                    question[
                                                                        'id']);
                                                            setState(() {
                                                              _questions =
                                                                  _apiService
                                                                      .getQuestionsWithAnswers();
                                                            });
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      'Pertanyaan berhasil dihapus')),
                                                            );
                                                          } catch (e) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                  content: Text(
                                                                      'Gagal menghapus pertanyaan: $e')),
                                                            );
                                                          }
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
