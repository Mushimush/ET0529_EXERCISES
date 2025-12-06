# Dart & Flutter Questions

A collection of Dart and Flutter questions to test your knowledge. From basic syntax to tricky edge cases!

---

###### 1. What's the output?

```dart
void main() {
  String s = "Mediterranean Sea";
  int pos = s.indexOf('r');
  print(s.substring(pos - 2, pos + 3));
}
```

- A: `terra`
- B: `iterr`
- C: `diter`
- D: `error`

<details><summary><b>Answer</b></summary>
<p>

#### Answer: A

Let's break it down:
- `s = "Mediterranean Sea"` (indices: M=0, e=1, d=2, i=3, t=4, e=5, r=6, r=7, a=8, n=9, e=10, a=11, n=12...)
- `s.indexOf('r')` returns `6` (the first 'r')
- `pos - 2` = `6 - 2` = `4`
- `pos + 3` = `6 + 3` = `9`
- `substring(4, 9)` extracts indices 4, 5, 6, 7, 8
- Characters: `t`, `e`, `r`, `r`, `a`

Result: `terra`

</p>
</details>

---

###### 2. What should fill the blanks for the output to be 100?

```dart
void main() {
  __(i)__ x = 5;
  __(ii)__ y;
  y = x;
  const z = x;
  print(z * y + 75);
}
```

- A: (i) `final` (ii) `final`
- B: (i) `const` (ii) `const`
- C: (i) `const` (ii) `final`
- D: (i) `final` (ii) `const`

<details><summary><b>Answer</b></summary>
<p>

#### Answer: C

Let's break it down:
- `const z = x` requires `x` to be a compile-time constant, so `x` must be `const`
- `y` is **declared first, then assigned later** (`y = x` on a separate line) → **must use `final`**
- With `const x = 5` and `final y = x`:
  - `z = x = 5`
  - `y = x = 5`
  - `z * y + 75 = 5 * 5 + 75 = 25 + 75 = 100` ✓

**Key Rule:**
| Pattern | Use |
|---------|-----|
| Declare AND assign on same line (compile-time value) | `const` |
| Declare AND assign on same line (runtime value) | `final` |
| Declare first, assign later | **`final` only** (never `const`) |

`const` variables **MUST** be assigned at declaration. If you see a variable declared on one line and assigned on another, it can only be `final`.

</p>
</details>

---

###### 3. Which is the correct arrow function equivalent?

```dart
String getTroopName(String color, String troop) {
  String name = color + ' ' + troop;
  name = name.toUpperCase();
  return name;
}
```

- A: `String getTroopName(String color, String troop) => (color + ' ' + troop).toUpperCase();`
- B: `String getTroopName(color, troop) => color.toUpperCase() + troop.toUpperCase();`
- C: `getTroopName(String color, String troop) -> (color + ' ' + troop).toUpperCase();`
- D: `String getTroopName(String color, String troop) -> { return (color + ' ' + troop).toUpperCase(); }`

<details><summary><b>Answer</b></summary>
<p>

#### Answer: A

Let's analyze each option:

- **A ✓**: Correct! Uses `=>`, has return type `String`, and chains operations correctly (concatenate first, then `toUpperCase()`)
- **B ✗**: Missing the space! `color.toUpperCase() + troop.toUpperCase()` produces `"PURPLEBOWLER"` not `"PURPLE BOWLER"`
- **C ✗**: Uses `->` instead of `=>` (Dart uses `=>`, not `->`)
- **D ✗**: Uses `->` instead of `=>`, and arrow functions don't use `{ return ... }`

**Key Rule:** Arrow functions in Dart:
- Use `=>` (fat arrow), NOT `->`
- Can only contain a **single expression** (no curly braces, no `return` keyword)
- The expression's value is automatically returned

```dart
// Regular function
int add(int a, int b) {
  return a + b;
}

// Arrow function equivalent
int add(int a, int b) => a + b;
```

</p>
</details>

---

###### 4. Which code snippet(s) will cause an error?

**Option A:**
```dart
void main() {
  final list = [1, 2, 3];
  list.add(4);
  print(list);
}
```

**Option B:**
```dart
void main() {
  const list = [1, 2, 3];
  list.add(4);
  print(list);
}
```

**Option C:**
```dart
void main() {
  final x = 10;
  x = 20;
  print(x);
}
```

**Option D:**
```dart
void main() {
  const x = 10;
  const y = x + 5;
  print(y);
}
```

- A: Option A only
- B: Option B only
- C: Options B and C
- D: All of them

<details><summary><b>Answer</b></summary>
<p>

#### Answer: C

Let's analyze each option:

| Option | Code | Result |
|--------|------|--------|
| **A** | `final list`; `list.add(4)` | ✓ **Works!** `final` prevents reassignment but allows modifying contents |
| **B** | `const list`; `list.add(4)` | ✗ **ERROR!** `const` makes the list completely immutable |
| **C** | `final x = 10`; `x = 20` | ✗ **ERROR!** Cannot reassign a `final` variable |
| **D** | `const x = 10`; `const y = x + 5` | ✓ **Works!** Both are valid compile-time constants |

