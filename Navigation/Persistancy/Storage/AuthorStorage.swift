//
//  AuthorStorage.swift
//  Navigation
//
//  Created by user212151 on 2/1/22.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

struct AuthorStorage {
    
    static var authors = [
        Author(
            name: "Habr",
            descriptions: ["Крипто-ETF от Сбера, новый сервис для YouTube блогеров и другие тренды января","Цифровые отпечатки GPU позволяют отслеживать пользователей в Интернете", "Tesla добавила функцию, которая не даёт слишком часто настраивать сиденья", "ИТ в тени: почему фрилансеры в России не спешат становиться ИП и самозанятыми"],
            images: [UIImage(named: "habrcrypto"), UIImage(named: "habrfingers"), UIImage(named: "habrtesla"), UIImage(named: "habrfreelance")],
            urlStrings: ["https://habr.com/ru/post/649067/", "https://habr.com/ru/company/cloud4y/news/t/649029/", "https://habr.com/ru/news/t/649049/", "https://habr.com/ru/post/649057/"]
        )
    ]
}
