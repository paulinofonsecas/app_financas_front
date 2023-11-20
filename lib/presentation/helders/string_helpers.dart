String compressString(String data, [int maxLetters = 15]) {
  return data.length <= maxLetters
      ? data
      : '${data.substring(0, maxLetters)}...';
}
