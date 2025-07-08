abstract class Specification<T> {
  bool isSatisfiedBy(T candidate);

  Specification<T> and(Specification<T> other) => AndSpecification(this, other);
  Specification<T> or(Specification<T> other) => OrSpecification(this, other);
}

class AndSpecification<T> extends Specification<T> {
  final Specification<T> a, b;
  AndSpecification(this.a, this.b);
  @override
  bool isSatisfiedBy(T c) => a.isSatisfiedBy(c) && b.isSatisfiedBy(c);
}

class OrSpecification<T> extends Specification<T> {
  final Specification<T> a, b;
  OrSpecification(this.a, this.b);
  @override
  bool isSatisfiedBy(T c) => a.isSatisfiedBy(c) || b.isSatisfiedBy(c);
}
