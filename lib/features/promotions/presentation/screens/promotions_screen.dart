import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../app/constants/app_colors.dart';
import '../../../user_selector/screens/user_selector_screen.dart';
import '../providers/promotions_provider.dart';
import '../widgets/promotion_card.dart';

class PromotionsScreen extends ConsumerStatefulWidget {
  const PromotionsScreen({super.key});

  @override
  ConsumerState<PromotionsScreen> createState() => _PromotionsScreenState();
}

class _PromotionsScreenState extends ConsumerState<PromotionsScreen> {
  late UserMode _userMode;
  bool _isInitialized = false;

  int _visibleCount = 0;
  int _hiddenCount = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInitialized) return;

    final extra = GoRouterState.of(context).extra;
    _userMode = extra is UserMode ? extra : UserMode.prelogin;
    _isInitialized = true;
  }

  bool _shouldShow({
    required String? visibility,
    required String? group,
  }) {
    if ((visibility == null || visibility.isEmpty) &&
        (group == null || group.isEmpty)) {
      return true;
    }

    final isPrelogin = visibility == 'prelogin';
    final isPostlogin = visibility == 'postlogin';
    final hasGroupTeszt = group?.toLowerCase().contains('teszt') ?? false;

    switch (_userMode) {
      case UserMode.prelogin:
        return isPrelogin;
      case UserMode.postlogin:
        return isPostlogin && !hasGroupTeszt;
      case UserMode.postloginWithGroup:
        return isPostlogin || hasGroupTeszt;
    }
  }

  @override
  Widget build(BuildContext context) {
    final promotionsAsync = ref.watch(fetchPromotionsProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 12),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: AppBar(
              backgroundColor: Colors.black.withAlpha((0.15 * 255).round()),
              elevation: 0,
              title: const Text('Promotions'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.pop(),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.bug_report),
                  onPressed: _showDebugPanel,
                  tooltip: 'Debug Panel',
                ),
              ],
            ),
          ),
        ),
      ),
      body: promotionsAsync.when(
        data: (promos) {
          _visibleCount = 0;
          _hiddenCount = 0;

          final filteredPromos = promos.where((p) {
            final vis = p.extraData['visibility'];
            final group = p.extraData['group'];
            final visible = _shouldShow(visibility: vis, group: group);
            visible ? _visibleCount++ : _hiddenCount++;
            return visible;
          }).toList(growable: false);

          return Padding(
            padding: const EdgeInsets.only(top: kToolbarHeight + 8),
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: filteredPromos.length,
              itemBuilder: (_, i) => Padding(
                padding: EdgeInsets.only(
                  top: i == 0 ? kToolbarHeight + 24 : 0,
                ),
                child: PromotionCard(promotion: filteredPromos[i]),
              ),
            ),
          );
        },
        error: (e, _) => Center(child: Text('Error: ${e.toString()}')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      bottomNavigationBar: _buildGlassNavigationBar(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.main,
        elevation: 6,
        shape: const CircleBorder(),
        onPressed: () => context.go('/'),
        child: const Icon(Icons.home, color: AppColors.dark),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildGlassNavigationBar(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFF000000).withAlpha(38),
            border: const Border(top: BorderSide(color: Colors.white12)),
          ),
        ),
      ),
    );
  }

  void _showDebugPanel() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Wrap(
          runSpacing: 16,
          children: [
            Row(
              children: [
                const Icon(Icons.bug_report, color: Colors.white),
                const SizedBox(width: 12),
                Text(
                  'Debug Panel',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.person, color: Colors.white70),
                const SizedBox(width: 8),
                Text('User Mode: $_userMode'),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.visibility, color: Colors.greenAccent),
                const SizedBox(width: 8),
                Text('Visible Promotions: $_visibleCount'),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.visibility_off, color: Colors.redAccent),
                const SizedBox(width: 8),
                Text('Hidden Promotions: $_hiddenCount'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
