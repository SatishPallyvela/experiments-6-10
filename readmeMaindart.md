

## 🧭 **How to Start the Explanation**

> “Now let’s look at the `main.dart` file — this is the starting point of every Flutter app.
> It controls which screen is shown first and how all other widgets (like our custom widgets and themes) come together.”

---

## 🪄 **1. Import Statements**

```dart
import 'package:flutter/material.dart';
```

🗣 **Explain:**
“This imports the **Material Design package**, which contains all the core widgets and themes used in Flutter apps — like `AppBar`, `Scaffold`, `Text`, and so on.”

---

```dart
// ex6
import 'ex6/custom_widgets.dart';
import 'ex6/themes.dart';

// ex7
import 'ex7/form.dart';

// ex8
import 'ex8/animations.dart';
import 'ex8/animation_types.dart';

// ex9
import 'ex9/display_data.dart';

// ex10
import 'ex10/ui_tests.dart';
import 'ex10/debugging_tools.dart';
```

🗣 **Explain:**
“These lines import all the different experiment files — each file contains the code for a specific lab task.

For example:

* `ex6/custom_widgets.dart` → our **CustomCard** and **CustomAvatar** (Experiment 6a)
* `ex6/themes.dart` → the **ThemeData** we defined for styling (Experiment 6b)
* `ex7/form.dart` → contains code for **forms and validation**
* and so on…”

🧩 **Tip for students:** This is how large apps are organized — by separating code into multiple files for clarity.

---

## 🚀 **2. The `main()` Function**

```dart
void main() {
  runApp(const MyApp());
}
```

🗣 **Explain:**
“This is the **entry point** of the Flutter app.
When you run the app, this `main()` function executes first.
`runApp()` loads our root widget — here it’s `MyApp()` — and displays it on the screen.”

🧠 Example analogy:

> “Think of `runApp()` as the ‘power switch’ — it turns on your Flutter app.”

---

## 🧱 **3. The MyApp Class**

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Experiments Demo',
      theme: appTheme,
      home: const HomePage(),
    );
  }
}
```

🗣 **Explain Line-by-Line:**

* `MyApp` is a **StatelessWidget** – it doesn’t change while running.
* Inside `build()`, we return a `MaterialApp`, which is the **root widget** of every Flutter app.

Explain each property inside `MaterialApp`:

* `debugShowCheckedModeBanner: false` → hides the “debug” banner in the corner.
* `title` → the name of the app.
* `theme: appTheme` → this loads our **custom theme** from `ex6/themes.dart` (Experiment 6b).
* `home: HomePage()` → sets the **starting screen** of the app.

🧠 **Teacher Tip:**

> “So this class controls the overall design and decides which screen is shown first.”

---

## 🏠 **4. The HomePage Class**

```dart
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
```

🗣 **Explain:**
“This defines our home screen as a **StatefulWidget**, meaning it can change during runtime (for example, when we click navigation buttons).”

---

### **The State Class**

```dart
class _HomePageState extends State<HomePage> {
  int _index = 0;
```

🗣 **Explain:**
“This class controls the actual UI for `HomePage`.
The `_index` variable stores which experiment page is currently being viewed.”

---

## 📄 **5. The `pages` List**

```dart
final pages = <Widget>[
  // 6a: Custom Widget
  Padding(
    padding: const EdgeInsets.all(12.0),
    child: ListView(
      children: const [
        Text("6a: Custom Widgets", ...),
        CustomCard(...),
      ],
    ),
  ),

  // 6b: Themes
  Padding(
    padding: const EdgeInsets.all(12.0),
    child: ListView(
      children: const [
        Text("6b: Themes & Styling", ...),
        CustomCard(...),
      ],
    ),
  ),
  ...
];
```

🗣 **Explain:**
“This list stores **all experiment screens** — from 6a to 10b.
Each item is a small Flutter screen built using `Padding`, `Text`, and our custom widgets.
When we tap a navigation icon, the app shows the corresponding screen from this list.”

---

## 🔖 **6. The `labels` List**

```dart
final labels = ['6a', '6b', '7a', '7b', '8a', '8b', '9a', '9b', '10a', '10b'];
```

🗣 **Explain:**
“This list just stores the experiment numbers, which are used as labels for the bottom navigation bar.”

---

## 🧭 **7. The Scaffold**

```dart
return Scaffold(
  appBar: AppBar(title: Text("Experiment ${labels[_index]}")),
  body: pages[_index],
  bottomNavigationBar: BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    currentIndex: _index,
    onTap: (i) => setState(() => _index = i),
    items: labels
        .map((l) => BottomNavigationBarItem(
              icon: const Icon(Icons.science),
              label: l,
            ))
        .toList(),
  ),
);
```

🗣 **Explain:**
“`Scaffold` gives us the basic page layout — an AppBar on top, the main body in the middle, and a BottomNavigationBar at the bottom.”

Then line-by-line:

* `AppBar` shows the experiment number dynamically (e.g., “Experiment 6a”).
* `body: pages[_index]` shows the selected page from our list.
* `BottomNavigationBar` lets us switch between experiments using the icons.
* When we tap an icon, the `setState()` function updates `_index`, and the screen changes instantly.

---

## 🧾 **Final Summary (How to Explain Together)**

| Section                 | What to Emphasize                                      |
| ----------------------- | ------------------------------------------------------ |
| **Imports**             | Organizing code across multiple experiment files.      |
| **main()**              | Entry point of the app (`runApp()` starts everything). |
| **MyApp**               | Defines global theme and starting screen.              |
| **HomePage**            | Main navigation screen controlling all experiments.    |
| **pages[]**             | Each experiment screen (6a–10b) as a separate widget.  |
| **BottomNavigationBar** | Lets you switch between experiments easily.            |

---

### 🎓 **Suggested Flow for Class Explanation**

1. Start with **“What happens first”** → `main()` and `MyApp`.
2. Then move to **“What appears on screen”** → `HomePage`.
3. Next, explain how **“Each experiment is loaded”** → `pages[]` list.
4. Finally, show how **navigation** works using the `BottomNavigationBar`.

---

Would you like me to create a **teacher presentation script** for this (with exact sentences to say while showing code in class + what to highlight on screen)?
It can help you explain naturally while teaching each section.
