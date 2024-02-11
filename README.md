# clean_architecture_with_state_management

A Dart package for clean architecture with state management.

## Overview

This Dart package provides a clean architecture template with state management.

## Features

- Separation of concerns with clean architecture principles.
- State management integration for a smooth user interface.
- Easily customizable and extendable.

## Folder Structure
```
|- features
|  ┌ feature_name/
|  |- data/
|  |    |-data_sources/
|  |    |    |- local/
|  |    |    |    └  feature_name_local_data_source.dart
|  |    |    └ remote/
|  |    |         └  feature_name_remote_data_source.dart
|  |    |- models/
|  |    |    └  feature_model.dart
|  |    └ repositories/
|  |         └  feature_name_repository_impl.dart
|  |- domain/
|  |    |- entities/
|  |    |    └  feature.dart
|  |    |- repositories/
|  |    |    └  feature_repository.dart
|  |    └ use_case/
|  |         └  feature_use_case.dart
|  |- presentation/
|  |    |- provider/
|  |    |    └  feature_provider.dart
|  |    |- widgets/
|  |    └  screens/
|  |         └  feature_screen.dart
|  └ inject_feature_name.dart
```


## Getting Started

### Installation

Add the following dependency to your `pubspec.yaml` file:

```yaml
dev_dependencies:
  clean_architecture_with_state_management:
```

## Usage

Basic usage example: 
```bash
dart run clean_architecture_with_state_management yourFeatureName
```

Create architecture with provider state management:
```bash
```bash
dart run clean_architecture_with_state_management yourFeatureName -provider
```