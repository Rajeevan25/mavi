// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Employee {

 String get id; String get name; String get role; EmployeeStatus get status; String get phone; String get email; String get availability; String? get avatarUrl; double get rating; int get experienceYears; List<String> get certifications; List<String> get languages; String? get emergencyContact; bool get isVerified; String? get idNumber; DateTime? get criminalRecordDate; List<String> get driverLicenseClasses; bool get weaponsPermit; DateTime? get firstAidExpiry; String? get uniformSize;
/// Create a copy of Employee
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmployeeCopyWith<Employee> get copyWith => _$EmployeeCopyWithImpl<Employee>(this as Employee, _$identity);

  /// Serializes this Employee to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Employee&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.role, role) || other.role == role)&&(identical(other.status, status) || other.status == status)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.availability, availability) || other.availability == availability)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.experienceYears, experienceYears) || other.experienceYears == experienceYears)&&const DeepCollectionEquality().equals(other.certifications, certifications)&&const DeepCollectionEquality().equals(other.languages, languages)&&(identical(other.emergencyContact, emergencyContact) || other.emergencyContact == emergencyContact)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.idNumber, idNumber) || other.idNumber == idNumber)&&(identical(other.criminalRecordDate, criminalRecordDate) || other.criminalRecordDate == criminalRecordDate)&&const DeepCollectionEquality().equals(other.driverLicenseClasses, driverLicenseClasses)&&(identical(other.weaponsPermit, weaponsPermit) || other.weaponsPermit == weaponsPermit)&&(identical(other.firstAidExpiry, firstAidExpiry) || other.firstAidExpiry == firstAidExpiry)&&(identical(other.uniformSize, uniformSize) || other.uniformSize == uniformSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,role,status,phone,email,availability,avatarUrl,rating,experienceYears,const DeepCollectionEquality().hash(certifications),const DeepCollectionEquality().hash(languages),emergencyContact,isVerified,idNumber,criminalRecordDate,const DeepCollectionEquality().hash(driverLicenseClasses),weaponsPermit,firstAidExpiry,uniformSize]);

@override
String toString() {
  return 'Employee(id: $id, name: $name, role: $role, status: $status, phone: $phone, email: $email, availability: $availability, avatarUrl: $avatarUrl, rating: $rating, experienceYears: $experienceYears, certifications: $certifications, languages: $languages, emergencyContact: $emergencyContact, isVerified: $isVerified, idNumber: $idNumber, criminalRecordDate: $criminalRecordDate, driverLicenseClasses: $driverLicenseClasses, weaponsPermit: $weaponsPermit, firstAidExpiry: $firstAidExpiry, uniformSize: $uniformSize)';
}


}

