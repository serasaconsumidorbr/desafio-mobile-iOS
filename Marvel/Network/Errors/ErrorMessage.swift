//
//  ErrorMessage.swift
//  Marvel
//
//  Created by João Pedro on 21/01/21.
//

import Foundation

public typealias ErrorMessageString = (title: String, errorDescription: String)

public struct ErrorMessages {
    public static let withoutInternet = ErrorMessageString("Parece que você está sem conexão com a internet.",
                                                           "Para continuar, verifique o status de sua conexão ou conecte-se a outra rede.")

    public static let genericError = ErrorMessageString("Parece que alguma coisa não deu certo.",
                                                        """
    Desculpe, tivemos alguns problemas
    técnicos durante sua última operação.
    """)

    public static let serverError = ErrorMessageString("Parece que alguma coisa não deu certo.",
                                                        """
    Desculpe, tivemos alguns problemas
    técnicos durante sua última operação.
    """)
}
