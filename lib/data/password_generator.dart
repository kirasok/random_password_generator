// We do not add ambiguous because we already use them in symbols
// The ambiguous array necessary only to remove them
import 'dart:math';

import 'symbols.dart';

String generatePassword(
    int length,
    bool includeLowercase,
    bool includeUppercase,
    bool includeNumbers,
    bool includeSymbols,
    bool excludeSimilar,
    bool excludeAmbiguous) {
  var resultChars = [];
  if (includeLowercase) resultChars += lowercase;
  if (includeUppercase) resultChars += uppercase;
  if (includeNumbers) resultChars += numbers;
  if (includeSymbols) resultChars += symbols;
  if (excludeSimilar)
    resultChars.removeWhere((element) => similar.contains(element));
  if (excludeAmbiguous)
    resultChars.removeWhere((element) => ambiguous.contains(element));

  if (resultChars.isNotEmpty) {
    String result = "";
    var random = Random.secure();
    for (var a = 0; a < length; a++) {
      result += resultChars[random.nextInt(resultChars.length)];
    }
    return result;
  } else {
    return "";
  }
}