/// @nodoc
abstract mixin class $EmployeeCopyWith<$Res>  {
  factory $EmployeeCopyWith(Employee value, $Res Function(Employee) _then) = _$EmployeeCopyWithImpl;
@useResult
$Res call({
 String id, String name, String role, EmployeeStatus status, String phone, String email, String availability, String? avatarUrl, double rating, int experienceYears, List<String> certifications, List<String> languages, String? emergencyContact, bool isVerified, String? idNumber, DateTime? criminalRecordDate, List<String> driverLicenseClasses, bool weaponsPermit, DateTime? firstAidExpiry, String? uniformSize
});




}
/// @nodoc
class _$EmployeeCopyWithImpl<$Res>
    implements $EmployeeCopyWith<$Res> {
  _$EmployeeCopyWithImpl(this._self, this._then);

  final Employee _self;
  final $Res Function(Employee) _then;

/// Create a copy of Employee
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? role = null,Object? status = null,Object? phone = null,Object? email = null,Object? availability = null,Object? avatarUrl = freezed,Object? rating = null,Object? experienceYears = null,Object? certifications = null,Object? languages = null,Object? emergencyContact = freezed,Object? isVerified = null,Object? idNumber = freezed,Object? criminalRecordDate = freezed,Object? driverLicenseClasses = null,Object? weaponsPermit = null,Object? firstAidExpiry = freezed,Object? uniformSize = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EmployeeStatus,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,experienceYears: null == experienceYears ? _self.experienceYears : experienceYears // ignore: cast_nullable_to_non_nullable
as int,certifications: null == certifications ? _self.certifications : certifications // ignore: cast_nullable_to_non_nullable
as List<String>,languages: null == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>,emergencyContact: freezed == emergencyContact ? _self.emergencyContact : emergencyContact // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,idNumber: freezed == idNumber ? _self.idNumber : idNumber // ignore: cast_nullable_to_non_nullable
as String?,criminalRecordDate: freezed == criminalRecordDate ? _self.criminalRecordDate : criminalRecordDate // ignore: cast_nullable_to_non_nullable
as DateTime?,driverLicenseClasses: null == driverLicenseClasses ? _self.driverLicenseClasses : driverLicenseClasses // ignore: cast_nullable_to_non_nullable
as List<String>,weaponsPermit: null == weaponsPermit ? _self.weaponsPermit : weaponsPermit // ignore: cast_nullable_to_non_nullable
as bool,firstAidExpiry: freezed == firstAidExpiry ? _self.firstAidExpiry : firstAidExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,uniformSize: freezed == uniformSize ? _self.uniformSize : uniformSize // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Employee].
extension EmployeePatterns on Employee {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Employee value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Employee() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Employee value)  $default,){
final _that = this;
switch (_that) {
case _Employee():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Employee value)?  $default,){
final _that = this;
switch (_that) {
case _Employee() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String role,  EmployeeStatus status,  String phone,  String email,  String availability,  String? avatarUrl,  double rating,  int experienceYears,  List<String> certifications,  List<String> languages,  String? emergencyContact,  bool isVerified,  String? idNumber,  DateTime? criminalRecordDate,  List<String> driverLicenseClasses,  bool weaponsPermit,  DateTime? firstAidExpiry,  String? uniformSize)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Employee() when $default != null:
return $default(_that.id,_that.name,_that.role,_that.status,_that.phone,_that.email,_that.availability,_that.avatarUrl,_that.rating,_that.experienceYears,_that.certifications,_that.languages,_that.emergencyContact,_that.isVerified,_that.idNumber,_that.criminalRecordDate,_that.driverLicenseClasses,_that.weaponsPermit,_that.firstAidExpiry,_that.uniformSize);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String role,  EmployeeStatus status,  String phone,  String email,  String availability,  String? avatarUrl,  double rating,  int experienceYears,  List<String> certifications,  List<String> languages,  String? emergencyContact,  bool isVerified,  String? idNumber,  DateTime? criminalRecordDate,  List<String> driverLicenseClasses,  bool weaponsPermit,  DateTime? firstAidExpiry,  String? uniformSize)  $default,) {final _that = this;
switch (_that) {
case _Employee():
return $default(_that.id,_that.name,_that.role,_that.status,_that.phone,_that.email,_that.availability,_that.avatarUrl,_that.rating,_that.experienceYears,_that.certifications,_that.languages,_that.emergencyContact,_that.isVerified,_that.idNumber,_that.criminalRecordDate,_that.driverLicenseClasses,_that.weaponsPermit,_that.firstAidExpiry,_that.uniformSize);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String role,  EmployeeStatus status,  String phone,  String email,  String availability,  String? avatarUrl,  double rating,  int experienceYears,  List<String> certifications,  List<String> languages,  String? emergencyContact,  bool isVerified,  String? idNumber,  DateTime? criminalRecordDate,  List<String> driverLicenseClasses,  bool weaponsPermit,  DateTime? firstAidExpiry,  String? uniformSize)?  $default,) {final _that = this;
switch (_that) {
case _Employee() when $default != null:
return $default(_that.id,_that.name,_that.role,_that.status,_that.phone,_that.email,_that.availability,_that.avatarUrl,_that.rating,_that.experienceYears,_that.certifications,_that.languages,_that.emergencyContact,_that.isVerified,_that.idNumber,_that.criminalRecordDate,_that.driverLicenseClasses,_that.weaponsPermit,_that.firstAidExpiry,_that.uniformSize);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Employee implements Employee {
  const _Employee({required this.id, required this.name, required this.role, this.status = EmployeeStatus.available, required this.phone, required this.email, required this.availability, this.avatarUrl, this.rating = 5.0, this.experienceYears = 0, final  List<String> certifications = const [], final  List<String> languages = const ['Deutsch'], this.emergencyContact, this.isVerified = false, this.idNumber, this.criminalRecordDate, final  List<String> driverLicenseClasses = const [], this.weaponsPermit = false, this.firstAidExpiry, this.uniformSize}): _certifications = certifications,_languages = languages,_driverLicenseClasses = driverLicenseClasses;
  factory _Employee.fromJson(Map<String, dynamic> json) => _$EmployeeFromJson(json);

@override final  String id;
@override final  String name;
@override final  String role;
@override@JsonKey() final  EmployeeStatus status;
@override final  String phone;
@override final  String email;
@override final  String availability;
@override final  String? avatarUrl;
@override@JsonKey() final  double rating;
@override@JsonKey() final  int experienceYears;
 final  List<String> _certifications;
@override@JsonKey() List<String> get certifications {
  if (_certifications is EqualUnmodifiableListView) return _certifications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_certifications);
}

 final  List<String> _languages;
@override@JsonKey() List<String> get languages {
  if (_languages is EqualUnmodifiableListView) return _languages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languages);
}

@override final  String? emergencyContact;
@override@JsonKey() final  bool isVerified;
@override final  String? idNumber;
@override final  DateTime? criminalRecordDate;
 final  List<String> _driverLicenseClasses;
@override@JsonKey() List<String> get driverLicenseClasses {
  if (_driverLicenseClasses is EqualUnmodifiableListView) return _driverLicenseClasses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_driverLicenseClasses);
}

