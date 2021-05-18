//
//  APIRest.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import UIKit

struct NoReply: Decodable {
    init() {}
}

struct DefaulErrorMsg: Codable {
    var message: String?

    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
}

enum DefaultErrorCodes: Int {
    case domainFail = 999,
         paramEncodeFail = 998,
         responseCodableFail = 997,
         noDataResponse = 996,
         statusCodeError = 995
}

class APIRest: APIRestProtocol {

    /// enumerado que define o Content-Type da request
    var contentType: ContentType?
    var contentFunctions = ContentTypeFunctions()

    var header: [String: String] = [:]

    private var task: URLSessionTask?

    init () {
    }

    func get<T>(endPoint: String, params: [String : Any]?,
                completion: @escaping CompletionRequest<T>) where T: Decodable {

        self.execute(method: .GET,
                     .json,
                     endPoint: endPoint,
                     params: params,
                     completion: completion)
    }

    func get<T, E>(endpoint: String, params: [String : Any]?, completion: @escaping CompletionResponse<T, E>) where T : Decodable, E : Decodable {
        self.execute(method: .GET, endpoint: endpoint, params: params, completion: completion)
    }

    func post<T>(endPoint: String, params: [String : Any]?,
                 completion: @escaping CompletionRequest<T>) where T: Decodable {

        self.execute(method: .POST,
                     .json,
                     endPoint: endPoint,
                     params: params,
                     completion: completion)
    }

    func post<T, E>(endpoint: String,
                    completion: @escaping CompletionResponse<T, E>) where T: Decodable, E: Decodable {

        self.execute(method: .POST, .json, nil, endpoint: endpoint, params: nil, payload: nil, completion: completion)
    }

    func post<B, T, E>(endpoint: String, body: B?, completion: @escaping CompletionResponse<T, E>) where B: Encodable, T : Decodable, E : Decodable {
        if let body = body {
            do {
                let body = try JSONEncoder().encode(body)
                self.execute(method: .POST, .json, nil, endpoint: endpoint, params: nil, payload: body, completion: completion)
            } catch let error {
                print(error.localizedDescription)
                completion(false, nil, nil)
            }
        } else {
            self.execute(method: .POST, .json, nil, endpoint: endpoint, params: nil, payload: nil, completion: completion)
        }
    }

    func post<T: Encodable>(endpoint: String, body: T?, completion: @escaping CompletionVoidRequest) {
        if let body = body {
            do {
                let body = try JSONEncoder().encode(body)
                self.execute(method: .POST, .json, nil, endPoint: endpoint, params: nil, payload: body, completion: completion)
            } catch let error {
                print(error.localizedDescription)
                completion(false, nil, nil)
            }
        } else {
            self.execute(method: .POST, .json, nil, endPoint: endpoint, params: nil, payload: nil, completion: completion)
        }
    }

    func post(endpoint: String, completion: @escaping CompletionVoidRequest) {
        self.execute(method: .POST, .json, nil, endPoint: endpoint, params: nil, payload: nil, completion: completion)
    }

    func put<T>(endPoint: String, params: [String : Any]?, payload: Data?,
                completion: @escaping CompletionRequest<T>) where T: Decodable {

        self.execute(method: .PUT,
                     .json,
                     endPoint: endPoint,
                     params: params,
                     payload: payload,
                     completion: completion)
    }

    func put<T, E>(endpoint: String, params: [String : Any]?, payload: Data?, completion: @escaping CompletionResponse<T, E>) where T : Decodable, E : Decodable {
        self.execute(method: .PUT, endpoint: endpoint, params: params, payload: payload, completion: completion)
    }

    func put(contentType: ContentType, endPoint: String, params: [String : Any]?, payload: Data?, completion: @escaping CompletionVoidRequest) {
        self.execute(method: .PUT,
                     contentType,
                     endPoint: endPoint,
                     params: params,
                     payload: payload,
                     completion: completion)
    }

    func get(endpoint: String, params: [String : Any]?, completion: @escaping CompletionVoidRequest) {
        self.execute(method: .GET, .json, endPoint: endpoint, params: params, completion: completion)
    }

    func delete(endpoint: String, params: [String : Any]?, completion: @escaping CompletionVoidRequest) {
        self.execute(method: .DELETE, .json, endPoint: endpoint, params: params, completion: completion)
    }

