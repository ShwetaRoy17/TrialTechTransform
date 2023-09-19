import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trialtechtransform_app/models/lawyer.model.dart';
import 'package:trialtechtransform_app/models/slot.model.dart';
import 'package:trialtechtransform_app/services/utp.services.dart';
import 'package:trialtechtransform_app/state_manage/state/slot.state.dart';

class SlotCubit extends Cubit<SlotStates> {
  SlotCubit() : super(SlotInitialState());

  void fetchSlot(DateTime date) async {
    emit(FetchingSlotsStat());

    try {
      List<SlotModel> lawyersId = await UtpService().fetchLawyers(date);
      emit(FetchedSlotsState(slots: lawyersId));
    } on FirebaseAuthException catch (e) {
      emit(ErrorInFetchedState(err: e.message.toString()));
    }
  }
}
