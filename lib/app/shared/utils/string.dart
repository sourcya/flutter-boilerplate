String capitalizeFirstChar(String str) {
  return '${str[0].toUpperCase()}${str.substring(1)}';
}

String capitalizeFirstCharForEachWord(String str) {
  return str
      .split(' ')
      .map((s) => s.isEmpty ? '' : capitalizeFirstChar(s))
      .join(' ');
}
