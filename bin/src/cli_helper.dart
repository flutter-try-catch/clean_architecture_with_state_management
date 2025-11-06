import 'dart:io';
import 'package:interact/interact.dart' as interact;

/// Helper class for interactive CLI operations with colors and prompts
class CLIHelper {
  // ANSI color codes
  static const String _reset = '\x1B[0m';
  static const String _red = '\x1B[31m';
  static const String _green = '\x1B[32m';
  static const String _yellow = '\x1B[33m';
  static const String _magenta = '\x1B[35m';
  static const String _cyan = '\x1B[36m';
  static const String _bold = '\x1B[1m';
  static const String _dim = '\x1B[2m';

  /// Print an error message in red
  static void error(String message) {
    print('$_red✗ $_bold$message$_reset');
  }

  /// Print a success message in green
  static void success(String message) {
    print('$_green✓ $message$_reset');
  }

  /// Print a warning message in yellow
  static void warning(String message) {
    print('$_yellow⚠ $message$_reset');
  }

  /// Print an info message in cyan
  static void info(String message) {
    print('$_cyan ℹ $message$_reset');
  }

  /// Print a header/title in magenta
  static void header(String message) {
    print('\n$_magenta$_bold═══════════════════════════════════════════$_reset');
    print('$_magenta$_bold  $message$_reset');
    print('$_magenta$_bold═══════════════════════════════════════════$_reset\n');
  }

  /// Print a section title
  static void section(String message) {
    print('\n$_cyan$_bold▶ $message$_reset');
  }

  /// Print a step/progress message
  static void step(String message) {
    print('  $_dim→$_reset $message');
  }

  /// Print a created file message
  static void fileCreated(String path) {
    print('  $_green✓$_reset Created: $_dim$path$_reset');
  }

  /// Print a skipped file message
  static void fileSkipped(String path) {
    print('  $_yellow⊘$_reset Skipped: $_dim$path$_reset');
  }

  /// Print completion message with summary
  static void complete(String message, {int? filesCreated}) {
    print('\n$_green$_bold════════════════════════════════════════════$_reset');
    print('$_green$_bold  ✓ $message$_reset');
    if (filesCreated != null) {
      print('$_green$_bold  Files created: $filesCreated$_reset');
    }
    print('$_green$_bold════════════════════════════════════════════$_reset\n');
  }

  /// Ask a yes/no question
  static bool confirm(String question, {bool defaultValue = true}) {
    return interact.Confirm(
      prompt: question,
      defaultValue: defaultValue,
      waitForNewLine: true,
    ).interact();
  }

  /// Get text input from user
  static String input(String prompt, {String? defaultValue, bool validate = true}) {
    while (true) {
      final input = interact.Input(
        prompt: prompt,
        defaultValue: defaultValue ?? '',
      ).interact();

      if (validate && input.trim().isEmpty) {
        error('Input cannot be empty. Please try again.');
        continue;
      }

      if (validate && !_isValidFeatureName(input.trim())) {
        error('Invalid feature name. Use only letters, numbers, and underscores.');
        continue;
      }

      return input.trim();
    }
  }

  /// Show a selection menu
  static String select(String prompt, List<String> options) {
    final selection = interact.Select(
      prompt: prompt,
      options: options,
    ).interact();

    return options[selection];
  }

  /// Show a multi-selection menu
  static List<String> multiSelect(String prompt, List<String> options) {
    final selections = interact.MultiSelect(
      prompt: prompt,
      options: options,
    ).interact();

    return selections.map((index) => options[index]).toList();
  }

  /// Show a spinner while executing a task
  static Future<T> spinner<T>(String message, Future<T> Function() task) async {
    // Simple progress indicator without actual spinner (interact package has limited spinner support)
    print('$_cyan⟳$_reset $message');
    
    try {
      final result = await task();
      print('$_green✓$_reset $message - Done');
      return result;
    } catch (e) {
      print('$_red✗$_reset $message - Failed');
      rethrow;
    }
  }

  /// Validate feature name (public method)
  static bool isValidFeatureName(String name) {
    return RegExp(r'^[a-zA-Z][a-zA-Z0-9_]*$').hasMatch(name);
  }

