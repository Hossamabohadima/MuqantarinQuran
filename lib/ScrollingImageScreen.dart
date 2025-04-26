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


          return Scaffold(
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
                              (orientation != Orientation.portrait)?ElevatedButton(
                                onPressed: () => cubit.nextImage(),
                                child: const Icon(Icons.arrow_left),
                              ):SizedBox.shrink(),
                              DropdownButton<int>(
                                value: cubit.scrollSpeed.round(),
                                onChanged: (value) {
                                  if (value != null) {
                                    cubit.updateScrollSpeed(value.toDouble());
                                  }
                                },
                                items: List.generate(
                                  11, // values from 0 to 10
                                      (index) => DropdownMenuItem(
                                    value: index,
                                    child: Text(index.toString()),
                                  ),
                                ),
                              ),
                              (orientation != Orientation.portrait)?ElevatedButton(
                                onPressed: () {
                                  cubit.toggleScrolling(); // Toggle play/pause
                                },
                                child: Icon(cubit.isScrolling ? Icons.pause : Icons.play_arrow,color: Colors.blue,), // Change icon based on state
                              ):SizedBox.shrink(),
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
                              (orientation != Orientation.portrait)? ElevatedButton(

                                onPressed: () => cubit.lastImage(),
                                child: const Icon(Icons.arrow_right),
                              ):SizedBox.shrink(),
                            ],
                          ),
                        ),
                        (orientation == Orientation.portrait)? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () => cubit.nextImage(),
                                child: const Icon(Icons.arrow_left),
                              ),

                              ElevatedButton(
                                onPressed: () {
                                  cubit.toggleScrolling(); // Toggle play/pause
                                },
                                child: Icon(cubit.isScrolling ? Icons.pause : Icons.play_arrow,color: Colors.blue,), // Change icon based on state
                              ),
                              ElevatedButton(

                                onPressed: () => cubit.lastImage(),
                                child: const Icon(Icons.arrow_right),
                              ),
                            ],
                          ),
                        ):SizedBox.shrink(),
                      ],
                    );
                    // }
                  },
                ),
              ));
        },
      ),
    );
  }
}
