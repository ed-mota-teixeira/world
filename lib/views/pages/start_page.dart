import 'package:countries/controllers/sound.dart';
import 'package:countries/models/countries_list.dart';
import 'package:countries/models/country.dart';
import 'package:countries/utils/routing/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartPage extends ConsumerStatefulWidget {
  const StartPage({super.key});

  @override
  createState() => _StartPage();
}

class _StartPage extends ConsumerState<StartPage> {
  Future<String>? _loadAsset;

  Future<String> load() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/countries.json");
    CountriesList().list = countriesFromJson(data);
    await Sound().setSources().catchError((e) {
      debugPrint(e.toString());
    });
    return data;
  }

  @override
  void initState() {
    super.initState();
    _loadAsset = load();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: null,
        body: Center(
          child: FutureBuilder<String>(
              future: _loadAsset,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Container();
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  case ConnectionState.active:
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return const Text('Something went wrong!');
                    }

                    if (snapshot.hasData) {
                      if (snapshot.data != null) {
                        Future.delayed(const Duration(seconds: 1)).then((_) {
                          // debugPrint(countriesList.length.toString());
                          Navigator.of(context)
                              .pushReplacementNamed(kMenuRoute);
                        });
                        return const Text('Loading');
                      }
                    }

                    return Container();
                }
              }),
        ),
      ),
    );
  }
}
