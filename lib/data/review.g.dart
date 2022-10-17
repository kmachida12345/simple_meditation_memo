// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

const ReviewSchema = Schema(
  name: r'Review',
  id: 6095424258056407391,
  properties: {
    r'review': PropertySchema(
      id: 0,
      name: r'review',
      type: IsarType.long,
    )
  },
  estimateSize: _reviewEstimateSize,
  serialize: _reviewSerialize,
  deserialize: _reviewDeserialize,
  deserializeProp: _reviewDeserializeProp,
);

int _reviewEstimateSize(
  Review object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _reviewSerialize(
  Review object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.review);
}

Review _reviewDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Review();
  object.review = reader.readLongOrNull(offsets[0]);
  return object;
}

P _reviewDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ReviewQueryFilter on QueryBuilder<Review, Review, QFilterCondition> {
  QueryBuilder<Review, Review, QAfterFilterCondition> reviewIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'review',
      ));
    });
  }

  QueryBuilder<Review, Review, QAfterFilterCondition> reviewIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'review',
      ));
    });
  }

  QueryBuilder<Review, Review, QAfterFilterCondition> reviewEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'review',
        value: value,
      ));
    });
  }

  QueryBuilder<Review, Review, QAfterFilterCondition> reviewGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'review',
        value: value,
      ));
    });
  }

  QueryBuilder<Review, Review, QAfterFilterCondition> reviewLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'review',
        value: value,
      ));
    });
  }

  QueryBuilder<Review, Review, QAfterFilterCondition> reviewBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'review',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ReviewQueryObject on QueryBuilder<Review, Review, QFilterCondition> {}
