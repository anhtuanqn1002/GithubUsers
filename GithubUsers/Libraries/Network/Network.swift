//
//  Network.swift
//  GithubUsers
//
//  Created by Anh Tuan on 7/2/19.
//  Copyright © 2019 tuan.nva. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Network {
    typealias Params = [String: Any]
    typealias Headers = [String: String]
    
    enum HTTPMethod: String {
        case post = "POST"
        case get = "GET"
        
        var defaultEncoding: ParamEncoding {
            switch self {
            case .post:
                return JSONEncoding.default
            case .get:
                return URLEncoding.default
            }
        }
    }
    
    private init() {}
}

// MARK: - Encoding
protocol ParamEncoding {}

protocol URLParamEncoding: ParamEncoding {
    func encode(params: Network.Params) -> [URLQueryItem]
}
extension Network {
    enum URLEncoding: URLParamEncoding {
        case `default`
        
        func encode(params: Network.Params) -> [URLQueryItem] {
            switch self {
            case .default:
                return params.map { URLQueryItem(name: $0.key, value: $0.value as? String) }
            }
        }
    }
}

protocol JSONParamEncoding: ParamEncoding {
    func encode(params: Network.Params) -> Data
}
extension Network {
    enum JSONEncoding: JSONParamEncoding {
        case `default`
        
        func encode(params: Network.Params) -> Data {
            switch self {
            case .default:
                return (try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)) ?? Data()
            }
        }
    }
}

// MARK: - Response
extension Network {
    struct Response {
        typealias ResultType = Swift.Result<JSON, NSError>
        
        let request: URLRequest?
        let response: HTTPURLResponse?
        let result: ResultType
    }
}

// MARK: - Adapter
private protocol NetworkConvertable {
    associatedtype DestinationType
    var convertedObject: DestinationType { get }
}

extension Network.HTTPMethod: NetworkConvertable {
    var convertedObject: Alamofire.HTTPMethod {
        return Alamofire.HTTPMethod(rawValue: rawValue) ?? Alamofire.HTTPMethod.get
    }
}

extension Network.JSONEncoding: NetworkConvertable {
    var convertedObject: Alamofire.JSONEncoding {
        switch self {
        case .default:
            return Alamofire.JSONEncoding.default
        }
    }
}

extension Network.URLEncoding: NetworkConvertable {
    var convertedObject: Alamofire.URLEncoding {
        switch self {
        case .default:
            return Alamofire.URLEncoding.default
        }
    }
}

extension ParamEncoding {
    fileprivate var alamofireEncoding: Alamofire.ParameterEncoding {
        switch self {
        case let jsonEncoding as Network.JSONEncoding:
            switch jsonEncoding {
            case .default:
                return Alamofire.JSONEncoding.default
            }
        case let urlEncoding as Network.URLEncoding:
            switch urlEncoding {
            case .default:
                return Alamofire.URLEncoding.default
            }
        default:
            return Alamofire.URLEncoding.default
        }
    }
}

// MARK: - Public
extension Network {
    @discardableResult
    static func request(method: HTTPMethod, url: String,
                        params: Params, parameterEncoding: ParamEncoding? = nil,
                        headers: Headers, completion: @escaping (Response) -> Void) -> URLSessionTask? {
        let dataRequest = Alamofire.request(url, method: method.convertedObject, parameters: params,
                                            encoding: (parameterEncoding ?? method.defaultEncoding).alamofireEncoding, headers: headers)
        Log("Request: \(method.rawValue) \(url) \nParams: \(params.description)")
        dataRequest.responseJSON { (response) in
            let result: Response.ResultType
            switch response.result {
            case .failure(let error):
                Log("Response: \(method.rawValue) \(url) \nError: \((error as NSError).localizedDescription)")
                result = Response.ResultType.failure(error as NSError)
            case .success(let value):
                Log("Response: \(method.rawValue) \(url) \nValue: \(value)")
                result = Response.ResultType.success(JSON(value))
            }
            completion(Response(request: response.request, response: response.response, result: result))
        }
        return dataRequest.task
    }
}
