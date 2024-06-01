
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

class PhonePePament extends statefulwidget {
const PhonePePament ({super.key});

@override
state<PhonePePayment> createState() => _PhonePePaymentState();

}

class _PhonePePaymentState extends State<PhonePePayment> {
	String environment = "UAT_SIM";
    String appId = "";
    String merchantId = "PGTESTPAYUAT";
    bool enableLogging = true;
	String checksum = "";
	String saltKey = "099eb0cd-02cf-4e2a-8aca-3e6c6aff0399";

	String saltIndex = "1";

	String callbackURL = "https://webhook.site/6172f64e-b3fe-4faa-ab51-effc81dbc5f2";

	String body = "";

	Object? result ;



	getChecksum(){
		final requestData = {
  "merchantId": "merchantId",
  "merchantTransactionId": "MT7850590068188104",
  "merchantUserId": "MUID123",
  "amount": 10000,
  "callbackUrl": "callbackUrl",
  "mobileNumber": "9999999999",
  "paymentInstrument": {
    "type": "PAY_PAGE"
  }
};

String base64Body = base64.encode(utf8.encode(json.encode(requestData)));


checksum = '${sha256.convert(utf8.encode(bse64Body+apiEndPoint+saltKey)).toString()}###$saltIndex';


return base64Body;



	}

	@override
	Void initState(){
	// TODO: implement initState
	super.initState();

	phonepeInit();


	body = getChecksum().toString();

	}

	@override
	widget build(BuildContext Context){
		return Const Placeholder();

		//button

	}

		Void phonepeInit() {
		
		
		PhonePePaymentSdk.init(environment, appId, merchantId, enableLogging)
        .then((val) => {
              setState(() {
                result = 'PhonePe SDK Initialized - $val';
              })
            })
        .catchError((error) {
      handleError(error);
      return <dynamic>{};
    });
	}


	void startPgTransaction() async{
		
		
		PhonePePaymentSdk.startTransaction(body, callbackUrl, checksum, "").then((response) => {
    setState(() {
                   if (response != null) 
                        {
                           String status = response['status'].toString();
                           String error = response['error'].toString();
                           if (status == 'SUCCESS') 
                           {
                             // "Flow Completed - Status: Success!";
                           } 
                           else {
                          // "Flow Completed - Status: $status and Error: $error";
                           }
                        } 
                   else {
                          // "Flow Incomplete";
                        }
                })
  }).catchError((error) {
  // handleError(error)
  return <dynamic>{};
  });

	
	}

	void handleError(error){
	
		setState((){
			result={"error" : error};
		});
	}

}