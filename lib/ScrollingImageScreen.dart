import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ScrollingImageCubit.dart' ;

class ScrollingImageScreen extends StatelessWidget {
  const ScrollingImageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ScrollingImageCubit(),
      child: BlocBuilder<ScrollingImageCubit, ScrollingImageState>(
        builder: (context, state) {
          final cubit = context.read<ScrollingImageCubit>();
          final image = cubit.image;
          cubit.startScrolling();
          Widget  ccc=Scaffold(
              body: GestureDetector(
                child: OrientationBuilder(
                  builder: (context, orientation) {
                    // if (orientation == Orientation.portrait) {
                    //   return SizedBox(
                    //           width: MediaQuery.of(context).size.width,
                    //           height: MediaQuery.of(context).size.height,
                    //           child: Image.asset(
                    //             'assets/Index.png',
                    //             fit: BoxFit.fill,
                    //           ),
                    //   );
                    // } else {
                    return Column(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            child: SingleChildScrollView(
                              controller: cubit.scrollController,
                              child: Image.asset(
                                image,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () => cubit.nextImage(),
                                child: const Icon(Icons.arrow_left),
                              ),
                              Slider(
                                value: cubit.scrollSpeed,
                                min: 0,
                                max: 10,
                                divisions: 10,
                                label: cubit.scrollSpeed.round().toString(),
                                onChanged: (value) {
                                  cubit.updateScrollSpeed(value);
                                },
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  cubit.toggleScrolling(); // Toggle play/pause
                                },
                                child: Icon(cubit.isScrolling ? Icons.pause : Icons.play_arrow,color: Colors.blue,), // Change icon based on state
                              ),
                              SizedBox(
                                width: 200,
                                child: TextField(
                                  controller: cubit.textController,
                                  decoration:  InputDecoration(
                                    hintText: cubit.pageData(),
                                    border: OutlineInputBorder(),
                                  ),
                                  onSubmitted: (value) {
                                    cubit.setImageIndex(value);
                                  },
                                ),
                              ),
                              ElevatedButton(

                                onPressed: () => cubit.lastImage(),
                                child: const Icon(Icons.arrow_right),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                    // }
                  },
                ),
              ));
          //print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
          // print(cubit.scrollController.position.maxScrollExtent);
          // cubit.printImageHeight();
          return ccc;
        },
      ),
    );
  }
}