    func execute<T>(method: MethodHTTP,
                    _ contentType: ContentType = .json,
                    _ urlDirect: URL? = nil,
                    endPoint: String,
                    params: [String : Any]?,
                    payload: Data? = nil,
                    completion: @escaping CompletionRequest<T>) where T: Decodable {

        let session = URLSession.shared

        let urlString: String = endPoint.contains("http") ? endPoint : WebDomain.dev.rawValue + endPoint

        guard var url = URL(string: urlString) else {
            completion(false, nil, ErrorData(timestamp: Date(), error: defaultError(errorType: .domainFail)))
            return
        }

        // usa urlDireta se for fornecida
        if let urlD = urlDirect {
            url = urlD
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.verb() //set http method as POST
        //HTTP Headers
        var boundary: String?
        if (contentType == .formdata) {
            boundary = contentFunctions.generateBoundary()
        }

        adpatRequestDeviceFields(&request, contentType, boundary)

        //headers
        for value in header {
            request.setValue(value.value, forHTTPHeaderField: value.key)
        }

        if let payload = payload {
            request.httpBody = payload
        } else {
            let correct = buildParams(params: params, request: &request, method: method, contentType: contentType)

            guard correct else {
                completion(false, nil, ErrorData(timestamp: Date(), error: self.defaultError(errorType: .paramEncodeFail)))
                return
            }
        }
        #if DEBUG
        print("[RESTAPI] Url: \(url)")
        print("[RESTAPI] Params: \(params.defaultValue)")
        print("[RESTAPI] Headers: \(String(describing: request.allHTTPHeaderFields))")
        print("[RESTAPI] Body: \(String(describing: request.httpBody))")
        print("[RESTAPI] Request: \(request)")
        #endif
        // Request
        task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard error == nil else {
                completion(false, nil, ErrorData(timestamp: Date(), error: NSError(domain: error?.localizedDescription ?? "", code: 0, userInfo: nil)))
                return
            }

            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            var resultData: T?
            #if DEBUG
            print("[RESTAPI] Status: \(statusCode)")
            #endif
            if (200..<300).contains(statusCode) {
                if let _data = data {
                    let decoder = JSONDecoder()
                    do {
                        resultData =  T.self == NoReply.self ? nil : try decoder.decode(T.self, from: _data)
                        let responseData = ResponseData(status: statusCode, data: resultData, responseData: data,
                                                        request: request, timestamp: Date())
                        print("[RESTAPI] ResponseData: \(responseData)")
                        completion(true, responseData, nil)
                    } catch let error {
                        #if DEBUG
                        print("\(error)")
                        print("\(String(describing: String(data: data!, encoding: .utf8)))")
                        #endif
                        let errorData = self.processError(.responseCodableFail, error: nil, request: request, data: data, statusCode: statusCode)
                        completion(false, nil, errorData)
                    }
                } else {
                    let errorData = self.processError(.noDataResponse, error: nil, request: request, data: data, statusCode: statusCode)
                    completion(false, nil, errorData)
                }
            } else {
                let errorData = self.processError(.statusCodeError, error: nil, request: request, data: data, statusCode: statusCode)
                completion(false, nil, errorData)
            }
        })