@override@JsonKey() final  bool weaponsPermit;
@override final  DateTime? firstAidExpiry;
@override final  String? uniformSize;

/// Create a copy of Employee
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmployeeCopyWith<_Employee> get copyWith => __$EmployeeCopyWithImpl<_Employee>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmployeeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Employee&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.role, role) || other.role == role)&&(identical(other.status, status) || other.status == status)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.availability, availability) || other.availability == availability)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.experienceYears, experienceYears) || other.experienceYears == experienceYears)&&const DeepCollectionEquality().equals(other._certifications, _certifications)&&const DeepCollectionEquality().equals(other._languages, _languages)&&(identical(other.emergencyContact, emergencyContact) || other.emergencyContact == emergencyContact)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.idNumber, idNumber) || other.idNumber == idNumber)&&(identical(other.criminalRecordDate, criminalRecordDate) || other.criminalRecordDate == criminalRecordDate)&&const DeepCollectionEquality().equals(other._driverLicenseClasses, _driverLicenseClasses)&&(identical(other.weaponsPermit, weaponsPermit) || other.weaponsPermit == weaponsPermit)&&(identical(other.firstAidExpiry, firstAidExpiry) || other.firstAidExpiry == firstAidExpiry)&&(identical(other.uniformSize, uniformSize) || other.uniformSize == uniformSize));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,role,status,phone,email,availability,avatarUrl,rating,experienceYears,const DeepCollectionEquality().hash(_certifications),const DeepCollectionEquality().hash(_languages),emergencyContact,isVerified,idNumber,criminalRecordDate,const DeepCollectionEquality().hash(_driverLicenseClasses),weaponsPermit,firstAidExpiry,uniformSize]);

@override
String toString() {
  return 'Employee(id: $id, name: $name, role: $role, status: $status, phone: $phone, email: $email, availability: $availability, avatarUrl: $avatarUrl, rating: $rating, experienceYears: $experienceYears, certifications: $certifications, languages: $languages, emergencyContact: $emergencyContact, isVerified: $isVerified, idNumber: $idNumber, criminalRecordDate: $criminalRecordDate, driverLicenseClasses: $driverLicenseClasses, weaponsPermit: $weaponsPermit, firstAidExpiry: $firstAidExpiry, uniformSize: $uniformSize)';
}


}

/// @nodoc
abstract mixin class _$EmployeeCopyWith<$Res> implements $EmployeeCopyWith<$Res> {
  factory _$EmployeeCopyWith(_Employee value, $Res Function(_Employee) _then) = __$EmployeeCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String role, EmployeeStatus status, String phone, String email, String availability, String? avatarUrl, double rating, int experienceYears, List<String> certifications, List<String> languages, String? emergencyContact, bool isVerified, String? idNumber, DateTime? criminalRecordDate, List<String> driverLicenseClasses, bool weaponsPermit, DateTime? firstAidExpiry, String? uniformSize
});




}
/// @nodoc
class __$EmployeeCopyWithImpl<$Res>
    implements _$EmployeeCopyWith<$Res> {
  __$EmployeeCopyWithImpl(this._self, this._then);

  final _Employee _self;
  final $Res Function(_Employee) _then;

/// Create a copy of Employee
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? role = null,Object? status = null,Object? phone = null,Object? email = null,Object? availability = null,Object? avatarUrl = freezed,Object? rating = null,Object? experienceYears = null,Object? certifications = null,Object? languages = null,Object? emergencyContact = freezed,Object? isVerified = null,Object? idNumber = freezed,Object? criminalRecordDate = freezed,Object? driverLicenseClasses = null,Object? weaponsPermit = null,Object? firstAidExpiry = freezed,Object? uniformSize = freezed,}) {
  return _then(_Employee(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EmployeeStatus,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,availability: null == availability ? _self.availability : availability // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,experienceYears: null == experienceYears ? _self.experienceYears : experienceYears // ignore: cast_nullable_to_non_nullable
as int,certifications: null == certifications ? _self._certifications : certifications // ignore: cast_nullable_to_non_nullable
as List<String>,languages: null == languages ? _self._languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>,emergencyContact: freezed == emergencyContact ? _self.emergencyContact : emergencyContact // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,idNumber: freezed == idNumber ? _self.idNumber : idNumber // ignore: cast_nullable_to_non_nullable
as String?,criminalRecordDate: freezed == criminalRecordDate ? _self.criminalRecordDate : criminalRecordDate // ignore: cast_nullable_to_non_nullable
as DateTime?,driverLicenseClasses: null == driverLicenseClasses ? _self._driverLicenseClasses : driverLicenseClasses // ignore: cast_nullable_to_non_nullable
as List<String>,weaponsPermit: null == weaponsPermit ? _self.weaponsPermit : weaponsPermit // ignore: cast_nullable_to_non_nullable
as bool,firstAidExpiry: freezed == firstAidExpiry ? _self.firstAidExpiry : firstAidExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,uniformSize: freezed == uniformSize ? _self.uniformSize : uniformSize // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
