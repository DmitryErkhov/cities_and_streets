String dateParse (String date) {

  date = date.split("T")[0];
  List<String> dateParts = date.split("-");

  switch (dateParts[1]) {
    case '01':
      dateParts[1] = 'января';
      break;
    case '02':
      dateParts[1] = 'февраля';
      break;
    case '03':
      dateParts[1] = 'марта';
      break;
    case '04':
      dateParts[1] = 'апреля';
      break;
    case '05':
      dateParts[1] = 'мая';
      break;
    case '06':
      dateParts[1] = 'июня';
      break;
    case '07':
      dateParts[1] = 'июля';
      break;
    case '08':
      dateParts[1] = 'августа';
      break;
    case '09':
      dateParts[1] = 'сентября';
      break;
    case '10':
      dateParts[1] = 'октября';
      break;
    case '11':
      dateParts[1] = 'ноября';
      break;
    case '12':
      dateParts[1] = 'декабря';
      break;
  }

  return '${dateParts[2]} ${dateParts[1]} ${dateParts[0]} года';
}