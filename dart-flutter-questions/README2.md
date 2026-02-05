# Dart & Flutter Quiz Questions - Set 2

Test your understanding of Dart and Flutter concepts with these practice questions.

---

## Question 1: Null Safety

**What should replace `__(i)__` and `__(ii)__` to produce the expected output?**

```dart
void main() {
  String? username;
  greet(username);    // Hello, Guest!
  username = "Alice";
  greet(username);    // Hello, Alice!
}

void greet(__(i)__ name) {
  print("Hello, ${__(ii)__ 'Guest'}!");
}
```

**Options:**
- A: (i) `String?` (ii) `name ??`
- B: (i) `String` (ii) `name`
- C: (i) `String?` (ii) `name`
- D: (i) `String` (ii) `name ??`

<details>
<summary>Click to reveal answer</summary>

### Answer: A

**(i) `String?` (ii) `name ??`**

### Explanation

**Null Safety Concepts:**
- `String? username` declares a **nullable String** that defaults to `null`
- The parameter must be `String?` to accept nullable values from the caller
- `name ?? 'Guest'` is the **null-coalescing operator**: if `name` is null, use `'Guest'`

**Execution Flow:**
1. First call: `username` is `null` → `name ?? 'Guest'` evaluates to `'Guest'` → prints "Hello, Guest!"
2. Second call: `username` is `"Alice"` → `name ?? 'Guest'` evaluates to `'Alice'` → prints "Hello, Alice!"

**Why other options fail:**
- **B:** `String` cannot accept `null`, causing a compile error when passing nullable `username`
- **C:** Missing `??` operator means it would print "Hello, null!" for the first call
- **D:** `String` (non-nullable) cannot accept the nullable `username` variable

</details>

---

## Question 2: String compareTo Method

**What is the output from Line 5 and Line 6 when this Dart program is run?**

```dart
void main() {
  // Consecutive ASCII for a to z is 97 to 122
  // Consecutive ASCII for A to Z is 65 to 90
  var x = 'Hello';
  var y = 'Hello';
  var z = 'hello';

  print(z.compareTo(x));  // output is 1
  print(x.compareTo(y));  // Line 5
  print(x.compareTo(z));  // Line 6
}
```

**Options:**
- A: 0 and 1
- B: 0 and -1
- C: 1 and 0
- D: -1 and 0

<details>
<summary>Click to reveal answer</summary>

### Answer: B

**0 and -1**

### Explanation

**How `compareTo` works:**
- Returns **negative** (-1) if the string comes **before** the argument lexicographically
- Returns **0** if the strings are **equal**
- Returns **positive** (1) if the string comes **after** the argument lexicographically

**ASCII Values:**
- Uppercase letters: A=65, B=66, ... H=72, ... Z=90
- Lowercase letters: a=97, b=98, ... h=104, ... z=122

**Step-by-step Analysis:**

1. `z.compareTo(x)` → `'hello'.compareTo('Hello')`
   - Compare first chars: 'h' (104) vs 'H' (72)
   - 104 > 72 → returns **1** (hello comes after Hello)

2. `x.compareTo(y)` → `'Hello'.compareTo('Hello')` **(Line 5)**
   - Strings are identical → returns **0**

3. `x.compareTo(z)` → `'Hello'.compareTo('hello')` **(Line 6)**
   - Compare first chars: 'H' (72) vs 'h' (104)
   - 72 < 104 → returns **-1** (Hello comes before hello)

**Output:** Line 5 = `0`, Line 6 = `-1`

</details>

---

## Question 3: Nested Ternary Operators

**Fill in the appropriate code for the blank in the Dart program below so that it prints "Child", "Teen", or "Adult" based on the value of age. (Note: Under 13 is Child, 13-19 is Teen, 20 and above is Adult)**

```dart
void main() {
  int age = 15;
  String category = _________________;
  print(category);  // prints "Child", "Teen" or "Adult"
}
```

