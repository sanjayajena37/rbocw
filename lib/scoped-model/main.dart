import 'package:rbocw/scoped-model/register.dart';
import 'package:scoped_model/scoped_model.dart';

import 'login.dart';

class MainModel extends Model with LoginModel, RegisterModel {}
