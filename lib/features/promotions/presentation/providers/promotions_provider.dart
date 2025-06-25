import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../domain/entities/promotion.dart';
import '../../domain/usecases/fetch_promotions.dart';
import '../../data/datasources/promotion_remote_datasource.dart';
import '../../data/repositories/promotion_repository_impl.dart';
import '../../../../core/network/http_client.dart';

final httpClientProvider = Provider<AppHttpClient>((ref) {
  return AppHttpClient();
});

final promotionRemoteDataSourceProvider = Provider<PromotionRemoteDataSource>((ref) {
  final client = ref.watch(httpClientProvider);
  return PromotionRemoteDataSource(client: client);
});

final promotionRepositoryProvider = Provider<PromotionRepositoryImpl>((ref) {
  final remote = ref.watch(promotionRemoteDataSourceProvider);
  return PromotionRepositoryImpl(remote);
});

final fetchPromotionsUseCaseProvider = Provider<FetchPromotions>((ref) {
  final repository = ref.watch(promotionRepositoryProvider);
  return FetchPromotions(repository);
});

final fetchPromotionsProvider = FutureProvider<List<Promotion>>((ref) async {
  final useCase = ref.watch(fetchPromotionsUseCaseProvider);
  return await useCase();
});