**Options:**
- A: `(age < 13) ? "Child" : ((age < 20) ? "Teen" : "Adult")`
- B: `(age >= 20) ? "Adult" : "Teen", (age < 13) ? "Child"`
- C: `(age < 20) ? "Teen" : ((age < 13) ? "Child" : "Adult")`
- D: `((age >= 13) ? ((age >= 20) ? "Teen" : "Adult") : "Child")`

<details>
<summary>Click to reveal answer</summary>

### Answer: A

**`(age < 13) ? "Child" : ((age < 20) ? "Teen" : "Adult")`**

### Explanation

**Nested Ternary Syntax:**
```
condition1 ? value1 : (condition2 ? value2 : value3)
```

**How Option A works (age = 15):**
1. First check: `age < 13` → `15 < 13` → `false`
2. Go to else branch: `(age < 20) ? "Teen" : "Adult"`
3. Second check: `age < 20` → `15 < 20` → `true`
4. Result: **"Teen"**

**Testing all cases with Option A:**
| age | `age < 13` | `age < 20` | Result |
|-----|-----------|-----------|--------|
| 10  | true      | -         | Child  |
| 15  | false     | true      | Teen   |
| 25  | false     | false     | Adult  |

**Why other options fail:**
- **B:** Invalid syntax - can't chain ternary operators with commas like that
- **C:** Wrong order - checks `age < 20` first, so age=10 would return "Teen" instead of "Child"
- **D:** Wrong logic - maps 13-19 to "Adult" and 20+ to "Teen" (reversed)

</details>

---

## Question 4: Flutter State Management

**In a StatefulWidget, what happens if you update a state variable directly WITHOUT calling `setState()`?**

```dart
class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int counter = 0;

  void increment() {
    counter++;  // Updated WITHOUT setState()
  }

  @override
  Widget build(BuildContext context) {
    return Text('$counter');
  }
}
```

**Options:**
- A: The variable is updated and the UI reflects the new value immediately.
- B: The variable is updated but the UI does NOT reflect the new value.
- C: The app crashes with a runtime error.
- D: The variable is not updated at all.

<details>
<summary>Click to reveal answer</summary>

### Answer: B

**The variable is updated but the UI does NOT reflect the new value.**

### Explanation

**How `setState()` works:**
- `setState()` does TWO things:
  1. Updates the state variable
  2. **Triggers a rebuild** of the widget by calling `build()` again

**What happens WITHOUT `setState()`:**
- The variable `counter` IS updated in memory (it becomes 1, 2, 3...)
- BUT Flutter doesn't know the state changed
- The `build()` method is NOT called again
- The UI continues showing the OLD value

**Correct implementation:**
```dart
void increment() {
  setState(() {
    counter++;
  });
}
```

**Why other options are wrong:**
- **A:** The UI won't update without `setState()` triggering a rebuild
- **C:** No crash occurs - the code runs fine, just no UI update
- **D:** The variable IS updated, just not reflected in the UI

**Key Concept:** `setState()` is the signal that tells Flutter "something changed, please rebuild this widget!"

</details>

---

## Question 5: Named and Required Parameters

**Refer to the following Dart program. Which of the following line(s) will cause an error?**

```dart
void main() {
  Product p1 = Product(price: 99.99);              // Line 1
  Product p2 = Product(name: "Laptop");            // Line 2
  Product p3 = Product(name: "Phone", price: 599); // Line 3
  Product p4 = Product("Tablet", price: 299);      // Line 4
}

class Product {
  String name;
  double price;

  Product({required this.name, this.price = 0.0});
}
```

**Options:**
- A: Line 1 and 4
- B: Line 2 and 3
- C: Line 1 only
- D: Line 4 only

<details>
<summary>Click to reveal answer</summary>

### Answer: A

**Line 1 and 4**

### Explanation

