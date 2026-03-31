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
mixin _$Report {

 String get id; String get jobId; String get location; DateTime get date; String get workStart; String get workEnd; String get notes; List<String> get photoUrls; String get signedBy; String? get exportedPdf; String get reportType; String get severity; bool get isIncident; String? get weather; bool get policeNotified; String? get signatureUrl;
/// Create a copy of Report
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportCopyWith<Report> get copyWith => _$ReportCopyWithImpl<Report>(this as Report, _$identity);

  /// Serializes this Report to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Report&&(identical(other.id, id) || other.id == id)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.location, location) || other.location == location)&&(identical(other.date, date) || other.date == date)&&(identical(other.workStart, workStart) || other.workStart == workStart)&&(identical(other.workEnd, workEnd) || other.workEnd == workEnd)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other.photoUrls, photoUrls)&&(identical(other.signedBy, signedBy) || other.signedBy == signedBy)&&(identical(other.exportedPdf, exportedPdf) || other.exportedPdf == exportedPdf)&&(identical(other.reportType, reportType) || other.reportType == reportType)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.isIncident, isIncident) || other.isIncident == isIncident)&&(identical(other.weather, weather) || other.weather == weather)&&(identical(other.policeNotified, policeNotified) || other.policeNotified == policeNotified)&&(identical(other.signatureUrl, signatureUrl) || other.signatureUrl == signatureUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,jobId,location,date,workStart,workEnd,notes,const DeepCollectionEquality().hash(photoUrls),signedBy,exportedPdf,reportType,severity,isIncident,weather,policeNotified,signatureUrl);

@override
String toString() {
  return 'Report(id: $id, jobId: $jobId, location: $location, date: $date, workStart: $workStart, workEnd: $workEnd, notes: $notes, photoUrls: $photoUrls, signedBy: $signedBy, exportedPdf: $exportedPdf, reportType: $reportType, severity: $severity, isIncident: $isIncident, weather: $weather, policeNotified: $policeNotified, signatureUrl: $signatureUrl)';
}


}

/// @nodoc
abstract mixin class $ReportCopyWith<$Res>  {
  factory $ReportCopyWith(Report value, $Res Function(Report) _then) = _$ReportCopyWithImpl;
@useResult
$Res call({
 String id, String jobId, String location, DateTime date, String workStart, String workEnd, String notes, List<String> photoUrls, String signedBy, String? exportedPdf, String reportType, String severity, bool isIncident, String? weather, bool policeNotified, String? signatureUrl
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? jobId = null,Object? location = null,Object? date = null,Object? workStart = null,Object? workEnd = null,Object? notes = null,Object? photoUrls = null,Object? signedBy = null,Object? exportedPdf = freezed,Object? reportType = null,Object? severity = null,Object? isIncident = null,Object? weather = freezed,Object? policeNotified = null,Object? signatureUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
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
as String?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String jobId,  String location,  DateTime date,  String workStart,  String workEnd,  String notes,  List<String> photoUrls,  String signedBy,  String? exportedPdf,  String reportType,  String severity,  bool isIncident,  String? weather,  bool policeNotified,  String? signatureUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Report() when $default != null:
return $default(_that.id,_that.jobId,_that.location,_that.date,_that.workStart,_that.workEnd,_that.notes,_that.photoUrls,_that.signedBy,_that.exportedPdf,_that.reportType,_that.severity,_that.isIncident,_that.weather,_that.policeNotified,_that.signatureUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String jobId,  String location,  DateTime date,  String workStart,  String workEnd,  String notes,  List<String> photoUrls,  String signedBy,  String? exportedPdf,  String reportType,  String severity,  bool isIncident,  String? weather,  bool policeNotified,  String? signatureUrl)  $default,) {final _that = this;
switch (_that) {
case _Report():
return $default(_that.id,_that.jobId,_that.location,_that.date,_that.workStart,_that.workEnd,_that.notes,_that.photoUrls,_that.signedBy,_that.exportedPdf,_that.reportType,_that.severity,_that.isIncident,_that.weather,_that.policeNotified,_that.signatureUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String jobId,  String location,  DateTime date,  String workStart,  String workEnd,  String notes,  List<String> photoUrls,  String signedBy,  String? exportedPdf,  String reportType,  String severity,  bool isIncident,  String? weather,  bool policeNotified,  String? signatureUrl)?  $default,) {final _that = this;
switch (_that) {
case _Report() when $default != null:
return $default(_that.id,_that.jobId,_that.location,_that.date,_that.workStart,_that.workEnd,_that.notes,_that.photoUrls,_that.signedBy,_that.exportedPdf,_that.reportType,_that.severity,_that.isIncident,_that.weather,_that.policeNotified,_that.signatureUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Report implements Report {
  const _Report({required this.id, required this.jobId, required this.location, required this.date, required this.workStart, required this.workEnd, required this.notes, final  List<String> photoUrls = const [], required this.signedBy, this.exportedPdf, this.reportType = 'Routine', this.severity = 'low', this.isIncident = false, this.weather, this.policeNotified = false, this.signatureUrl}): _photoUrls = photoUrls;
  factory _Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

@override final  String id;
@override final  String jobId;
@override final  String location;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Report&&(identical(other.id, id) || other.id == id)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.location, location) || other.location == location)&&(identical(other.date, date) || other.date == date)&&(identical(other.workStart, workStart) || other.workStart == workStart)&&(identical(other.workEnd, workEnd) || other.workEnd == workEnd)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other._photoUrls, _photoUrls)&&(identical(other.signedBy, signedBy) || other.signedBy == signedBy)&&(identical(other.exportedPdf, exportedPdf) || other.exportedPdf == exportedPdf)&&(identical(other.reportType, reportType) || other.reportType == reportType)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.isIncident, isIncident) || other.isIncident == isIncident)&&(identical(other.weather, weather) || other.weather == weather)&&(identical(other.policeNotified, policeNotified) || other.policeNotified == policeNotified)&&(identical(other.signatureUrl, signatureUrl) || other.signatureUrl == signatureUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,jobId,location,date,workStart,workEnd,notes,const DeepCollectionEquality().hash(_photoUrls),signedBy,exportedPdf,reportType,severity,isIncident,weather,policeNotified,signatureUrl);

@override
String toString() {
  return 'Report(id: $id, jobId: $jobId, location: $location, date: $date, workStart: $workStart, workEnd: $workEnd, notes: $notes, photoUrls: $photoUrls, signedBy: $signedBy, exportedPdf: $exportedPdf, reportType: $reportType, severity: $severity, isIncident: $isIncident, weather: $weather, policeNotified: $policeNotified, signatureUrl: $signatureUrl)';
}


}

/// @nodoc
abstract mixin class _$ReportCopyWith<$Res> implements $ReportCopyWith<$Res> {
  factory _$ReportCopyWith(_Report value, $Res Function(_Report) _then) = __$ReportCopyWithImpl;
@override @useResult
$Res call({
 String id, String jobId, String location, DateTime date, String workStart, String workEnd, String notes, List<String> photoUrls, String signedBy, String? exportedPdf, String reportType, String severity, bool isIncident, String? weather, bool policeNotified, String? signatureUrl
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? jobId = null,Object? location = null,Object? date = null,Object? workStart = null,Object? workEnd = null,Object? notes = null,Object? photoUrls = null,Object? signedBy = null,Object? exportedPdf = freezed,Object? reportType = null,Object? severity = null,Object? isIncident = null,Object? weather = freezed,Object? policeNotified = null,Object? signatureUrl = freezed,}) {
  return _then(_Report(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
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
as String?,
  ));
}


}

// dart format on
