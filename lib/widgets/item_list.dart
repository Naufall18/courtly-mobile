import 'package:flutter/material.dart';
import '../models/item.dart';
import '../data/repo.dart';
import '../config.dart';
import 'item_form.dart';

class ItemList extends StatelessWidget {
  final ItemRepo repo;
  final List<Item> Function() selector;
  const ItemList({super.key, required this.repo, required this.selector});

  void _openForm(BuildContext context, {Item? existing}) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ItemForm(repo: repo, existing: existing)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: repo,
      builder: (context, _) {
        if (!repo.loaded) {
          return const Center(child: CircularProgressIndicator());
        }
        final items = selector();
        if (items.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.event_busy,
                      size: 56, color: Theme.of(context).colorScheme.outline),
                  const SizedBox(height: 14),
                  Text('No ${AppConfig.noun.toLowerCase()}s yet',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 6),
                  Text('Book a court and it will show up here.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.outline)),
                  const SizedBox(height: 18),
                  FilledButton.icon(
                    onPressed: () => _openForm(context),
                    icon: const Icon(Icons.add),
                    label: Text('Add ${AppConfig.noun}'),
                  ),
                ],
              ),
            ),
          );
        }
        return ListView.separated(
          itemCount: items.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, i) {
            final it = items[i];
            final sub = [
              if (it.detail.isNotEmpty) it.detail,
              if (it.category.isNotEmpty) it.category,
            ].join('  ·  ');
            return Dismissible(
              key: ValueKey(it.id),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (_) => repo.remove(it.id),
              child: ListTile(
                leading: AppConfig.usesFlag
                    ? Checkbox(
                        value: it.flag, onChanged: (_) => repo.toggle(it.id))
                    : CircleAvatar(child: Text(it.title.characters.first)),
                title: Text(it.title),
                subtitle: sub.isEmpty ? null : Text(sub),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (AppConfig.usesFlag)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 3),
                        decoration: BoxDecoration(
                          color: (it.flag ? Colors.green : Colors.orange)
                              .withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          it.flag ? AppConfig.flagLabel : 'Pending',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: it.flag
                                ? Colors.green.shade800
                                : Colors.orange.shade800,
                          ),
                        ),
                      ),
                    if (AppConfig.usesValue)
                      Text(
                        it.value.toStringAsFixed(0),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    const SizedBox(width: 4),
                    const Icon(Icons.chevron_right),
                  ],
                ),
                onTap: () => _openForm(context, existing: it),
              ),
            );
          },
        );
      },
    );
  }
}
