import 'package:flutter/material.dart';
import 'package:my_project/Authorized/addform.dart';
import 'package:my_project/services/api_service.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<dynamic>> _questions;
  int hoveredIndex = -1; // Variabel untuk melacak indeks yang di-hover

  @override
  void initState() {
    super.initState();
    _questions = _apiService.getQuestionsWithAnswers();
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
                      ListTile(
                        leading: const Icon(Icons.info, color: Colors.black),
                        title: const Text(
                          'Data Informasi',
                          style: TextStyle(
                              color: Color.fromARGB(255, 164, 4, 4),
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        leading: const Icon(Icons.logout, color: Colors.black),
                        title: const Text('Logout',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        onTap: () {},
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Data Informasi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage(
                                'assets/images/user.png'), // Path ke gambar profil
                            radius: 16,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Hai, Admin!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
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
                            SizedBox(
                              width: 200,
                              child: TextField(
                                decoration: const InputDecoration(
                                  hintText: 'Cari Data',
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 12),
                                  isDense: true,
                                ),
                                onChanged: (value) {},
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
                            color: const Color.fromARGB(255, 191, 204, 193),
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

                                  final questions = snapshot.data!;
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: questions.length,
                                    itemBuilder: (context, index) {
                                      final question = questions[index];
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
                                              ? Colors.grey[300]
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
                                                                child:
                                                                    const Text(
                                                                  "Batal",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
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
                                                              ),
                                                              ElevatedButton(
                                                                onPressed:
                                                                    () async {
                                                                  await _apiService
                                                                      .updateQuestion(
                                                                    question[
                                                                        'id'],
                                                                    {
                                                                      'question_text':
                                                                          questionController
                                                                              .text,
                                                                      'answers':
                                                                          [
                                                                        {
                                                                          'answer_text':
                                                                              answerController.text
                                                                        }
                                                                      ],
                                                                    },
                                                                  );
                                                                  setState(() {
                                                                    _questions =  _apiService.getQuestionsWithAnswers();
                                                                  });
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    const Text(
                                                                  "Simpan",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
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
