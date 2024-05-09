import ballerina/http;

service / on new http:Listener(8080) {
    resource function get test\-dependency() returns string {
        return "Test dependency is working!";
    }
}
