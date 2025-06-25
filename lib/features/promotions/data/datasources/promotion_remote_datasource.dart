import 'package:html/parser.dart' as html_parser;

import '../../../../core/network/http_client.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/logger.dart';

import '../models/promotion_model.dart';

final class PromotionRemoteDataSource {
  static const _baseUrl = 'https://xcasino.lvcstage.hu';

  final AppHttpClient client;

  PromotionRemoteDataSource({required this.client});

  Future<List<PromotionModel>> fetchPromotions() async {
    final uri = Uri.parse('$_baseUrl/cms/pages/promotions/test/en.html');

    try {
      final response = await client.get(uri);
      final document = html_parser.parse(response.body);
      final blocks = document.querySelectorAll('.content-block');

      return blocks.map((block) {
        final title = block.querySelector('.content-block-content__header')?.text.trim() ?? '';
        final description = block.querySelector('.content-block-content__text')?.text.trim() ?? '';

        final rawImage = block.querySelector('img')?.attributes['src'];
        final rawLink = block.querySelector('a')?.attributes['href'];

        final visibility = block.attributes['data-visibility'];
        final group = block.attributes['data-group'];

        return PromotionModel(
          title: title,
          description: description,
          imageUrl: resolveUrl(rawImage, baseUrl: _baseUrl),
          link: resolveUrl(rawLink, baseUrl: _baseUrl),
          visibility: visibility,
          group: group,
        );
      }).toList(growable: false);
    } on Failure catch (e, st) {
      AppLogger.error(e, stackTrace: st);
      rethrow;
    } catch (e, st) {
      AppLogger.error(e, stackTrace: st);
      throw ParsingFailure('Failed to parse promotions');
    }
  }
}

String resolveUrl(String? value, {required String baseUrl}) {
  if (value == null || value.trim().isEmpty) return '';
  final trimmed = value.trim();

  if (trimmed.startsWith('http')) {
    return trimmed;
  }

  return trimmed.startsWith('/') ? '$baseUrl$trimmed' : '$baseUrl/$trimmed';
}
