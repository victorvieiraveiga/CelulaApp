//
//  Cep.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 28/03/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

import Foundation
import MapKit


class Cep: Decodable {
    var bairro: String
    var cidade: String
    var logradouro : String
    var estado_info : [estado_info]
    var cep : String
    var cidade_info: [cidade_info] 
    var estado : String
}

class estado_info : Decodable {
    var area_km2 : String
    var codigo_ibge: String
    var nome: String
}

class cidade_info: Decodable {
    var area_km2: String
    var codigo_ibge: String
    
}