        task?.resume()
    }

    func execute(method: MethodHTTP,
                 _ contentType: ContentType,
                 _ urlDirect: URL? = nil,
                 endPoint: String,
                 params: [String : Any]?,
                 payload: Data? = nil,
                 completion: @escaping CompletionVoidRequest) {
        let session = URLSession.shared

        let urlString: String = endPoint.contains("http") ? endPoint : WebDomain.dev.rawValue + endPoint
        guard var url = URL(string: urlString) else {
            completion(false, nil, ErrorData(timestamp: Date(), error: defaultError(errorType: .domainFail)))
            return
        }

        if let urlD = urlDirect {
            url = urlD
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.verb()
        //HTTP Headers
        var boundary: String?
        if (contentType == .formdata) {
            boundary = contentFunctions.generateBoundary()
        }

        adpatRequestDeviceFields(&request, contentType, boundary)

        //headers
        for value in header {
            request.setValue(value.value, forHTTPHeaderField: value.key)
        }

        if let payload = payload {
            request.httpBody = payload
            request.setValue(payload.count.description, forHTTPHeaderField: "content-length")
        } else {
            let correct = buildParams(params: params, request: &request, method: method, contentType: contentType)

            guard correct else {
                completion(false, nil, ErrorData(timestamp: Date(), error: self.defaultError(errorType: .paramEncodeFail)))
                return
            }
        }
        #if DEBUG
        print("[RESTAPI] Url: \(url)")
        print("[RESTAPI] Params: \(params.defaultValue)")
        print("[RESTAPI] Headers: \(String(describing: request.allHTTPHeaderFields))")
        print("[RESTAPI] Body: \(String(describing: request.httpBody))")
        #endif
        // Request
        task = session.dataTask(with: request, completionHandler: { [weak self] data, response, error in

            guard error == nil else {
                completion(false, nil, ErrorData(timestamp: Date(), error: NSError(domain: error?.localizedDescription ?? "", code: 0, userInfo: nil)))
                return
            }

            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            #if DEBUG
            print("[RESTAPI] Status: \(statusCode)")
            #endif
            if (200..<300).contains(statusCode) {
                let responseData = ResponseVoid(status: statusCode, responseData: data,
                                                request: request, timestamp: Date())
                completion(true, responseData, nil)
            } else {
                let errorData = self?.processError(.statusCodeError, error: nil, request: request, data: data, statusCode: statusCode)
                completion(false, nil, errorData)
            }
        })

        task?.resume()
    }

    func execute<T, E>(method: MethodHTTP,
                       _ contentType: ContentType = .json,
                       _ urlDirect: URL? = nil,
                       endpoint: String,
                       params: [String : Any]?,
                       payload: Data? = nil,
                       completion: @escaping CompletionResponse<T, E>) where T : Decodable, E : Decodable {
        let session = URLSession.shared

        let urlString: String = endpoint.contains("http") ? endpoint : WebDomain.dev.rawValue + endpoint
        guard let url = urlDirect ?? URL(string: urlString) else {
            completion(false, nil, ErrorData(timestamp: Date(), error: defaultError(errorType: .domainFail)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.verb() //set http method as POST
        //HTTP Headers
        var boundary: String?
        if (contentType == .formdata) {
            boundary = contentFunctions.generateBoundary()
        }

        adpatRequestDeviceFields(&request, contentType, boundary)

        //headers
        for value in header {
            request.setValue(value.value, forHTTPHeaderField: value.key)
        }

        if let payload = payload {
            request.httpBody = payload
        } else {
            let correct = buildParams(params: params, request: &request, method: method, contentType: contentType)

            guard correct else {
                completion(false, nil, ErrorData(timestamp: Date(), error: self.defaultError(errorType: .paramEncodeFail)))
                return
            }
        }
        #if DEBUG
        print("[RESTAPI] Url: \(url)")
        print("[RESTAPI] Params: \(params.defaultValue)")
        print("[RESTAPI] Headers: \(String(describing: request.allHTTPHeaderFields))")
        print("[RESTAPI] Body: \(String(describing: request.httpBody))")
        #endif
        // Request
        task = session.dataTask(with: request, completionHandler: { [weak self] data, response, error in
            guard error == nil else {
                completion(false, nil, ErrorData(timestamp: Date(), error: NSError(domain: error?.localizedDescription ?? "", code: 0, userInfo: nil)))
                return
            }

            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            let errorData: ErrorData<E>? = ErrorData(timestamp: Date(), error: nil)
            var errorCode: DefaultErrorCodes?
            var error: NSError?
            var resultData: T?
            #if DEBUG
            print("[RESTAPI] Status: \(statusCode)")
            #endif
            if (200..<300).contains(statusCode) {
                if let _data = data {
                    let decoder = JSONDecoder()
                    do {
                        resultData =  T.self == NoReply.self ? nil : try decoder.decode(T.self, from: _data)
                        let responseData = ResponseData(status: statusCode, data: resultData, responseData: data,
                                                        request: request, timestamp: Date())
                        completion(true, responseData, nil)
                    } catch let error {
                        #if DEBUG
                        print("\(error)")
                        print("\(String(describing: String(data: _data, encoding: .utf8)))")
                        #endif
                        errorCode = .responseCodableFail
                    }
                } else {
                    errorCode = .noDataResponse
                    completion(false, nil, nil)
                }
            } else {
                errorCode = .statusCodeError
                if let _data = data {
                    errorData?.decode(data: _data)
                }

                if let codeError = errorCode {
                    error = self?.defaultError(errorType: codeError, statusCode)
                }
                errorData?.error = error
                errorData?.status = statusCode
                errorData?.request = request
                completion(false, nil, errorData)
            }
        })

        task?.resume()
    }

    func addHeaderValue(value: String, key: String) -> Bool {
        self.header[key] = value
        return self.header.contains(where: { $1 == value })
    }

    func clearHeaderValues() -> Bool {
        self.header.removeAll()
        return self.header.isEmpty
    }

    func setAuthorization(value: String) -> Bool {
        return addHeaderValue(value: value, key: "Authorization")
    }

    private func adpatRequestDeviceFields(_ request: inout URLRequest, _ contentType: ContentType, _ boundary: String?) {
        request.addValue(contentType.contentType(boundary), forHTTPHeaderField: "Content-Type")
        request.addValue(contentType.contentType(), forHTTPHeaderField: "Accept")
        request.setValue(UIDevice.current.systemVersion, forHTTPHeaderField: "x-sistema-operacional")
        request.setValue(UIDevice.current.identifierForVendor?.description ?? "", forHTTPHeaderField: "x-uuid")
    }

    private func processError(_ errorCode: DefaultErrorCodes?, error: NSError?,
                              request: URLRequest?, data: Data?, statusCode: Int) -> ErrorData<ErrorSpringCodable>? {
        let errorData: ErrorData<ErrorSpringCodable>? = ErrorData(timestamp: Date(), error: nil)
        var error: NSError?

        if let _data = data {
            errorData?.decode(data: _data)
        }

        if let codeError = errorCode {
            error = defaultError(errorType: codeError, statusCode)
        }
        errorData?.error = error
        errorData?.status = statusCode
        errorData?.request = request

        return errorData
    }

    private func defaultError(errorType: DefaultErrorCodes, _ errorCode: Int = 0) -> NSError {
        switch errorType {
        case .domainFail:
            return NSError(domain: "dominio ausente", code: errorType.rawValue, userInfo: nil)
        case .paramEncodeFail:
            return NSError(domain: "paramento codable fail", code: errorType.rawValue, userInfo: nil)
        case .responseCodableFail:
            return NSError(domain: "response codable fail", code: errorType.rawValue, userInfo: nil)
        case .noDataResponse:
            return NSError(domain: "no data response fail", code: errorType.rawValue, userInfo: nil)
        case .statusCodeError:
            return NSError(domain: "erro no servidor \(errorCode)", code: errorCode, userInfo: nil)
        }
    }

    internal func queryItens(url: URL, params: [String: Any]) -> URL {
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            var queryItems = [URLQueryItem]()
            params.forEach { key, value in
                if ((value as? Int) != nil) || ((value as? String) != nil) || ((value as? Double) != nil)
                    || ((value as? Float) != nil) || ((value as? Character) != nil) {
                    queryItems.append(URLQueryItem(name: "\(key)", value: "\(value)"))
                }
            }
            if !queryItems.isEmpty {
                urlComponents.queryItems = queryItems
            }
            return urlComponents.url ?? url
        }
        return url
    }

    internal func buildParams(params: [String: Any]?,  request: inout URLRequest,
                              method: MethodHTTP, contentType: ContentType) -> Bool {
        if method != .GET {
            if contentType == .json {
                if let paramDict = params {
                    guard JSONSerialization.isValidJSONObject(paramDict) else {
                        return false
                    }
                    do {
                        request.httpBody = try contentFunctions.createDataBodyJsonData(withParameters: paramDict)
                    } catch {
                        return false
                    }
                }
            }
            if contentType == .formdata {
                if let paramDict = params {
                    request.httpBody = contentFunctions.createDataBodyFormData(withParameters: paramDict)
                    let bytes = request.httpBody?.count
                    request.setValue("\(bytes ?? bytes.defaultValue)", forHTTPHeaderField: "content-length")
                }
            }
        }

        if method == .GET {
            if let  param = params, let url = request.url {
                let urlWithComponents = self.queryItens(url: url, params: param)
                request.url = urlWithComponents
            }

        }

        return true
    }

    func extractErrorMsgFromResponseBody(body: Data) -> String? {
        do{
            let decoder = JSONDecoder()
            let resultBody = try decoder.decode(DefaulErrorMsg.self, from: body)
            return resultBody.message ?? nil
        } catch {
            return nil
        }
    }

    func cancelTask() {
        task?.cancel()
    }
}
