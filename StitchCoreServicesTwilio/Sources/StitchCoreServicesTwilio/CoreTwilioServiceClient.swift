import Foundation
import MongoSwift
import StitchCore

open class CoreTwilioServiceClient {
    
    private let service: CoreStitchServiceClient
    
    public init(withService service: CoreStitchServiceClient) {
        self.service = service
    }
    
    public func sendMessage(to: String,
                            from: String,
                            body: String,
                            mediaURL: String? = nil) throws {
        var args: Document = [
            "to": to,
            "from": from,
            "body": body
        ]

        if mediaURL != nil {
            args["mediaUrl"] = mediaURL
        }
        
        try self.service.callFunctionInternal(withName: "send", withArgs: [args], withRequestTimeout: nil)
    }
}
