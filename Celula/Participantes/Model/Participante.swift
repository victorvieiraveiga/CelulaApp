//
//  Participante.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 24/03/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

import Foundation

class Participante {
    
    var nome: String
    var email: String
    var telefone: String
    var dataNascimento: String
    var nomeCelula : String
    var imagem: String
   
    
    init (nome: String,  email: String,telefone: String, dataNascimento: String, nomeCelula: String, imagem: String ) {
        self.nome = nome
        self.email = email
        self.telefone = telefone
        self.dataNascimento = dataNascimento
        self.nomeCelula = nomeCelula
        self.imagem = imagem
    }
    
}
