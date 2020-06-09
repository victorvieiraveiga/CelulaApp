//
//  HomeViewController.swift
//  Celula
//
//  Created by Victor Vieira Veiga on 14/04/20.
//  Copyright © 2020 Victor Vieira Veiga. All rights reserved.
//

import UIKit
import CoreData
import GoogleMobileAds

class HomeViewController: UIViewController {

 
    @IBOutlet weak var collectionCelula: UICollectionView!
    @IBOutlet weak var collectionReuniao: UICollectionView!
    @IBOutlet weak var contadorReuniao: UILabel!
 
    @IBOutlet weak var collectionParticipantes: UICollectionView!
    
    @IBOutlet weak var viewPrincipal: UIView!
    @IBOutlet weak var viewSemCelula: UIView!
    
    @IBOutlet weak var labelUltimasReunioes: UILabel!
    @IBOutlet weak var labelParticipantes: UILabel!
    
    @IBOutlet weak var viewReuniaoMini: UIView!

    @IBOutlet weak var viewCelulaMini: UIView!
    @IBOutlet weak var labelContParticipantes: UILabel!
    @IBOutlet weak var viewParticipantesMini: UIView!
    @IBOutlet weak var labelContCelula: UILabel!
    @IBOutlet weak var stackMiniaturas: UIStackView!
    
    var reuniaoList : [NSManagedObject] = []
    var participantesReuniao : [NSManagedObject] = []
    var celulaList : [NSManagedObject] = []
    var participantesList : [NSManagedObject] = []
    let reuniaoObject = FormataReuniao()
    let celulaObject = FormataCelula()
    let partObject = FormataParticipantes()
    
    private let banner : GADBannerView = {
        let banner = GADBannerView()
        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716" //"ca-app-pub-6593854542748346/5020695807"
        banner.load(GADRequest())
        banner.backgroundColor = .secondarySystemBackground
        return banner
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inicio()

        collectionReuniao.delegate = self
        collectionReuniao.dataSource = self
        
        collectionCelula.delegate = self
        collectionCelula.dataSource = self
        
        collectionParticipantes.dataSource = self
        collectionParticipantes.delegate = self


        collectionReuniao.heightAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        collectionCelula.heightAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        collectionParticipantes.heightAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        
        if let flowLayoutA = collectionCelula.collectionViewLayout as? UICollectionViewFlowLayout {
               flowLayoutA.scrollDirection = .horizontal
          }
         if let flowLayoutB = collectionReuniao.collectionViewLayout as? UICollectionViewFlowLayout {
               flowLayoutB.scrollDirection = .horizontal
           }
        
        if let flowLayoutc = collectionParticipantes.collectionViewLayout as? UICollectionViewFlowLayout {
               flowLayoutc.scrollDirection = .horizontal
        }
        
        banner.rootViewController = self
        //view.addSubview(banner)
        viewPrincipal.addSubview(banner)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        inicio()

        contadorReuniao.text = String(reuniaoObject.numeroReunioes())
        collectionCelula.reloadData()
        collectionReuniao.reloadData()
        collectionParticipantes.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        banner.frame = CGRect(x: 0, y: viewPrincipal.frame.size.height-50, width: viewPrincipal.frame.size.width, height: 50).integral
    }
    
    func inicio () {
        
        if celulaObject.existeCelula() == true {
            
            viewSemCelula.isHidden = true
            viewPrincipal.isHidden = false

            self.reuniaoList = reuniaoObject.CarregaReuniao(numero_registros: 10)
            self.celulaList = celulaObject.CarregaCelula()
            self.participantesList = partObject.CarregaParticipante()
            labelUltimasReunioes.isHidden = true
             labelParticipantes.isHidden = true
            //exibeLabelsCelula()
           // exibeLabelsReuniao()
            //exibeLabelsParticipante()
            exibeMiniaturas()

        }
        else {
            viewSemCelula.isHidden = false
            viewPrincipal.isHidden = true
        }
    }
    
    func exibeLabelsReuniao () {
        if self.reuniaoList.count > 0 {
            contadorReuniao.text = String(reuniaoObject.numeroReunioes())
            labelUltimasReunioes.isHidden = false
            viewReuniaoMini.isHidden = false
            contadorReuniao.isHidden = false
        }else {
            labelUltimasReunioes.isHidden = true
            viewReuniaoMini.isHidden = true
            contadorReuniao.isHidden = true
        }
    }
    
    func exibeLabelsCelula () {
        if self.celulaList.count > 0 {
            
            labelContCelula.isHidden = false
            viewCelulaMini.isHidden = false
            labelContCelula.text = String(celulaObject.numeroCelula())
        }else {
            labelContCelula.isHidden = true
            viewCelulaMini.isHidden = true
        }
    }
    
    func exibeLabelsParticipante() {
        if self.participantesList.count > 0 {
             labelParticipantes.isHidden = false
            labelContParticipantes.isHidden = false
            viewParticipantesMini.isHidden = false
            labelContParticipantes.text = String(partObject.numeroParticipante())
        }else {
            labelContParticipantes.isHidden = true
            viewParticipantesMini.isHidden = true
             labelParticipantes.isHidden = true
        }
    }
    
    func exibeMiniaturas () {
        
        if self.reuniaoList.count > 0 {
            if self.participantesList.count > 0 {
                if self.celulaList.count > 0 {
                    stackMiniaturas.isHidden = false
                    exibeLabelsParticipante()
                    exibeLabelsCelula ()
                    exibeLabelsReuniao ()
                }
            }
        }
    }
    
    
    

    
    @IBAction func chamaTelaCadastroCelula(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
              let controller = storyboard.instantiateViewController(identifier: "cadCelula") as! CadastroCelulaViewController
              navigationController?.pushViewController(controller, animated: true)
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.collectionReuniao {
            return reuniaoList.count
        }else {
                if collectionView == self.collectionCelula {
                    return celulaList.count
                }
                else {
                    return participantesList.count
                 }
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if collectionView == self.collectionCelula {
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCelula", for: indexPath) as! ConfigCellCelula
            
            let celula = celulaList[indexPath.item]
            cellB.configuraCelula(celula)
            return cellB
        } else {
            if collectionView == self.collectionReuniao {
                let cellA = collectionReuniao.dequeueReusableCell(withReuseIdentifier: "reuniaoCell", for: indexPath) as! ConfigCell
                        
                        let reuniao = reuniaoList[indexPath.item]
                        let id = reuniao.value(forKey: "id") as! String
                        self.participantesReuniao =  partObject.CarregaParticipantesReuniao(idReuniao: id, nomeCelula: "Celula Victor")
                        cellA.configuraReuniao(reuniao,  self.participantesReuniao )
                        
                        return cellA
            }else {
                let cellC = collectionParticipantes.dequeueReusableCell(withReuseIdentifier: "participantesCell", for: indexPath) as! ConfigCellParticipantes
                                   
                let participante = self.participantesList [indexPath.item]
                cellC.configuraParticipanted(participante)
                return cellC
            }
        
            
        
        }
    }
    

}