**The constructor:**
```dart
Product({required this.name, this.price = 0.0});
```
- `name` is **required** - must always be provided
- `price` is **optional** - has default value `0.0`

**Line-by-line analysis:**

| Line | Code | `name` | `price` | Result |
|------|------|--------|---------|--------|
| 1 | `Product(price: 99.99)` | Missing! | Provided | **ERROR** |
| 2 | `Product(name: "Laptop")` | Provided | Uses default 0.0 | Valid |
| 3 | `Product(name: "Phone", price: 599)` | Provided | Provided | Valid |
| 4 | `Product("Tablet", price: 299)` | Positional arg! | Provided | **ERROR** |

**Why Line 1 fails:**
- Missing the `required` parameter `name`

**Why Line 4 fails:**
- `"Tablet"` is passed as a **positional argument**
- But the constructor only accepts **named parameters** (inside `{}`)
- Should be: `Product(name: "Tablet", price: 299)`

**Key Concepts:**
- `required` means the parameter MUST be provided
- Named parameters use `{}` and must be called with `paramName: value`
- Positional arguments cannot be used with named-only constructors

</details>

---

## Question 6: Constructor Parameter Types

**Which constructor definition would allow the following call to work?**

```dart
void main() {
  Car myCar = Car("Toyota", year: 2024);
}
```

**Options:**

A:
```dart
class Car {
  String brand;
  int year;
  Car({required this.brand, this.year = 2020});
}
```

B:
```dart
class Car {
  String brand;
  int year;
  Car(this.brand, {this.year = 2020});
}
```

C:
```dart
class Car {
  String brand;
  int year;
  Car(this.brand, this.year);
}
```

D:
```dart
class Car {
  String brand;
  int year;
  Car({this.brand = "Unknown", required this.year});
}
```

<details>
<summary>Click to reveal answer</summary>

### Answer: B

```dart
Car(this.brand, {this.year = 2020});
```

### Explanation

**The call we need to support:**
```dart
Car("Toyota", year: 2024);
//  ^^^^^^^^  ^^^^^^^^^^
//  Positional   Named
```

This call uses:
- `"Toyota"` as a **positional** argument (no parameter name)
- `year: 2024` as a **named** argument (has parameter name)

**Analyzing each option:**

| Option | Constructor | `"Toyota"` | `year: 2024` | Result |
|--------|-------------|------------|--------------|--------|
| A | `({required this.brand, this.year = 2020})` | Needs `brand:` | Works | **ERROR** |
| B | `(this.brand, {this.year = 2020})` | Positional ✓ | Named ✓ | **VALID** |
| C | `(this.brand, this.year)` | Positional ✓ | Needs positional | **ERROR** |
| D | `({this.brand = "Unknown", required this.year})` | Needs `brand:` | Works | **ERROR** |

**Key Syntax:**
```dart
// All positional
Car(this.brand, this.year);

// All named
Car({this.brand, this.year});

// Mixed: positional THEN named
Car(this.brand, {this.year});
```

**Rule:** Positional parameters come FIRST, then named parameters in `{}`.

</details>

---

## Question 7: Firestore Data Structure

**In Firebase Firestore, which of the following correctly describes the data hierarchy?**

**Options:**
- A: Database → Documents → Collections → Fields
- B: Database → Collections → Documents → Fields
- C: Database → Fields → Documents → Collections
- D: Database → Collections → Fields → Documents

<details>
<summary>Click to reveal answer</summary>

### Answer: B

**Database → Collections → Documents → Fields**

### Explanation

**Firestore Hierarchy:**
```
Database
  └── Collection (e.g., "users")
        └── Document (e.g., "user123")
              └── Fields (e.g., name: "John", age: 25)
```

**Example in code:**
```dart
FirebaseFirestore.instance
    .collection('users')      // Collection
    .doc('user123')           // Document
    .get();                   // Gets the fields
```

