import 'package:flutter/material.dart';

class DataLoadError extends StatelessWidget {
  const DataLoadError({super.key, required this.onRetry});
  final VoidCallback onRetry;
  @override
  Widget build(BuildContext context) => Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
            child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                        'Не удалось загрузить данные. Проверьте подключение к интернету.',
                        textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    TextButton(
                        onPressed: onRetry, child: const Text('Повторить')),
                  ],
                ))),
      );
}
