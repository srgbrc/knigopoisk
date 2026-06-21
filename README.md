# knigopoisk
pet ruby, RoR, TRB, GrapeApi, CanCanCan
Книгопоиск это сервис, где можно книгу добавить и оценку ей выставить, как на кинопоиске и это круто

Метод	Путь	Описание
GET	/api/v1/bookshelves	список полок текущего пользователя
GET	/api/v1/bookshelves/:id	одна полка
POST	/api/v1/bookshelves	создать полку
PUT	/api/v1/bookshelves/:id	обновить полку
DELETE	/api/v1/bookshelves/:id	удалить полку
POST	/api/v1/bookshelves/:bookshelf_id/books	добавить книгу (params: book_id)
DELETE	/api/v1/bookshelves/:bookshelf_id/books/:id	удалить книгу с полки
