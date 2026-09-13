import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_flow/core/constants/app_colors.dart';
import 'package:money_flow/core/constants/app_dimensions.dart';
import 'package:money_flow/core/services/hive_service.dart';
import 'package:money_flow/core/utils/show_toastification.dart';
import 'package:money_flow/core/widgets/custom_text.dart';
import 'package:money_flow/features/home/view_models/balance_visibility_cubit/balance_visibility_cubit.dart';
import 'package:money_flow/features/home/views/widgets/user_image.dart';
import 'package:money_flow/features/profile/views/profile_view.dart';
import 'package:money_flow/features/security/view_model/app_lock_cubit/app_lock_cubit.dart';

class UserGreetingSection extends StatelessWidget {
  const UserGreetingSection({super.key, this.onTap});
  final void Function()? onTap;

  void _handleLock(BuildContext context) {
    final appLockCubit = context.read<AppLockCubit>();
    final locked = appLockCubit.lockNow();
    if (!locked) {
      ShowToastification.warning(
        context,
        'App Lock is disabled. Set up a PIN in Security Settings.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: HiveService.watchUserModel(),
      builder: (context, _) {
        final user = HiveService.getUserModel();
        final name = (user != null && user.name.trim().isNotEmpty)
            ? user.name.trim()
            : 'User';

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.viewPadding,
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                // User info (Avatar + Greeting), tappable to open Profile
                Expanded(
                  child: InkWell(
                    onTap:
                        onTap ??
                        () {
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                              builder: (_) => const ProfileView(),
                            ),
                          );
                        },
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          const UserImage(radius: 24),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const CustomText(
                                  'Hello,',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                                CustomText(
                                  name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // Trailing Action Button: Hide / Show Balance
                BlocBuilder<BalanceVisibilityCubit, bool>(
                  builder: (context, isHidden) {
                    return _HeaderActionButton(
                      icon: isHidden
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      tooltip: isHidden ? 'Show balance' : 'Hide balance',
                      isActive: isHidden,
                      onTap: () =>
                          context.read<BalanceVisibilityCubit>().toggle(),
                    );
                  },
                ),

                const SizedBox(width: 8),

                // Trailing Action Button: Instant App Lock
                _HeaderActionButton(
                  icon: Icons.lock_outline_rounded,
                  tooltip: 'Lock app',
                  onTap: () => _handleLock(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HeaderActionButton extends StatelessWidget {
  const _HeaderActionButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.isActive = false,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primary.withValues(alpha: 0.25)
                  : AppColors.black1,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isActive
                    ? AppColors.primary.withValues(alpha: 0.6)
                    : Colors.white.withValues(alpha: 0.08),
                width: 1,
              ),
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, anim) =>
                    ScaleTransition(scale: anim, child: child),
                child: Icon(
                  icon,
                  key: ValueKey(icon),
                  size: 20,
                  color: isActive ? Colors.white : AppColors.icon,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
