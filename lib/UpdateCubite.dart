import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ScrollingImageCubit.dart';
class UpdateCubit extends Cubit<UpdateState> {
  final ScrollingImageCubit scrollingImageCubit;
  late final Timer _timer;
  double? _lastOffset;

  UpdateCubit(this.scrollingImageCubit) : super(UpdateState("Enter page Number")) {
    _lastOffset = 0;

    _timer = Timer.periodic(Duration(seconds: 20), (_) {
      if (scrollingImageCubit.scrollController.hasClients) {
        double currentOffset = scrollingImageCubit.scrollController.offset;
        if (currentOffset != _lastOffset) {
          _lastOffset = currentOffset;
          updateHint();
        }
      }
    });
  }

  void updateHint() {
    final newText = scrollingImageCubit.pageData(); // or use _lastOffset.toString()
    emit(UpdateState(newText)); // ✅ emit new state with text
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
class UpdateState {
  final String text;
  UpdateState(this.text);
}