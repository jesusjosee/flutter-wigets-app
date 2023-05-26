import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SlideInfo {
  final String title;
  final String caption;
  final String imageUrl;

  SlideInfo(this.title, this.caption, this.imageUrl);
}

final slides = <SlideInfo>[
 SlideInfo('Busca la comida', 'Non sunt esse reprehenderit dolore eu.', 'assets/images/1.png'),
 SlideInfo('Entrega la comida', 'Eiusmod nostrud consectetur et mollit ullamco et sint.', 'assets/images/2.png'),
 SlideInfo('Disfruta la comida', 'Ex excepteur et eu et proident proident reprehenderit.', 'assets/images/3.png'),
];

class AppTutorialScreen extends StatefulWidget {

  static const name = 'tutorial_screen';

  const AppTutorialScreen({super.key});

  @override
  State<AppTutorialScreen> createState() => _AppTutorialScreenState();
}

class _AppTutorialScreenState extends State<AppTutorialScreen> {
  final PageController pageViewController = PageController();
  bool endReached = false;

  // para controllar el controller
  @override
  void initState() {
    super.initState();

    pageViewController.addListener(() { 
      final page = pageViewController.page ?? 0 ;
      if ( !endReached && page >= (slides.length - 1.5 ) ){
        endReached = true;
        setState(() {});
      }
    });

  }

  // para destruir el controller
  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          PageView(
            controller: pageViewController,
            physics: const BouncingScrollPhysics(),
            children: slides.map(
              (slideData) => _Slide(
                title: slideData.title, 
                caption: slideData.caption, 
                imageUrl: slideData.imageUrl)
            ).toList()
          ),

          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: () => context.pop(), 
              child: const Text('Salir')
            )
          ),

          endReached 
            ? Positioned(
                bottom: 50,
                right: 30,
                child: FadeInRight( // widget animado animate_do
                  from: 15,
                  delay: const Duration(seconds: 1),
                  child: FilledButton(
                    child: const Text('Comenzar'),
                    onPressed: () => context.pop(),
                  ),
                ),
              ) 
            : const SizedBox(),

        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final String title;
  final String caption;
  final String imageUrl;

  const _Slide({
    required this.title, 
    required this.caption, 
    required this.imageUrl
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captionStyle = Theme.of(context).textTheme.bodySmall;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(image: AssetImage(imageUrl)),
            const SizedBox(height: 20,),
            Text(title, style: titleStyle,),
            const SizedBox(height: 10),
            Text(caption, style: captionStyle,)
          ],
        ),
      ),
    );
  }
}