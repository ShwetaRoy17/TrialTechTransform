import 'package:trialtechtransform_app/models/lawyer.model.dart';

import '../../models/slot.model.dart';

class SlotStates {}

class FetchingSlotsStat extends SlotStates {}

class ErrorInFetchedState extends SlotStates {
  String err;
  ErrorInFetchedState({
    required this.err,
  });
}

class FetchedSlotsState extends SlotStates {
  List<SlotModel> slots;
  FetchedSlotsState({required this.slots});
}

class SlotInitialState extends SlotStates {}
