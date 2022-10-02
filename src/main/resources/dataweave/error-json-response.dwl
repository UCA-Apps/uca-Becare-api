%dw 2.0
output application/json encoding="UTF-8", skipNullOn="everywhere"
var errors = (((error.description default "" replace "Error validating JSON. Error: - " with "") replace "- " with "") splitBy "\n")
fun field(field: String) = if(field contains '[') ((field splitBy("["))[1] splitBy("]"))[0]
					       else ((field splitBy(" "))[0] splitBy("/")) [sizeOf((field splitBy(" "))[0] splitBy("/"))-1]
---
if(vars.httpStatus == 400)
{
 "ReferenceId" : payload.ReferenceId,
 "StatusCode" : 2,
 "Errors" : vars.errorDescription map{
 	Code: 400,
 	Message: $,
 	Field: field($)
 } 
}
else if(vars.httpStatus == 500)
{
   "ReferenceId" : if(vars.quoteNo != null)vars.quoteNo else payload.ReferenceId,
 "StatusCode" : 2,
 "Errors" :  [{
    	field: "",
    	message: if(vars.quoteNo != null) "Requested Quotation is not present in Mule end" else (if(vars.errorDescription != null) vars.errorDescription else error.description),
    	code: ""
    }]
}
else
{
	code : vars.httpStatus,
	message : if(vars.errorMessage != null) vars.errorMessage else (error.errorType.identifier),
	description: if(vars.errorDescription != null) vars.errorDescription else error.description,
	dateTime : now() as String { format: "yyyy-MM-dd'T'HH:mm:ss" },
	transactionId : vars.transactionId
}
