# Flutter Project Guide

## Introduction

This guide provides best practices for maintaining clean code architecture, adhering to SOLID principles, and organizing the folder structure in a scalable, maintainable and testable Flutter project. It also includes examples to ensure consistency and ease of collaboration.


<br>



## Table of Contents

1. [SOLID Principles](#solid-principles)
2. [Clean Code Architecture](#clean-code-architecture)
3. [Folder Structure](#folder-structure)
4. [Naming Conventions](#naming-conventions)
5. [Commenting Guidelines](#commenting-guidelines)
6. [Effective Code](#effective-code)


<br>
<br>
<br>





## SOLID Principles

### 1. **Single Responsibility Principle (SRP)**:
   - A class should have only one reason to change.
   
   ```dart
   // Bad example
   class UserController {
       void login() { /* Authentication logic */ }
       void saveUserToDatabase() { /* Database logic */ }
   }

   // Good example
   class AuthenticationService {
       void login() { /* Authentication logic */ }
   }

   class UserRepository {
       void saveUser() { /* Database logic */ }
   }
   ```

### 2. **Open/Closed Principle (OCP)**:
   - A class should be open for extension, but closed for modification.
   
   ```dart
    // Good example
    abstract class PaymentMethod {
        void pay();
    }

    class CreditCardPayment implements PaymentMethod {
        @override
        void pay() {
            // Logic for credit card payment
        }
    }

    class PayPalPayment implements PaymentMethod {
        @override
        void pay() {
            // Logic for PayPal payment
        }
    }

    // If a new payment method is introduced, you don't modify the existing classes. 
    // You just extend them with a new class.
    class ApplePayPayment implements PaymentMethod {
        @override
        void pay() {
            // Logic for ApplePay payment
        }
    }

   ```

### 3. **Liskov Substitution Principle (LSP)**:
   - Subtypes should be substitutable for their base types without affecting program correctness.
   
   ```dart
    // Bad example: Violating Liskov Substitution Principle
    abstract class Bird {
    void fly();
    }

    class Sparrow extends Bird {
    @override
    void fly() {
        print('Sparrow is flying.');
    }
    }

    class Penguin extends Bird {
    @override
    void fly() {
        throw Exception('Penguins cannot fly!');
    }
    }

    void letBirdFly(Bird bird) {
    bird.fly();
    }

    void main() {
    Bird sparrow = Sparrow();
    letBirdFly(sparrow); // Works fine
    
    Bird penguin = Penguin();
    letBirdFly(penguin); // Throws an exception, violating LSP
    }

   ```
   - To fix this, adjust the class hierarchy:
   ```dart
    // Good example: Adhering to Liskov Substitution Principle
    abstract class Bird {
    void eat();
    }

    abstract class FlyingBird extends Bird {
    void fly();
    }

    class Sparrow extends FlyingBird {
    @override
    void eat() {
        print('Sparrow is eating.');
    }

    @override
    void fly() {
        print('Sparrow is flying.');
    }
    }

    class Penguin extends Bird {
    @override
    void eat() {
        print('Penguin is eating.');
    }
    // No need to implement fly() since penguins do not fly
    }

    void letBirdEat(Bird bird) {
    bird.eat();
    }

    void main() {
    Bird sparrow = Sparrow();
    letBirdEat(sparrow); // Works fine
    
    Bird penguin = Penguin();
    letBirdEat(penguin); // Works fine, adheres to LSP
    }

   ```

### 4. **Interface Segregation Principle (ISP)**:
   - Clients should not be forced to depend on interfaces they don't use.
   
   ```dart
    // Bad example: Interface is too broad
    abstract class Worker {
        void work();
        void eat();
    }

    class HumanWorker implements Worker {
        @override
        void work() {
            print("Human working...");
        }

        @override
        void eat() {
            print("Human eating...");
        }
    }

    class RobotWorker implements Worker {
        @override
        void work() {
            print("Robot working...");
        }

        @override
        void eat() {
            // Robots don't eat, but this method must be implemented due to the interface.
        }
    }

    // Good example: Split the interface into smaller ones
    abstract class Workable {
        void work();
    }

    abstract class Eatable {
        void eat();
    }

    class HumanWorker implements Workable, Eatable {
        @override
        void work() {
            print("Human working...");
        }

        @override
        void eat() {
            print("Human eating...");
        }
    }

    class RobotWorker implements Workable {
        @override
        void work() {
            print("Robot working...");
        }
    }

   ```


### 5. **Dependency Inversion Principle (DIP)**:
   - Clients should not be forced to depend on interfaces they don't use.
   
   ```dart
    // Bad example: Direct dependency on low-level implementation
    class Worker {
        void work() {
            print("Worker is working");
        }
    }

    class Manager {
        final Worker worker;

        Manager(this.worker);

        void manage() {
            worker.work();
        }
    }

    // Good example: Depend on abstraction
    abstract class IWorker {
        void work();
    }

    class HumanWorker implements IWorker {
        @override
        void work() {
            print("Human working...");
        }
    }

    class RobotWorker implements IWorker {
        @override
        void work() {
            print("Robot working...");
        }
    }

    class Manager {
        final IWorker worker;

        Manager(this.worker);

        void manage() {
            worker.work();
        }
    }

    // Now, Manager depends on the IWorker abstraction, which can be easily substituted with any other worker implementation.

   ```



<br>
<br>
<br>



## Clean Code Architecture

Clean architecture focuses on separating different responsibilities (UI, business logic, data access) into distinct layers to make the project more maintainable, testable, and scalable.

### Key Concepts:

- **Separation of Concerns**: Divide different functionalities into separate layers.
- **Loose Coupling**: Reduce dependencies between layers to allow flexibility and change.
- **Testability**: Ensure each component can be tested in isolation.




<br>
<br>
<br>



## Folder Structure
- Folder structure for `Clean Code Architecture` .

<!-- ```painttext ``` -->

```painttext
    lib/
    ├── common/
    │   ├── abstract_classes/
    │   │   └── stateful_util.dart
    │   ├── classes/
    │   │   ├── adaptive_image_provider.dart
    │   │   ├── permission_class.dart
    │   │   └── play_store_appupdate.dart
    │   ├── utils/
    │   ├── dialogues/
    │   │   ├── show_confirmation_dialogue.dart
    │   │   ├── show_loading.dart
    │   │   └── show_alert_dialogue.dart
    │   ├── entities/
    │   ├── models/
    │   │   └── api_response_model.dart
    │   ├── screens/
    │   └── widgets/
    │
    ├── config/
    │   ├── constants/
    │   │   ├── app_constants.dart
    │   │   ├── app_regx.dart
    │   │   ├── assets.dart
    │   │   ├── color_constants.dart
    │   │   ├── conntection_apis.dart
    │   │   └── const_string.dart
    │   ├── enums/
    │   ├── firebase/
    │   └── themes/
    │       ├── light_theme/
    │       │   ├── light_theme.dart
    │       │   ├── light_theme.appbar.dart
    │       │   ├── light_theme.bottomsheet.dart
    │       │   ├── light_theme.button.dart
    │       │   ├── light_theme.checkbox.dart
    │       │   ├── light_theme.constants.dart
    │       │   ├── light_theme.inputdecoration.dart
    │       │   ├── light_theme.listtile.dart
    │       │   └── light_theme.text.dart
    │       └── dark_theme/
    │           ├── dark_theme.dart
    │           ├── dark_theme.appbar.dart
    │           ├── dark_theme.bottomsheet.dart
    │           ├── dark_theme.button.dart
    │           ├── dark_theme.checkbox.dart
    │           ├── dark_theme.constants.dart
    │           ├── dark_theme.inputdecoration.dart
    │           ├── dark_theme.listtile.dart
    │           └── dark_theme.text.dart
    │
    ├── core/
    │   ├── extensions/
    │   │   ├── context_ext.dart
    │   │   ├── datetime_ext.dart
    │   │   ├── map_ext.dart
    │   │   ├── num_ext.dart
    │   │   ├── parse_api_response.dart
    │   │   ├── string_ext.dart
    │   │   └── texteditingctrl_ext.dart
    │   └── functions/
    │
    ├── features/
    │   └── dashboard/
    │       ├── data/
    │       │   ├── source/
    │       │   │   ├── local/
    │       │   │   └── remote/
    │       │   ├── models/
    │       │   └── repo_impl/
    │       ├── domain/
    │       │   ├── entities/
    │       │   ├── repo/
    │       │   └── usecases/
    │       └── presentation/
    │           ├── screens/
    │           │      └── dashboard_sreen.dart
    │           ├── utils/
    │           │      └── dashboard_utils.dart
    │           └── widgets/
    │
    └── main.dart

```

### Folder Breakdown:


This section provides a breakdown of the folder structure in the project, detailing the purpose of each folder and its contents.

### `lib/`

The main directory for the Flutter application code.

### `common/`

Contains shared resources, including:

- **`abstract_classes/`**: Abstract classes that provide a base for other classes.
- **`classes/`**: Concrete implementations of various classes, including utilities and helper classes.
- **`utils/`**: Utility functions and helpers that can be used throughout the application.
- **`dialogues/`**: Custom dialog widgets for user interactions (e.g., confirmations, loading indicators).
- **`entities/`**: Domain entities that define the structure of data models.
- **`models/`**: Data models, particularly for API responses and serialization.
- **`screens/`**: Commonly used screens across the app.
- **`widgets/`**: Reusable UI components and widgets.

### `config/`

Configuration files and constants for the application, organized as follows:

- **`constants/`**: Various constant values and configurations, including:
  - `app_constants.dart`: General app constants.
  - `app_regx.dart`: Regular expressions used in the app.
  - `assets.dart`: Asset paths and configurations.
  - `color_constants.dart`: Defined colors for the app.
  - `conntection_apis.dart`: API endpoint constants.
  - `const_string.dart`: String constants used throughout the app.
  
- **`enums/`**: Enum definitions used within the application for better type safety and readability.
- **`firebase/`**: Firebase configuration files and related utilities.
- **`themes/`**: Theming files for the application, separated into light and dark themes for better customization and user experience.

### `core/`

Core functionalities and extensions for the application:

- **`extensions/`**: Extensions for various types (like `String`, `DateTime`, etc.) to add custom functionality.
- **`functions/`**: Common functions that may be utilized throughout the application.

### `features/`

Feature-specific directories that encapsulate all related files and functionalities:

- **`dashboard/`**: Contains all resources related to the dashboard feature, organized into:
  - **`data/`**: Data sources and repository implementations for managing data.
    - **`source/`**: Local and remote data source implementations.
    - **`models/`**: Data models specific to this feature.
    - **`repo_impl/`**: Repository implementation files.
  
  - **`domain/`**: Domain logic, including entities, repositories, and use cases.
    - **`entities/`**: Domain entities specific to the dashboard feature.
    - **`repo/`**: Interfaces for repositories.
    - **`usecases/`**: Use cases for handling feature-specific business logic.
  
  - **`presentation/`**: UI-related resources, including screens, utilities, and widgets specific to the dashboard feature.
    - **`screens/`**: Screens for displaying data and user interaction.
    - **`utils/`**: Helper methods and utilities for the presentation layer.
    - **`widgets/`**: Custom widgets designed for use within the dashboard feature.

### `main.dart`

The entry point of the Flutter application, where the app is initialized and run.


<br>
<br>
<br>



## Naming Conventions

This document outlines the naming conventions to follow throughout the Flutter project to ensure consistency, readability, and maintainability.

### 1. UpperCamelCase

- `Classes`, `enum` types, `typedef`, and `type` parameters should capitalize the first letter of each word (including the first word), and use no separators.
```dart
// Good
class SliderMenu {...}

class HttpRequest {...}

typedef Predicate<T> = bool Function(T value);
```

```dart
// Bad
class sliderMenu {...}

class httprequest {...}

typedef predicate<T> = bool Function(T value);
```

### 2. lowerCamelCase

- Class `members`, top-level `definitions`, `variables` and `parameters` (named, positional etc) should capitalize the first letter of each word except the first word, and use no separators.

```dart
// Good
const pi = 3.14;
const defaultTimeout = 1000;
final urlScheme = RegExp('^([a-z]+):');

class Dice {
  static final numberGenerator = Random();
}
```

```dart
// Bad
const PI = 3.14;
const DefaultTimeout = 1000;
final URL_SCHEME = RegExp('^([a-z]+):');

class Dice {
  static final NUMBER_GENERATOR = Random();
}
```

### 3. lowercase_with_underscores

- DO name `packages`, `directories`, and `files` using `lowercase_with_underscores`

```dart
// Good
import 'dart:math' as math;
import 'package:angular_components/angular_components.dart' as angular_components;
import 'package:js/js.dart' as js;
```



```dart
// Bad
import 'dart:math' as Math;
import 'package:angular_components/angular_components.dart' as angularComponents;
import 'package:js/js.dart' as JS;
```

### 4. PREFER using _, __, etc. for unused callback parameters

- Sometimes the type signature of a callback function requires a parameter, but the callback implementation doesn't use the parameter. In this case, it's idiomatic to name the unused parameter _. If the function has multiple unused parameters, use additional underscores to avoid name collisions: __, ___, etc.

```dart
// Good
futureOfVoid.then((_) {
  print('Operation complete.');
});
```

```dart
// Bad
futureOfVoid.then((resultvalue) {
  print('Operation complete.');
});
```


### 5. DON'T use prefix letters

```dart
// Good
defaultTimeout
```

```dart
// Bad
kDefaultTimeout
```

### 6. Test Files

- Append `.test.dart` to the name of test files.
- Follow the same naming conventions as the files being tested, using `lowercase_with_underscores`.



By adhering to these naming conventions, the codebase will remain consistent and understandable, facilitating easier collaboration among team members.




<br>
<br>
<br>




## Commenting Guidelines

Effective commenting is essential for maintaining and understanding the code. This project adopts two types of comments to clarify the intent and functionality of the code:

### 1. Documentation Comments `///`

Documentation comments are used for providing comprehensive descriptions of `classes` , `methods`, and `functions`. These comments should explain:

- The purpose of the class or method.
- The parameters and return values.
- Any exceptions that may be thrown.
- Additional context or relevant information for understanding the implementation.

#### Example:

```dart
/// This class represents a user in the application.
/// 
/// It contains the user's basic information, such as their name,
/// email, and profile picture. It also provides methods for
/// managing user-related actions, such as updating profile information.
///
/// Example usage:
/// ```dart
/// User user = User(name: 'John Doe', email: 'john@example.com');
/// user.updateProfile('newProfilePic.png');
/// ```
class User {
  String name;
  String email;
  String profilePicture;

  User({required this.name, required this.email});

    /// Update profile picture
  void updateProfile(String newProfilePic) {
     // Logic here
  }
}
```


### 2. Clarification Comments `//`

Clarification comments are shorter remarks used to provide general information, notes, or reminders about specific lines or sections of code. These comments might include:

- TODOs or FIXMEs for tasks that need to be addressed later.
- Notes on complex logic that requires additional explanation.
- General remarks about the code or implementation details.

#### Example:

```dart
// TODO: Refactor this method to improve performance
void calculateValues() {
  // Logic here
}

// Clarification on the logic used
// This condition checks if the user is active before proceeding.
if (user.isActive) {
  // Proceed with action
}

```

### Note :

- DON'T use block comments for documentation. You can use a block comment (`/* ... */`) to temporarily comment out a section of code, but all other comments should use `//`.
```dart
// Good

void greet(String name) {
  // Assume we have a valid name.
  print('Hi, $name!');
}

```
```dart
// Bad

void greet(String name) {
  /* Assume we have a valid name. */
  print('Hi, $name!');
}

```

- DO separate the first sentence of a doc comment into its own paragraph.
```dart
// Good

/// Deletes the file at [path].
///
/// Throws an [IOError] if the file could not be found. Throws a
/// [PermissionError] if the file is present but could not be deleted.
void delete(String path) {
  ...
}
```
```dart
// Bad

/// Deletes the file at [path]. Throws an [IOError] if the file could not
/// be found. Throws a [PermissionError] if the file is present but could
/// not be deleted.
void delete(String path) {
  ...
}
```

- DON'T write documentation for both the `getter` and `setter` of a property.
```dart
// Good

/// The pH level of the water in the pool.
///
/// Ranges from 0-14, representing acidic to basic, with 7 being neutral.
int get phLevel => ...
set phLevel(int level) => ...
```
```dart
// Bad

/// The depth of the water in the pool, in meters.
int get waterDepth => ...

/// Updates the water depth to a total of [meters] in height.
set waterDepth(int meters) => ...
```

- DO put doc comments before metadata annotations.
```dart
// Good

/// A button that can be flipped on and off.
@Component(selector: 'toggle')
class ToggleComponent {}
```
```dart
// Bad

@Component(selector: 'toggle')
/// A button that can be flipped on and off.
class ToggleComponent {}
```

- PREFER backtick fences for code blocks.
```dart
// Good

/// You can use [CodeBlockExample] like this:
///
/// ```dart
/// var example = CodeBlockExample();
/// print(example.isItGreat); // "Yes."
/// ```
```
```dart
// Bad

/// You can use [CodeBlockExample] like this:
///
///     var example = CodeBlockExample();
///     print(example.isItGreat); // "Yes."
```

<br>
<br>
<br>


## Effective Code

- Use string interpolation instead of concatenation.
```dart
// Good

'Hello, $name! You are ${year - birth} years old.';

// use adjacent strings
raiseAlarm('ERROR: Parts of the spaceship are on fire. Other '
    'parts are overrun by martians. Unclear which are which.');

```
```dart
// Bad

'Hello, ' + name + '! You are ' + (year - birth).toString() + ' y...';



raiseAlarm('ERROR: Parts of the spaceship are on fire. Other ' +
    'parts are overrun by martians. Unclear which are which.');
```

- DO use collection `literals` when possible.
```dart
// Good

var arguments = [
  ...options,
  command,
  ...?modeFlags,
  for (var path in filePaths)
    if (path.endsWith('.dart')) path.replaceAll('.dart', '.js')
];

```
```dart
// Bad

var arguments = <String>[];
arguments.addAll(options);
arguments.add(command);
if (modeFlags != null) arguments.addAll(modeFlags);
arguments.addAll(filePaths
    .where((path) => path.endsWith('.dart'))
    .map((path) => path.replaceAll('.dart', '.js')));
```

- DON'T use `.length` to see if a collection is empty.
```dart
// Good

if (lunchBox.isEmpty) return 'so hungry...';
if (words.isNotEmpty) return words.join(' ');
```
```dart
// Bad

if (lunchBox.length == 0) return 'so hungry...';
if (!words.isEmpty) return words.join(' ');
```

- AVOID using `Iterable.forEach()` with a function literal
.
```dart
// Good

for (final person in people) {
  ...
}
```
```dart
// Bad

people.forEach((person) {
  ...
});
```
- DON'T use `async` when it has no useful effect
.
```dart
// Good

Future<int> fastestBranch(Future<int> left, Future<int> right) {
  return Future.any([left, right]);
}
```
```dart
// Bad

Future<int> fastestBranch(Future<int> left, Future<int> right) async {
  return Future.any([left, right]);
}
```


- DON'T use nested `if` `else` conditions. Use `guard` clauses to simplify code.

```dart
// Good: Using guard clauses


String processOrder(Order order) {
  if (order == null) {
    return "Order is null.";
  }

  if (order.items == null || order.items.isEmpty) {
    return "Order has no items.";
  }

  if (!order.isPaid) {
    return "Order is not paid.";
  }

  if (order.isShipped) {
    return "Order is already shipped.";
  }

  return "Order will be processed for shipping.";
}

```
```dart
// Bad: Nested if-else conditions


String processOrder(Order order) {
  if (order != null) {
    if (order.items != null && order.items.isNotEmpty) {
      if (order.isPaid) {
        if (order.isShipped) {
          return "Order is already shipped.";
        } else {
          return "Order will be processed for shipping.";
        }
      } else {
        return "Order is not paid.";
      }
    } else {
      return "Order has no items.";
    }
  } else {
    return "Order is null.";
  }
}

```


<!-- ```dart
// Good

```
```dart
// Bad

``` -->