**Key Concepts:**
- **Collection:** A container that holds documents (like a folder)
- **Document:** A single record identified by a unique ID (like a file)
- **Fields:** Key-value pairs inside a document (the actual data)

**Visual Example:**
```
Firestore Database
  └── users (collection)
        ├── user001 (document)
        │     ├── name: "Alice"
        │     └── email: "alice@email.com"
        └── user002 (document)
              ├── name: "Bob"
              └── email: "bob@email.com"
```

</details>

---

## Question 8: Do-While Loop with List

**Assuming that a variable `nums` is a list that contains:**
```dart
[5, 24, 42, 17]
```

**What is the output from the following Dart snippet?**

```dart
int index = 0;
do {
  if (nums[index] % 2 == 0) {
    print(nums[index]);
    index++;
  } else {
    print('#');
    index += 2;
  }
} while (index < 4);
```

**Options:**
- A: #<br>42<br>17
- B: #<br>42<br>#
- C: 5<br>24<br>42
- D: #<br>24<br>42

<details>
<summary>Click to reveal answer</summary>

### Answer: B

```
#
42
#
```

### Explanation

**List:** `nums = [5, 24, 42, 17]` (indices 0, 1, 2, 3)

**Trace through the loop:**

| Iteration | index | nums[index] | Even? | Action | Output | New index |
|-----------|-------|-------------|-------|--------|--------|-----------|
| 1 | 0 | 5 | No (5%2!=0) | print('#'), index+=2 | **#** | 2 |
| 2 | 2 | 42 | Yes (42%2==0) | print(42), index++ | **42** | 3 |
| 3 | 3 | 17 | No (17%2!=0) | print('#'), index+=2 | **#** | 5 |
| - | 5 | - | 5<4 false, EXIT | - | - |

**Step-by-step:**
1. index=0: `5 % 2 == 0` → false (odd) → print `#`, index becomes 2
2. index=2: `42 % 2 == 0` → true (even) → print `42`, index becomes 3
3. index=3: `17 % 2 == 0` → false (odd) → print `#`, index becomes 5
4. index=5: `5 < 4` is false → loop exits

**Output:** #, 42, #

**Why other options are wrong:**
- **A:** 17 is never printed (we print '#' instead when odd)
- **C:** 5 is odd so prints '#', not 5; also skips index 1 entirely
- **D:** Index jumps from 0 to 2, so 24 (at index 1) is never accessed

</details>

---

## Question 9: Understanding Function Purpose

**Assuming that a class `Book` has been defined with these 3 attributes:**
```dart
String title, author, genre;
```

**Assuming also that the variable `books` in the following snippet is a list that contains a few Book objects with proper data.**

```dart
int func2(List<Book> books, String g) {
  int count = 0;
  for (int i = 0; i < books.length; i++) {
    if (books[i].genre == g) {
      count++;
    }
  }
  return count;
}
```

**What is the purpose of the function `func2`?**

**Options:**
- A: To check if the list contains a Book with a particular genre
- B: To count how many Books in the list have a particular genre
- C: To get the index of the first Book with a particular genre
- D: To remove all Books with a particular genre from the list

<details>
<summary>Click to reveal answer</summary>

### Answer: B

**To count how many Books in the list have a particular genre**

### Explanation

**Function Analysis:**
```dart
int func2(List<Book> books, String g) {
  int count = 0;                        // Initialize counter
  for (int i = 0; i < books.length; i++) {  // Loop through all books
    if (books[i].genre == g) {          // If genre matches
      count++;                          // Increment counter
    }
  }
  return count;                         // Return the count
}
```

**Key observations:**
1. Returns `int` (not `bool`) → suggests counting or finding index
2. Uses a `count` variable that increments → counting pattern
3. Checks `genre == g` for each book → filtering by genre
4. Returns `count` after loop completes → total count

**Example usage:**
```dart
List<Book> myBooks = [
  Book("1984", "Orwell", "Fiction"),
  Book("Dune", "Herbert", "Fiction"),
  Book("Cosmos", "Sagan", "Science"),
];

int result = func2(myBooks, "Fiction");  // Returns 2
```

