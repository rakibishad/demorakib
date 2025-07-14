import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/location_bloc.dart';
import 'bloc/location_event.dart';
import 'bloc/location_state.dart';
import 'model/city_model.dart';
import 'model/vendor_model.dart';


class CityAreaSelectionScreen extends StatelessWidget {
  final List<CityModel> cities = [
    CityModel(name: 'Dhaka', areas: ['Banani', 'Gulshan', 'Dhanmondi']),
    CityModel(name: 'Chittagong', areas: ['Pahartali', 'Agrabad']),
    CityModel(name: 'Khulna', areas: ['Sonadanga', 'Shibbari']),
    CityModel(name: 'Rajshahi', areas: ['Boalia', 'Rajpara']),
  ];

  final List<Vendor> vendors = [
    Vendor(name: 'Vendor 1', city: 'Dhaka', area: 'Banani'),
    Vendor(name: 'Vendor 2', city: 'Dhaka', area: 'Gulshan'),
    Vendor(name: 'Vendor 3', city: 'Chittagong', area: 'Agrabad'),
    Vendor(name: 'Vendor 4', city: 'Khulna', area: 'Shibbari'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select City & Area'),
        backgroundColor: Colors.green,
      ),
      body: BlocProvider(
        create: (_) => LocationBloc(),
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            final bloc = context.read<LocationBloc>();
            final selectedCityModel =
            cities.firstWhere((c) => c.name == state.selectedCity, orElse: () => cities[0]);
            final filteredAreas = selectedCityModel.areas;

            final filteredVendors = vendors.where((v) {
              return v.city == state.selectedCity && (state.selectedArea == null || v.area == state.selectedArea);
            }).toList();

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // City Dropdown
                  DropdownButtonFormField<String>(
                    value: state.selectedCity,
                    decoration: InputDecoration(
                      labelText: 'Select City',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    items: cities
                        .map((city) => DropdownMenuItem(value: city.name, child: Text(city.name)))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) bloc.add(CitySelected(value));
                    },
                  ),
                  SizedBox(height: 20),

                  // Area Dropdown
                  DropdownButtonFormField<String>(
                    value: state.selectedArea,
                    decoration: InputDecoration(
                      labelText: 'Select Area',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    items: filteredAreas
                        .map((area) => DropdownMenuItem(value: area, child: Text(area)))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) bloc.add(AreaSelected(value));
                    },
                  ),
                  SizedBox(height: 30),

                  // Vendors List
                  Expanded(
                    child: filteredVendors.isEmpty
                        ? Center(child: Text("No vendors found."))
                        : ListView.builder(
                      itemCount: filteredVendors.length,
                      itemBuilder: (_, index) {
                        final vendor = filteredVendors[index];
                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            title: Text(vendor.name),
                            subtitle: Text('${vendor.city} > ${vendor.area}'),
                            trailing: Icon(Icons.store, color: Colors.green),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
