import '../entities/promotion.dart';
import '../repositories/promotion_repository.dart';

final class FetchPromotions {
  final PromotionRepository repository;

  FetchPromotions(this.repository);

  Future<List<Promotion>> call() => repository.fetchAll();
}
