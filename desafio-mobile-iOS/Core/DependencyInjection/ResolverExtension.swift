//
//  ResolverExtension.swift
//  Marvel
//
//  Created by andre mietti on 15/05/21.
//

import Swinject

extension Resolver {
    public func resolveSafe<Service>(_ serviceType: Service.Type) -> Service {
        guard let dependency = resolve(serviceType, name: nil) else {
            preconditionFailure("\(serviceType) is nil")
        }
        return dependency
    }

    public func resolveSafe<Service, Arg1>(_ serviceType: Service.Type, argument: Arg1) -> Service {
        guard let service = resolve(serviceType, argument: argument) else {
            preconditionFailure("\(serviceType) is nil")
        }
        return service
    }

    public func resolveSafe<Service, Arg1, Arg2>(_ serviceType: Service.Type, arguments arg1: Arg1, _ arg2: Arg2) -> Service {
        guard let service = resolve(serviceType, arguments: arg1, arg2) else {
            preconditionFailure("\(serviceType) is nil")
        }
        return service
    }
}

