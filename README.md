# VK_Realm

Учебный демо проект/песочница для ознакомления с различными инструментами

*  Работа с основными элементами UI
*  Realm, CoreData, Keychain, NotificationCenter
*  Работа с сетью через URLSession
*  Работа с GCD
*  Coordinators pattern, MVC/MVVM
*  AutoLayout
*  Swift Package Manager
*  Localization
*  Light/Dark mode
*  FaceID/TouchID
*  Notifications
*  Drag/Drop

# Основные экраны и логика
### Экран ленты
![Simulator Screen Shot - iPhone 11 Pro - 2022-02-03 at 20 00 03](https://user-images.githubusercontent.com/76397462/152393707-d68b6925-3804-4332-905b-0108880fd641.png)

###### Основная логика
Нажатие на кнопку + открывает popup с возможностью скрыть пост из ленты или добавить пост в любимые. Добавление происходит через CoreData.
Тап на ячейку ведет на экран других постов данного автора.

### Экран постов автора 
![Simulator Screen Shot - iPhone 11 Pro - 2022-02-03 at 20 00 32](https://user-images.githubusercontent.com/76397462/152394220-9b549c2e-60ae-41a7-825d-818eddae4566.png)

###### Основная логика
Нажатие на ячейку ведет на пост в интернет по url адресу.
Нажатие на кнопку Поделиться открывает экран с возможностью поделиться ссылкой и описание поста

### Экран логина 
![Simulator Screen Shot - iPhone 11 Pro - 2022-02-03 at 20 00 54](https://user-images.githubusercontent.com/76397462/152394647-c82f363e-d5d9-494c-9bb6-be1fbb036959.png)

###### Основная логика
Чтобы залогиниться нужно заполнить поля с логином и паролем. При входе в REALM данные о входе будут сохранены. В следующий раз, если не разлогиниться, сразу появится экран профиля
Имеется возможность зайти в приложение по FaceID или TouchID

### Экран профиля 
![Simulator Screen Shot - iPhone 11 Pro - 2022-02-03 at 20 01 44](https://user-images.githubusercontent.com/76397462/152395393-2f39f2fb-2cfb-4ebc-b310-ecde84702cf5.png)

###### Основная логика
Экран содержит данные о пользователе, фото пользователя и его посты
Можно изменить статус пользователя. Нажатие на аватарку выводит ее на передний план
Тап по ячейке с фото ведет на экран фотографий
Пост можно добавить в любимые по двойному тапу. Добавляется с помощью CoreData

### Экран фотографий
![Simulator Screen Shot - iPhone 11 Pro - 2022-02-03 at 20 01 53](https://user-images.githubusercontent.com/76397462/152395946-5696303d-326e-44cd-b17b-cfa2eb35a5f5.png)

###### Основная логика
Экран содержит галерею фотографий. Загружаются из интернета

### Экран любимых постов
![Simulator Screen Shot - iPhone 11 Pro - 2022-02-03 at 20 02 19](https://user-images.githubusercontent.com/76397462/152396129-7f086504-8c14-4b31-b88e-736a1abaeb82.png)

###### Основная логика
Экран с любимыми постами. Загружются из CoreData
Можно отфильтровать по имени автора. Фильтр можно сбросить
По свайпу на ячейку можно удалить пост из любимых
