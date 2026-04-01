// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GuardEntry {

 String get name; String get startTime; String get endTime; String get pause; String get total;
/// Create a copy of GuardEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GuardEntryCopyWith<GuardEntry> get copyWith => _$GuardEntryCopyWithImpl<GuardEntry>(this as GuardEntry, _$identity);

  /// Serializes this GuardEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GuardEntry&&(identical(other.name, name) || other.name == name)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.pause, pause) || other.pause == pause)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,startTime,endTime,pause,total);

@override
String toString() {
  return 'GuardEntry(name: $name, startTime: $startTime, endTime: $endTime, pause: $pause, total: $total)';
}


}

/// @nodoc
abstract mixin class $GuardEntryCopyWith<$Res>  {
  factory $GuardEntryCopyWith(GuardEntry value, $Res Function(GuardEntry) _then) = _$GuardEntryCopyWithImpl;
@useResult
$Res call({
 String name, String startTime, String endTime, String pause, String total
});




}
/// @nodoc
class _$GuardEntryCopyWithImpl<$Res>
    implements $GuardEntryCopyWith<$Res> {
  _$GuardEntryCopyWithImpl(this._self, this._then);

  final GuardEntry _self;
  final $Res Function(GuardEntry) _then;

/// Create a copy of GuardEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? startTime = null,Object? endTime = null,Object? pause = null,Object? total = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,pause: null == pause ? _self.pause : pause // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GuardEntry].
extension GuardEntryPatterns on GuardEntry {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GuardEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GuardEntry() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GuardEntry value)  $default,){
final _that = this;
switch (_that) {
case _GuardEntry():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GuardEntry value)?  $default,){
final _that = this;
switch (_that) {
case _GuardEntry() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String startTime,  String endTime,  String pause,  String total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GuardEntry() when $default != null:
return $default(_that.name,_that.startTime,_that.endTime,_that.pause,_that.total);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String startTime,  String endTime,  String pause,  String total)  $default,) {final _that = this;
switch (_that) {
case _GuardEntry():
return $default(_that.name,_that.startTime,_that.endTime,_that.pause,_that.total);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String startTime,  String endTime,  String pause,  String total)?  $default,) {final _that = this;
switch (_that) {
case _GuardEntry() when $default != null:
return $default(_that.name,_that.startTime,_that.endTime,_that.pause,_that.total);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GuardEntry implements GuardEntry {
  const _GuardEntry({required this.name, required this.startTime, required this.endTime, required this.pause, required this.total});
  factory _GuardEntry.fromJson(Map<String, dynamic> json) => _$GuardEntryFromJson(json);

@override final  String name;
@override final  String startTime;
@override final  String endTime;
@override final  String pause;
@override final  String total;

/// Create a copy of GuardEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GuardEntryCopyWith<_GuardEntry> get copyWith => __$GuardEntryCopyWithImpl<_GuardEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GuardEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GuardEntry&&(identical(other.name, name) || other.name == name)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.pause, pause) || other.pause == pause)&&(identical(other.total, total) || other.total == total));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,startTime,endTime,pause,total);

@override
String toString() {
  return 'GuardEntry(name: $name, startTime: $startTime, endTime: $endTime, pause: $pause, total: $total)';
}


}

/// @nodoc
abstract mixin class _$GuardEntryCopyWith<$Res> implements $GuardEntryCopyWith<$Res> {
  factory _$GuardEntryCopyWith(_GuardEntry value, $Res Function(_GuardEntry) _then) = __$GuardEntryCopyWithImpl;
@override @useResult
$Res call({
 String name, String startTime, String endTime, String pause, String total
});




}
/// @nodoc
class __$GuardEntryCopyWithImpl<$Res>
    implements _$GuardEntryCopyWith<$Res> {
  __$GuardEntryCopyWithImpl(this._self, this._then);

  final _GuardEntry _self;
  final $Res Function(_GuardEntry) _then;

/// Create a copy of GuardEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? startTime = null,Object? endTime = null,Object? pause = null,Object? total = null,}) {
  return _then(_GuardEntry(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,pause: null == pause ? _self.pause : pause // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Report {

 String get id; String get reportNumber; String get jobId; String get location; String get clientAddress; DateTime get date; String get workStart; String get workEnd; String get notes; List<String> get photoUrls; String get signedBy; String? get exportedPdf; String get reportType; String get severity; bool get isIncident; String? get weather; bool get policeNotified; String? get signatureUrl; bool get isOutOfBounds; double get calculatedPay; double get breakDurationHours; List<GuardEntry> get guards;
/// Create a copy of Report
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportCopyWith<Report> get copyWith => _$ReportCopyWithImpl<Report>(this as Report, _$identity);

  /// Serializes this Report to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Report&&(identical(other.id, id) || other.id == id)&&(identical(other.reportNumber, reportNumber) || other.reportNumber == reportNumber)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.location, location) || other.location == location)&&(identical(other.clientAddress, clientAddress) || other.clientAddress == clientAddress)&&(identical(other.date, date) || other.date == date)&&(identical(other.workStart, workStart) || other.workStart == workStart)&&(identical(other.workEnd, workEnd) || other.workEnd == workEnd)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other.photoUrls, photoUrls)&&(identical(other.signedBy, signedBy) || other.signedBy == signedBy)&&(identical(other.exportedPdf, exportedPdf) || other.exportedPdf == exportedPdf)&&(identical(other.reportType, reportType) || other.reportType == reportType)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.isIncident, isIncident) || other.isIncident == isIncident)&&(identical(other.weather, weather) || other.weather == weather)&&(identical(other.policeNotified, policeNotified) || other.policeNotified == policeNotified)&&(identical(other.signatureUrl, signatureUrl) || other.signatureUrl == signatureUrl)&&(identical(other.isOutOfBounds, isOutOfBounds) || other.isOutOfBounds == isOutOfBounds)&&(identical(other.calculatedPay, calculatedPay) || other.calculatedPay == calculatedPay)&&(identical(other.breakDurationHours, breakDurationHours) || other.breakDurationHours == breakDurationHours)&&const DeepCollectionEquality().equals(other.guards, guards));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,reportNumber,jobId,location,clientAddress,date,workStart,workEnd,notes,const DeepCollectionEquality().hash(photoUrls),signedBy,exportedPdf,reportType,severity,isIncident,weather,policeNotified,signatureUrl,isOutOfBounds,calculatedPay,breakDurationHours,const DeepCollectionEquality().hash(guards)]);

@override
String toString() {
  return 'Report(id: $id, reportNumber: $reportNumber, jobId: $jobId, location: $location, clientAddress: $clientAddress, date: $date, workStart: $workStart, workEnd: $workEnd, notes: $notes, photoUrls: $photoUrls, signedBy: $signedBy, exportedPdf: $exportedPdf, reportType: $reportType, severity: $severity, isIncident: $isIncident, weather: $weather, policeNotified: $policeNotified, signatureUrl: $signatureUrl, isOutOfBounds: $isOutOfBounds, calculatedPay: $calculatedPay, breakDurationHours: $breakDurationHours, guards: $guards)';
}


}

/// @nodoc
abstract mixin class $ReportCopyWith<$Res>  {
  factory $ReportCopyWith(Report value, $Res Function(Report) _then) = _$ReportCopyWithImpl;
@useResult
$Res call({
 String id, String reportNumber, String jobId, String location, String clientAddress, DateTime date, String workStart, String workEnd, String notes, List<String> photoUrls, String signedBy, String? exportedPdf, String reportType, String severity, bool isIncident, String? weather, bool policeNotified, String? signatureUrl, bool isOutOfBounds, double calculatedPay, double breakDurationHours, List<GuardEntry> guards
});




}
/// @nodoc
class _$ReportCopyWithImpl<$Res>
    implements $ReportCopyWith<$Res> {
  _$ReportCopyWithImpl(this._self, this._then);

  final Report _self;
  final $Res Function(Report) _then;

/// Create a copy of Report
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? reportNumber = null,Object? jobId = null,Object? location = null,Object? clientAddress = null,Object? date = null,Object? workStart = null,Object? workEnd = null,Object? notes = null,Object? photoUrls = null,Object? signedBy = null,Object? exportedPdf = freezed,Object? reportType = null,Object? severity = null,Object? isIncident = null,Object? weather = freezed,Object? policeNotified = null,Object? signatureUrl = freezed,Object? isOutOfBounds = null,Object? calculatedPay = null,Object? breakDurationHours = null,Object? guards = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reportNumber: null == reportNumber ? _self.reportNumber : reportNumber // ignore: cast_nullable_to_non_nullable
as String,jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,clientAddress: null == clientAddress ? _self.clientAddress : clientAddress // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,workStart: null == workStart ? _self.workStart : workStart // ignore: cast_nullable_to_non_nullable
as String,workEnd: null == workEnd ? _self.workEnd : workEnd // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,photoUrls: null == photoUrls ? _self.photoUrls : photoUrls // ignore: cast_nullable_to_non_nullable
as List<String>,signedBy: null == signedBy ? _self.signedBy : signedBy // ignore: cast_nullable_to_non_nullable
as String,exportedPdf: freezed == exportedPdf ? _self.exportedPdf : exportedPdf // ignore: cast_nullable_to_non_nullable
as String?,reportType: null == reportType ? _self.reportType : reportType // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,isIncident: null == isIncident ? _self.isIncident : isIncident // ignore: cast_nullable_to_non_nullable
as bool,weather: freezed == weather ? _self.weather : weather // ignore: cast_nullable_to_non_nullable
as String?,policeNotified: null == policeNotified ? _self.policeNotified : policeNotified // ignore: cast_nullable_to_non_nullable
as bool,signatureUrl: freezed == signatureUrl ? _self.signatureUrl : signatureUrl // ignore: cast_nullable_to_non_nullable
as String?,isOutOfBounds: null == isOutOfBounds ? _self.isOutOfBounds : isOutOfBounds // ignore: cast_nullable_to_non_nullable
as bool,calculatedPay: null == calculatedPay ? _self.calculatedPay : calculatedPay // ignore: cast_nullable_to_non_nullable
as double,breakDurationHours: null == breakDurationHours ? _self.breakDurationHours : breakDurationHours // ignore: cast_nullable_to_non_nullable
as double,guards: null == guards ? _self.guards : guards // ignore: cast_nullable_to_non_nullable
as List<GuardEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [Report].
extension ReportPatterns on Report {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Report value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Report() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Report value)  $default,){
final _that = this;
switch (_that) {
case _Report():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Report value)?  $default,){
final _that = this;
switch (_that) {
case _Report() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String reportNumber,  String jobId,  String location,  String clientAddress,  DateTime date,  String workStart,  String workEnd,  String notes,  List<String> photoUrls,  String signedBy,  String? exportedPdf,  String reportType,  String severity,  bool isIncident,  String? weather,  bool policeNotified,  String? signatureUrl,  bool isOutOfBounds,  double calculatedPay,  double breakDurationHours,  List<GuardEntry> guards)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Report() when $default != null:
return $default(_that.id,_that.reportNumber,_that.jobId,_that.location,_that.clientAddress,_that.date,_that.workStart,_that.workEnd,_that.notes,_that.photoUrls,_that.signedBy,_that.exportedPdf,_that.reportType,_that.severity,_that.isIncident,_that.weather,_that.policeNotified,_that.signatureUrl,_that.isOutOfBounds,_that.calculatedPay,_that.breakDurationHours,_that.guards);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String reportNumber,  String jobId,  String location,  String clientAddress,  DateTime date,  String workStart,  String workEnd,  String notes,  List<String> photoUrls,  String signedBy,  String? exportedPdf,  String reportType,  String severity,  bool isIncident,  String? weather,  bool policeNotified,  String? signatureUrl,  bool isOutOfBounds,  double calculatedPay,  double breakDurationHours,  List<GuardEntry> guards)  $default,) {final _that = this;
switch (_that) {
case _Report():
return $default(_that.id,_that.reportNumber,_that.jobId,_that.location,_that.clientAddress,_that.date,_that.workStart,_that.workEnd,_that.notes,_that.photoUrls,_that.signedBy,_that.exportedPdf,_that.reportType,_that.severity,_that.isIncident,_that.weather,_that.policeNotified,_that.signatureUrl,_that.isOutOfBounds,_that.calculatedPay,_that.breakDurationHours,_that.guards);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String reportNumber,  String jobId,  String location,  String clientAddress,  DateTime date,  String workStart,  String workEnd,  String notes,  List<String> photoUrls,  String signedBy,  String? exportedPdf,  String reportType,  String severity,  bool isIncident,  String? weather,  bool policeNotified,  String? signatureUrl,  bool isOutOfBounds,  double calculatedPay,  double breakDurationHours,  List<GuardEntry> guards)?  $default,) {final _that = this;
switch (_that) {
case _Report() when $default != null:
return $default(_that.id,_that.reportNumber,_that.jobId,_that.location,_that.clientAddress,_that.date,_that.workStart,_that.workEnd,_that.notes,_that.photoUrls,_that.signedBy,_that.exportedPdf,_that.reportType,_that.severity,_that.isIncident,_that.weather,_that.policeNotified,_that.signatureUrl,_that.isOutOfBounds,_that.calculatedPay,_that.breakDurationHours,_that.guards);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Report implements Report {
  const _Report({required this.id, this.reportNumber = '2024-0001', required this.jobId, required this.location, this.clientAddress = '', required this.date, required this.workStart, required this.workEnd, required this.notes, final  List<String> photoUrls = const [], required this.signedBy, this.exportedPdf, this.reportType = 'Routine', this.severity = 'low', this.isIncident = false, this.weather, this.policeNotified = false, this.signatureUrl, this.isOutOfBounds = false, this.calculatedPay = 0.0, this.breakDurationHours = 0.0, final  List<GuardEntry> guards = const []}): _photoUrls = photoUrls,_guards = guards;
  factory _Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

@override final  String id;
@override@JsonKey() final  String reportNumber;
@override final  String jobId;
@override final  String location;
@override@JsonKey() final  String clientAddress;
@override final  DateTime date;
@override final  String workStart;
@override final  String workEnd;
@override final  String notes;
 final  List<String> _photoUrls;
@override@JsonKey() List<String> get photoUrls {
  if (_photoUrls is EqualUnmodifiableListView) return _photoUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photoUrls);
}

@override final  String signedBy;
@override final  String? exportedPdf;
@override@JsonKey() final  String reportType;
@override@JsonKey() final  String severity;
@override@JsonKey() final  bool isIncident;
@override final  String? weather;
@override@JsonKey() final  bool policeNotified;
@override final  String? signatureUrl;
@override@JsonKey() final  bool isOutOfBounds;
@override@JsonKey() final  double calculatedPay;
@override@JsonKey() final  double breakDurationHours;
 final  List<GuardEntry> _guards;
@override@JsonKey() List<GuardEntry> get guards {
  if (_guards is EqualUnmodifiableListView) return _guards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_guards);
}


/// Create a copy of Report
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportCopyWith<_Report> get copyWith => __$ReportCopyWithImpl<_Report>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Report&&(identical(other.id, id) || other.id == id)&&(identical(other.reportNumber, reportNumber) || other.reportNumber == reportNumber)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.location, location) || other.location == location)&&(identical(other.clientAddress, clientAddress) || other.clientAddress == clientAddress)&&(identical(other.date, date) || other.date == date)&&(identical(other.workStart, workStart) || other.workStart == workStart)&&(identical(other.workEnd, workEnd) || other.workEnd == workEnd)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other._photoUrls, _photoUrls)&&(identical(other.signedBy, signedBy) || other.signedBy == signedBy)&&(identical(other.exportedPdf, exportedPdf) || other.exportedPdf == exportedPdf)&&(identical(other.reportType, reportType) || other.reportType == reportType)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.isIncident, isIncident) || other.isIncident == isIncident)&&(identical(other.weather, weather) || other.weather == weather)&&(identical(other.policeNotified, policeNotified) || other.policeNotified == policeNotified)&&(identical(other.signatureUrl, signatureUrl) || other.signatureUrl == signatureUrl)&&(identical(other.isOutOfBounds, isOutOfBounds) || other.isOutOfBounds == isOutOfBounds)&&(identical(other.calculatedPay, calculatedPay) || other.calculatedPay == calculatedPay)&&(identical(other.breakDurationHours, breakDurationHours) || other.breakDurationHours == breakDurationHours)&&const DeepCollectionEquality().equals(other._guards, _guards));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,reportNumber,jobId,location,clientAddress,date,workStart,workEnd,notes,const DeepCollectionEquality().hash(_photoUrls),signedBy,exportedPdf,reportType,severity,isIncident,weather,policeNotified,signatureUrl,isOutOfBounds,calculatedPay,breakDurationHours,const DeepCollectionEquality().hash(_guards)]);

