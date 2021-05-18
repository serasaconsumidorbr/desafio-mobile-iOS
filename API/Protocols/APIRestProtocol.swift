//
//  APIRestProtocol.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import Foundation

protocol APIRestProtocol {

    typealias CompletionRequest<T: Decodable> = (_ sucesso: Bool,
                                                 _ responseData: ResponseData<T>?,
                                                 _ error: ErrorData<ErrorSpringCodable>?) -> Void

    typealias CompletionVoidRequest = (_ sucesso: Bool, _ responseData: ResponseVoid?, _ error:  ErrorData<ErrorSpringCodable>?) -> Void

    typealias CompletionResponse<T: Decodable, E: Decodable> = (_ success: Bool, _ response: ResponseData<T>?, _ error: ErrorData<E>?) -> Void

    func get<T: Decodable>(endPoint: String, params: [String: Any]?,
                           completion: @escaping CompletionRequest<T>)

    func get<T: Decodable, E: Decodable>(endpoint: String, params: [String: Any]?,
                                         completion: @escaping CompletionResponse<T, E>)

    func get(endpoint: String, params: [String: Any]?, completion: @escaping CompletionVoidRequest)

    func post<T: Decodable>(endPoint: String, params: [String: Any]?,
                            completion: @escaping CompletionRequest<T>)

    func post<B: Encodable, T: Decodable, E: Decodable>(endpoint: String, body: B?,
                                                        completion: @escaping CompletionResponse<T, E>)

    func post<T: Decodable, E: Decodable>(endpoint: String, completion: @escaping CompletionResponse<T, E>)

    func post<T: Encodable>(endpoint: String, body: T?, completion: @escaping CompletionVoidRequest)
    func post(endpoint: String, completion: @escaping CompletionVoidRequest)

    func put<T: Decodable>(endPoint: String, params: [String: Any]?, payload: Data?,
                           completion: @escaping CompletionRequest<T>)

    func put<T: Decodable, E: Decodable>(endpoint: String, params: [String: Any]?, payload: Data?,
                                         completion: @escaping CompletionResponse<T, E>)

    func put(contentType: ContentType, endPoint: String, params: [String : Any]?, payload: Data?, completion: @escaping CompletionVoidRequest)

    func delete(endpoint: String, params: [String: Any]?, completion: @escaping CompletionVoidRequest)

    /// Executa a fun
    func execute<T: Decodable>(method: MethodHTTP,
                               _ contentType: ContentType,
                               _ urlDirect: URL?,
                               endPoint: String,
                               params: [String: Any]?,
                               payload: Data?,
                               completion: @escaping CompletionRequest<T>
    )

    func execute<T: Decodable, E: Decodable>(method: MethodHTTP,
                                             _ contentType: ContentType,
                                             _ urlDirect: URL?,
                                             endpoint: String,
                                             params: [String: Any]?,
                                             payload: Data?,
                                             completion: @escaping CompletionResponse<T, E>
    )

    func execute(method: MethodHTTP,
                 _ contentType: ContentType,
                 _ urlDirect: URL?,
                 endPoint: String,
                 params: [String: Any]?,
                 payload: Data?,
                 completion: @escaping CompletionVoidRequest
    )

    func addHeaderValue(value: String, key: String) -> Bool

    func setAuthorization(value: String) -> Bool

    func clearHeaderValues() -> Bool

    func buildParams(params: [String: Any]?,  request: inout URLRequest, method: MethodHTTP,
                     contentType: ContentType) -> Bool

    func extractErrorMsgFromResponseBody(body: Data) -> String?
}
