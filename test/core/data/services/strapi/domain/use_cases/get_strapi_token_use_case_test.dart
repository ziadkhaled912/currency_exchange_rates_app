// import 'package:base_project/core/data/services/strapi/domain/entities/user_request.dart';
// import 'package:base_project/core/data/services/strapi/domain/repositories/strapi_repository.dart';
// import 'package:base_project/core/data/services/strapi/domain/use_cases/get_strapi_token_use_case.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
//
// class MockStrapiRepository extends Mock implements StrapiRepository {}
//
// void main() {
//   late MockStrapiRepository mockStrapiRepository;
//   late StrapiTokenGetUseCase strapiTokenGetUseCase;
//
//   setUp(() {
//     mockStrapiRepository = MockStrapiRepository();
//     strapiTokenGetUseCase = StrapiTokenGetUseCase(mockStrapiRepository);
//   });
//
//   final tStrapiToken = "token";
//   final tStrapiUser = StrapiUser("identifier", "password");
//
//   group("getStrapiToken", () {
//     test("should return token if connection to repository success", () async {
//       // arrange
//       when(() => mockStrapiRepository.getStrapiToken(tStrapiUser))
//           .thenAnswer((_) async => Right(tStrapiToken));
//       // act
//       final result = await strapiTokenGetUseCase.call(StrapiTokenParams(tStrapiUser));
//       // assert
//       expect(result, Right(tStrapiToken));
//       verify(() => mockStrapiRepository.getStrapiToken(tStrapiUser));
//       verifyNoMoreInteractions(mockStrapiRepository);
//     });
//   });
// }
