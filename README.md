# knigopoisk
pet ruby, RoR, TRB, GrapeApi, CanCanCan
Книгопоиск это сервис, где можно книгу добавить и оценку ей выставить, как на кинопоиске и это круто

| Метод | Путь | Описание | Auth |
|---|---|---|:---:|
| `POST` | `/api/v1/sessions/login` | Получить JWT токен | — |
| **Books** | | | |
| `GET` | `/api/v1/books` | Список книг | — |
| `GET` | `/api/v1/books/:id` | Одна книга | — |
| `POST` | `/api/v1/books` | Создать книгу | — |
| `PUT` | `/api/v1/books/:book_id` | Обновить книгу | — |
| `DELETE` | `/api/v1/books/:book_id` | Удалить книгу | — |
| **Authors** | | | |
| `GET` | `/api/v1/authors` | Список авторов | — |
| `GET` | `/api/v1/authors/:id` | Один автор | — |
| `POST` | `/api/v1/authors` | Создать автора | — |
| `PUT` | `/api/v1/authors/:id` | Обновить автора | — |
| `DELETE` | `/api/v1/authors/:id` | Удалить автора | — |
| **Genres** | | | |
| `GET` | `/api/v1/genres` | Список жанров | — |
| `GET` | `/api/v1/genres/:id` | Один жанр | — |
| `POST` | `/api/v1/genres` | Создать жанр | — |
| `PUT` | `/api/v1/genres/:id` | Обновить жанр | — |
| `DELETE` | `/api/v1/genres/:id` | Удалить жанр | — |
| **Ratings** | | | |
| `GET` | `/api/v1/ratings` | Список оценок | — |
| `POST` | `/api/v1/ratings` | Создать оценку | JWT |
| `PUT` | `/api/v1/ratings` | Обновить оценку | JWT |
| `DELETE` | `/api/v1/ratings` | Удалить оценку | JWT |
| **Bookshelves** | | | |
| `GET` | `/api/v1/bookshelves` | Список полок пользователя | JWT |
| `GET` | `/api/v1/bookshelves/:id` | Одна полка | JWT |
| `POST` | `/api/v1/bookshelves` | Создать полку | JWT |
| `PUT` | `/api/v1/bookshelves/:id` | Обновить полку | JWT |
| `DELETE` | `/api/v1/bookshelves/:id` | Удалить полку | JWT |
| `POST` | `/api/v1/bookshelves/:bookshelf_id/books` | Добавить книгу на полку | JWT |
| `DELETE` | `/api/v1/bookshelves/:bookshelf_id/books/:id` | Убрать книгу с полки | JWT |

> Замечание: в [ratings.rb:11](app/api/v1/ratings.rb) опечатка — `curent_user` вместо `current_user`, `POST /ratings` сломан.
