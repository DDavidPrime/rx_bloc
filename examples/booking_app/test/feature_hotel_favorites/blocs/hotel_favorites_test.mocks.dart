// Mocks generated by Mockito 5.4.2 from annotations
// in booking_app/test/feature_hotel_favorites/blocs/hotel_favorites_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:booking_app/base/common_blocs/coordinator_bloc.dart' as _i4;
import 'package:booking_app/base/repositories/paginated_hotels_repository.dart'
    as _i5;
import 'package:favorites_advanced_base/core.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:rx_bloc_list/models.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakePaginatedList_0<E> extends _i1.SmartFake
    implements _i2.PaginatedList<E> {
  _FakePaginatedList_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeHotel_1 extends _i1.SmartFake implements _i3.Hotel {
  _FakeHotel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCoordinatorBlocEvents_2 extends _i1.SmartFake
    implements _i4.CoordinatorBlocEvents {
  _FakeCoordinatorBlocEvents_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCoordinatorBlocStates_3 extends _i1.SmartFake
    implements _i4.CoordinatorBlocStates {
  _FakeCoordinatorBlocStates_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [PaginatedHotelsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockPaginatedHotelsRepository extends _i1.Mock
    implements _i5.PaginatedHotelsRepository {
  MockPaginatedHotelsRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.PaginatedList<_i3.Hotel>> getFavoriteHotelsPaginated({
    required int? pageSize,
    required int? page,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getFavoriteHotelsPaginated,
          [],
          {
            #pageSize: pageSize,
            #page: page,
          },
        ),
        returnValue: _i6.Future<_i2.PaginatedList<_i3.Hotel>>.value(
            _FakePaginatedList_0<_i3.Hotel>(
          this,
          Invocation.method(
            #getFavoriteHotelsPaginated,
            [],
            {
              #pageSize: pageSize,
              #page: page,
            },
          ),
        )),
      ) as _i6.Future<_i2.PaginatedList<_i3.Hotel>>);
  @override
  _i6.Future<_i2.PaginatedList<_i3.Hotel>> getHotelsPaginated({
    required _i3.HotelSearchFilters? filters,
    required int? pageSize,
    required int? page,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getHotelsPaginated,
          [],
          {
            #filters: filters,
            #pageSize: pageSize,
            #page: page,
          },
        ),
        returnValue: _i6.Future<_i2.PaginatedList<_i3.Hotel>>.value(
            _FakePaginatedList_0<_i3.Hotel>(
          this,
          Invocation.method(
            #getHotelsPaginated,
            [],
            {
              #filters: filters,
              #pageSize: pageSize,
              #page: page,
            },
          ),
        )),
      ) as _i6.Future<_i2.PaginatedList<_i3.Hotel>>);
  @override
  _i6.Future<List<_i3.Hotel>> getFavoriteHotels() => (super.noSuchMethod(
        Invocation.method(
          #getFavoriteHotels,
          [],
        ),
        returnValue: _i6.Future<List<_i3.Hotel>>.value(<_i3.Hotel>[]),
      ) as _i6.Future<List<_i3.Hotel>>);
  @override
  _i6.Future<List<_i3.Hotel>> getHotels({_i3.HotelSearchFilters? filters}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getHotels,
          [],
          {#filters: filters},
        ),
        returnValue: _i6.Future<List<_i3.Hotel>>.value(<_i3.Hotel>[]),
      ) as _i6.Future<List<_i3.Hotel>>);
  @override
  _i6.Future<_i3.Hotel> favoriteHotel(
    _i3.Hotel? hotel, {
    required bool? isFavorite,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #favoriteHotel,
          [hotel],
          {#isFavorite: isFavorite},
        ),
        returnValue: _i6.Future<_i3.Hotel>.value(_FakeHotel_1(
          this,
          Invocation.method(
            #favoriteHotel,
            [hotel],
            {#isFavorite: isFavorite},
          ),
        )),
      ) as _i6.Future<_i3.Hotel>);
  @override
  _i6.Future<List<_i3.Hotel>> fetchFullEntities(
    List<String>? ids, {
    bool? allProps = false,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchFullEntities,
          [ids],
          {#allProps: allProps},
        ),
        returnValue: _i6.Future<List<_i3.Hotel>>.value(<_i3.Hotel>[]),
      ) as _i6.Future<List<_i3.Hotel>>);
  @override
  _i6.Future<_i3.Hotel> hotelById(String? hotelId) => (super.noSuchMethod(
        Invocation.method(
          #hotelById,
          [hotelId],
        ),
        returnValue: _i6.Future<_i3.Hotel>.value(_FakeHotel_1(
          this,
          Invocation.method(
            #hotelById,
            [hotelId],
          ),
        )),
      ) as _i6.Future<_i3.Hotel>);
}

/// A class which mocks [CoordinatorBlocType].
///
/// See the documentation for Mockito's code generation for more information.
class MockCoordinatorBlocType extends _i1.Mock
    implements _i4.CoordinatorBlocType {
  MockCoordinatorBlocType() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.CoordinatorBlocEvents get events => (super.noSuchMethod(
        Invocation.getter(#events),
        returnValue: _FakeCoordinatorBlocEvents_2(
          this,
          Invocation.getter(#events),
        ),
      ) as _i4.CoordinatorBlocEvents);
  @override
  _i4.CoordinatorBlocStates get states => (super.noSuchMethod(
        Invocation.getter(#states),
        returnValue: _FakeCoordinatorBlocStates_3(
          this,
          Invocation.getter(#states),
        ),
      ) as _i4.CoordinatorBlocStates);
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [CoordinatorBlocStates].
///
/// See the documentation for Mockito's code generation for more information.
class MockCoordinatorBlocStates extends _i1.Mock
    implements _i4.CoordinatorBlocStates {
  MockCoordinatorBlocStates() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Stream<_i3.Hotel> get onHotelUpdated => (super.noSuchMethod(
        Invocation.getter(#onHotelUpdated),
        returnValue: _i6.Stream<_i3.Hotel>.empty(),
      ) as _i6.Stream<_i3.Hotel>);
  @override
  _i6.Stream<List<_i3.Hotel>> get onFetchedHotelsWithExtraDetails =>
      (super.noSuchMethod(
        Invocation.getter(#onFetchedHotelsWithExtraDetails),
        returnValue: _i6.Stream<List<_i3.Hotel>>.empty(),
      ) as _i6.Stream<List<_i3.Hotel>>);
  @override
  _i6.Stream<List<_i3.Hotel>> get onHotelsUpdated => (super.noSuchMethod(
        Invocation.getter(#onHotelsUpdated),
        returnValue: _i6.Stream<List<_i3.Hotel>>.empty(),
      ) as _i6.Stream<List<_i3.Hotel>>);
}

/// A class which mocks [CoordinatorBlocEvents].
///
/// See the documentation for Mockito's code generation for more information.
class MockCoordinatorBlocEvents extends _i1.Mock
    implements _i4.CoordinatorBlocEvents {
  MockCoordinatorBlocEvents() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void hotelUpdated(_i3.Hotel? hotel) => super.noSuchMethod(
        Invocation.method(
          #hotelUpdated,
          [hotel],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void hotelsWithExtraDetailsFetched(List<_i3.Hotel>? hotels) =>
      super.noSuchMethod(
        Invocation.method(
          #hotelsWithExtraDetailsFetched,
          [hotels],
        ),
        returnValueForMissingStub: null,
      );
}
