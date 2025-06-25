import '../../domain/entities/promotion.dart';
import '../../domain/repositories/promotion_repository.dart';
import '../datasources/promotion_remote_datasource.dart';

final class PromotionRepositoryImpl implements PromotionRepository {
  final PromotionRemoteDataSource remote;

  PromotionRepositoryImpl(this.remote);

  @override
  Future<List<Promotion>> fetchAll() async {
    final models = await remote.fetchPromotions();
    return models.map((e) => e.toEntity()).toList(growable: false);
  }
}
