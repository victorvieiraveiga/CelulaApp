//
//  Celula.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 24/03/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

class Celula {
    
    var id: String
    var nomeCelula: String
    var nomeLider: String
    var nomeAnfitriao : String
    var horario: String
    var dia: String
    var cep: String
    var logradouro: String
    var numero: String
    var bairro: String
    var municipio: String
    var uf : String
    
   
    
    
    
    init(id: String, nomeCelula: String, nomeLider: String,nomeAnfitriao : String,horario: String, dia: String, cep: String, logradouro: String, numero: String, bairro: String, municipio: String, uf: String )
    {
        self.id = id
        self.nomeCelula = nomeCelula
        self.nomeLider = nomeLider
        self.nomeAnfitriao = nomeAnfitriao
        self.horario = horario
        self.dia = dia
        self.cep = cep
        self.logradouro = logradouro
        self.numero = numero
        self.bairro = bairro
        self.municipio = municipio
        self.uf = uf
      
    }
    
}
