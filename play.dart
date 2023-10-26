void main(List<String> args) {
  var list = List.generate(103, (index) => index + 1);
  var page = args.isNotEmpty ? int.parse(args.first) : 1;
  var pageSize = args.isNotEmpty && args.length > 1 ? int.parse(args.last) : 10;

  var result = getPaginatedList(list, page, pageSize);

  print(result);
}

List<int> getPaginatedList(List<int> list, int page, [int pageSize = 10]) {
  if (page == 1) {
    return list.take(pageSize).toList();
  } else {
    return list = list.skip(pageSize * page).take(pageSize).toList();
  }
}
