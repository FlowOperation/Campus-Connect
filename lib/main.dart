import 'package:campus_connect/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Widget app = const ProviderScope(child: CampusConnectApp());

  try {
    if (!_supportsNativeFirebaseConfiguration()) {
      throw UnsupportedError(
        'Firebase is configured for Android and iOS only in this repository. '
        'Use a mobile target with local platform config files.',
      );
    }

    await Firebase.initializeApp();
  } catch (error) {
    app = FirebaseSetupRequiredApp(message: error.toString());
  }

  runApp(app);
}

bool _supportsNativeFirebaseConfiguration() {
  if (kIsWeb) {
    return false;
  }

  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
    case TargetPlatform.iOS:
      return true;
    case TargetPlatform.fuchsia:
    case TargetPlatform.linux:
    case TargetPlatform.macOS:
    case TargetPlatform.windows:
      return false;
  }
}

class FirebaseSetupRequiredApp extends StatelessWidget {
  final String message;

  const FirebaseSetupRequiredApp({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.settings_input_component_outlined,
                      size: 56,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Firebase setup required',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'This repository keeps Firebase runtime config local. '
                      'Add native Android and iOS service files for your own '
                      'Firebase project before running the app.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    const SelectableText(
                      '1. Download local mobile Firebase config files or run\n'
                      '   bash scripts/fetch_firebase_mobile_config.sh '
                      '<project-id> <android-app-id> <ios-app-id>\n'
                      '2. Add android/app/google-services.json\n'
                      '3. Add ios/Runner/GoogleService-Info.plist',
                    ),
                    const SizedBox(height: 16),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
