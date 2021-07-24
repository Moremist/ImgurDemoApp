# ImgurForSpider

Тестовое задание. Выводит популярные мемы с сервиса Imgur, а также комментарии к ним.
---

### Models:
- CommentStruct - структура для парсинга комментариев
- GalleryStruct - структура для парсинга галлереи

### Controllers:
- MainViewController - контроллер отображения с коллекцией мемов
- DetailViewController - контроллер отображения с комментариями мема

### Helpers:
- API - класс ддя работы с сетью
- CustomLayout - кастомный лейаут для отображения коллекции на главном экране

### Cells:
- CustomTableViewCell
- CollectionViewCell

### API:
- https://api.imgur.com/

### Libraries:
- Kingfisher Swift - для удобного выгрузки изображений из сети и установки в ячейки коллекции (https://github.com/onevcat/Kingfisher)
