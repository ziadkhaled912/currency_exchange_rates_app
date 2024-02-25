import 'package:bloc/bloc.dart';
import 'package:currency_exchange/core/data/api_manager/models/failures/failure.dart';
import 'package:currency_exchange/features/home/data/mappers/latest_rates_response_mapper.dart';
import 'package:currency_exchange/features/home/data/models/request_models/latest_rates_request_model.dart';
import 'package:currency_exchange/features/home/data/repository/currency_repository.dart';
import 'package:currency_exchange/features/home/domain/entities/currency.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'currency_state.dart';

@injectable
class CurrencyCubit extends Cubit<CurrencyState> {
  CurrencyCubit(this._repository) : super(const CurrencyState());

  final CurrencyRepository _repository;
  LatestRatesRequestModel? _requestModel;

  Future<void> getLatestRates(LatestRatesRequestModel request) async {
    _requestModel = request;
    emit(state.requestLoading());
    final result = await _repository.getLatestRates(request);
    emit(result.fold(
      (l) => state.requestFail(l),
      (data) {
        final currencies = data.data?.values.map((e) => e.toEntity()).toList() ?? [];
        return state.requestSuccess(currencies);
      },
    ));
  }

  Future<void> retry() async {
    if(_requestModel != null) {
      await getLatestRates(_requestModel!);
    }
  }
}
