import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class AcademicFormPage extends StatefulWidget {
  const AcademicFormPage({super.key});

  @override
  State<AcademicFormPage> createState() => _AcademicFormPageState();
}

class _AcademicFormPageState extends State<AcademicFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _institutionController = TextEditingController();
  final _startYearController = TextEditingController();
  final _endYearController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _logoUrlController = TextEditingController();
  final _orderController = TextEditingController();

  bool _isOngoing = false;

  @override
  void dispose() {
    _institutionController.dispose();
    _startYearController.dispose();
    _endYearController.dispose();
    _descriptionController.dispose();
    _logoUrlController.dispose();
    _orderController.dispose();
    super.dispose();
  }

  InputDecoration _decoration(
    String label, {
    String? hint,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
    );
  }

  Future<void> _pickYear(TextEditingController controller) async {
    final now = DateTime.now();
    final initialYear = int.tryParse(controller.text) ?? now.year;

    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(initialYear),
      firstDate: DateTime(1970),
      lastDate: DateTime(now.year + 10),
      initialDatePickerMode: DatePickerMode.year,
    );

    if (picked == null || !mounted) return;
    setState(() {
      controller.text = picked.year.toString();
    });
  }

  String? _validateInstitution(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Nama institusi tidak boleh kosong!';
    }
    if (text.length < 3) {
      return 'Nama institusi minimal 3 karakter!';
    }
    if (text.length > 100) {
      return 'Nama institusi maksimal 100 karakter!';
    }
    return null;
  }

  String? _validateStartYear(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Tahun mulai wajib dipilih!';
    }
    return null;
  }

  String? _validateEndYear(String? value) {
    if (_isOngoing) return null;

    if (value == null || value.trim().isEmpty) {
      return "Tahun selesai wajib dipilih atau aktifkan 'Masih berlangsung'!";
    }
    final start = int.tryParse(_startYearController.text);
    final end = int.tryParse(value);
    if (start != null && end != null && end < start) {
      return 'Tahun selesai tidak boleh lebih awal dari tahun mulai!';
    }
    return null;
  }

  String? _validateDescription(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Deskripsi tidak boleh kosong!';
    }
    if (text.length < 10) {
      return 'Deskripsi minimal 10 karakter!';
    }
    if (text.length > 500) {
      return 'Deskripsi maksimal 500 karakter!';
    }
    return null;
  }

  String? _validateLogoUrl(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return null;

    final uri = Uri.tryParse(text);
    final isValid =
        uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
    if (!isValid) {
      return 'URL logo harus diawali http:// atau https:// dan valid!';
    }
    return null;
  }

  String? _validateOrder(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) {
      return 'Urutan tidak boleh kosong!';
    }
    final order = int.tryParse(text);
    if (order == null) {
      return 'Urutan harus berupa angka bulat!';
    }
    if (order < 0 || order > 999) {
      return 'Urutan harus antara 0 sampai 999!';
    }
    return null;
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _isOngoing = false;
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final institution = _institutionController.text.trim();
    final period =
        '${_startYearController.text} - ${_isOngoing ? 'Present' : _endYearController.text}';
    final description = _descriptionController.text.trim();
    final logoUrl = _logoUrlController.text.trim();
    final order = _orderController.text.trim();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Data akademik berhasil ditambahkan!'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Institusi: $institution'),
                const SizedBox(height: 8),
                Text('Periode: $period'),
                const SizedBox(height: 8),
                Text('Deskripsi: $description'),
                const SizedBox(height: 8),
                Text('URL Logo: ${logoUrl.isEmpty ? '-' : logoUrl}'),
                const SizedBox(height: 8),
                Text('Urutan: $order'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Tutup'),
              onPressed: () {
                Navigator.pop(context);
                _resetForm();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Academic Form'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Institution / School Name ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _institutionController,
                  decoration: _decoration(
                    'Nama Institusi / Sekolah',
                    hint: 'Contoh: Universitas Indonesia',
                  ),
                  validator: _validateInstitution,
                ),
              ),

              // === Start Year ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _startYearController,
                  readOnly: true,
                  onTap: () => _pickYear(_startYearController),
                  decoration: _decoration(
                    'Tahun Mulai',
                    hint: 'Pilih tahun mulai',
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  validator: _validateStartYear,
                ),
              ),

              // === Ongoing Switch ===
              SwitchListTile(
                title: const Text('Masih berlangsung (Present)'),
                value: _isOngoing,
                onChanged: (bool value) {
                  setState(() {
                    _isOngoing = value;
                    if (value) _endYearController.clear();
                  });
                },
              ),

              // === End Year ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  key: ValueKey(_isOngoing),
                  controller: _endYearController,
                  readOnly: true,
                  enabled: !_isOngoing,
                  onTap: () => _pickYear(_endYearController),
                  decoration: _decoration(
                    'Tahun Selesai',
                    hint: _isOngoing ? 'Present' : 'Pilih tahun selesai',
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  validator: _validateEndYear,
                ),
              ),

              // === Description ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: _decoration(
                    'Deskripsi',
                    hint: 'Contoh: Program Sarjana Ilmu Komputer',
                  ),
                  validator: _validateDescription,
                ),
              ),

              // === Logo URL (opsional) ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _logoUrlController,
                  keyboardType: TextInputType.url,
                  decoration: _decoration(
                    'URL Logo / Gambar (opsional)',
                    hint: 'https://contoh.com/logo.png',
                  ),
                  validator: _validateLogoUrl,
                ),
              ),

              // === Order ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _orderController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: _decoration(
                    'Urutan',
                    hint: 'Angka 0 - 999 (semakin kecil tampil lebih dulu)',
                  ),
                  validator: _validateOrder,
                ),
              ),

              // === Tombol Simpan ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _submit,
                    child: const Text('Simpan'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
