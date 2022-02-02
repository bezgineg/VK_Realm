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
            descriptions: ["Крипто-ETF от Сбера, новый сервис для YouTube блогеров и другие тренды января","Цифровые отпечатки GPU позволяют отслеживать пользователей в Интернете", "Tesla добавила функцию, которая не даёт слишком часто настраивать сиденья", "ИТ в тени: почему фрилансеры в России не спешат становиться ИП и самозанятыми", "Как я запускал Spring Cloud", "Меши с Python & Blender: икосферы"],
            images: [UIImage(named: "habrcrypto"), UIImage(named: "habrfingers"), UIImage(named: "habrtesla"), UIImage(named: "habrfreelance"), UIImage(named: "habrcloud"), UIImage(named: "habrpython")],
            urlStrings: ["https://habr.com/ru/post/649067/", "https://habr.com/ru/company/cloud4y/news/t/649029/", "https://habr.com/ru/news/t/649049/", "https://habr.com/ru/post/649057/", "https://habr.com/ru/post/649131/", "https://habr.com/ru/post/647193/"]
        ),
        Author(
            name: "Tinkoff",
            descriptions: ["Инвестидея: TD SYNNEX, потому что теперь побольше","Как я ушел с госслужбы и начал строить карьеру в банке", "7 неочевидных плюсов ОСАГО от Тинькофф", "Как я отдохнул в Эйлате за 15 700 ₽ в 2019 году", "«Не хуже, чем у Абрамовича»: 8 историй о бизнесе в 2021 году", "Новые ценные бумаги на Мосбирже за январь 2022"],
            images: [UIImage(named: "tinkoff1"), UIImage(named: "tinkoff2"), UIImage(named: "tinkoff3"), UIImage(named: "tinkoff4"), UIImage(named: "tinkoff5"), UIImage(named: "tinkoff6")],
            urlStrings: ["https://journal.tinkoff.ru/news/idea-snx/", "https://journal.tinkoff.ru/career-gosuchrezhdeniye-bank/", "https://journal.tinkoff.ru/short/osago-cashback/", "https://journal.tinkoff.ru/ejlat-2019-trip/", "https://journal.tinkoff.ru/istorii-o-biznese/", "https://journal.tinkoff.ru/news/invest-digest-01-2022/"]
        ),
        Author(
            name: "Igromania",
            descriptions: ["Средний балл Dying Light 2 на Metacritic не дотянул и до 8 из 10","Свежий патч для League of Legends ослабил Зери и обновил Ари", "PGL проведёт первый мейджор 2022 года по CS:GO в Бельгии", "Мейсона Гринвуда удалили из FIFA 22 после обвинений в изнасиловании", "«В The Witcher: Monster Slayer появился новый монстр — Калидус", "«Веном 2» и «Дюна» — самые просматриваемые фильмы на «Кинопоиске» в январе"],
            images: [UIImage(named: "igromania1"), UIImage(named: "igromania2"), UIImage(named: "igromania3"), UIImage(named: "igromania4"), UIImage(named: "igromania5"), UIImage(named: "igromania6")],
            urlStrings: ["https://www.igromania.ru/news/113193/Sredniy_ball_Dying_Light_2_na_Metacritic_ne_dotyanul_i_do_8_iz_10.html", "https://www.igromania.ru/news/113194/Svezhiy_patch_dlya_League_of_Legends_oslabil_Zeri_i_obnovil_Ari.html", "https://www.igromania.ru/news/113192/PGL_provedyot_pervyy_meydzhor_2022_goda_po_CS_GO_v_Belgii.html", "https://www.igromania.ru/news/113190/Meysona_Grinvuda_udalili_iz_FIFA_22_posle_obvineniy_v_iznasilovanii.html", "https://www.igromania.ru/news/113187/V_The_Witcher_Monster_Slayer_poyavilsya_novyy_monstr-Kalidus.html", "https://www.igromania.ru/news/113189/Venom_2_i_Dyuna-samye_prosmatrivaemye_filmy_na_Kinopoiske_v_yanvare.html"]
        )
    ]
}