@override
String toString() {
  return 'Report(id: $id, reportNumber: $reportNumber, jobId: $jobId, location: $location, clientAddress: $clientAddress, date: $date, workStart: $workStart, workEnd: $workEnd, notes: $notes, photoUrls: $photoUrls, signedBy: $signedBy, exportedPdf: $exportedPdf, reportType: $reportType, severity: $severity, isIncident: $isIncident, weather: $weather, policeNotified: $policeNotified, signatureUrl: $signatureUrl, isOutOfBounds: $isOutOfBounds, calculatedPay: $calculatedPay, breakDurationHours: $breakDurationHours, guards: $guards)';
}


}

/// @nodoc
abstract mixin class _$ReportCopyWith<$Res> implements $ReportCopyWith<$Res> {
  factory _$ReportCopyWith(_Report value, $Res Function(_Report) _then) = __$ReportCopyWithImpl;
@override @useResult
$Res call({
 String id, String reportNumber, String jobId, String location, String clientAddress, DateTime date, String workStart, String workEnd, String notes, List<String> photoUrls, String signedBy, String? exportedPdf, String reportType, String severity, bool isIncident, String? weather, bool policeNotified, String? signatureUrl, bool isOutOfBounds, double calculatedPay, double breakDurationHours, List<GuardEntry> guards
});




}
/// @nodoc
class __$ReportCopyWithImpl<$Res>
    implements _$ReportCopyWith<$Res> {
  __$ReportCopyWithImpl(this._self, this._then);

  final _Report _self;
  final $Res Function(_Report) _then;

/// Create a copy of Report
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? reportNumber = null,Object? jobId = null,Object? location = null,Object? clientAddress = null,Object? date = null,Object? workStart = null,Object? workEnd = null,Object? notes = null,Object? photoUrls = null,Object? signedBy = null,Object? exportedPdf = freezed,Object? reportType = null,Object? severity = null,Object? isIncident = null,Object? weather = freezed,Object? policeNotified = null,Object? signatureUrl = freezed,Object? isOutOfBounds = null,Object? calculatedPay = null,Object? breakDurationHours = null,Object? guards = null,}) {
  return _then(_Report(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,reportNumber: null == reportNumber ? _self.reportNumber : reportNumber // ignore: cast_nullable_to_non_nullable
as String,jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,clientAddress: null == clientAddress ? _self.clientAddress : clientAddress // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,workStart: null == workStart ? _self.workStart : workStart // ignore: cast_nullable_to_non_nullable
as String,workEnd: null == workEnd ? _self.workEnd : workEnd // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,photoUrls: null == photoUrls ? _self._photoUrls : photoUrls // ignore: cast_nullable_to_non_nullable
as List<String>,signedBy: null == signedBy ? _self.signedBy : signedBy // ignore: cast_nullable_to_non_nullable
as String,exportedPdf: freezed == exportedPdf ? _self.exportedPdf : exportedPdf // ignore: cast_nullable_to_non_nullable
as String?,reportType: null == reportType ? _self.reportType : reportType // ignore: cast_nullable_to_non_nullable
as String,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as String,isIncident: null == isIncident ? _self.isIncident : isIncident // ignore: cast_nullable_to_non_nullable
as bool,weather: freezed == weather ? _self.weather : weather // ignore: cast_nullable_to_non_nullable
as String?,policeNotified: null == policeNotified ? _self.policeNotified : policeNotified // ignore: cast_nullable_to_non_nullable
as bool,signatureUrl: freezed == signatureUrl ? _self.signatureUrl : signatureUrl // ignore: cast_nullable_to_non_nullable
as String?,isOutOfBounds: null == isOutOfBounds ? _self.isOutOfBounds : isOutOfBounds // ignore: cast_nullable_to_non_nullable
as bool,calculatedPay: null == calculatedPay ? _self.calculatedPay : calculatedPay // ignore: cast_nullable_to_non_nullable
as double,breakDurationHours: null == breakDurationHours ? _self.breakDurationHours : breakDurationHours // ignore: cast_nullable_to_non_nullable
as double,guards: null == guards ? _self._guards : guards // ignore: cast_nullable_to_non_nullable
as List<GuardEntry>,
  ));
}


}

// dart format on
