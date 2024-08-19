//
//  mock.swift
//  friend_diet
//
//  Created by Lucas on 25/03/24.
//

import Foundation

struct ListItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
}

let MockData: [ListItem] = [
    ListItem(title: "Dicas de dieta", subtitle: "a dica é...."),
    ListItem(title: "Resumo refeições", subtitle: "as suas refei...."),
    ListItem(title: "Resumo exercício", subtitle: "os seus exerci..."),
    // Adicione mais itens conforme necessário
]
