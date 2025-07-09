/// Module: Specification Pattern
///
/// Defines a generic `Specification<T>` abstract class for encapsulating
/// business rules as predicates, along with combinator methods (`and`, `or`)
/// and concrete implementations (`AndSpecification`, `OrSpecification`).
///
/// **Example Usage:**
/// ```dart
/// // Filter sessions by mentor name "Alice Smith"
/// final spec = Filter(
///   field: Field.mentorName,
///   filterOperator: FilterOperator.equals,
///   filterText: "Alice Smith",
/// ).toSpecification();
///
/// final filtered = sessions.where(spec.isSatisfiedBy).toList();
/// // filtered contains only sessions by Alice Smith
/// ```
library;

/// Abstract base class for specifications that test whether a candidate
/// object satisfies a given condition.
///
/// Implementations must override [isSatisfiedBy]. Provides combinators:
/// - `and`: logical conjunction of two specifications.
/// - `or`: logical disjunction of two specifications.
abstract class Specification<T> {
  /// Evaluates whether the given candidate satisfies this specification.
  ///
  /// **Parameters:**
  /// - `candidate` (`T`): The object to test.
  ///
  /// **Returns:** `true` if the candidate meets the specification.
  bool isSatisfiedBy(T candidate);

  /// Combines this specification with another using logical AND.
  ///
  /// **Parameters:**
  /// - `other` (`Specification<T>`): The other specification to combine.
  ///
  /// **Returns:** A new `Specification<T>` that is satisfied only if both
  /// this and `other` are satisfied.
  Specification<T> and(Specification<T> other) => AndSpecification(this, other);

  /// Combines this specification with another using logical OR.
  ///
  /// **Parameters:**
  /// - `other` (`Specification<T>`): The other specification to combine.
  ///
  /// **Returns:** A new `Specification<T>` that is satisfied if either
  /// this or `other` is satisfied.
  Specification<T> or(Specification<T> other) => OrSpecification(this, other);
}

/// A composite specification that requires both sub-specifications to be satisfied.
class AndSpecification<T> extends Specification<T> {
  final Specification<T> a, b;

  /// Constructs an `AndSpecification` from two specifications.
  ///
  /// **Parameters:**
  /// - `a` (`Specification<T>`): The first specification.
  /// - `b` (`Specification<T>`): The second specification.
  AndSpecification(this.a, this.b);

  /// Returns true if both underlying specifications are satisfied by `c`.
  ///
  /// **Parameters:**
  /// - `c` (`T`): The candidate object.
  @override
  bool isSatisfiedBy(T c) => a.isSatisfiedBy(c) && b.isSatisfiedBy(c);
}

/// A composite specification that requires at least one sub-specification to be satisfied.
class OrSpecification<T> extends Specification<T> {
  final Specification<T> a, b;

  /// Constructs an `OrSpecification` from two specifications.
  ///
  /// **Parameters:**
  /// - `a` (`Specification<T>`): The first specification.
  /// - `b` (`Specification<T>`): The second specification.
  OrSpecification(this.a, this.b);

  /// Returns true if at least one underlying specification is satisfied by `c`.
  ///
  /// **Parameters:**
  /// - `c` (`T`): The candidate object.
  @override
  bool isSatisfiedBy(T c) => a.isSatisfiedBy(c) || b.isSatisfiedBy(c);
}
