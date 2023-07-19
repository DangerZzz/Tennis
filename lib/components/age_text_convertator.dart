/// Преобразования количества лет в правильную форму
class AgeTextConvert {
  ///
  String convertAge(
    num age,
  ) {
    var ageConverter = '';
    if (age < 11 || age > 20) {
      switch (age.toString().substring(age.toString().length - 1)) {
        case '0':
          ageConverter = 'лет';
          break;
        case '1':
          ageConverter = 'год';
          break;
        case '2':
          ageConverter = 'года';
          break;
        case '3':
          ageConverter = 'года';
          break;
        case '4':
          ageConverter = 'года';
          break;
        case '5':
          ageConverter = 'лет';
          break;
        case '6':
          ageConverter = 'лет';
          break;
        case '7':
          ageConverter = 'лет';
          break;
        case '8':
          ageConverter = 'лет';
          break;
        case '9':
          ageConverter = 'лет';
          break;
      }
    } else {
      ageConverter = 'лет';
    }

    return ageConverter;
  }
}
