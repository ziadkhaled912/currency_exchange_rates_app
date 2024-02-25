import 'package:bloc/bloc.dart';
import 'package:currency_exchange/core/data/api_manager/models/failures/failure.dart';
import 'package:currency_exchange/features/gold_rates/data/models/gold_price_request_model.dart';
import 'package:currency_exchange/features/gold_rates/data/models/gold_price_response_model.dart';
import 'package:currency_exchange/features/gold_rates/data/repository/gold_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'gold_price_state.dart';

@injectable
class GoldPriceCubit extends Cubit<GoldPriceState> {
  GoldPriceCubit(this._repository) : super(const GoldPriceState());

  final GoldRepository _repository;
  GoldPriceRequestModel? _requestModel;

  Future<void> getGoldPrice(GoldPriceRequestModel request) async {
    _requestModel = request;
    emit(state.requestLoading());
    final result = await _repository.getGoldPrices(request);
    emit(result.fold(
          (l) => state.requestFail(l),
          (data) => state.requestSuccess(data),
    ));
  }

  Future<void> retry() async {
    if(_requestModel != null) {
      await getGoldPrice(_requestModel!);
    }
  }
}
