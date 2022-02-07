import 'package:cv/cv.dart';
import 'package:grocery_list_maker/models/constant.dart';

abstract class DbRecord extends CvModelBase {
  final id = CvField<int>(columnId);
}