**Key Difference:**

| Keyword | Can Reassign? | Can Modify Contents? |
|---------|---------------|----------------------|
| `final` | ❌ No | ✅ Yes |
| `const` | ❌ No | ❌ No |

- `final` = The **variable** can't point to something else, but the **object** it points to can be modified
- `const` = The **entire object** is frozen and immutable

</p>
</details>

---

###### 5. Which combination will compile successfully?

```dart
void main() {
  __(i)__ PI = 3.14159;
  __(ii)__ currentTime = DateTime.now();
  __(iii)__ appName = 'MyApp';

  print('$appName started at $currentTime, PI = $PI');
}
```

- A: (i) `const` (ii) `const` (iii) `const`
- B: (i) `const` (ii) `final` (iii) `const`
- C: (i) `final` (ii) `const` (iii) `final`
- D: (i) `final` (ii) `final` (iii) `final`

<details><summary><b>Answer</b></summary>
<p>

#### Answer: B and D

Let's analyze each variable:

| Variable | Value | Can use `const`? | Can use `final`? |
|----------|-------|------------------|------------------|
| `PI = 3.14159` | Literal number (known at compile time) | ✅ Yes | ✅ Yes |
| `currentTime = DateTime.now()` | Runtime value (only known when program runs) | ❌ **No!** | ✅ Yes |
| `appName = 'MyApp'` | Literal string (known at compile time) | ✅ Yes | ✅ Yes |

**Why each option:**
- **A ✗**: `DateTime.now()` is evaluated at runtime, cannot be `const`
- **B ✓**: Correct! Uses `const` for compile-time values, `final` for runtime
- **C ✗**: `DateTime.now()` cannot be `const`
- **D ✓**: Also correct! `final` accepts both compile-time and runtime values

**Key Rule: When to use which?**

| Use `const` when... | Use `final` when... |
|---------------------|---------------------|
| Value is known at **compile time** | Value is determined at **runtime** |
| Literals: `42`, `'hello'`, `true` | API calls, user input |
| Math on constants: `const x = 2 * 3;` | `DateTime.now()` |
| You want maximum performance | Value won't change after being set |

**Best practice:** Use `const` when possible (better performance), use `final` when the value comes from runtime.

</p>
</details>

---

###### 6. What's the output?

```dart
void main() {
  int x = 1;
  do {
    x *= 3;
    print(x);
  } while (x < 20);
}
```

- A: `3, 9, 27`
- B: `1, 3, 9`
- C: `3, 9`
- D: `1, 3, 9, 27`

<details><summary><b>Answer</b></summary>
<p>

#### Answer: A

Let's trace through the `do-while` loop:

| Iteration | Before | Operation | After | Print | Condition `x < 20` |
|-----------|--------|-----------|-------|-------|-------------------|
| 1 | x = 1 | x *= 3 | x = 3 | `3` | 3 < 20 → true, continue |
| 2 | x = 3 | x *= 3 | x = 9 | `9` | 9 < 20 → true, continue |
| 3 | x = 9 | x *= 3 | x = 27 | `27` | 27 < 20 → false, stop |

Output: `3, 9, 27`

**Key Point about `do-while`:**
- The loop body executes **at least once** before checking the condition
- This is different from `while`, which checks the condition first

```dart
// do-while: executes body FIRST, then checks condition
do {
  // body runs at least once
} while (condition);

// while: checks condition FIRST, then executes body
while (condition) {
  // body may never run if condition is false
}
```

</p>
</details>

---

###### 7. Fill in the blanks to navigate to BattleScreen

```dart
void main() {
  runApp(MaterialApp(
    routes: {
      '/arena': (context) => const ArenaScreen(),
      '/battle': (context) => const BattleScreen(),
    }
  ));
}

// Fill in the blanks:
onPressed: () {
  ____(i)______(context, ___(ii)____);
}
```

- A: (i) `Navigator.pushNamed` (ii) `'/battle'`
- B: (i) `Navigator.pushNamed` (ii) `'BattleScreen'`
- C: (i) `Navigator.push` (ii) `'/battle'`
- D: (i) `Navigation.pushNamed` (ii) `'/battle'`

<details><summary><b>Answer</b></summary>
<p>

#### Answer: A

Let's analyze each option:

- **A ✓**: Correct! `Navigator.pushNamed(context, '/battle')` uses the route name defined in `routes:`
- **B ✗**: `'BattleScreen'` is the class name, not the route name. Routes use the key (`'/battle'`)
- **C ✗**: `Navigator.push` is used with `MaterialPageRoute`, not named routes
- **D ✗**: It's `Navigator`, not `Navigation`

**Key Rule: Named Routes vs Direct Push**

| Method | Usage |
|--------|-------|
| `Navigator.pushNamed(context, '/routeName')` | Use with routes defined in `MaterialApp(routes: {...})` |
| `Navigator.push(context, MaterialPageRoute(...))` | Use for direct navigation without named routes |

```dart
// Named route (defined in MaterialApp)
Navigator.pushNamed(context, '/battle');

// Direct push (no named route needed)
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => BattleScreen()),
);
```