**Why other options are wrong:**
- **A:** Would return `bool`, not `int`; would use `return true` when found
- **C:** Would return `i` (the index) when found, not continue counting
- **D:** Would need to modify/remove from the list, not just count

</details>

---

## Question 10: For Loop with Break and Continue

**What is the output from the following Dart snippet?**

```dart
void main() {
  int n = 0;
  for (;; n++) {
    if (n == 6) break;
    if (n % 2 == 0) {
      continue;
    }
    print('*');
  }
}
```

**Options:**
- A: * (printed 6 times)
- B: * (printed 4 times)
- C: * (printed 3 times)
- D: * (printed 2 times)

<details>
<summary>Click to reveal answer</summary>

### Answer: C

**\* (printed 3 times)**

### Explanation

**Understanding the for loop:**
- `for (;; n++)` is an **infinite loop** - the `;;` means no initialization and no condition
- The loop runs forever until `break` is hit
- `n` starts at 0 and increments each iteration

**Trace through the loop:**

| n | n == 6? | n % 2 == 0? (even?) | Action | Output |
|---|---------|---------------------|--------|--------|
| 0 | No | Yes (even) | continue (skip print) | - |
| 1 | No | No (odd) | print('*') | **\*** |
| 2 | No | Yes (even) | continue (skip print) | - |
| 3 | No | No (odd) | print('*') | **\*** |
| 4 | No | Yes (even) | continue (skip print) | - |
| 5 | No | No (odd) | print('*') | **\*** |
| 6 | Yes | - | break (exit loop) | - |

**Key insight:** Only **odd numbers** (1, 3, 5) reach the print statement. Even numbers trigger `continue`.

**Output:** `*` printed 3 times (for n = 1, 3, 5)

**Key Concepts:**
- `for (;;)` creates an infinite loop (equivalent to `while(true)`)
- `break` exits the loop immediately
- `continue` skips to the next iteration without executing remaining code

</details>

---

## Question 11: const vs final Keywords

**In the Dart snippet below, which line(s) will cause an error?**

```dart
void calculate() {
  const int a = 5;         // Line 1
  final int b = a * 2;     // Line 2
  const int c = a + 3;     // Line 3
  final int d = b + 1;     // Line 4
  const int e = b * 2;     // Line 5
}
```

**Options:**
- A: Line 5
- B: Line 2 and 5
- C: Line 4 and 5
- D: Line 2 and 4

<details>
<summary>Click to reveal answer</summary>

### Answer: A

**Line 5**

### Explanation

**Key Difference:**
| Keyword | When value is determined | Can use runtime values? |
|---------|-------------------------|------------------------|
| `const` | **Compile-time** | No - only literals and other const |
| `final` | **Runtime** | Yes - can compute at runtime |

**Line-by-line analysis:**

**What is a literal?**
A literal is a fixed value written directly in code (e.g., `5`, `"Hello"`, `true`). Literals are always known at compile-time.

**Line-by-line analysis:**

| Line | Code | Valid? | Reason |
|------|------|--------|--------|
| 1 | `const int a = 5;` | ✓ | `5` is a literal (hardcoded value) - known at compile-time |
| 2 | `final int b = a * 2;` | ✓ | `final` can use any value; `a` is const so this works |
| 3 | `const int c = a + 3;` | ✓ | `a` is const, so `a + 3` is compile-time constant |
| 4 | `final int d = b + 1;` | ✓ | `final` can use runtime values like `b` |
| 5 | `const int e = b * 2;` | ✗ | **ERROR:** `b` is `final` (not const), so `b * 2` is NOT compile-time |

**Why Line 5 fails:**
- `const` requires a **compile-time constant**
- `b` is declared as `final`, not `const`
- Even though `b`'s value comes from a const (`a * 2`), `b` itself is `final`
- `final` values are determined at **runtime**, not compile-time
- Therefore `b * 2` cannot be used in a `const` declaration

