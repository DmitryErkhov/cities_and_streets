import 'package:flutter/material.dart';
import 'package:cities_and_streets/blocs/bloc_export.dart';

class StreetScreen extends StatefulWidget {

  int cityId;
  StreetScreen({super.key, required this.cityId});

  @override
  State<StreetScreen> createState() => _StreetScreenState();
}

class _StreetScreenState extends State<StreetScreen> {


  @override
  void initState() {
    super.initState();
    BlocProvider.of<StreetBloc>(context).add(FetchStreetEvent(widget.cityId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<StreetBloc, StreetState>(builder: (context, state) {
        if (state is StreetLoadingState) {
          return const Center(
            child: CircularProgressIndicator(strokeWidth: 6, backgroundColor: Color(0xFFF2F3F5), color: Color(0xFF1A1A1A),),
          );
        } else if (state is StreetErrorState) {
          return Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 15,
                left: 20,
                right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/street_error_crocodile.png'),
                const Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Text(
                    'Без улиц можно потеряться',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFF354153),
                    ),
                  ),
                ),
                const Text(
                  'Не смогли загрузить список улиц, спросите у кого‑нибудь как пройти',
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
                          BlocProvider.of<StreetBloc>(context).add(FetchStreetEvent(widget.cityId));
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
        } else if (state is StreetLoadedState) {
          if( state.streets.isNotEmpty) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Улицы города', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Color(0xFF0D1421),),),
                centerTitle: true,
              ),
              body: SafeArea(
                child: ListView.builder(
                    itemCount: state.streets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: index != 3 ? const Border(bottom: BorderSide(color: Color(0xFFEAECF0))) : null,
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.fromLTRB(16, 8, 24, 8),
                          title: Text(state.streets[index].name),
                          subtitle: Text(state.streets[index].address),
                          titleTextStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Color(0xFF0D1421)),
                          subtitleTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF667085), overflow: TextOverflow.ellipsis),
                        ),
                      );
                    }
                ),
              ),
            );
          } return Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 15,
                left: 20,
                right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/no_street_crocodile.png'),
                const Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Text(
                    'Тут пусто...',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xFF354153),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    'Названия улиц в этом городе ещё не добавлены',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xFF667085),
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
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
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Вернуться назад',
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
        }

        return Container();
      }),
    );
  }
}
