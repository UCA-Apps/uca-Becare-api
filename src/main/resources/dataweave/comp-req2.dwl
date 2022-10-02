%dw 2.0
output application/json skipNullOn="everywhere"
fun CategoryType(CATEGORY: String, code: String)= trim((vars.CategoryType filter($.CATEGORY == CATEGORY and $.code == code) map ($.uca_code))[0] default '')
fun test(CATEGORY: String, code: String)= CategoryType(CATEGORY, code)
---
flatten ([	
	if(payload.InsuredIdTypeCode != null) if(CategoryType('Insurer Id Type', payload.InsuredIdTypeCode) != '') null else 'InsuredIdTypeCode value is '++ payload.InsuredIdTypeCode ++' not present/inactive in the lookups' 
	else null,
	if(payload.InsuredNationalityCode != null) if(CategoryType('Country', payload.InsuredNationalityCode) != '') null else 'InsuredNationalityCode value is '++ payload.InsuredNationalityCode ++' not present/inactive in the lookups'
	else null,
	if(payload.InsuredIdIssuePlaceCode != null) if(CategoryType('City', payload.InsuredIdIssuePlaceCode) != '') null else 'InsuredIdIssuePlaceCode value is '++ payload.InsuredIdIssuePlaceCode ++' not present/inactive in the lookups'
	else null,	
	if(payload.InsuredCityCode != null) if(CategoryType('City', payload.InsuredCityCode) != '') null else 'InsuredCityCode value is '++ payload.InsuredCityCode ++' not present/inactive in the lookups'
	else null,
	if(payload.VehicleIdTypeCode != null) if(CategoryType('Vehicle Unique Type', payload.VehicleIdTypeCode) != '') null else 'VehicleIdTypeCode value is '++ payload.VehicleIdTypeCode ++' not present/inactive in the lookups'
	else null,
	if(payload.VehiclePlateTypeCode != null) if(CategoryType('Plate Type', payload.VehiclePlateTypeCode) != '') null else 'VehiclePlateTypeCode value is '++ payload.VehiclePlateTypeCode ++' not present/inactive in the lookups'
	else null,
	if(payload.VehicleMajorColorCode != null) if(CategoryType('Color', payload.VehicleMajorColorCode) != '') null else 'VehicleMajorColorCode value is '++ payload.VehicleMajorColorCode ++' not present/inactive in the lookups'
	else null,
	if(payload.VehicleBodyTypeCode != null) if(CategoryType('Vehicle Body', payload.VehicleBodyTypeCode) != '') null else 'VehicleBodyTypeCode value is '++ payload.VehicleBodyTypeCode ++' not present/inactive in the lookups'
	else null,
	if(payload.VehicleRegPlaceCode != null) if(CategoryType('City', payload.VehicleRegPlaceCode) != '') null else 'VehicleRegPlaceCode value is '++ payload.VehicleRegPlaceCode ++' not present/inactive in the lookups'
	else null,
	if(payload.NCDFreeYears != null) if(CategoryType('NCD Code Claims', payload.NCDFreeYears) != '') null else 'NCDFreeYears value is '++ payload.NCDFreeYears ++' not present/inactive in the lookups'
	else null,
	if(payload.VehiclePlateText1 == null or payload.VehiclePlateText1 == "") null
	else  if(CategoryType('Plate Character', payload.VehiclePlateText1) != '') null else 'VehiclePlateText1 value is '++ payload.VehiclePlateText1 ++' not present/inactive in the lookups',
	if(payload.VehiclePlateText2 == null or payload.VehiclePlateText2 == "") null
	else if(CategoryType('Plate Character', payload.VehiclePlateText2) != '') null else 'VehiclePlateText2 value is '++ payload.VehiclePlateText2 ++' not present/inactive in the lookups',
	if(payload.VehiclePlateText3 == null or payload.VehiclePlateText3 == "") null
	else  if(CategoryType('Plate Character', payload.VehiclePlateText3) != '') null else 'VehiclePlateText3 value is '++ payload.VehiclePlateText3 ++' not present/inactive in the lookups',
	if(payload.InsuredSocialStatusCode != null) if(CategoryType('Social Status', payload.InsuredSocialStatusCode) != '') null else 'InsuredSocialStatusCode value is '++ payload.InsuredSocialStatusCode ++' not present/inactive in the lookups'
	else null,
	if(payload.InsuredEducationCode != null) if(CategoryType('Education', payload.InsuredEducationCode) != '') null else 'InsuredEducationCode value is '++ payload.InsuredEducationCode ++' not present/inactive in the lookups'
	else null,
	if(payload.InsuredOccupationCode != null) if(CategoryType('Occupation', payload.InsuredOccupationCode) != '') null else 'InsuredOccupationCode value is '++ payload.InsuredOccupationCode ++' not present/inactive in the lookups'
	else null,
	if(payload.InsuredWorkCityCode != null) if(CategoryType('City', payload.InsuredWorkCityCode) != '') null else 'InsuredWorkCityCode value is '++ payload.InsuredWorkCityCode ++' not present/inactive in the lookups'
	else null,
	if(payload.VehicleUseCode != null) if(CategoryType('Use Of Vehicle', payload.VehicleUseCode) != '') null else 'VehicleUseCode value is '++ payload.VehicleUseCode ++' not present/inactive in the lookups'
	else null,
	if(payload.VehicleTransmissionTypeCode != null) if(CategoryType('Transmission', payload.VehicleTransmissionTypeCode) != '') null else 'VehicleTransmissionTypeCode value is '++ payload.VehicleTransmissionTypeCode ++' not present/inactive in the lookups'
	else null,
	if(payload.VehicleMileageExpectedAnnualCode != null) if(CategoryType('Mileages', payload.VehicleMileageExpectedAnnualCode) != '') null else 'VehicleMileageExpectedAnnualCode value is '++ payload.VehicleMileageExpectedAnnualCode ++' not present/inactive in the lookups'
	else null,
	if(payload.VehicleEngineSizeCode != null) if(CategoryType('Engine Size', payload.VehicleEngineSizeCode) != '') null else 'VehicleEngineSizeCode value is '++ payload.VehicleEngineSizeCode ++' not present/inactive in the lookups'
	else null,
	if(payload.VehicleOvernightParkingLocationCode != null) if(CategoryType('Location Where Vehicle Is Kept Overnight', payload.VehicleOvernightParkingLocationCode) != '') null else 'VehicleOvernightParkingLocationCode value is '++ payload.VehicleOvernightParkingLocationCode ++' not present/inactive in the lookups'
	else null,
	if(payload.VehicleAxleWeightCode != null) if(CategoryType('Vehicle Axle Weight', payload.VehicleAxleWeightCode) != '') null else 'VehicleAxleWeightCode value is '++ payload.VehicleAxleWeightCode ++' not present/inactive in the lookups'
	else null,
	
	
	(payload.Drivers map (driver , indexOfDriver) -> {
				(DriverTypeCode: "/Drivers/" ++ indexOfDriver ++ "/DriverTypeCode value is "++ driver.DriverTypeCode ++" not present/inactive in the lookups") if(driver.DriverTypeCode !=null and sizeOf(trim(test('Driver Types', driver.DriverTypeCode))) == 0)
		}).DriverTypeCode,		
	(payload.Drivers map (driver , indexOfDriver) -> {
				(DriverIdTypeCode: "/Drivers/" ++ indexOfDriver ++ "/DriverIdTypeCode value is "++ driver.DriverIdTypeCode ++" not present/inactive in the lookups") if(driver.DriverIdTypeCode !=null and sizeOf(trim(test('Insurer Id Type', driver.DriverIdTypeCode))) == 0)
		}).DriverIdTypeCode,	
	(payload.Drivers map (driver , indexOfDriver) -> {
				(DriverNationalityCode: "/Drivers/" ++ indexOfDriver ++ "/DriverNationalityCode value is "++ driver.DriverNationalityCode ++" not present/inactive in the lookups") if(driver.DriverNationalityCode !=null and sizeOf(trim(test('Country', driver.DriverNationalityCode))) == 0)
		}).DriverNationalityCode,
	(payload.Drivers map (driver , indexOfDriver) -> {
				(DriverNCDFreeYears: "/Drivers/" ++ indexOfDriver ++ "/DriverNCDFreeYears value is "++ driver.DriverNCDFreeYears ++" not present/inactive in the lookups") if(driver.DriverNCDFreeYears !=null and sizeOf(trim(test('NCD Code Claims', driver.DriverNCDFreeYears))) == 0)
		}).DriverNCDFreeYears,
	(payload.Drivers map (driver , indexOfDriver) -> {
				(DriverSocialStatusCode: "/Drivers/" ++ indexOfDriver ++ "/DriverSocialStatusCode value is "++ driver.DriverSocialStatusCode ++" not present/inactive in the lookups") if(driver.DriverSocialStatusCode !=null and sizeOf(trim(test('Social Status', driver.DriverSocialStatusCode))) == 0)
		}).DriverSocialStatusCode,
	(payload.Drivers map (driver , indexOfDriver) -> {
				(DriverDrivingPercentage: "/Drivers/" ++ indexOfDriver ++ "/DriverDrivingPercentage value is "++ driver.DriverDrivingPercentage ++" not present/inactive in the lookups") if(driver.DriverDrivingPercentage !=null and sizeOf(trim(test('Driving Percentage', driver.DriverDrivingPercentage))) == 0)
		}).DriverDrivingPercentage,	
	(payload.Drivers map (driver , indexOfDriver) -> {
				(DriverEducationCode: "/Drivers/" ++ indexOfDriver ++ "/DriverEducationCode value is "++ driver.DriverEducationCode ++" not present/inactive in the lookups") if(driver.DriverEducationCode !=null and sizeOf(trim(test('Education',driver.DriverEducationCode))) == 0)
		}).DriverEducationCode,		
	(payload.Drivers map (driver , indexOfDriver) -> {
				(DriverOccupationCode: "/Drivers/" ++ indexOfDriver ++ "/DriverOccupationCode value is "++ driver.DriverOccupationCode ++" not present/inactive in the lookups") if(driver.DriverOccupationCode !=null and sizeOf(trim(test('Occupation', driver.DriverOccupationCode))) == 0)
		}).DriverOccupationCode,	
	(payload.Drivers map (driver , indexOfDriver) -> {
				(DriverMedicalConditionCode: "/Drivers/" ++ indexOfDriver ++ "/DriverMedicalConditionCode value is "++ driver.DriverMedicalConditionCode ++" not present/inactive in the lookups") if(driver.DriverMedicalConditionCode !=null and sizeOf(trim(test('Medical Conditions As DL', driver.DriverMedicalConditionCode))) == 0)
		}).DriverMedicalConditionCode,		
	(payload.Drivers map (driver , indexOfDriver) -> {
				(DriverHomeCityCode: "/Drivers/" ++ indexOfDriver ++ "/DriverHomeCityCode value is "++ driver.DriverHomeCityCode ++" not present/inactive in the lookups") if(driver.DriverHomeCityCode !=null and sizeOf(trim(test('City', driver.DriverHomeCityCode))) == 0)
		}).DriverHomeCityCode,		
	(payload.Drivers map (driver , indexOfDriver) -> {
				(DriverWorkCityCode: "/Drivers/" ++ indexOfDriver ++ "/DriverWorkCityCode value is "++ driver.DriverWorkCityCode ++" not present/inactive in the lookups") if(driver.DriverWorkCityCode !=null and sizeOf(trim(test('City', driver.DriverWorkCityCode))) == 0)
		}).DriverWorkCityCode,	
	payload.Drivers map ( driver , indexOfDriver ) -> (
		(driver.DriverLicenses map ( driverLicense , indexOfDriverLicense ) -> {
				(LicenseCountryCode: "/Drivers/" ++ indexOfDriver ++ "/DriverLicenses/" ++ indexOfDriverLicense ++ "/LicenseCountryCode value is "++ driverLicense.LicenseCountryCode ++" not present/inactive in the lookups") if(driverLicense.LicenseCountryCode !=null and sizeOf(trim(test('Country', driverLicense.LicenseCountryCode))) == 0)
		}).LicenseCountryCode),
	payload.Drivers map ( driver , indexOfDriver ) -> (
		(driver.DriverLicenses map ( driverLicense , indexOfDriverLicense ) -> {
				(DriverLicenseTypeCode: "/Drivers/" ++ indexOfDriver ++ "/DriverLicenses/" ++ indexOfDriverLicense ++ "/DriverLicenseTypeCode value is "++ driverLicense.DriverLicenseTypeCode ++" not present/inactive in the lookups") if(driverLicense.DriverLicenseTypeCode !=null and sizeOf(trim(test('Driver License Type', driverLicense.DriverLicenseTypeCode))) == 0)
		}).DriverLicenseTypeCode),	
	payload.Drivers map ( driver , indexOfDriver ) -> (
		(driver.DriverViolations map ( driverLicense , indexOfDriverLicense ) -> {
				(ViolationCode: "/Drivers/" ++ indexOfDriver ++ "/DriverViolations/" ++ indexOfDriverLicense ++ "/ViolationCode value is "++ driverLicense.ViolationCode ++" not present/inactive in the lookups") if(driverLicense.ViolationCode !=null and sizeOf(trim(test('Traffic Violations', driverLicense.ViolationCode))) == 0)
		}).ViolationCode),
	(payload.VehicleSpecifications map (driver , indexOfDriver) -> {
				(VehicleSpecificationCode: "/VehicleSpecifications/" ++ indexOfDriver ++ "/VehicleSpecificationCode value is "++ driver.VehicleSpecificationCode ++" not present/inactive in the lookups") if(driver.VehicleSpecificationCode !=null and sizeOf(trim(test('Vehicle Specifications', driver.VehicleSpecificationCode))) == 0)
		}).VehicleSpecificationCode		 
])

