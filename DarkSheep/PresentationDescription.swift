//
//  PresentationDescription.swift
//  
//
//  Created by Serg Kolodny on 10.05.2022.
//

import UIKit

class PresentationDescription {
    
    let presentationText = ["Цель игры","Состав игры","Подготовка к игре","Ход игры","Конец игры"]
       
    let descriptionText = [
       "Темная овечка - это веселая и быстрая игра с простыми правилами.Чтобы победить, первым избавься своих карт, составляя простые равенства с добавлением или вычитанием. Но не забывай использовать особые карты, чтобы помешать соперникам - подсунь им лису или медведя! А можешь рискнуть - собрать четыре темные овечки, чтобы одержать досрочную победу!",
        "Карточки с овцами - 60 шт\n\nТемная овечка - 6 шт\n\nМедведь - 4 шт\n\nСобака - 5 шт\n\nУлитка - 4 шт\n\nЛиса - 5 шт",
        "- Перемещайте колоду. Раздйте каждому игрокупо 7 карт взакрытую.\n\n- Оставшуюся колоду положите перед игроками рубашкой вверх.\n\n- Откройте верхнюю карту колоды и положите ее рубашкой вниз рядом с колодой,оброзовав новую стопку.Если на открытой карте не 1-10 овец - верните ее в колоду и откройте новую - пока не выпадет карта с изображением овец (но не темная овечка)",
         "Игроки ходят по очереди, по часовой стрелке.Выберите кто ходит первым с помощью жребия.\n\nВ свой ход игрок может:\n\n1.Положить одну или две карты с овцами на стопку 'загон'.\n2.Вместо карт с овцами игрок в свой ход может выложить одну из особых карт(кроме 'собаки').Особые карты выкладывают в отдельную стопку 'лес',рядом с 'загоном'.\n3.Если у игрока нет карт,которые он может выложить в свой ход,либо не хочет выкладывать их - он берет карту из колоды и пропускает ход.",
             "Есть 3 условия при которых игра заканчивается:\n\n-один из игроков избавился от своих карт\n-закончилась колода\n-один из игроков который собрал 4 'темные овечки'\n\nЕсть 3 исхода игры:\n\n-Если игра закончилась и игрок у которого меньше всего балов,побеждает\n-Если у каждого игрока больше либо равно 200 балов, проигрывают все\n-Если игра закончилась и у некоторых игроков одинаковое количество баллов по меньшей сумме, то обьявляется ничья между этими игроками"]

    let presentationImage = [UIImage(named: "countButton"),UIImage(named: "countButton"),UIImage(named: "countButton"),UIImage(named: "countButton"),UIImage(named: "countButton")]
    
}