**Rule of thumb:**
- `const` can only use other `const` values or literals
- `final` can use anything (const, final, or runtime values)

</details>

---

# Dart & Flutter Quick Recap

A quick reference guide covering essential concepts for your exam.

---

## 1. Flutter App Structure

### AppBar
- The **horizontal region at the top** of a mobile app
- Contains title, navigation icons, action buttons
```dart
Scaffold(
  appBar: AppBar(title: Text('My App')),
)
```

### Scaffold Properties
| Property | Description |
|----------|-------------|
| `appBar` | Top navigation bar |
| `body` | Main content area |
| `floatingActionButton` | FAB button |
| `drawer` | Side navigation menu |
| `bottomNavigationBar` | Bottom nav bar |

**NOT a Scaffold property:** `home`, `title`, `theme` (these belong to MaterialApp)

### MaterialApp Properties
| Property | Description |
|----------|-------------|
| `home` | The default route widget |
| `title` | App title (shown in task manager) |
| `theme` | App-wide theme data |
| `routes` | Named route definitions |
| `debugShowCheckedModeBanner` | Show/hide debug banner |

---

## 2. Dart Basics

### File Extension
- Dart files use the **`.dart`** extension
- Example: `main.dart`, `home_page.dart`

### Data Types in Dart
| Type | Example | Description |
|------|---------|-------------|
| `int` | `42` | Whole numbers |
| `double` | `3.14` | Decimal numbers |
| `String` | `'Hello'` | Text |
| `bool` | `true` | True/false |
| `List` | `[1, 2, 3]` | Ordered collection |
| `Map` | `{'a': 1}` | Key-value pairs |
| `Set` | `{1, 2, 3}` | Unique values only |

**NOT a data type:** `char`, `float`, `array`

### Variable Keywords
| Keyword | Reassign? | Modify Contents? | When Set? |
|---------|-----------|------------------|-----------|
| `var` | Yes | Yes | Runtime |
| `final` | No | Yes (for collections) | Runtime |
| `const` | No | No | Compile-time |

```dart
var x = 10;      // Can change: x = 20; ✓
final y = 10;    // Cannot change: y = 20; ✗
const z = 10;    // Cannot change: z = 20; ✗
```

---

## 3. Functions

### main() Function
- **Entry point** of every Dart/Flutter application
- The app starts executing from here
```dart
void main() {
  runApp(MyApp());  // Starts the Flutter app
}
```

### print() Method
- Takes an **Object** as parameter (any type)
- Converts it to String and outputs to console
```dart
print('Hello');     // String
print(42);          // int
print(true);        // bool
print([1, 2, 3]);   // List
```

### trim() Function
- Removes **leading and trailing spaces** from a String
```dart
String text = '  Hello World  ';
print(text.trim());  // Output: 'Hello World'
```

---

## 4. Widgets

### What is a Widget?
- **Everything in Flutter is a widget**
- A widget is a **UI building block** that describes part of the user interface
- Widgets can be combined to build complex UIs

### Widget Naming Conventions
| Element | Convention | Example |
|---------|------------|---------|
| Widget class name | **Capital letter** (PascalCase) | `MyButton`, `HomePage` |
| Property name | **lowercase** (camelCase) | `backgroundColor`, `fontSize` |

```dart
class MyWidget extends StatelessWidget {  // Capital M
  final String title;  // lowercase t
}
```

### Property Sequence
- The **order of properties does NOT matter** in Flutter
- Both are identical:
```dart
// These are the same:
Text('Hi', style: TextStyle(), textAlign: TextAlign.center)
Text('Hi', textAlign: TextAlign.center, style: TextStyle())
```

### Property Separator
- Properties are separated by a **comma** `,`
```dart
Container(
  width: 100,      // comma
  height: 200,     // comma
  color: Colors.blue,  // trailing comma (optional but recommended)
)
```

