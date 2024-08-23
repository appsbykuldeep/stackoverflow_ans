extension AppIterableBasics<E> on Iterable<E> {
  bool containsAny(Iterable<E> other) => any(other.contains);
}

extension AppListBasics<T> on List<T> {
  List<List<T>> chunk(int chunkSize) {
    return Iterable.generate(
      (length / chunkSize).ceil(),
      (index) => skip(index * chunkSize).take(chunkSize).toList(),
    ).toList();
  }

  // List<List<E>> chunkConvert<E>(int chunkSize, E Function(T) convert) {
  //   return Iterable.generate(
  //     (length / chunkSize).ceil(),
  //     (index) => skip(index * chunkSize)
  //         .take(chunkSize)
  //         .map((e) => convert.call(e))
  //         .toList(),
  //   ).toList();
  // }

  List<List<E>> chunkConvert<E>(
      int chunkSize, E Function(int index, T e) convert) {
    final chunkedList = <List<E>>[];

    final len = length;

    List<E> chunk = <E>[];
    int y = 1;
    for (int i = 0; i < len; i++) {
      if (y == chunkSize) {
        y = 1;
        chunkedList.add(chunk);
        chunk = [];
      }

      chunk.add(convert.call(i, this[i]));
      y++;
    }

    if (chunk.isNotEmpty) {
      chunkedList.add(chunk);
    }

    return chunkedList;
  }

  // List<List<T>> chunk(int chunkSize) {
  //   final chunkedList = <List<T>>[];
  //   final len = length;
  //   final max = (len / chunkSize).ceil();
  //   if (max == 1) {
  //     chunkedList.add(this);
  //     return chunkedList;
  //   }

  //   for (int i = 0; i < max; i++) {
  //     if (i == 0) {
  //       chunkedList.add(sublist(i, math.min(i + chunkSize - 1, len)));
  //     }else{
  //       chunkedList.add(sublist(i, math.min(i + chunkSize - 1, len)));
  //     }
  //   }
  //   return chunkedList;
  // }
}
