// Importing the 'dart:convert' library — used to convert data between
// Dart objects and JSON (JavaScript Object Notation) format.
// This is required because most APIs send data as JSON.
import 'dart:convert';

// Importing the 'http' package, which allows making network requests (GET, POST, etc.)
// The 'as http' part gives it a short alias so we can call http.get(), http.post(), etc.
import 'package:http/http.dart' as http;

// ------------------------------------------------------------
// 💡 Data Model Class — represents one "Post" object from the API
// ------------------------------------------------------------

// Each Post has three fields: id, title, and body.
class Post {
  final int id; // Unique numeric ID for each post
  final String title; // Short title or heading of the post
  final String body; // Main content or message of the post

  // Constructor to create a Post object
  Post({required this.id, required this.title, required this.body});

  // A 'factory constructor' that helps to create a Post object from JSON data.
  // This means if you have a JSON object (like a Map), you can easily convert it
  // into a Post object using: Post.fromJson(jsonMap)
  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json['id'], // Extracts the 'id' field from JSON
    title: json['title'], // Extracts the 'title' field
    body: json['body'], // Extracts the 'body' field
  );
}

// ------------------------------------------------------------
// 🌐 Function to Fetch Data from the Internet
// ------------------------------------------------------------

// The function returns a Future because network calls take time.
// It fetches a list of Post objects from an API endpoint.
// 'limit' parameter tells how many posts to retrieve.
Future<List<Post>> fetchPosts(int limit) async {
  // 1️⃣ Create a URI (Uniform Resource Identifier) that represents the API endpoint.
  // 'Uri.https' automatically builds a valid HTTPS URL.
  // The parameters inside the map (like '_limit') become query parameters.
  final uri = Uri.https(
    'jsonplaceholder.typicode.com', // The API domain
    '/posts', // The endpoint path
    {
      '_limit': '$limit', // Query parameter to limit the number of posts
    },
  );

  // 2️⃣ Send an HTTP GET request to the given URI.
  // 'await' pauses the function until the response is received.
  // '.timeout()' ensures the request won’t hang forever — if no response in 10 seconds,
  // it will throw a timeout exception.
  final resp = await http.get(uri).timeout(const Duration(seconds: 10));

  // 3️⃣ Check the HTTP status code to ensure the request was successful.
  // A status code of 200 means "OK" — the request was successful and data is available.
  if (resp.statusCode == 200) {
    // 4️⃣ Convert the JSON response body (a string) into a Dart object.
    // The API returns a JSON array, so jsonDecode gives us a List<dynamic>.
    final List<dynamic> data = jsonDecode(resp.body);

    // 5️⃣ Convert each element (Map) in the JSON array into a Post object using fromJson().
    // 'map()' applies a function to every element in the list.
    // 'toList()' turns the result into a regular List<Post>.
    return data.map((e) => Post.fromJson(e)).toList();
  } else {
    // 6️⃣ If the server didn’t return 200, throw an error message.
    // This helps FutureBuilder display an error screen.
    throw Exception('Server error: ${resp.statusCode}');
  }
}
