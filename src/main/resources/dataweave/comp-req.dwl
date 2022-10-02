%dw 2.0
output application/json skipNullOn="everywhere"
var InsIdType= if(payload.InsuredIdTypeCode == 1 or payload.InsuredIdTypeCode == 2) true else false
var VehicleId= if(payload.VehicleIdTypeCode == 1) true else false 
var productCheck= (vars.CategoryType filter ($.CATEGORY == 'Cover Type' and ($.code as Number default null) == payload.ProductTypeCode) map($.code)) [0]
var EffectiveDate= ((now()) + |P29D|) as String {format:"yyyy-MM-dd'T'HH:mm:ss+hh:mm"}
---
flatten ([
	if(payload.PolicyEffectiveDate > EffectiveDate) "PolicyEffectiveDate :"++ payload.PolicyEffectiveDate ++" is invalid" 
	else null,
	if(payload.InsuredIdTypeCode == 1) (if(payload.InsuredId startsWith('1')) null
	else "InsuredId should be National ID  when InsuredIdTypeCode is '1'") else null,
	if(payload.InsuredIdTypeCode == 2) (if (payload.InsuredId startsWith('2')) null
	else "InsuredId should be Iqama ID when InsuredIdTypeCode is '2'") else null,
	if(InsIdType and (payload.InsuredBirthDate == null or payload.InsuredBirthDate == ""))
		"InsuredBirthDate should be mandatory when 'InsuredIdTypeCode' is '1' or '2'"
	else null,
	if(InsIdType and(payload.InsuredGenderCode == null or payload.InsuredGenderCode == ""))
		"InsuredGenderCode should be mandatory when 'InsuredIdTypeCode' is '1' or '2'"
	else null,	
	if(sizeOf(trim(productCheck)) == 0) "ProductTypeCode ,Requested aggregator ProductTypeCode:'" ++ payload.ProductTypeCode ++ "' is incorrect/invalid"
	else null,	
	if(InsIdType and(payload.InsuredNationalityCode == null or payload.InsuredNationalityCode == ""))
		"InsuredNationalityCode should be mandatory when 'InsuredIdTypeCode' is '1' or '2'"
	else null,
	if(InsIdType and(payload.InsuredIdIssuePlaceCode == null or payload.InsuredIdIssuePlaceCode == ""))
		"InsuredIdIssuePlaceCode should be mandatory when 'InsuredIdTypeCode' is '1' or '2'"
	else null,
	if(InsIdType and(payload.InsuredIdIssuePlace == null or payload.InsuredIdIssuePlace == ""))
		"InsuredIdIssuePlace should be mandatory when 'InsuredIdTypeCode' is '1' or '2'"
	else null,
	if(InsIdType and(payload.InsuredFirstNameAr == null or payload.InsuredFirstNameAr == ""))
		"InsuredFirstNameAr should be mandatory when 'InsuredIdTypeCode' is '1' or '2'"
	else null,
	if(InsIdType and(payload.InsuredSocialStatusCode == null or payload.InsuredSocialStatusCode == ""))
		"InsuredSocialStatusCode should be mandatory when 'InsuredIdTypeCode' is '1' or '2'"
	else null,
	if(InsIdType and(payload.InsuredOccupationCode == null or payload.InsuredOccupationCode == ""))
		"InsuredOccupationCode should be mandatory when 'InsuredIdTypeCode' is '1' or '2'"
	else null,
	if(InsIdType and(payload.InsuredOccupation == null or payload.InsuredOccupation == ""))
		"InsuredOccupation should be mandatory when 'InsuredIdTypeCode' is '1' or '2'"
	else null,
	if(InsIdType and(payload.InsuredEducationCode == null or payload.InsuredEducationCode == 0))
		"InsuredEducationCode should be mandatory when 'InsuredIdTypeCode' is '1' or '2'"
	else null,
	if(InsIdType and(payload.InsuredChildrenBelow16Years == null))
		"InsuredChildrenBelow16Years should be mandatory when 'InsuredIdTypeCode' is '1' or '2'"
	else null,
	if(VehicleId and (payload.VehiclePlateNumber == null or payload.VehiclePlateNumber == 0))
		"VehiclePlateNumber should be mandatory when 'VehicleIdTypeCode' is '1'"
	else null,
	if(VehicleId and (payload.VehiclePlateText1 == null or payload.VehiclePlateText1 == ""))
		"VehiclePlateText1 should be mandatory when 'VehicleIdTypeCode' is '1'"
	else null,
	if(VehicleId and (payload.VehiclePlateText2 == null or payload.VehiclePlateText2 == ""))
		"VehiclePlateText2 should be mandatory when 'VehicleIdTypeCode' is '1'"
	else null,
	if(VehicleId and (payload.VehiclePlateText3 == null or payload.VehiclePlateText3 == ""))
		if((payload.VehiclePlateTypeCode as String default '') == "10") null else "VehiclePlateText3 should be mandatory when 'VehicleIdTypeCode' is '1'"
	else null,
	if(VehicleId and (payload.VehicleOwnerName == null or payload.VehicleOwnerName == ""))
		"VehicleOwnerName should be mandatory when 'VehicleIdTypeCode' is '1'"
	else null,
	if(VehicleId and (payload.VehicleOwnerId == null or payload.VehicleOwnerId == 0))
		"VehicleOwnerId should be mandatory when 'VehicleIdTypeCode' is '1'"
	else null,
	if(VehicleId and (payload.VehiclePlateTypeCode == null or payload.VehiclePlateTypeCode == ""))
		"VehiclePlateTypeCode should be mandatory when 'VehicleIdTypeCode' is '1'"
	else null,
	if((payload.ProductTypeCode == 2) and (payload.VehicleValue == null or payload.VehicleValue == 0))
		"VehicleValue should be mandatory when 'ProductTypeCode' is '2'"
	else null,
	if((payload.ProductTypeCode == 2) and (payload.DeductibleValue == null or payload.DeductibleValue == 0))
		"DeductibleValue should be mandatory when 'ProductTypeCode' is '2'"
	else null,
	if((payload.ProductTypeCode == 2) and (payload.VehicleAgencyRepair == null))
		"VehicleAgencyRepair should be mandatory when 'ProductTypeCode' is '2'"
	else null,
	if((payload.VehicleUseCode == 2) and (payload.VehicleAxleWeightCode == null or payload.VehicleAxleWeightCode == 0))
		"VehicleAxleWeightCode should be mandatory when 'VehicleUseCode' is '2'"
	else null,
	if(payload.VehicleModification and (payload.VehicleModificationDetails == null or payload.VehicleModificationDetails == ""))
		"VehicleModificationDetails should be mandatory when 'VehicleModification' is 'true'"
	else null,
	payload.Drivers map ( driver , indexOfDriver ) -> (
		(driver.DriverLicenses map ( driverLicense , indexOfDriverLicense ) -> {
				(DriverLicenseTypeCode: "/Drivers/" ++ indexOfDriver ++ "/DriverLicenses/" ++ indexOfDriverLicense ++ "/DriverLicenseTypeCode should be mandatory when 'LicenseCountryCode' is '113'") if(driverLicense.LicenseCountryCode == 113 and (driverLicense.DriverLicenseTypeCode == null or driverLicense.DriverLicenseTypeCode == ""))
		}).DriverLicenseTypeCode),
	payload.Drivers map ( driver , indexOfDriver ) -> (
		(driver.DriverLicenses map ( driverLicense , indexOfDriverLicense ) -> {
			(DriverLicenseExpiryDate: "/Drivers/" ++ indexOfDriver ++ "/DriverLicenses/" ++ indexOfDriverLicense ++ "/DriverLicenseExpiryDate should be mandatory when 'LicenseCountryCode' is '113'") if(driverLicense.LicenseCountryCode == 113 and (driverLicense.DriverLicenseExpiryDate == null or driverLicense.DriverLicenseExpiryDate == ""))
		}).DriverLicenseExpiryDate)
])
