part of 'gold_price_cubit.dart';

class GoldPriceState extends Equatable {
  const GoldPriceState({
    this.isLoading = false,
    this.failure,
    this.responseModel,
  });

  final bool isLoading;
  final Failure? failure;
  final GoldPriceResponseModel? responseModel;

  GoldPriceState requestLoading() =>
      copyWith(
        isLoading: true,
        failure: null,
        responseModel: null,
      );

  GoldPriceState requestSuccess(GoldPriceResponseModel responseModel) =>
      copyWith(
        isLoading: false,
        responseModel: responseModel,
      );

  GoldPriceState requestFail(Failure failure) =>
      copyWith(
        isLoading: false,
        failure: failure,
      );

  GoldPriceState copyWith({
    bool? isLoading,
    Failure? failure,
    GoldPriceResponseModel? responseModel,
  }) {
    return GoldPriceState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      responseModel: responseModel ?? this.responseModel,
    );
  }

  @override
  List<Object?> get props => [isLoading, failure, responseModel];
}
