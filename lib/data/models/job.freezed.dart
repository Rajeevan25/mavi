// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Job {

 String get id; String get title; String get location; DateTime get date; String get startTime; String get endTime; String get serviceType; JobStatus get status; List<String> get assignedEmployeeIds; String? get notes; String? get clientName; String? get contactPhone; double? get targetLatitude; double? get targetLongitude;
/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobCopyWith<Job> get copyWith => _$JobCopyWithImpl<Job>(this as Job, _$identity);

  /// Serializes this Job to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Job&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.location, location) || other.location == location)&&(identical(other.date, date) || other.date == date)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.assignedEmployeeIds, assignedEmployeeIds)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.contactPhone, contactPhone) || other.contactPhone == contactPhone)&&(identical(other.targetLatitude, targetLatitude) || other.targetLatitude == targetLatitude)&&(identical(other.targetLongitude, targetLongitude) || other.targetLongitude == targetLongitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,location,date,startTime,endTime,serviceType,status,const DeepCollectionEquality().hash(assignedEmployeeIds),notes,clientName,contactPhone,targetLatitude,targetLongitude);

@override
String toString() {
  return 'Job(id: $id, title: $title, location: $location, date: $date, startTime: $startTime, endTime: $endTime, serviceType: $serviceType, status: $status, assignedEmployeeIds: $assignedEmployeeIds, notes: $notes, clientName: $clientName, contactPhone: $contactPhone, targetLatitude: $targetLatitude, targetLongitude: $targetLongitude)';
}


}

/// @nodoc
abstract mixin class $JobCopyWith<$Res>  {
  factory $JobCopyWith(Job value, $Res Function(Job) _then) = _$JobCopyWithImpl;
@useResult
$Res call({
 String id, String title, String location, DateTime date, String startTime, String endTime, String serviceType, JobStatus status, List<String> assignedEmployeeIds, String? notes, String? clientName, String? contactPhone, double? targetLatitude, double? targetLongitude
});




}
/// @nodoc
class _$JobCopyWithImpl<$Res>
    implements $JobCopyWith<$Res> {
  _$JobCopyWithImpl(this._self, this._then);

  final Job _self;
  final $Res Function(Job) _then;

/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? location = null,Object? date = null,Object? startTime = null,Object? endTime = null,Object? serviceType = null,Object? status = null,Object? assignedEmployeeIds = null,Object? notes = freezed,Object? clientName = freezed,Object? contactPhone = freezed,Object? targetLatitude = freezed,Object? targetLongitude = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,serviceType: null == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as JobStatus,assignedEmployeeIds: null == assignedEmployeeIds ? _self.assignedEmployeeIds : assignedEmployeeIds // ignore: cast_nullable_to_non_nullable
as List<String>,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,clientName: freezed == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String?,contactPhone: freezed == contactPhone ? _self.contactPhone : contactPhone // ignore: cast_nullable_to_non_nullable
as String?,targetLatitude: freezed == targetLatitude ? _self.targetLatitude : targetLatitude // ignore: cast_nullable_to_non_nullable
as double?,targetLongitude: freezed == targetLongitude ? _self.targetLongitude : targetLongitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [Job].
extension JobPatterns on Job {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Job value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Job() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Job value)  $default,){
final _that = this;
switch (_that) {
case _Job():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Job value)?  $default,){
final _that = this;
switch (_that) {
case _Job() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String location,  DateTime date,  String startTime,  String endTime,  String serviceType,  JobStatus status,  List<String> assignedEmployeeIds,  String? notes,  String? clientName,  String? contactPhone,  double? targetLatitude,  double? targetLongitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Job() when $default != null:
return $default(_that.id,_that.title,_that.location,_that.date,_that.startTime,_that.endTime,_that.serviceType,_that.status,_that.assignedEmployeeIds,_that.notes,_that.clientName,_that.contactPhone,_that.targetLatitude,_that.targetLongitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String location,  DateTime date,  String startTime,  String endTime,  String serviceType,  JobStatus status,  List<String> assignedEmployeeIds,  String? notes,  String? clientName,  String? contactPhone,  double? targetLatitude,  double? targetLongitude)  $default,) {final _that = this;
switch (_that) {
case _Job():
return $default(_that.id,_that.title,_that.location,_that.date,_that.startTime,_that.endTime,_that.serviceType,_that.status,_that.assignedEmployeeIds,_that.notes,_that.clientName,_that.contactPhone,_that.targetLatitude,_that.targetLongitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String location,  DateTime date,  String startTime,  String endTime,  String serviceType,  JobStatus status,  List<String> assignedEmployeeIds,  String? notes,  String? clientName,  String? contactPhone,  double? targetLatitude,  double? targetLongitude)?  $default,) {final _that = this;
switch (_that) {
case _Job() when $default != null:
return $default(_that.id,_that.title,_that.location,_that.date,_that.startTime,_that.endTime,_that.serviceType,_that.status,_that.assignedEmployeeIds,_that.notes,_that.clientName,_that.contactPhone,_that.targetLatitude,_that.targetLongitude);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Job implements Job {
  const _Job({required this.id, required this.title, required this.location, required this.date, required this.startTime, required this.endTime, required this.serviceType, this.status = JobStatus.open, final  List<String> assignedEmployeeIds = const [], this.notes, this.clientName, this.contactPhone, this.targetLatitude, this.targetLongitude}): _assignedEmployeeIds = assignedEmployeeIds;
  factory _Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);

@override final  String id;
@override final  String title;
@override final  String location;
@override final  DateTime date;
@override final  String startTime;
@override final  String endTime;
@override final  String serviceType;
@override@JsonKey() final  JobStatus status;
 final  List<String> _assignedEmployeeIds;
@override@JsonKey() List<String> get assignedEmployeeIds {
  if (_assignedEmployeeIds is EqualUnmodifiableListView) return _assignedEmployeeIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assignedEmployeeIds);
}

@override final  String? notes;
@override final  String? clientName;
@override final  String? contactPhone;
@override final  double? targetLatitude;
@override final  double? targetLongitude;

/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobCopyWith<_Job> get copyWith => __$JobCopyWithImpl<_Job>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Job&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.location, location) || other.location == location)&&(identical(other.date, date) || other.date == date)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._assignedEmployeeIds, _assignedEmployeeIds)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.clientName, clientName) || other.clientName == clientName)&&(identical(other.contactPhone, contactPhone) || other.contactPhone == contactPhone)&&(identical(other.targetLatitude, targetLatitude) || other.targetLatitude == targetLatitude)&&(identical(other.targetLongitude, targetLongitude) || other.targetLongitude == targetLongitude));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,location,date,startTime,endTime,serviceType,status,const DeepCollectionEquality().hash(_assignedEmployeeIds),notes,clientName,contactPhone,targetLatitude,targetLongitude);