  /// Internal validation method for backwards compatibility
  static bool _isValidFeatureName(String name) {
    return isValidFeatureName(name);
  }

  /// Print help information
  static void printHelp() {
    header('Clean Architecture Generator');
    
    print('${_bold}USAGE:$_reset');
    print('  cleanarch [options] [feature-name]                    ${_dim}# Global installation$_reset');
    print('  dart run cleanarch [options] [feature-name]           ${_dim}# Local installation$_reset\n');
    
    print('${_bold}INSTALLATION:$_reset');
    print('  ${_green}Global (recommended):$_reset');
    print('    dart pub global activate clean_architecture_with_state_management');
    print('  ${_cyan}Local:$_reset');
    print('    Add to pubspec.yaml dev_dependencies and run dart pub get\n');
    
    print('${_bold}MODES:$_reset');
    print('  Interactive Mode (default): Run without arguments for interactive prompts');
    print('  Command Mode: Provide feature name and flags\n');
    
    print('${_bold}OPTIONS:$_reset');
    print('  -h, --help           Show this help message');
    print('  -d, --dry-run        Preview changes without creating files');
    print('  -i, --interactive    Force interactive mode');
    print('  -p, --provider       Use Provider state management');
    print('  -b, --bloc           Use Bloc state management');
    print('  -c, --cubit          Use Cubit state management');
    print('  -r, --riverpod       Use Riverpod state management');
    print('  --no-git             Skip git add step\n');
    
    print('${_bold}EXAMPLES:$_reset');
    print('  # Interactive mode (recommended)');
    print('  $_dim\$ cleanarch$_reset\n');
    
    print('  # Command mode with Bloc');
    print('  $_dim\$ cleanarch user -b$_reset\n');
    
    print('  # Dry run to preview');
    print('  $_dim\$ cleanarch product --dry-run$_reset\n');
    
    print('  # With Riverpod and no git');
    print('  $_dim\$ cleanarch auth -r --no-git$_reset\n');
    
    print('${_bold}STRUCTURE:$_reset');
    print('  Creates clean architecture with:');
    print('  $_green✓$_reset Data layer (models, repositories, data sources)');
    print('  $_green✓$_reset Domain layer (entities, use cases, repositories)');
    print('  $_green✓$_reset Presentation layer (screens, widgets, state management)');
    print('  $_green✓$_reset Dependency injection setup\n');
  }

  /// Print welcome banner
  static void printWelcome() {
    print('\n$_cyan');
    print('  ╔═══════════════════════════════════════════════════════╗');
    print('  ║                                                       ║');
    print('  ║   🏗️  Clean Architecture Generator                    ║');
    print('  ║   with State Management                              ║');
    print('  ║                                                       ║');
    print('  ║   Generate clean, scalable Flutter features          ║');
    print('  ║   with your favorite state management                ║');
    print('  ║                                                       ║');
    print('  ╚═══════════════════════════════════════════════════════╝');
    print(_reset);
  }

  /// Print feature summary before creation
  static void printSummary({
    required String featureName,
    String? stateManagement,
    required bool dryRun,
  }) {
    section('Summary');
    print('  Feature Name: $_bold$featureName$_reset');
    print('  State Management: $_bold${stateManagement ?? 'None (base structure only)'}$_reset');
    print('  Mode: $_bold${dryRun ? 'DRY RUN (Preview)' : 'CREATE FILES'}$_reset');
  }

  /// Clear screen
  static void clearScreen() {
    if (Platform.isWindows) {
      print(Process.runSync("cls", [], runInShell: true).stdout);
    } else {
      print(Process.runSync("clear", [], runInShell: true).stdout);
    }
  }

  /// Print divider
  static void divider() {
    print('$_dim─────────────────────────────────────────────$_reset');
  }

  /// Print tips
  static void printTips() {
    print('\n$_cyan$_bold💡 Tips:$_reset');
    print('  • Use snake_case or camelCase for feature names');
    print('  • The generator handles naming conventions automatically');
    print('  • Files are automatically added to git');
    print('  • Use --dry-run to preview before creating\n');
  }
}

