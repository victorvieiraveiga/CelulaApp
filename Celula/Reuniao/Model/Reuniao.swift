//
//  Reuniao.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 25/03/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

import Foundation
import UIKit

struct Reuniao {

    var data: String
    var participantes: [ParticipanteReuniao]
    var observacoes: String
    var idCelula: String
    var celulaNome : String
    }

struct  ParticipanteReuniao {
    var nome : String
}
