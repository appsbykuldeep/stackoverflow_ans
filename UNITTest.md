# Flutter Unit Test Guide

## Introduction

In Flutter, unit tests focus on verifying the behavior of individual classes, methods, or functions without relying on external dependencies like UI components or API calls. 
<br>
[Youtube tutorial for bigner](https://www.youtube.com/watch?v=mxTW020pyuc)


<br>



## Table of Contents
- Here are common types of unit test cases you might encounter in a Flutter project.

1. [Business Logic Tests](#business-logic-tests)
2. [Data Validation Tests](#data-validation-tests)
3. [State Management Tests](#state-management-tests)
4. [Repository and Data Layer Tests](#repository-and-data-layer-tests)
5. [Service Tests (with Mocked Dependencies)](#service-tests-(with-mocked-dependencies))
6. [Utility and Helper Tests](#utility-and-helper-tests)
7. [Dependency Injection Tests](#dependency-injection-tests)
8. [Configuration and Environment Tests](#configuration-and-environment-tests)
9. [Effective Test](#effective-test)


<br>
<br>
<br>


## Business Logic Tests


- **Simple Method Tests**: Verify that each method in the business logic (e.g., `calculations`, `parsing`, `formatting`) returns the expected results.
- **Edge Cases**: Test for unusual or extreme values, such as null values, empty inputs, or maximum values, to ensure stability.
- **Error Handling**: Confirm that exceptions are correctly caught and handled (or rethrown) and that error messages or states are set as expected.

### Simple Example
- Let's create a `Calculator` class that performs basic arithmetic operations:

```dart
class Calculator {
  int add(int a, int b) => a + b;
  int subtract(int a, int b) => a - b;
  int multiply(int a, int b) => a * b;
  double divide(int a, int b) {
    if (b == 0) throw ArgumentError('Cannot divide by zero');
    return a / b;
  }
}
```


- Test Cases:

```dart

void main() {
  final calculator = Calculator();

  test('Addition returns correct result', () {
    expect(calculator.add(2, 3), 5);
  });

  test('Division throws error when dividing by zero', () {
    expect(() => calculator.divide(4, 0), throwsArgumentError);
  });

  test('Subtraction returns correct result', () {
    expect(calculator.subtract(5, 2), 3);
  });
}


```

### Complex Example

- Let’s say we have a `ShoppingCart` class that relies on a `DiscountService` to apply discounts.

```dart
class ShoppingCart {
  final DiscountService discountService;
  List<Item> items = [];

  ShoppingCart(this.discountService);

  void addItem(Item item) => items.add(item);

  Future<double> getTotal() async {
    final total = items.fold(0, (sum, item) => sum + item.price);
    final discount = await discountService.getDiscount();
    return total - discount;
  }
}
```
- Test Case with `Mocked` Dependency:

```dart
class MockDiscountService extends Mock implements DiscountService {}

void main() {
  final discountService = MockDiscountService();
  final cart = ShoppingCart(discountService);

  test('getTotal calculates correct total with discount', () async {
    // Arrange
    cart.addItem(Item(name: 'Item1', price: 50.0));
    cart.addItem(Item(name: 'Item2', price: 25.0));
    when(discountService.getDiscount()).thenAnswer((_) async => 10.0);

    // Act
    final total = await cart.getTotal();

    // Assert
    expect(total, 65.0); // (50 + 25) - 10 discount
    verify(discountService.getDiscount()).called(1);
  });
}

```



<br>
<br>
<br>


## Data Validation Tests

- **Input Validation**: Test functions that validate input (e.g., `email`, `passwords`, or `phone numbers`) to ensure they handle valid and invalid inputs correctly.
- **Model Validation**: Ensure that any constraints on your models (e.g., `required fields` or `specific value ranges`) are respected.

### Simple Example

- Here’s an example of an `EmailValidator` class:

```dart
class EmailValidator {
  static bool isValid(String email) {
    final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }
}

```
- Test Cases:

```dart
void main() {
  test('Valid email passes validation', () {
    expect(EmailValidator.isValid('test@example.com'), isTrue);
  });

  test('Invalid email fails validation', () {
    expect(EmailValidator.isValid('test@.com'), isFalse);
  });

  test('Empty email fails validation', () {
    expect(EmailValidator.isValid(''), isFalse);
  });
}
```


<br>
<br>
<br>





## State Management Tests

- **Initial State**: Verify that classes and objects start in their correct initial states.
- **State Transition**: Test that calling specific methods or setting specific properties transitions the state correctly.
- **Listeners and Callbacks**:  If using providers or streams, ensure listeners and callbacks are triggered appropriately and contain expected values.
- **Error State**:  Test for appropriate handling of invalid state transitions or data, such as trying to update data that fails constraints.

### Example

- For a `Counter` class that manages a counter value, we’ll test its state management:

```dart
class Counter {
  int _value = 0;
  int get value => _value;

  void increment() => _value++;
  void decrement() {
    if (_value > 0) _value--;
  }
}
```

- Test Cases:

```dart
void main() {
  final counter = Counter();

  test('Initial value is 0', () {
    expect(counter.value, 0);
  });

  test('Increment increases value by 1', () {
    counter.increment();
    expect(counter.value, 1);
  });

  test('Decrement decreases value by 1, does not go below 0', () {
    counter.decrement();
    expect(counter.value, 0);
  });
}
```

### Complex Example

- Consider a `WeatherBloc` class using streams to manage state in a weather app.

```dart
class WeatherBloc {
  final WeatherService weatherService;
  final _weatherStreamController = StreamController<Weather>();

  Stream<Weather> get weatherStream => _weatherStreamController.stream;

  WeatherBloc(this.weatherService);

  Future<void> fetchWeather(String city) async {
    final weather = await weatherService.getWeather(city);
    _weatherStreamController.add(weather);
  }

  void dispose() => _weatherStreamController.close();
}

```

- Test Case with `StreamController` and Mock Service:


```dart
class MockWeatherService extends Mock implements WeatherService {}

void main() {
  final weatherService = MockWeatherService();
  final bloc = WeatherBloc(weatherService);

  test('fetchWeather emits weather data to stream', () async {
    // Arrange
    final weather = Weather(city: 'London', temperature: 20);
    when(weatherService.getWeather('London')).thenAnswer((_) async => weather);

    // Act
    bloc.fetchWeather('London');

    // Assert
    expectLater(bloc.weatherStream, emits(weather));
  });
}

```

<br>
<br>
<br>




## Repository and Data Layer Tests

- **Repository Method Tests**: Mock dependencies like databases or APIs to verify the behavior of repository methods.
- **Data Transformation**: Test that data coming from repositories is transformed correctly, if necessary, before reaching the business layer.
- **Caching Mechanisms**: Ensure that any caching mechanisms store and retrieve data as expected.

### Example

- Suppose we have a `UserRepository` that interacts with a data source:

```dart
class UserRepository {
  final UserDataSource dataSource;

  UserRepository(this.dataSource);

  Future<User> fetchUser(int id) async {
    return await dataSource.getUserById(id);
  }
}
```

- Using `mockito` to mock the data source:

```dart
class MockUserDataSource extends Mock implements UserDataSource {}

void main() {
  final dataSource = MockUserDataSource();
  final repository = UserRepository(dataSource);

  test('FetchUser returns user data from data source', () async {
    final user = User(id: 1, name: 'John Doe');
    when(dataSource.getUserById(1)).thenAnswer((_) async => user);

    final result = await repository.fetchUser(1);

    expect(result, equals(user));
    verify(dataSource.getUserById(1)).called(1);
  });
}
```




<br>
<br>
<br>


## Service Tests (with Mocked Dependencies)

- **API Call Tests**: Use a mocking library like `mockito` to simulate API responses and test that your service layer methods return the correct data.
- **Error Handling**: Simulate network failures or API errors and verify that the service layer handles these situations gracefully.
- **Data Parsing**: Test that `JSON` or `XML` responses from APIs are parsed correctly into your Dart models.

### Simple Example

- Assume a `WeatherService` that fetches data from an API:

```dart
class WeatherService {
  final ApiClient apiClient;

  WeatherService(this.apiClient);

  Future<String> fetchWeather(String city) async {
    final response = await apiClient.get('/weather?city=$city');
    return response['weather'];
  }
}
```


- Test Cases using `Mock API` Client:

```dart
class MockApiClient extends Mock implements ApiClient {}

void main() {
  final apiClient = MockApiClient();
  final service = WeatherService(apiClient);

  test('fetchWeather returns correct weather data', () async {
    when(apiClient.get('/weather?city=London')).thenAnswer(
      (_) async => {'weather': 'Sunny'},
    );

    final result = await service.fetchWeather('London');

    expect(result, 'Sunny');
    verify(apiClient.get('/weather?city=London')).called(1);
  });
}
```

### Complex Example

- Imagine a `UserService` that fetches user data from an API and throws an error if the user is not found.

```dart
class UserService {
  final ApiClient apiClient;

  UserService(this.apiClient);

  Future<User> getUser(int id) async {
    final response = await apiClient.get('/user/$id');
    if (response.statusCode == 404) {
      throw UserNotFoundException('User not found');
    }
    return User.fromJson(response.data);
  }
}

```


- Test Case with Mock and Error Handling:

```dart
class MockApiClient extends Mock implements ApiClient {}

void main() {
  final apiClient = MockApiClient();
  final userService = UserService(apiClient);

  test('getUser throws UserNotFoundException for 404 response', () async {
    // Arrange
    when(apiClient.get('/user/1')).thenAnswer((_) async => Response(statusCode: 404));

    // Act & Assert
    expect(() async => await userService.getUser(1), throwsA(isA<UserNotFoundException>()));
  });
}

```



<br>
<br>
<br>

## Utility and Helper Tests

- **Utility Function Tests**: Test utility functions, like `formatters`, `converters`, or `string processors` , for expected output.
- **Date/Time Functions**: If there are helper functions to manipulate dates/times, test various time zones, daylight savings adjustments, and different date formats.
- **Constants and Enums**:  If using helper functions that convert or process enums or constants, verify they work as expected across all possible values.

### Example

- Suppose we have a `DateFormatter` helper class:

```dart
class DateFormatter {
  static String formatDate(DateTime date) {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }
}
```

- Test Cases:  

```dart
void main() {
  test('formatDate formats date correctly', () {
    final date = DateTime(2023, 10, 5);
    expect(DateFormatter.formatDate(date), '2023-10-05');
  });
}
```


<br>
<br>
<br>

## Dependency Injection Tests


- **Injection Behavior**: Test that dependencies are correctly injected and used within classes, especially if you’re using dependency injection libraries like `get_it` or `provider`.
- **Mocked Dependencies**: Ensure that injected dependencies (especially mocks) behave as expected and isolate specific dependencies for each test.

### Example

- For dependency injection, we can use a locator like `get_it`. Here’s a simplified example with `get_it`:

```dart
final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<ApiService>(() => MockApiService());
}

void main() {
  setup();

  test('Injected ApiService returns mock data', () {
    final apiService = getIt<ApiService>();
    expect(apiService.getData(), 'Mock data');
  });
}
```



Note : `We will use core functionality insted of any Dependency Injection.`
- Singleton class

```dart 
//Create Singleton class
class Singleton {
  Singleton._();
  static final Singleton _instance = Singleton._();
  static Singleton get instance => _instance;

  /// Other methods
  void anymethod() {
    print("called");
  }
}

// to use it in any function or in method just use

void testFunc() {
  Singleton.instance.anymethod();
}

```

- Lasy Singleton class

```dart
//Create Lazy Singleton class
class LasySingleton {
  LasySingleton._();

  static LasySingleton? _instance;

  static LasySingleton _getLasy() {
    _instance ??= LasySingleton._();
    return _instance!;
  }

  static LasySingleton get lasyInstance => _getLasy();

  /// Other methods
  void anymethod() {
    print("called");
  }
}

// to use it in any function or in method just use

void testFunc() {
  LasySingleton.lasyInstance.anymethod();
}

```



<br>
<br>
<br>




## Configuration and Environment Tests

- **Environment-Based Configurations**: Test any environment-based logic to verify it adapts correctly to development, staging, or production configurations.
- **Feature Flags**: If your app has feature flags, write tests to verify that feature flags toggle functionality on/off as expected.

### Example

- Here’s a `Config` class that loads settings based on the environment:

```dart
class Config {
  final String environment;

  Config({required this.environment});

  String get apiUrl {
    switch (environment) {
      case 'prod':
        return 'https://api.prod.com';
      case 'dev':
      default:
        return 'https://api.dev.com';
    }
  }
}
```

- Test Cases:

```dart
void main() {
  test('apiUrl returns correct URL for production', () {
    final config = Config(environment: 'prod');
    expect(config.apiUrl, 'https://api.prod.com');
  });

  test('apiUrl returns correct URL for development', () {
    final config = Config(environment: 'dev');
    expect(config.apiUrl, 'https://api.dev.com');
  });
}
```


<br>
<br>
<br>

## Effective Test

### Use Descriptive Test Names
- Describe the expected behavior in the test name. This makes tests easier to understand, maintain, and debug.

```dart

// Bad
test('calculates total')

// Good

test('calculateTotal returns the correct total including tax')

```


### Follow Arrange-Act-Assert (AAA) Pattern

- **Arrange**: Set up the initial state, dependencies, or mocks.
- **Act**: Execute the function or method being tested.
- **Assert**: Verify the result or behavior is as expected.


```dart
test('adds two numbers correctly', () {
  // Arrange
  final calculator = Calculator();

  // Act
  final result = calculator.add(2, 3);

  // Assert
  expect(result, 5);
});

```


### Use Mocks Effectively with Mockito
- `Mockito` is the most common mocking library in Flutter, making it easy to control dependency behavior in tests.
- Use `when()` to define specific behaviors for mocks, and `verify()` to check that methods were called correctly.

```dart
when(mockService.getData()).thenAnswer((_) async => 'Mocked data');
verify(mockService.getData()).called(1);
```

### Use Parameterized Tests for Repetitive Scenarios
- If testing multiple variations of similar inputs or outputs, use parameterized tests to avoid redundancy.
- Flutter’s [parameterized_test](https://pub.dev/packages/parameterized_test) `package` can help run the same test logic across different sets of parameters.

```dart
void main() {
  group('addition', () {
    final cases = [
      [1, 2, 3],
      [0, 0, 0],
      [-1, -1, -2],
    ];

    for (var case in cases) {
      test('adding ${case[0]} and ${case[1]} returns ${case[2]}', () {
        expect(Calculator().add(case[0], case[1]), case[2]);
      });
    }
  });
}
```


### Use Test Coverage Tools

- Use Flutter’s [coverage](https://pub.dev/packages/coverage) `package` to check how much of your code is covered by tests.
- Focus on covering critical paths and core business logic, and don’t stress about reaching 100% coverage.

### Avoid Hardcoding Delays
- If you’re testing async code, avoid using `await Future.delayed(...)`.
- Instead, use mocks to simulate delays or complete the Future immediately for a reliable and fast test.


### Test for Exception and Error Scenarios
- Don’t just test for success—verify that your code handles failure gracefully.
- Use `expect(..., throwsException)` or `throwsA` for specific error types.

```dart
test('throws when input is invalid', () {
  expect(() => Calculator().divide(4, 0), throwsA(isA<ArgumentError>()));
});

```

### Write Tests for Bugs

- If you find a `bug` in your code, write a test that reproduces the bug before fixing it.
- This practice helps ensure that the bug won’t be `reintroduced` in the future.


### Use `emitsInOrder` for Stream Tests
- For testing state management classes or BLoCs that use streams, `emitsInOrder` helps validate multiple states over time.

```dart
expectLater(bloc.state, emitsInOrder([State.loading, State.success]));

```

### Organize Tests by Feature
- Structure your test files to match your app’s feature set for easier navigation and readability.
- For example, if you have a `login` feature, put related tests under `test/login/` and organize each feature in a similar way.


<br>
<br>
<br>