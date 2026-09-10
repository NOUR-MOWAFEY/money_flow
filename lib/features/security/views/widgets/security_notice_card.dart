import 'package:flutter/material.dart';
import 'package:money_flow/core/widgets/notice_card.dart';

class SecurityNoticeCard extends StatelessWidget {
  const SecurityNoticeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const NoticeCard(
      title: 'End-to-End Local Security',
      description:
          'Your 6-digit PIN is cryptographically hashed with SHA-256 and stored exclusively inside your device secure enclave/keychain.',
    );
  }
}
