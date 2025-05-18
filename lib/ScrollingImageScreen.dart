import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ScrollingImageCubit.dart' ;
import 'UpdateCubite.dart';

class ScrollingImageScreen extends StatelessWidget {
  const ScrollingImageScreen({super.key});
  @override
  Widget build(BuildContext context) {
     return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ScrollingImageCubit()),
          BlocProvider(create: (context) => UpdateCubit(context.read<ScrollingImageCubit>())),
        ],
        child: BlocBuilder<ScrollingImageCubit, ScrollingImageState>(
        builder: (context, state) {
        final cubit = context.read<ScrollingImageCubit>();

      final image = cubit.image;
      cubit.startScrolling();
          return Scaffold(
              body: GestureDetector(
                onTap: () => cubit.pauseScrolling(),
                child: OrientationBuilder(
                  builder: (context, orientation) {
                    cubit.speedratio= (orientation != Orientation.portrait)?1:0.5;

                    Future.delayed(Duration(milliseconds: 50), ()  {
                      cubit.restoreScrollPosition();

                    });
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
                          padding: const EdgeInsets.all(0.0),
                          child: SizedBox(
                    height: 30,
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
                              BlocBuilder<UpdateCubit, UpdateState>(
                                builder: (context, updateState) {
                                  return SizedBox(
                                    width: 200,
                                    height: 40,
                                    child: TextField(
                                      controller: cubit.textController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(bottom: 8),
                                        hintText: updateState.text, // ✅ using dynamic hint
                                        border: OutlineInputBorder(),
                                      ),
                                      onSubmitted: (value) {
                                        cubit.setImageIndex(value);
                                      },
                                    ),
                                  );
                                },
                              ),
                              (orientation != Orientation.portrait)?ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/Help'); // Toggle play/pause
                                },
                                child: Icon(Icons.help), // Change icon based on state
                              ):SizedBox.shrink(),
                              (orientation != Orientation.portrait)? ElevatedButton(

                                onPressed: () => cubit.lastImage(),
                                child: const Icon(Icons.arrow_right),
                              ):SizedBox.shrink(),

                            ],
                          ),
                        )),
                        (orientation == Orientation.portrait)? Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: SizedBox(
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () => cubit.nextImage(),
                                  child: const Icon(Icons.arrow_left),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    cubit.toggleScrolling();
                                  },
                                  child: Icon(
                                    cubit.isScrolling ? Icons.pause : Icons.play_arrow,
                                    color: Colors.blue,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/Help'); // Toggle play/pause
                                  },
                                  child: Icon(Icons.help), // Change icon based on state
                                ),
                                ElevatedButton(
                                  onPressed: () => cubit.lastImage(),
                                  child: const Icon(Icons.arrow_right),
                                ),
                                ],
                            ),
                          ),
                        )
                            :SizedBox.shrink(),
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
