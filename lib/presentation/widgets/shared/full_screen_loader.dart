import 'package:flutter/material.dart';

class FullSceenLoader extends StatelessWidget {
  const FullSceenLoader({super.key});
  
  

  Stream<String> getLoafingMessages() {
    final messages = <String>[
      'Cargando peliculas',
      'Comprando palomitas de maíz',
      'Cargando populares',
      'Llamando a mi novia',
      'Ya mero...',
      'Esto está tardando más de lo esperado :(',
    ];

    return Stream.periodic( const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Esper por favor'),
          const SizedBox(height: 10,),
          const CircularProgressIndicator(strokeWidth: 2,),
          const SizedBox(height: 10,),
          StreamBuilder(
            stream: getLoafingMessages(), 
            builder: (context, snapshot) {
              if ( !snapshot.hasData) return const Text('Cargando...');
              return Text( snapshot.data!);
            },
          )
        ],
      ),
    );
  }
}