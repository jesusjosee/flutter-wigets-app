import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InfiniteScrollScreen extends StatefulWidget {

  static const name = 'infinite_screen';

  const InfiniteScrollScreen({super.key});

  @override
  State<InfiniteScrollScreen> createState() => _InfiniteScrollScreenState();
}

class _InfiniteScrollScreenState extends State<InfiniteScrollScreen> {

  List<int> imagesIds = [1,2,3,4,5];
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;
  bool isMounted = true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() { 
      if ( (scrollController.position.pixels +500) >= scrollController.position.maxScrollExtent ){
        loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    isMounted = false; // se debe poner a falso cuando el componente se ha desmontado
    super.dispose();
  }

  // hacer las comprobaciones antes de cargas las 5 imagenes y añadir una espera
  Future loadNextPage() async{
    if ( isLoading) return; // si es verdadero no se hace nada 
    isLoading  = true;
    setState(() {});
    await Future.delayed(const Duration(seconds: 2));

    if (!isMounted) return; // si no esta montado no hacer la carga de imagenes
    addFiveImages();
    isLoading = false;
    setState(() {});

    //  Mueve el scroll cuando se hizo la carga de las ultimas imagenes
    moveScrollToBottom();

  }

  // crgar 5 imagenes
  void addFiveImages() {
    final lastId = imagesIds.last;

    imagesIds.addAll(
      [1,2,3,4,5].map((index) => lastId + index)
    );
  }


  Future onRefresh () async{
    /* Cargar nuevas imagenes al hacer refresh */

    isLoading = true;
    setState(() { });

    await Future.delayed(const Duration(seconds: 2));
    if (!isMounted) return;

    isLoading = false;
    final lastId = imagesIds.last;
    imagesIds.clear(); // borrar todas las imagenes
    imagesIds.add(lastId + 1); // añadir un elemento a partir del ultimo anterior
    addFiveImages(); // carga 5 imagenes
    setState(() { });

  }

  // Desplaza las imagenes hacia arriba desppues de la carga
  void moveScrollToBottom(){
    //
    if ( scrollController.position.pixels + 100 <= scrollController.position.maxScrollExtent) return;
    
    scrollController.animateTo(
      scrollController.position.pixels + 100, 
      duration: const Duration(milliseconds: 300), 
      curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: RefreshIndicator(
          onRefresh: onRefresh,
          edgeOffset: 10,
          strokeWidth: 2,
          child: ListView.builder(
            controller: scrollController,
            itemCount: imagesIds.length,
            itemBuilder: (context, index) {
              return FadeInImage(
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300,
                placeholder: const AssetImage('assets/images/jar-loading.gif'), 
                image: NetworkImage('https://picsum.photos/id//${imagesIds[index]}/500/300')
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pop(),
        // child: const Icon(Icons.arrow_back_ios_new_outlined),
        child: isLoading 
                ?  SpinPerfect(
                    infinite: true,
                    child: const Icon(Icons.refresh)
                  )
                : FadeIn(child: const Icon(Icons.arrow_back_ios_new_outlined))
      ),
    );
  }
}