</p>
</details>

---

###### 8. What happens when you run this program?

```dart
void main() {
  int level = 5;

  switch(level) {
    case 1:
    case 5:
    case 10:
      print("Level: " + level);
    case 15:
      print(" - Pro!");
      break;
  }
}
```

- A: Prints `Level: 5`
- B: Prints `Level: 5 - Pro!`
- C: Prints `Level: 5` then ` - Pro!` on separate lines
- D: Compilation error

<details><summary><b>Answer</b></summary>
<p>

#### Answer: D

This code has a **compilation error:**

**Error: String + int concatenation**
```dart
print("Level: " + level);  // ❌ Can't use + with String and int
```

In Dart, you cannot concatenate a `String` with an `int` using the `+` operator.

**Fix options:**
- String interpolation: `print("Level: $level");`
- Explicit conversion: `print("Level: " + level.toString());`

**Note:** The empty cases (`case 1:`, `case 5:`, `case 10:`) falling through to share the same code block is valid Dart syntax.

</p>
</details>

---

###### 9. Fill in the blank to print the correct league

```dart
void main() {
  int trophies = 4500;
  print("You are in __________.");
}
```

**Rule:** If trophies >= 5000: "Champion", otherwise: "Challenger"

- A: `${(trophies >= 5000) ? "Champion" : "Challenger"}`
- B: `${(trophies >= 5000)} ? "Champion" : "Challenger"`
- C: `(trophies >= 5000) : {"Champion", "Challenger"}`
- D: `${trophies >= 5000 ? "Challenger" : "Champion"}`

<details><summary><b>Answer</b></summary>
<p>

#### Answer: A

Let's analyze each option:

- **A ✓**: Correct! `${(trophies >= 5000) ? "Champion" : "Challenger"}` → `4500 >= 5000` is `false` → returns `"Challenger"`
- **B ✗**: Wrong `}` placement - closes interpolation too early, ternary is outside
- **C ✗**: Invalid syntax - ternary uses `?` not `:` to start
- **D ✗**: Values are swapped! Would print "Champion" when it should be "Challenger"

**Ternary Operator Syntax:**
```dart
condition ? valueIfTrue : valueIfFalse
```

**Examples:**
```dart
int age = 20;

// Ternary in string interpolation
print("You are ${age >= 18 ? 'adult' : 'minor'}");

// Ternary in variable assignment
String status = age >= 18 ? "adult" : "minor";

// Nested ternary (use sparingly!)
String grade = score >= 90 ? "A" : score >= 80 ? "B" : "C";
```

</p>
</details>

---

###### 10. Which of the following is a valid way to call this function?

```dart
String greetUser({required String name, String greeting = "Hello"}) {
  return "$greeting, $name!";
}
```

- A: `greetUser("Alice")`
- B: `greetUser(greeting: "Hi")`
- C: `greetUser(name: "Alice")`
- D: `greetUser(name: "Alice", "Hi")`

<details><summary><b>Answer</b></summary>
<p>

#### Answer: C

Let's analyze each option:

- **A ✗**: Named parameters require the parameter name! Can't just pass `"Alice"`
- **B ✗**: `name` is `required`, so you can't skip it. This call is missing `name`
- **C ✓**: Correct! Uses parameter name, and `greeting` uses its default value `"Hello"`
- **D ✗**: Can't mix named and positional arguments - should be `greeting: "Hi"`

**Key Rule: Named Parameters in Dart**

| Syntax | Meaning |
|--------|---------|
| `{int x}` | Optional named parameter, defaults to `null` (or must be nullable) |
| `{int x = 5}` | Optional named parameter with default value |
| `{required int x}` | Required named parameter, **no default**, must be provided |

**Calling Named Parameters:**
```dart
// ❌ Wrong - named params need names
greetUser("Alice");

// ❌ Wrong - missing required param
greetUser(greeting: "Hi");

// ✓ Correct - use parameter name
greetUser(name: "Alice");

// ✓ Can override defaults
greetUser(name: "Alice", greeting: "Hey");
```

</p>
</details>

---

## Quick Reference: String Methods

| Method | Description | Example | Result |
|--------|-------------|---------|--------|
| `substring(start)` | From start to end | `"hello".substring(2)` | `"llo"` |
| `substring(start, end)` | From start to end-1 | `"hello".substring(1, 4)` | `"ell"` |
| `indexOf(str)` | First occurrence | `"hello".indexOf('l')` | `2` |
| `indexOf(str, start)` | First occurrence from start | `"hello".indexOf('l', 3)` | `3` |
| `lastIndexOf(str)` | Last occurrence | `"hello".lastIndexOf('l')` | `3` |
| `length` | String length | `"hello".length` | `5` |

### Key Points

1. **`substring(start, end)`** extracts characters from `start` up to but **NOT including** `end`
2. **`indexOf()` returns `-1`** if the substring is not found
3. **Indices start at 0**, so the first character is at index 0
4. **`substring(n)`** with one argument extracts from index `n` to the end of the string

---

## Contributing

Feel free to submit a PR to add more questions!
