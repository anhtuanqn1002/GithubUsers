//
//  APIManager.swift
//  GithubUsers
//
//  Created by Anh Tuan on 7/2/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import Foundation

struct APIManager {
    private init() {}
    
    private static var headers: Network.Headers {
        return [:]
    }
    
    private static var defaultParams: Network.Params {
        let params: [String: Any] = [:]
        return params
    }
}

// MARK: - Endpoint
extension APIManager {
    static func endpoint(path: String, _ arguments: CVarArg...) -> String {
        var components = URLComponents(string: Constants.StringURL.root)
        components?.path = String(format: path, arguments: arguments)
        return components?.url?.absoluteString ?? ""
    }
}

// MARK: - Request
extension APIManager {
    @discardableResult
    static func request(method: Network.HTTPMethod, url: String,
                        params: Network.Params, encoding: ParamEncoding? = nil,
                        completion: @escaping (Network.Response) -> Void) -> URLSessionTask? {
        let parameters = params.merging(defaultParams) { $1 }
        let requestData = Network.request(method: method, url: url, params: parameters,
                                            parameterEncoding: encoding, headers: headers) { (response) in
                                                completion(validateResponse(response))
        }
        return requestData
    }
}

// MARK: - Validate
private extension APIManager {
    private static func validateResponse(_ response: Network.Response) -> Network.Response {
        switch response.result {
        case .success(let data):
            let errorInfo = data["error"]
            guard errorInfo.exists(),
                let code = errorInfo["code"].int,
                let message = errorInfo["message"].string
                else { return response }
            
            let error = NSError(domain: "GithubUsers", code: code, userInfo: [NSLocalizedDescriptionKey: message])
            let resultError = Network.Response.ResultType.failure(error)
            return Network.Response(request: response.request, response: response.response, result: resultError)
        case .failure:
            return response
        }
    }
}
