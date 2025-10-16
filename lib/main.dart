import 'package:flutter/material.dart';

void main() {
  runApp(const KalkulatorBMI());
}

class KalkulatorBMI extends StatelessWidget {
  const KalkulatorBMI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator BMI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: BMIScreen(),
    );
  }
}

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final _berat = TextEditingController(); 
  final _tinggi = TextEditingController();
  String? _gender = "Laki-laki";

  // var,const,final;

  double? _hasil;
  String? _keterangan ; 
  void _hitungBMI(){
    // bmi =bb(kg)/(tb(m))2
    final double weight = double.tryParse(_berat.text) ?? 0;
    final double height= double.tryParse(_tinggi.text) ?? 0;
    setState(() {
      if(weight > 0 && height > 0){
        final double heightInM = height/100;
        final double bmi = weight / (heightInM * heightInM);
        _hasil = bmi;

// beda kategori untuk laki-laki dan perempuan
        if (_gender == "Laki-laki") {
          if (bmi < 18.5) {
            _keterangan = "Kekurangan berat badan";
          } else if (bmi < 25) {
            _keterangan = "Berat badan ideal";
          } else if (bmi < 30) {
            _keterangan = "Kelebihan berat badan";
          } else {
            _keterangan = "Obesitas";
          }
        } else {
          //Perempuan
          if (bmi < 18) {
            _keterangan = "Kekurangan berat badan";
          } else if (bmi < 24) {
            _keterangan = "Berat badan ideal";
          } else if (bmi < 29) {
            _keterangan = "Kelebihan berat badan";
          } else {
            _keterangan = "Obesitas";
          }
        }
      } else {
        _hasil = null;
        _keterangan = "Masukkan data yang valid!";
      }
    });
  }

  void _reset() {
    setState(() {
      _berat.clear();
      _tinggi.clear();
      _hasil = null;
      _keterangan = null;
      _gender = "Laki-laki";
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator BMI'),
        backgroundColor: Colors.indigoAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  "Hitung Indeks Massa Tubuh Anda",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigoAccent,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _berat,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Berat Badan (Kg)',
                    prefixIcon: Icon(Icons.monitor_weight),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _tinggi,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Tinggi Badan (Cm)',
                    prefixIcon: Icon(Icons.height),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    const Text(
                      "Jenis Kelamin:",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: DropdownButton<String>(
                        value: _gender,
                        items: const [
                          DropdownMenuItem(
                              value: "Laki-laki", child: Text("Laki-laki")),
                          DropdownMenuItem(
                              value: "Perempuan", child: Text("Perempuan")),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _gender = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _hitungBMI,
                      icon: const Icon(Icons.calculate),
                      label: const Text("Hitung BMI"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigoAccent,
                        foregroundColor: Colors.white,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _reset,
                      icon: const Icon(Icons.refresh),
                      label: const Text("Reset"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                if (_hasil != null)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Hasil BMI Anda",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _hasil!.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.teal.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _keterangan ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}