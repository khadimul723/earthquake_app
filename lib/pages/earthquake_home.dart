import 'package:earthquak/utils/constant.dart';
import 'package:earthquak/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/earthquake_provider.dart';

class EarthquakeHome extends StatefulWidget {
  const EarthquakeHome({super.key});

  @override
  State<EarthquakeHome> createState() => _EarthquakeHomeState();
}

class _EarthquakeHomeState extends State<EarthquakeHome> {
  @override
  void didChangeDependencies() {
    Provider.of<EarthquakeProvider>(context, listen: false).getData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earthquake Home'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Consumer<EarthquakeProvider>(
        builder: (context, provider, child) {
          return provider.hasDataLoaded
              ? Stack(
                  children: [
                    Image.network(
                      backgroundImage,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.cover,
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: _EarthquakeDataSection(provider, context)),
                        ],
                      ),
                    )
                  ],
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _EarthquakeDataSection(
      EarthquakeProvider provider, BuildContext context) {
    return ListView.builder(
      itemCount: provider.earthquakeData!.features!.length,
      itemBuilder: (context, index) {
        final item = provider.earthquakeData!.features![index];
        return ListTile(
          title: Text('${item.properties!.title}'),
          subtitle: Text(getFormattedDate(item.properties!.updated!, pattern: 'dd. MM. yyyy')),
          trailing: Text('${item.properties!.mag}'),
        );
      },
    );
  }
}
