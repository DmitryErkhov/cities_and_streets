import 'package:cities_and_streets/blocs/city_bloc/city_bloc.dart';
import 'package:cities_and_streets/widgets/city_widget.dart';
import 'package:flutter/material.dart';

import '../blocs/bloc_export.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CityBloc>(context).add(FetchCityEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CityBloc, CityState>(
        builder: (context, state) {
          if (state is CityLoadingState) {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 6, backgroundColor: Color(0xFFF2F3F5), color: Color(0xFF1A1A1A),),
            );
          } else if (state is CityErrorState) {
            return Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 15,
                  left: 20,
                  right: 20
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/all_error_crocodile.png'),
                  const Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: Text(
                      'Оглядитесь...',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xFF354153),
                      ),
                    ),
                  ),
                  const Text(
                    'Нет ни городов, ни улиц. Очевидно, что‑то сломалось и мы уже это чиним.',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xFF667085),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 116),
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 328),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: const Color(0xFFEAECF0), width: 1),
                      ),
                      child: Container(
                        width: 328,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xFF0D1421),
                        ),
                        child: TextButton(
                          onPressed: () {
                            BlocProvider.of<CityBloc>(context)
                                .add(FetchCityEvent());
                          },
                          child: const Text(
                            'Попробовать снова',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CityLoadedState) {
            return CustomScrollView(
              slivers: [
                const SliverAppBar(
                  title: Text(
                    'Города',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 32,
                      color: Color(0xFF354153),
                    ),
                  ),
                  floating: true,
                  pinned: true,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Padding(
                        padding: index == state.cities.length - 1
                            ? const EdgeInsets.symmetric(vertical: 16)
                            : const EdgeInsets.only(top: 16),
                        child: Center(
                          child: CityWidgetInfo(
                              id: state.cities[index].id,
                              name: state.cities[index].name,
                              image: state.cities[index].image,
                              dateTimeImage: state.cities[index].dateTimeImage,
                              totalPeople: state.cities[index].totalPeople,
                              lat: state.cities[index].lat,
                              long: state.cities[index].long),
                        ),
                      );
                    },
                    childCount: state.cities.length,
                  ),
                ),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}
