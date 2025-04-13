import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final kDateFormat = DateFormat('dd/MM/yyyy');

final kDateFieldHintText = kDateFormat.pattern?.toLowerCase() ?? '';

const kUuid = Uuid();

const int kMaxTitleLength = 63;
const double kFormHorizontalPadding = 16.0 * 2;
const double kFieldVerticalSpacing = 20.0;
const double kFieldSectionSpacing = 40.0;

const kMinTextFieldLines = 5;
const kMaxTextFieldLines = 10;

const kSafeAreaTopPadding = 20.0;
const kSafeAreaLeftPadding = 20.0;
