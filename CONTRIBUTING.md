# Contributing to Flutter Animated Circle

First off, thank you for considering contributing to Flutter Animated Circle! 🎉 It's people like you that make this package better for everyone.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [How to Contribute](#how-to-contribute)
- [Pull Request Process](#pull-request-process)
- [Code Style Guidelines](#code-style-guidelines)
- [Testing Guidelines](#testing-guidelines)
- [Documentation](#documentation)
- [Release Process](#release-process)

## 📜 Code of Conduct

This project adheres to a code of conduct that we expect project participants to uphold. Please read the full text to understand what actions will and will not be tolerated.

### Our Standards

- **Be respectful** and inclusive
- **Be collaborative** and constructive
- **Focus on what's best** for the community
- **Show empathy** towards other community members

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK (included with Flutter)
- Git
- A GitHub account
- Your favorite IDE (VS Code, Android Studio, or IntelliJ)

### Development Setup

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/flutter_animated_circle.git
   cd flutter_animated_circle
   ```

3. **Add the upstream remote**:
   ```bash
   git remote add upstream https://github.com/geridev12/flutter_animated_circle.git
   ```

4. **Install dependencies**:
   ```bash
   flutter pub get
   cd example && flutter pub get
   ```

5. **Verify the setup**:
   ```bash
   flutter test
   cd example && flutter run
   ```

## 🛠 How to Contribute

### Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates.

**Great bug reports include:**
- A clear, descriptive title
- Exact steps to reproduce the issue
- Expected behavior vs. actual behavior
- Screenshots or code samples (if applicable)
- Environment details (Flutter version, platform, etc.)

### Suggesting Features

Feature suggestions are welcome! Please:
- Check if the feature already exists or is planned
- Describe the problem the feature would solve
- Provide a detailed description of the suggested solution
- Consider the scope and complexity

### Code Contributions

1. **Create a branch** for your feature/fix:
   ```bash
   git checkout -b feature/amazing-feature
   # or
   git checkout -b fix/bug-description
   ```

2. **Make your changes** following our [Code Style Guidelines](#code-style-guidelines)

3. **Add tests** for your changes (see [Testing Guidelines](#testing-guidelines))

4. **Update documentation** if needed

5. **Run the test suite**:
   ```bash
   flutter test
   flutter analyze
   ```

6. **Commit your changes**:
   ```bash
   git commit -m "feat: add amazing feature"
   # or
   git commit -m "fix: resolve bug with animation timing"
   ```

7. **Push to your fork**:
   ```bash
   git push origin feature/amazing-feature
   ```

8. **Create a Pull Request** on GitHub

## 🔄 Pull Request Process

### Before Submitting

- [ ] Code follows the style guidelines
- [ ] Self-review of the code is complete
- [ ] Tests are added and passing
- [ ] Documentation is updated
- [ ] No merge conflicts exist
- [ ] Commit messages follow our conventions

### PR Description Template

```markdown
## Description
Brief description of the changes

## Type of Change
- [ ] Bug fix (non-breaking change)
- [ ] New feature (non-breaking change)
- [ ] Breaking change (fix or feature that causes existing functionality to change)
- [ ] Documentation update

## Testing
- [ ] All tests pass
- [ ] New tests added for new functionality
- [ ] Manual testing completed

## Screenshots (if applicable)
Add screenshots to help explain your changes

## Checklist
- [ ] My code follows the style guidelines
- [ ] I have performed a self-review
- [ ] I have commented my code where necessary
- [ ] I have updated the documentation
- [ ] My changes generate no new warnings
```

## 🎨 Code Style Guidelines

### Dart Code Style

- Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use `dart format` to format your code
- Follow the existing code patterns in the project

### File Organization

```
lib/
├── src/
│   ├── models/          # Data models
│   ├── painters/        # Custom painters
│   ├── view/           # Widgets
│   └── utils/          # Utility functions
├── flutter_animated_circle.dart  # Main export
```

### Naming Conventions

- **Classes**: `PascalCase` (e.g., `AnimatedCircleView`)
- **Variables/Functions**: `camelCase` (e.g., `strokeWidth`)
- **Constants**: `lowerCamelCase` (e.g., `defaultDuration`)
- **Files**: `snake_case` (e.g., `animated_circle_view.dart`)

### Documentation Standards

- Use `///` for public API documentation
- Include examples in documentation
- Document all public classes, methods, and properties
- Use clear, concise language

Example:
```dart
/// A widget that displays an animated circle with configurable appearance.
///
/// This widget allows for customization of the circle's appearance through
/// [circlePainterConfig], animation timing through [duration], and styling
/// through [strokeWidth] and [borderWidth].
///
/// Example:
/// ```dart
/// AnimatedCircleView(
///   circlePainterConfig: CirclePainterConfig.full(
///     fillColor: Colors.blue,
///     borderColor: Colors.blue.shade800,
///   ),
///   duration: const Duration(milliseconds: 800),
/// )
/// ```
class AnimatedCircleView extends StatefulWidget {
  // Implementation...
}
```

## 🧪 Testing Guidelines

### Test Structure

- **Unit Tests**: Test individual components and logic
- **Widget Tests**: Test widget behavior and UI
- **Integration Tests**: Test complete user flows (in example app)

### Writing Tests

1. **Test file naming**: `test/src/component/component_test.dart`
2. **Test organization**: Group related tests using `group()`
3. **Test naming**: Use descriptive names that explain the scenario
4. **Assertions**: Use meaningful assertion messages

Example:
```dart
group('CircleSegment', () {
  test('creates instance with correct properties', () {
    const segment = CircleSegment(
      fillColor: Colors.blue,
      borderColor: Colors.red,
      ratio: 0.5,
    );

    expect(segment.fillColor, Colors.blue);
    expect(segment.borderColor, Colors.red);
    expect(segment.ratio, 0.5);
  });

  test('throws assertion error for invalid ratio', () {
    expect(
      () => CircleSegment(
        fillColor: Colors.blue,
        borderColor: Colors.red,
        ratio: -0.1, // Invalid ratio
      ),
      throwsAssertionError,
    );
  });
});
```

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/src/models/circle_segment_test.dart

# Run tests with coverage
flutter test --coverage
```

## 📚 Documentation

### README Updates

When making changes that affect the public API:
- Update code examples
- Add new features to the feature list
- Update the API reference table
- Include migration notes if breaking changes

### Changelog

Every PR should include a changelog entry in `CHANGELOG.md`:
- Follow [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) format
- Use categories: Added, Changed, Deprecated, Removed, Fixed, Security
- Include the date and version number

### API Documentation

- All public APIs must be documented
- Include usage examples
- Document parameters, return values, and exceptions
- Use `@since` tags for new features

## 🚀 Release Process

1. **Version Bumping**: Follow [Semantic Versioning](https://semver.org/)
   - `MAJOR.MINOR.PATCH`
   - Major: Breaking changes
   - Minor: New features (backward compatible)
   - Patch: Bug fixes (backward compatible)

2. **Update Files**:
   - `pubspec.yaml` (version number)
   - `CHANGELOG.md` (release notes)
   - `README.md` (if needed)

3. **Testing**: Ensure all tests pass and manual testing is complete

4. **Documentation**: Verify all documentation is up to date

5. **Release**: Create a GitHub release with detailed release notes

## 💬 Getting Help

If you need help or have questions:

- **GitHub Discussions**: For general questions and discussions
- **GitHub Issues**: For bugs and feature requests
- **Code Review**: Request reviews on your PRs

## 🎉 Recognition

Contributors will be recognized in:
- GitHub contributors list
- Release notes
- Special thanks in documentation

Thank you for contributing to Flutter Animated Circle! 🚀
