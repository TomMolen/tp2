import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  String _userName = '';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _updateUserData(String name, String hobby) {
    setState(() {
      _userName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigasi Bar Flutter'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Nama: $_userName',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
      body: _selectedIndex == 0
          ? HomePage()
          : ProfilePage(
              userName: _userName,
              onTapDataDiri: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DataDiriPage(
                      updateUserCallback: _updateUserData,
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Halaman Beranda'),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final String userName;
  final VoidCallback onTapDataDiri;

  ProfilePage({required this.userName, required this.onTapDataDiri});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Nama: $userName',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Profil'),
            ),
          ),
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Selamat datang, $userName!'),
                  ElevatedButton(
                    onPressed: onTapDataDiri,
                    child: Text('Isi Data Diri'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DataDiriPage extends StatefulWidget {
  final Function(String, String) updateUserCallback;

  DataDiriPage({required this.updateUserCallback});

  @override
  _DataDiriPageState createState() => _DataDiriPageState();
}

class _DataDiriPageState extends State<DataDiriPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _hobbyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Isi Data Diri'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: _hobbyController,
              decoration: InputDecoration(labelText: 'Hobi'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                final name = _nameController.text;
                final hobby = _hobbyController.text;
                widget.updateUserCallback(name, hobby);
                Navigator.pop(context);
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
