import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final dateFormat = DateFormat('dd/MM/yyyy');

final dateFieldHintText = dateFormat.pattern!.toLowerCase();

const uuid = Uuid();
