import 'package:fluent_ui/fluent_ui.dart';
import 'package:gsheets/gsheets.dart';
import 'commons.dart';

class src {
  static const credentials = r'''
  {
    "type": "service_account",
    "project_id": "costaz-desktop-project",
    "private_key_id": "e2964a5af10fdc3c4459022719f879835f5e30e9",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC5uxCov5MCxuZ9\nVyEdbd0w5g7HA0YIizbYBQpG5/zav+bf4SbHj3zagVDpy4wyFKBnBcOfgqWC/WOi\n5Q7/wHPHkseTuMVPrPWmhXah3LB1TbaEwTwLfsuUal7ox3puVERDoVGi7HrM4VeS\nwHwNUJUIACxxj88xE+FkieQHsDnGqEHslmJk+vhPpSBMqd2Txj+Pm/KOPZ84yUkQ\ntvSEgibB2HPMiBcd05TDf6l2PJigEMAgt5ztfA5pMvpIZPgO4dyfSo24Xqg/pJSu\n7FtAJTv1NSJNR8gb9J229sahv4aKNL+8rb/DF07oh9+o0zWn0Rvu6ZqyFPw+uLp+\nrWuk98iNAgMBAAECggEAIzC1oRd9MgFAIh78VABhMLbiNWRiJFPGPitETXd+ke7a\nvnABQj3mXNs0GrwZkdKVKrftnv8ov3clpfNLAnuzJCzkGhHf9q7xc03l0pjHKU6i\nZqhbKV1qkrINzgKfqKBYN80ss9clFEUc694DEx3BwvyPbyvdiLG42q0Css85vzEF\n+cCkjVw81TiqQrl9PpDoQGtD2PpTU7z7GIX36Rk4gLEBMpcbInQWr5lWF/bWsXHr\nTjGcdBaXmSsaCPTJIlnWSaIOukdPm8+xC2KhEf+MOtPhmYQKYtyp3mvuJbSxZgOu\n8K7FswHBZVDDgJsEeqXfRwXh9ms6PJqyFHtxAJVOAQKBgQD+/veK1Ng/d+pkw1Jl\nV5A1glf0kHZwgIhuVnx4uew2rHbVv4cVViNnkDmGW/zyGAIaXcZaJroxzQoixGRs\nPspXSQ3l+gkgbXmlCWAdIzAMrWt0I7jtkYs+r52ILD6uNLjyLBqcFqPfeahZq9xy\nSmrY7KEvQxlwtjdV56L2DFUSAQKBgQC6dkePoH0kVn6727r0g+7Fl91c64i39Qoy\nyRdzzmWkQgayImsPA7v3YIl4w1IVZAhinyDPSgA3tXeg8qDzaGmFIZ3WzICCB8ZS\nAu/Yz7iIDWpEzHy35Y0HHkc9PWTIq+K2Cfh00csf1NbGg+ifp1fx9RcXAgqLpRoV\nyPVEFIDejQKBgGY+ibdLHOJmDMAWaWVlNNefyfCwNC1r/EhxuTsXIZXSlVujjmCJ\nx2xxMf+jxsqzwbQcwbnIKYRqeJP0N2gHzU4uZro+BYbRHqOEHNvSDiQnLRzGbhIj\n97dM51eAlil3zmicMpc/pLmoqE48UQoquKj+SKsQtpSxG4MAfCE4VKwBAoGBALaC\nl8EKAfPThfEzPmefy9M0tsQA96239+eF1aLQ38RLrGooLkpgCVg18dl2tZ2icGK4\nB1FeyZ+9y/6J/ujBxqc9JFXfjdm46nHT1hiOGb1yBBabYWhPFB9nj6ttsHyLYjl0\nwPD3eK8Lkb511viOwBJhJ9ypbtEJJeM09H1S5GDxAoGAcp1BoTTR30dehuDvIqyt\nIru6pUA4hWHuWK8uXzzDOPr8IMqyZQ3aY8wEz6/Uca0hYymns0kHNg+Z9m2dj5lR\nVn4ODHVwbMKCjyyBw27GMS7SLjSraDkU4EBS7XKMYqb6X+LqU/s9kPmu7qICe9BF\nX0EgRq04FYxhqfwxEBAZ97Y=\n-----END PRIVATE KEY-----\n",
    "client_email": "i-am-testing-it@costaz-desktop-project.iam.gserviceaccount.com",
    "client_id": "117779218770242619646",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/i-am-testing-it%40costaz-desktop-project.iam.gserviceaccount.com"
  }
  ''';
  static const def_sheet_ID = "1hgf72DPliAk59721Eezl6AoZPRkL7XyZDvHoXuq9GFI";
  static final gsheet_handle = GSheets(src.credentials);
  static final default_sheet = gsheet_handle.spreadsheet(src.def_sheet_ID);
  static final default_works = default_sheet.then((value) => value.worksheetByIndex(1));
}

Future<bool> fillAPIs() async {
  final my_sheet = await src.default_sheet;

  // API.dropdown_sections should be the titles of the worksheets, skipping the last one
  API.dropdown_sections = my_sheet.sheets.map((e) => e.title).toList().sublist(0, my_sheet.sheets.length - 1);

  return true;
}

Future<List<Text>> getRow(int row) async {
  final sheet = await src.default_works;
  final row_data = await sheet?.values.row(row);
  return row_data!.map((e) => Text(e)).toList();
}