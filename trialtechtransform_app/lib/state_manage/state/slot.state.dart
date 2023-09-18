import 'package:trialtechtransform_app/models/lawyer.model.dart';

class SlotStates {}

class FetchingSlotsStat extends SlotStates {}

class ErrorInFetchedState extends SlotStates {
  String err;
  ErrorInFetchedState({
    required this.err,
  });
}

class FetchedSlotsState extends SlotStates {
  List<LawyerModel> lawyerId;
  FetchedSlotsState({required this.lawyerId});
}

class SlotInitialState extends SlotStates {}
