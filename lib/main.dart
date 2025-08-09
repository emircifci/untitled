import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

// Data Models
class Revenue {
  final double amount;
  final DateTime date;
  final String photographer;
  final String station;

  Revenue({
    required this.amount,
    required this.date,
    required this.photographer,
    required this.station,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ciro Takip Sistemi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate login delay
      Future.delayed(const Duration(milliseconds: 800), () {
        if (_usernameController.text == 'admin' && 
            _passwordController.text == '0613') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MainScreen()),
          );
        } else {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Kullanıcı adı veya şifre hatalı!'),
              backgroundColor: Colors.red,
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.indigo],
          ),
        ),
        child: Center(
          child: Card(
            margin: const EdgeInsets.all(32.0),
            elevation: 8,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              padding: const EdgeInsets.all(32.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo/Icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const Icon(
                        Icons.analytics,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Title
                    Text(
                      'Ciro Takip Sistemi',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Giriş yapın',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Username field
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Kullanıcı Adı',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kullanıcı adı gerekli';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // Password field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Şifre',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Şifre gerekli';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    
                    // Login button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text(
                                'Giriş Yap',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Info text
                    Text(
                      'Demo: admin / 0613',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[500],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;


  // Temporary in-memory data storage.
  // This will be replaced with a persistent database later.
  final List<Revenue> _revenues = [];
  final List<String> _photographers = ['Ahmet', 'Mehmet', 'Ayşe', 'Hasan', 'Fatma'];
  final List<String> _stations = ['aska', 'palace', 'imperial'];

  void _addRevenue(Revenue revenue) {
    setState(() {
      _revenues.add(revenue);
    });
  }

  void _addPhotographer(String name) {
    setState(() {
      _photographers.add(name);
    });
  }

  void _deletePhotographer(String name) {
    setState(() {
      _photographers.remove(name);
      // Optional: also remove revenues associated with the deleted photographer
      _revenues.removeWhere((r) => r.photographer == name);
    });
  }


  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    
    // Initialize screens
    _screens = [
      DashboardPage(stations: _stations, revenues: _revenues),
      AddRevenuePage(
        stations: _stations,
        photographers: _photographers,
        onAddRevenue: _addRevenue,
      ),
      RevenueAnalysisPage(
        stations: _stations,
        photographers: _photographers,
        revenues: _revenues,
      ),
      PhotographersPage(
        photographers: _photographers,
        onAdd: _addPhotographer,
        onDelete: _deletePhotographer,
      ),
    ];
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    // Rebuild screens with updated data on every state change
    final screens = [
       DashboardPage(stations: _stations, revenues: _revenues),
       AddRevenuePage(
        stations: _stations,
        photographers: _photographers,
        onAddRevenue: (revenue) {
          _addRevenue(revenue);
          // Switch to the dashboard to see the result
          _onItemTapped(0);
        },
      ),
      RevenueAnalysisPage(
        stations: _stations,
        photographers: _photographers,
        revenues: _revenues,
      ),
      PhotographersPage(
        photographers: _photographers,
        onAdd: _addPhotographer,
        onDelete: _deletePhotographer,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ciro Takip Sistemi'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Çıkış Yap'),
                    content: const Text('Sistemden çıkış yapmak istediğinizden emin misiniz?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('İptal'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Çıkış Yap'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_card),
            label: 'Ciro Ekle',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Ciro Analiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Fotoğrafçılar',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

// --- Dashboard Page ---
class DashboardPage extends StatelessWidget {
  final List<String> stations;
  final List<Revenue> revenues;

  const DashboardPage({
    super.key,
    required this.stations,
    required this.revenues,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final currencyFormatter = NumberFormat.currency(locale: 'tr_TR', symbol: '₺');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Sayfa'),
      ),
      body: ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          final station = stations[index];
          
          final totalRevenue = revenues
              .where((r) => r.station == station)
              .fold(0.0, (sum, item) => sum + item.amount);

          final monthlyRevenue = revenues
              .where((r) =>
                  r.station == station &&
                  r.date.month == now.month &&
                  r.date.year == now.year)
              .fold(0.0, (sum, item) => sum + item.amount);

          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    station.toUpperCase(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildRevenueInfo('Bu Ayki Ciro', currencyFormatter.format(monthlyRevenue), context),
                      _buildRevenueInfo('Toplam Ciro', currencyFormatter.format(totalRevenue), context),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
   Widget _buildRevenueInfo(String title, String amount, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodySmall),
        Text(amount, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }
}


// --- Add Revenue Page ---
class AddRevenuePage extends StatefulWidget {
  final List<String> stations;
  final List<String> photographers;
  final void Function(Revenue) onAddRevenue;

  const AddRevenuePage({
    super.key,
    required this.stations,
    required this.photographers,
    required this.onAddRevenue,
  });

  @override
  _AddRevenuePageState createState() => _AddRevenuePageState();
}

class _AddRevenuePageState extends State<AddRevenuePage> {
  String? _selectedStation;
  DateTime _selectedDate = DateTime.now();
  final Map<String, TextEditingController> _revenueControllers = {};

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each photographer
    for (String photographer in widget.photographers) {
      _revenueControllers[photographer] = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ciro Ekle'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Station Selection
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'İstasyon Seçimi',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _selectedStation,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'İstasyon Seçin',
                      ),
                      items: widget.stations.map((station) {
                        return DropdownMenuItem(
                          value: station,
                          child: Text(station.toUpperCase()),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() => _selectedStation = value),
                      validator: (value) => value == null ? 'Lütfen bir istasyon seçin' : null,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Photographers List with Revenue Inputs
            if (_selectedStation != null) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fotoğrafçı Ciroları',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...widget.photographers.map((photographer) => 
                        _buildPhotographerRevenueInput(photographer)
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Date Selection and Save Button
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tarih ve Kaydet',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Date Selection
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Tarih: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () async {
                              final pickedDate = await showDatePicker(
                                context: context,
                                initialDate: _selectedDate,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              if (pickedDate != null) {
                                setState(() => _selectedDate = pickedDate);
                              }
                            },
                            icon: const Icon(Icons.calendar_today),
                            label: const Text('Tarih Seç'),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Save Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: _saveAllRevenues,
                          child: const Text(
                            'Tüm Ciroları Kaydet',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPhotographerRevenueInput(String photographer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              photographer,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: TextField(
              controller: _revenueControllers[photographer],
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '₺',
                hintText: '0.00',
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  void _saveAllRevenues() {
    if (_selectedStation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen önce bir istasyon seçin')),
      );
      return;
    }

    int savedCount = 0;
    List<String> errors = [];

    for (String photographer in widget.photographers) {
      final controller = _revenueControllers[photographer];
      final amountText = controller?.text.trim() ?? '';
      
      if (amountText.isNotEmpty) {
        final amount = double.tryParse(amountText);
        if (amount != null && amount > 0) {
          final revenue = Revenue(
            amount: amount,
            date: _selectedDate,
            photographer: photographer,
            station: _selectedStation!,
          );
          widget.onAddRevenue(revenue);
          savedCount++;
        } else {
          errors.add('$photographer için geçersiz tutar: $amountText');
        }
      }
    }

    if (savedCount > 0) {
      // Clear all input fields
      for (var controller in _revenueControllers.values) {
        controller.clear();
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$savedCount adet ciro başarıyla kaydedildi!'),
          backgroundColor: Colors.green,
        ),
      );
    } else if (errors.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Hata: ${errors.join(', ')}'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lütfen en az bir ciro girin'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (var controller in _revenueControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}

// --- Revenue Analysis Page ---
class RevenueAnalysisPage extends StatefulWidget {
  final List<String> stations;
  final List<String> photographers;
  final List<Revenue> revenues;

  const RevenueAnalysisPage({
    super.key,
    required this.stations,
    required this.photographers,
    required this.revenues,
  });

  @override
  _RevenueAnalysisPageState createState() => _RevenueAnalysisPageState();
}

class _RevenueAnalysisPageState extends State<RevenueAnalysisPage> {
  String? _selectedFilter;
  String? _selectedValue;
  String _selectedPeriod = 'daily';
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime _endDate = DateTime.now();

  final List<Map<String, String>> _periods = [
    {'value': 'daily', 'label': 'Günlük'},
    {'value': 'weekly', 'label': 'Haftalık'},
    {'value': 'monthly', 'label': 'Aylık'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ciro Analiz'),
      ),
      body: Column(
        children: [
          // Filters Section
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Filter Type Selection
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedFilter,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Filtre Türü',
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'station',
                            child: Text('İstasyon'),
                          ),
                          DropdownMenuItem(
                            value: 'photographer',
                            child: Text('Fotoğrafçı'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedFilter = value;
                            _selectedValue = null;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedValue,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Seçim',
                        ),
                        items: _getFilterValues(),
                        onChanged: (value) => setState(() => _selectedValue = value),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Period Selection
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedPeriod,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Periyot',
                        ),
                        items: _periods.map((period) {
                          return DropdownMenuItem(
                            value: period['value'],
                            child: Text(period['label']!),
                          );
                        }).toList(),
                        onChanged: (value) => setState(() => _selectedPeriod = value!),
                      ),
                    ),
                    const SizedBox(width: 16),
                    if (_selectedPeriod != 'monthly') ...[
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () => _showDateRangePicker(),
                          icon: const Icon(Icons.date_range),
                          label: Text(
                            '${DateFormat('dd/MM').format(_startDate)} - ${DateFormat('dd/MM').format(_endDate)}',
                          ),
                        ),
                      ),
                    ] else ...[
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Center(
                            child: Text(
                              'Aylık raporda tüm aylar gösterilir',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          
          // Results Section
          Expanded(
            child: _buildResults(),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _getFilterValues() {
    if (_selectedFilter == 'station') {
      return widget.stations.map((station) {
        return DropdownMenuItem(
          value: station,
          child: Text(station.toUpperCase()),
        );
      }).toList();
    } else if (_selectedFilter == 'photographer') {
      return widget.photographers.map((photographer) {
        return DropdownMenuItem(
          value: photographer,
          child: Text(photographer),
        );
      }).toList();
    }
    return [];
  }

  void _showDateRangePicker() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(start: _startDate, end: _endDate),
    );
    
    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  Widget _buildResults() {
    if (_selectedFilter == null || _selectedValue == null) {
      return const Center(
        child: Text(
          'Lütfen filtre seçeneklerini belirleyin',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    List<Revenue> filteredRevenues;
    
    if (_selectedPeriod == 'monthly') {
      // For monthly view, show full months regardless of selected date range
      filteredRevenues = widget.revenues.where((revenue) {
        if (_selectedFilter == 'station') {
          return revenue.station == _selectedValue;
        } else {
          return revenue.photographer == _selectedValue;
        }
      }).toList();
    } else {
      // For daily and weekly, use the selected date range
      filteredRevenues = widget.revenues.where((revenue) {
        if (_selectedFilter == 'station') {
          return revenue.station == _selectedValue;
        } else {
          return revenue.photographer == _selectedValue;
        }
      }).where((revenue) {
        return revenue.date.isAfter(_startDate.subtract(const Duration(days: 1))) &&
               revenue.date.isBefore(_endDate.add(const Duration(days: 1)));
      }).toList();
    }

    if (filteredRevenues.isEmpty) {
      return const Center(
        child: Text(
          'Seçilen kriterlere uygun ciro bulunamadı',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Summary Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Özet',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSummaryItem('Toplam Ciro', _calculateTotalRevenue(filteredRevenues)),
                    _buildSummaryItem('Ortalama', _calculateAverageRevenue(filteredRevenues)),
                    _buildSummaryItem('Maksimum', _calculateMaxRevenue(filteredRevenues)),
                  ],
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Detailed Results
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _selectedPeriod == 'monthly' ? 'Aylık Sonuçlar (Tüm Aylar)' : 'Detaylı Sonuçlar',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ..._buildDetailedResults(filteredRevenues),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.green[700],
          ),
        ),
      ],
    );
  }

  List<Widget> _buildDetailedResults(List<Revenue> revenues) {
    final currencyFormatter = NumberFormat.currency(locale: 'tr_TR', symbol: '₺');
    
    try {
      if (_selectedPeriod == 'daily') {
        // Group by date
        final groupedByDate = <DateTime, List<Revenue>>{};
        for (var revenue in revenues) {
          final date = DateTime(revenue.date.year, revenue.date.month, revenue.date.day);
          groupedByDate.putIfAbsent(date, () => []).add(revenue);
        }
        
        final sortedDates = groupedByDate.keys.toList()..sort();
        
        return sortedDates.map((date) {
          final dailyRevenues = groupedByDate[date]!;
          final total = dailyRevenues.fold(0.0, (sum, r) => sum + r.amount);
          
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('dd/MM/yyyy').format(date),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  currencyFormatter.format(total),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }).toList();
        
      } else if (_selectedPeriod == 'weekly') {
        // Group by week
        final groupedByWeek = <String, List<Revenue>>{};
        for (var revenue in revenues) {
          final weekStart = _getWeekStart(revenue.date);
          final weekKey = '${weekStart.year}-W${_getWeekNumber(weekStart)}';
          groupedByWeek.putIfAbsent(weekKey, () => []).add(revenue);
        }
        
        final sortedWeeks = groupedByWeek.keys.toList()..sort();
        
        return sortedWeeks.map((weekKey) {
          final weekRevenues = groupedByWeek[weekKey]!;
          final total = weekRevenues.fold(0.0, (sum, r) => sum + r.amount);
          final weekStart = _parseWeekKey(weekKey);
          
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${DateFormat('dd/MM').format(weekStart)} - ${DateFormat('dd/MM').format(weekStart.add(const Duration(days: 6)))}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  currencyFormatter.format(total),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }).toList();
        
      } else {
        // Monthly
        final groupedByMonth = <String, List<Revenue>>{};
        for (var revenue in revenues) {
          // Create month key in format: YYYY-MM
          final monthKey = '${revenue.date.year}-${revenue.date.month.toString().padLeft(2, '0')}';
          groupedByMonth.putIfAbsent(monthKey, () => []).add(revenue);
        }
        
        final sortedMonths = groupedByMonth.keys.toList()..sort();
        
        return sortedMonths.map((monthKey) {
          try {
            final monthRevenues = groupedByMonth[monthKey]!;
            final total = monthRevenues.fold(0.0, (sum, r) => sum + r.amount);
            final parts = monthKey.split('-');
            
            if (parts.length != 2) {
              return const SizedBox.shrink(); // Skip invalid month keys
            }
            
            final year = int.tryParse(parts[0]);
            final month = int.tryParse(parts[1]);
            
            if (year == null || month == null || month < 1 || month > 12) {
              return const SizedBox.shrink(); // Skip invalid dates
            }
            
            final monthDate = DateTime(year, month);
            final firstDayOfMonth = DateTime(year, month, 1);
            final lastDayOfMonth = DateTime(year, month + 1, 0); // Last day of month
            
            // Use Turkish month names
            String monthName;
            try {
              monthName = DateFormat('MMMM yyyy', 'tr_TR').format(monthDate);
            } catch (e) {
              // Fallback to English if Turkish fails
              monthName = DateFormat('MMMM yyyy').format(monthDate);
            }
            
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          monthName,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          '${DateFormat('dd/MM').format(firstDayOfMonth)} - ${DateFormat('dd/MM').format(lastDayOfMonth)}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    currencyFormatter.format(total),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          } catch (e) {
            // Return empty widget for any parsing errors
            return const SizedBox.shrink();
          }
        }).where((widget) => widget is! SizedBox).toList();
      }
    } catch (e) {
      // Return error message if something goes wrong
      return [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Veri işlenirken hata oluştu: $e',
            style: const TextStyle(color: Colors.red),
          ),
        )
      ];
    }
  }

  String _calculateTotalRevenue(List<Revenue> revenues) {
    final total = revenues.fold(0.0, (sum, revenue) => sum + revenue.amount);
    return NumberFormat.currency(locale: 'tr_TR', symbol: '₺').format(total);
  }

  String _calculateAverageRevenue(List<Revenue> revenues) {
    if (revenues.isEmpty) return '₺0.00';
    final total = revenues.fold(0.0, (sum, revenue) => sum + revenue.amount);
    final average = total / revenues.length;
    return NumberFormat.currency(locale: 'tr_TR', symbol: '₺').format(average);
  }

  String _calculateMaxRevenue(List<Revenue> revenues) {
    if (revenues.isEmpty) return '₺0.00';
    final max = revenues.map((r) => r.amount).reduce((a, b) => a > b ? a : b);
    return NumberFormat.currency(locale: 'tr_TR', symbol: '₺').format(max);
  }

  DateTime _getWeekStart(DateTime date) {
    final daysFromMonday = date.weekday - 1;
    return date.subtract(Duration(days: daysFromMonday));
  }

  int _getWeekNumber(DateTime date) {
    final startOfYear = DateTime(date.year, 1, 1);
    final daysSinceStartOfYear = date.difference(startOfYear).inDays;
    return ((daysSinceStartOfYear - startOfYear.weekday + 10) / 7).floor();
  }

  DateTime _parseWeekKey(String weekKey) {
    final parts = weekKey.split('-');
    final year = int.parse(parts[0]);
    final weekNum = int.parse(parts[1].substring(1));
    final startOfYear = DateTime(year, 1, 1);
    final firstMonday = startOfYear.add(Duration(days: (8 - startOfYear.weekday) % 7));
    return firstMonday.add(Duration(days: (weekNum - 1) * 7));
  }
}

// --- Photographers Page ---
class PhotographersPage extends StatefulWidget {
  final List<String> photographers;
  final void Function(String) onAdd;
  final void Function(String) onDelete;

  const PhotographersPage({
    super.key,
    required this.photographers,
    required this.onAdd,
    required this.onDelete,
  });

  @override
  _PhotographersPageState createState() => _PhotographersPageState();
}

class _PhotographersPageState extends State<PhotographersPage> {
  final _nameController = TextEditingController();

  void _showAddPhotographerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Yeni Fotoğrafçı Ekle'),
          content: TextField(
            controller: _nameController,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Fotoğrafçı Adı'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty) {
                  widget.onAdd(_nameController.text);
                  _nameController.clear();
                  Navigator.pop(context);
                }
              },
              child: const Text('Ekle'),
            ),
          ],
        );
      },
    );
  }

   void _showDeleteConfirmDialog(String name) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Fotoğrafçıyı Sil'),
          content: Text('"$name" adlı fotoğrafçıyı silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                widget.onDelete(name);
                Navigator.pop(context);
              },
              child: const Text('Sil', style: TextStyle(color: Colors.red)),
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
        title: const Text('Fotoğrafçılar'),
      ),
      body: widget.photographers.isEmpty 
      ? const Center(child: Text('Henüz fotoğrafçı eklenmemiş.'))
      : ListView.builder(
        itemCount: widget.photographers.length,
        itemBuilder: (context, index) {
          final photographer = widget.photographers[index];
          return ListTile(
            title: Text(photographer),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () => _showDeleteConfirmDialog(photographer),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPhotographerDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
