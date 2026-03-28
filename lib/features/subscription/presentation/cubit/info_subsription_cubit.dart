import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mstech/features/subscription/domain/entity/subscription.dart';

class InfoSubsriptionCubit extends Cubit<Subscription?> {
  InfoSubsriptionCubit() : super(null);

  void setSubscriptionInfo({required Subscription? subscription}) {
    emit(subscription);
  }
}
