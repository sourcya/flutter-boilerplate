abstract class Endpoints {
  const Endpoints._();

  static const baseUrl = 'https://jsonplaceholder.typicode.com';

  static const posts = '/posts';
  static String postById(int id) => '/posts/$id';
}
