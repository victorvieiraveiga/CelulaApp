//
//  Cep.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 27/03/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

import Foundation
import UIKit

class CepApi: Decodable {
    
    var cep: String
    var logradouro: String
    var complemento: String
    var bairro: String
    var localidade : String
    var uf: String
    var unidade: String
    var ibge: String
    var gia: String
    
}

//{
//  "cep": "20040-924",
//  "logradouro": "Rua do Ouvidor 60",
//  "complemento": "",
//  "bairro": "Centro",
//  "localidade": "Rio de Janeiro",
//  "uf": "RJ",
//  "unidade": "",
//  "ibge": "3304557",
//  "gia": ""
//}
