import '../entities/promotion.dart';

abstract interface class PromotionRepository {
  Future<List<Promotion>> fetchAll();
}
