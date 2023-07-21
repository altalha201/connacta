class Conversion {

  static List<String> stringToArray(String givenString) {
    List<String> result = [];
    int stringLength = givenString.length;

    for (int i = 1; i <= stringLength; i++) {
      result.add(givenString.toLowerCase().substring(0, i));
    }

    return result;
  }

}