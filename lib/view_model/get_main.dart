import 'dart:io';

String? authToken;

void setAuthToken(String token) {
  authToken = token;
}

// Define dynamic headers
dynamic getHeader2 = {
  HttpHeaders.authorizationHeader: authToken != null
      ? 'Bearer 103|BpPFh7aDKQtvRLWDlSNV7uVsCEIRR5sZ7lNlztPq3f8cb130'
      : '',
};

dynamic postHeader = {
  HttpHeaders.contentTypeHeader: 'application/json',
  HttpHeaders.authorizationHeader: authToken != null ? 'Bearer $authToken' : '',
};
