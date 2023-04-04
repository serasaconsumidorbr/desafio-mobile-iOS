//
//  EndpointConvertible.swift
//  MarvelCharacters
//
//  Created by Gabriel Beltrame Silva on 03/04/23.
//

import Alamofire

public protocol EndpointConvertible {
    var baseURL: String { get }
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var authenticationParameters: Parameters? { get }
    var additionalParameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
    var headers: [HTTPHeader]? { get }
    var convertible: URLConvertible { get }
    
    func isEqualTo(_ endpointConvertible: EndpointConvertible) -> Bool
    func asEquatable() -> EquatableEndpointConvertible
}


public struct EquatableEndpointConvertible: EndpointConvertible, Equatable {
    
    private let value: EndpointConvertible
    
    public init(_ value: EndpointConvertible) {
        self.value = value
    }
    
    public var baseURL: String {
        return value.baseURL
    }
    
    public var endpoint: String {
        return value.endpoint
    }
    
    public var method: HTTPMethod {
        return value.method
    }
    
    public var authenticationParameters: Parameters? {
        return value.authenticationParameters
    }
    
    public var additionalParameters: Parameters? {
        return value.additionalParameters
    }
    
    public var encoding: ParameterEncoding {
        return value.encoding
    }
    
    public var headers: [HTTPHeader]? {
        return value.headers
    }
    
    public var convertible: URLConvertible {
        return value.convertible
    }
    
    public static func ==(lhs: EquatableEndpointConvertible, rhs: EquatableEndpointConvertible) -> Bool {
        return lhs.value.isEqualTo(rhs.value)
    }
}

extension EndpointConvertible where Self: Equatable {
    public func isEqualTo(_ other: EndpointConvertible) -> Bool {
        guard let otherEndpointConvertible = other as? Self else { return false }
        return self == otherEndpointConvertible
    }
    
    public func asEquatable() -> EquatableEndpointConvertible {
        return EquatableEndpointConvertible(self)
    }
}

public extension EndpointConvertible {
    var baseURL: String {
        return "https://developer.marvel.com"
    }
    
    var authenticationParameters: Parameters? {
        guard let apiSecret = APIKeys.apiSecret, let apiKey = APIKeys.apiKey else { return nil }
        let timestamp = String(Date().timeIntervalSince1970)
        
        return [
            "ts": timestamp,
            "apiKey": apiKey,
            "hash": (timestamp + apiSecret + apiKey).MD5
        ]
    }
    
    var convertible: URLConvertible {
        return baseURL + endpoint
    }
}
