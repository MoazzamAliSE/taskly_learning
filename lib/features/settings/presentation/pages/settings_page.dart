import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:easy_localization/easy_localization.dart';

final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text('settings.title'.tr()),
            centerTitle: true,
            floating: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.palette,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text('settings.theme.title'.tr()),
                        subtitle: Text(
                          _getThemeName(themeMode),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        trailing: DropdownButton<ThemeMode>(
                          value: themeMode,
                          items: [
                            DropdownMenuItem(
                              value: ThemeMode.system,
                              child: Text('settings.theme.system'.tr()),
                            ),
                            DropdownMenuItem(
                              value: ThemeMode.light,
                              child: Text('settings.theme.light'.tr()),
                            ),
                            DropdownMenuItem(
                              value: ThemeMode.dark,
                              child: Text('settings.theme.dark'.tr()),
                            ),
                          ],
                          onChanged: (ThemeMode? newThemeMode) {
                            if (newThemeMode != null) {
                              ref.read(themeProvider.notifier).state =
                                  newThemeMode;
                            }
                          },
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        leading: Icon(
                          Icons.language,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text('settings.language.title'.tr()),
                        subtitle: Text(
                          _getLanguageName(context.locale),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        trailing: DropdownButton<Locale>(
                          value: context.locale,
                          items: [
                            DropdownMenuItem(
                              value: const Locale('en'),
                              child: Text('settings.language.english'.tr()),
                            ),
                            DropdownMenuItem(
                              value: const Locale('es'),
                              child: Text('settings.language.spanish'.tr()),
                            ),
                          ],
                          onChanged: (Locale? newLocale) {
                            if (newLocale != null) {
                              context.setLocale(newLocale);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn().slideY(begin: -0.2),
                const SizedBox(height: 16),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.info,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text('settings.about.title'.tr()),
                        subtitle: Text('app.version'.tr()),
                        onTap: () {
                          showAboutDialog(
                            context: context,
                            applicationName: 'app.title'.tr(),
                            applicationVersion: 'app.version'.tr(),
                            applicationIcon: const FlutterLogo(size: 48),
                            children: [
                              Text('settings.about.description'.tr()),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ).animate().fadeIn().slideY(
                      begin: 0.2,
                      delay: const Duration(milliseconds: 200),
                    ),
                const SizedBox(height: 16),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.help_outline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text('settings.help.title'.tr()),
                        onTap: () {
                          // TODO: Implement help & support
                        },
                      ),
                      const Divider(),
                      ListTile(
                        leading: Icon(
                          Icons.privacy_tip_outlined,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text('settings.privacy.title'.tr()),
                        onTap: () {
                          // TODO: Implement privacy policy
                        },
                      ),
                    ],
                  ),
                ).animate().fadeIn().slideY(
                      begin: 0.2,
                      delay: const Duration(milliseconds: 400),
                    ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  String _getThemeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'settings.theme.system'.tr();
      case ThemeMode.light:
        return 'settings.theme.light'.tr();
      case ThemeMode.dark:
        return 'settings.theme.dark'.tr();
    }
  }

  String _getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'settings.language.english'.tr();
      case 'es':
        return 'settings.language.spanish'.tr();
      default:
        return 'settings.language.english'.tr();
    }
  }
}
