import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ButtonsScreen extends StatelessWidget {

  static const String name = 'buttons_scren';

   
  const ButtonsScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const _ButtonsView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pop();
        },
        child: const Icon(Icons.arrow_back_ios_new_rounded),
      
      ),
    );
  }
}

class _ButtonsView extends StatelessWidget {
  const _ButtonsView();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Wrap( // widgets similar al row pero en el desbordamiento para que pase a la siguiente linea
          spacing: 10,
          alignment: WrapAlignment.center,
          children: [
            ElevatedButton(onPressed: (){}, child: const Text('Elevated')),
            const ElevatedButton(onPressed: null, child: Text('Elevated disabled')),

            ElevatedButton.icon(
              onPressed: (){}, 
              icon: const Icon(Icons.ac_unit_outlined), 
              label: const Text('Elevated Icon')
            ),

            FilledButton(
              onPressed: (){}, 
              child: const Text('Filled')
            ),

            FilledButton.icon(
              onPressed: (){}, 
              icon: const Icon(Icons.accessibility_outlined), 
              label: const Text('Filled Icon')
            ),

            OutlinedButton(onPressed: (){}, child: const Text('Outlined')),

            OutlinedButton.icon(
              onPressed: (){}, 
              icon: const Icon(Icons.add_alert), 
              label: const Text('Outlined Icon')
            ),

            TextButton(
              onPressed: (){}, 
              child: const Text('Text')
            ),

            TextButton.icon(
              onPressed: (){}, 
              icon: Icon(Icons.ad_units), 
              label: const Text('Text icon')
            ),

            IconButton(
              onPressed: (){}, 
              icon: Icon(Icons.app_registration, 
                color: colors.primary,)
            ),

            IconButton(
              onPressed: (){}, 
              icon: const Icon(Icons.app_registration),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(colors.primary),
                iconColor: const MaterialStatePropertyAll(Colors.white)
              ),
            ),

            // Custom button
            const CustomButton()
    
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        color: colors.primary,
        child: InkWell( // Similar al GestureDetect
          onTap: (){},
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text('Custom Button', style: TextStyle(color: Colors.white),),
          ),
        ),
      ),
    );
  }
}