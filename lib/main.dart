import 'package:campus_connect/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  } on UnsupportedError catch (error, stackTrace) {
    _reportFirebaseInitializationError(error, stackTrace);
    app = FirebaseSetupRequiredApp(message: error.toString());
  } on FirebaseException catch (error, stackTrace) {
    _reportFirebaseInitializationError(error, stackTrace);
    app = FirebaseInitializationFailedApp(
      message: error.message ?? error.toString(),
    );
  } on PlatformException catch (error, stackTrace) {
    _reportFirebaseInitializationError(error, stackTrace);
    app = FirebaseInitializationFailedApp(
      message: error.message ?? error.toString(),
    );
  }

  runApp(app);
}

void _reportFirebaseInitializationError(Object error, StackTrace stackTrace) {
  FlutterError.reportError(
    FlutterErrorDetails(
      exception: error,
      stack: stackTrace,
      library: 'campus_connect',
      context: ErrorDescription('while initializing Firebase'),
    ),
  );
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
    return _FirebaseStatusApp(
      title: 'Firebase setup required',
      description:
          'This repository keeps Firebase runtime config local. Add native '
          'Android and iOS service files for your own Firebase project before '
          'running the app.',
      steps:
          '1. Download local mobile Firebase config files or run\n'
          '   bash scripts/fetch_firebase_mobile_config.sh '
          '<project-id> <android-app-id> <ios-app-id>\n'
          '2. Add android/app/google-services.json\n'
          '3. Add ios/Runner/GoogleService-Info.plist',
      message: message,
    );
  }
}

class FirebaseInitializationFailedApp extends StatelessWidget {
  final String message;

  const FirebaseInitializationFailedApp({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return _FirebaseStatusApp(
      title: 'Firebase initialization failed',
      description:
          'Firebase could not be initialized on this device. Verify your '
          'local mobile config files and Firebase app registration for this '
          'platform.',
      steps:
          '1. Confirm android/app/google-services.json or\n'
          '   ios/Runner/GoogleService-Info.plist exists for this platform\n'
          '2. Verify the package name or bundle identifier matches Firebase\n'
          '3. Re-fetch local files if needed with the helper script',
      message: message,
    );
  }
}

class _FirebaseStatusApp extends StatelessWidget {
  final String title;
  final String description;
  final String steps;
  final String message;

  const _FirebaseStatusApp({
    required this.title,
    required this.description,
    required this.steps,
    required this.message,
  });

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
                      title,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(description, textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    SelectableText(steps),
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
