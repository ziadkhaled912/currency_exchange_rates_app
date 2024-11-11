import 'package:bloc_test/bloc_test.dart';
import 'package:currency_exchange/core/presentation/cubits/language_cubit/language_cubit.dart';

class MockLanguageCubit extends MockCubit<LanguageState>
    implements LanguageCubit {}

    const languageState = LanguageState();

void setupWhenListen(LanguageCubit cubit, [LanguageState? state]) => whenListen(
      cubit,
      Stream.value(state ?? languageState),
      initialState: state ?? languageState,
    );