@override
String toString() {
  return 'Job(id: $id, title: $title, location: $location, date: $date, startTime: $startTime, endTime: $endTime, serviceType: $serviceType, status: $status, assignedEmployeeIds: $assignedEmployeeIds, notes: $notes, clientName: $clientName, contactPhone: $contactPhone, targetLatitude: $targetLatitude, targetLongitude: $targetLongitude)';
}


}

/// @nodoc
abstract mixin class _$JobCopyWith<$Res> implements $JobCopyWith<$Res> {
  factory _$JobCopyWith(_Job value, $Res Function(_Job) _then) = __$JobCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String location, DateTime date, String startTime, String endTime, String serviceType, JobStatus status, List<String> assignedEmployeeIds, String? notes, String? clientName, String? contactPhone, double? targetLatitude, double? targetLongitude
});




}
/// @nodoc
class __$JobCopyWithImpl<$Res>
    implements _$JobCopyWith<$Res> {
  __$JobCopyWithImpl(this._self, this._then);

  final _Job _self;
  final $Res Function(_Job) _then;

/// Create a copy of Job
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? location = null,Object? date = null,Object? startTime = null,Object? endTime = null,Object? serviceType = null,Object? status = null,Object? assignedEmployeeIds = null,Object? notes = freezed,Object? clientName = freezed,Object? contactPhone = freezed,Object? targetLatitude = freezed,Object? targetLongitude = freezed,}) {
  return _then(_Job(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,serviceType: null == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as JobStatus,assignedEmployeeIds: null == assignedEmployeeIds ? _self._assignedEmployeeIds : assignedEmployeeIds // ignore: cast_nullable_to_non_nullable
as List<String>,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,clientName: freezed == clientName ? _self.clientName : clientName // ignore: cast_nullable_to_non_nullable
as String?,contactPhone: freezed == contactPhone ? _self.contactPhone : contactPhone // ignore: cast_nullable_to_non_nullable
as String?,targetLatitude: freezed == targetLatitude ? _self.targetLatitude : targetLatitude // ignore: cast_nullable_to_non_nullable
as double?,targetLongitude: freezed == targetLongitude ? _self.targetLongitude : targetLongitude // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
