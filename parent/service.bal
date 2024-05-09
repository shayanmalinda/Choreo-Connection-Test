import ballerina/http;

public type ClientAuthConfig record {|
    string tokenUrl;
    string clientId;
    string clientSecret;
|};

configurable string dependencyBaseUrl = ?;
configurable ClientAuthConfig clientAuthConfig = ?;

final http:Client clientEndpoint = check new (
    dependencyBaseUrl,
    {
        auth: {
            ...clientAuthConfig
        }
    }
);

service / on new http:Listener(9090) {
    resource function get test\-parent() returns string|error {
        http:Response|http:ClientError get = clientEndpoint->get("/test-dependency");
        if get is http:Response {
            return check get.getTextPayload();
        } else {
            return "Error occurred";
        }
    }
}