---

## 5. Common Widgets

### Padding Widget
- Adds **empty space around** a child widget
- Creates visual spacing/margins
```dart
Padding(
  padding: EdgeInsets.all(16.0),
  child: Text('Hello'),
)
```

### TextStyle Properties
| Property | Description | Example |
|----------|-------------|---------|
| `fontSize` | Text size | `fontSize: 20` |
| `fontWeight` | Bold, normal, etc. | `fontWeight: FontWeight.bold` |
| `color` | Text color | `color: Colors.red` |
| `fontStyle` | Italic, normal | `fontStyle: FontStyle.italic` |
| `letterSpacing` | Space between letters | `letterSpacing: 2.0` |

```dart
Text(
  'Hello',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),
)
```

---

## 6. Object-Oriented Programming

### Inheritance (extends)
- Use **`extends`** keyword to create a subclass
- Subclass inherits properties and methods from parent
```dart
class Animal {
  void eat() => print('Eating');
}

class Dog extends Animal {  // Dog inherits from Animal
  void bark() => print('Woof!');
}
```

---

## 7. Collections

### Set - No Duplicates!
- A Set only stores **unique values**
- If you add a duplicate, it is **ignored** (no error, just not added)
```dart
Set<int> numbers = {1, 2, 3};
numbers.add(2);  // Duplicate - ignored!
print(numbers);  // Output: {1, 2, 3}
print(numbers.length);  // Output: 3
```

### List vs Set vs Map
| Collection | Duplicates? | Ordered? | Access |
|------------|-------------|----------|--------|
| List | Yes | Yes | By index `[0]` |
| Set | No | No | By value |
| Map | Keys: No | No | By key `['name']` |

---

## 8. pubspec.yaml

### Purpose
- **Configuration file** for Flutter/Dart projects
- Defines:
  - Project name and description
  - Dependencies (packages)
  - Assets (images, fonts)
  - SDK version constraints

```yaml
name: my_app
description: A Flutter application

dependencies:
  flutter:
    sdk: flutter
  http: ^0.13.0  # External package

flutter:
  assets:
    - images/logo.png
```

---

## 9. Loop Control

### for Loop Syntax
```dart
for (initialization; condition; increment) {
  // code
}

// Infinite loop (no condition):
for (;;) {
  // runs forever until break
}
```

### break vs continue
| Keyword | What it does |
|---------|--------------|
| `break` | **Exit** the loop completely |
| `continue` | **Skip** current iteration, go to next |

```dart
for (int i = 0; i < 5; i++) {
  if (i == 2) continue;  // Skip when i is 2
  if (i == 4) break;     // Exit when i is 4
  print(i);
}
// Output: 0, 1, 3
```

---

## 10. Null Safety Operators

| Operator | Name | Example | What it does |
|----------|------|---------|--------------|
| `?` | Nullable type | `String? name` | Variable can be null |
| `?.` | Null-aware access | `name?.length` | Returns null if name is null |
| `??` | Null coalescing | `name ?? 'Guest'` | Use 'Guest' if name is null |
| `!` | Null assertion | `name!.length` | Force unwrap (crashes if null!) |

---

## Quick Answer Reference

| Question | Answer |
|----------|--------|
| Horizontal region at top of app? | **AppBar** |
| File extension for Dart? | **`.dart`** |
| Keyword for subclass? | **`extends`** |
| Remove leading/trailing spaces? | **`trim()`** |
| print() takes what type? | **Object** |
| Add duplicate to Set? | **Ignored (not added)** |
| Properties separator? | **Comma (`,`)** |
| Widget names start with? | **Capital letter** |
| Property order matters? | **No** |
| Purpose of Padding? | **Add space around child** |
| Purpose of pubspec.yaml? | **Project configuration** |
| Purpose of main()? | **Entry point of app** |

---
