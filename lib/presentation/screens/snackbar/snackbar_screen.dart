import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SnackbarScreen extends StatelessWidget {

  static const name = 'snackbar_screen';

  const SnackbarScreen({super.key});

  void showCustomSnackbar(context){

    ScaffoldMessenger.of(context).clearSnackBars();

    final snackBar = SnackBar(
      content: const Text('Hola mundo'),
      action: SnackBarAction(
        label: 'Ok', 
        onPressed: () {
          const Duration(seconds: 5);
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void opendDialog(context){
    showDialog(
      context: context, 
      barrierDismissible: false, // evita salir del dialogo sin cofirmar
      builder: (context) => AlertDialog(
        title: const Text('Estas seguro'),
        content: const Text('Proident exercitation incididunt nostrud fugiat est veniam deserunt. Ullamco do dolore dolore irure laboris sunt ut anim enim. Ullamco et pariatur non exercitation.'),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text('Cancelar')),
          TextButton(onPressed: () => context.pop(), child: const Text('Aceptar')),

        ],
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbars y Diálogos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Licencias usadas
            FilledButton.tonal(
              onPressed: (){
                // showAboutDialog es un componente de flutter para mostrar dialogos
                showAboutDialog(
                  context: context,
                  children: [
                    const Text('Enim deserunt minim voluptate tempor ut ullamco enim eu officia mollit nostrud veniam. Sit excepteur eiusmod magna magna. Cupidatat incididunt eu est amet.')
                  ]
                  );
              }, 
              child: const Text('Licencias usadas')
            ),

            // Mostrar diálogo
            FilledButton.tonal(
              onPressed: () => opendDialog(context), 
              child: const Text('Mostrar diálogo')
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Mostrar Snackbar'),
        icon: const Icon(Icons.remove_red_eye_outlined),
        onPressed: () => showCustomSnackbar(context),
      ),
    );
  }
}