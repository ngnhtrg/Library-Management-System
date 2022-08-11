# База данных для библиотеки

***Цель работы:*** получение практических навыков работы с промышленными СУБД, проектирование БД (концептуальное, логическое, физическое), создание хранимых процедур, представлений, триггеров, индексов.

## Постановка:

### 1. Выбрать предметную область, выделить в ней 4-6 сущностей:
База данных «Библиотека», используемая для автоматизации библиотеки.

**Сущности:**
- Books - Таблица книг
- Authors - Таблица авторов
- Readers - Читатели
- Issues - Выдачи
- Fines - Штрафы
- Publishers - Издательства
### 2. Спроектировать базу данных:
**1. Концептуальная модель:** все сущности из п.1 с указанием связей в нотации «воронья лапка».
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/conceptual.png)

**2. Логическая модель:** описание таблиц и их атрибутивного состава, а также указание связей в нотации «воронья лапка». БД должна находиться во 2НФ или в 3НФ (аргументировать свой выбор). После нормализации ~ 8-10 сущностей. Для описания использовать ER-диаграмму. Хотя бы одну таблицу необходимо сделать версионной. На выбор представляются SCD типа 2 и 4.
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/logic.png)
Все таблицы находятся в форме 3НФ, чтобы уменьшить дублирование данных, предотвратить аномалии данных, обеспечить ссылочную целостность и упростить управление данными. Таблица Issues находится в SCD типа 2.

**3. Физическая модель:** описание хранения таблиц в СУБД.  
**books**
| Название             | Описание             | Тип данных           | Ограничение          |
| :------------------- | :------------------- | :------------------- | :------------------- |
| book_id              | Идентификатор книги  | INTEGER              | PRIMARY KEY          |
| book_title           | Название книги       | VARCHAR(128)         | NOT NULL             |
| publisher_id         | Идентификатор издательства | INTEGER        | FOREIGN KEY          |
| edition_num          | Редакция             | INTEGER              | NOT NULL             |
| language_txt         | Язык                 | VARCHAR(128)         | NOT NULL             |
| copies_cnt           | Количество копий     | INTEGER              | NOT NULL             |
| remain_cnt           | Количество оставшихся книг | INTEGER        | NOT NULL             |

**readers**
| Название             | Описание             | Тип данных           | Ограничение          |
| :------------------- | :------------------- | :------------------- | :------------------- |
| reader_id            | Идентификатор        | INTEGER              | PRIMARY KEY          |
| reader_nm            | Имя читатели         | VARCHAR(128)         | NOT NULL             |
| phone_no             | Номер телефона       | VARCHAR(128)         | NOT NULL             |
| address_txt          | Адресс               | VARCHAR(128)         | NOT NULL             |

**issues**
| Название             | Описание             | Тип данных           | Ограничение          |
| :------------------- | :------------------- | :------------------- | :------------------- |
| issue_id             | Идентификатор        | INTEGER              | PRIMARY KEY          |
| book_id              | Идентификатор        | INTEGER              | FOREIGN KEY          |
| reader_id            | Идентификатор        | INTEGER              | FOREIGN KEY          |
| borrowed_from_dt     | Дата получения       | DATE                 | NOT NULL             |
| borrowed_to_dt       | Дата сдачи           | DATE                 | NOT NULL             |
| actual_return_dt     | Дата возрата         | DATE                 | NOT NULL             |


**fines**
| Название             | Описание             | Тип данных           | Ограничение          |
| :------------------- | :------------------- | :------------------- | :------------------- |
| fine_id              | Идентификатор        | INTEGER              | PRIMARY KEY          |
| issue_id             | Идентификатор        | INTEGER              | FOREIGN KEY          |
| fine_dt              | Дата штрафа          | DATE                 | NOT NULL             |
| fine_amt             | Сумма штрафа         | INTEGER              | NOT NULL             |

**publishers**
| Название             | Описание             | Тип данных           | Ограничение          |
| :------------------- | :------------------- | :------------------- | :------------------- |
| publisher_id         | Идентификатор        | INTEGER              | PRIMARY KEY          |
| publisher_nm         | Название издательство| VARCHAR(128)         | NOT NULL             |
| phone_no             | Номер телефона       | VARCHAR(128)         | NOT NULL             |
| address_txt          | Адресс               | VARCHAR(128)         | NOT NULL             |

**authors**
| Название             | Описание             | Тип данных           | Ограничение          |
| :------------------- | :------------------- | :------------------- | :------------------- |
| author_id            | Идентификатор        | INTEGER              | PRIMARY KEY          |
| author_nm            | Имя автора           | VARCHAR(128)         | NOT NULL             |

**book_author**
| Название             | Описание             | Тип данных           | Ограничение          |
| :------------------- | :------------------- | :------------------- | :------------------- |
| book_id              | Идентификатор книги  | INTEGER              | FOREIGN KEY          |
| author_id            | Идентификатор автора | INTEGER              | FOREIGN KEY          |

**book_category**
| Название             | Описание             | Тип данных           | Ограничение          |
| :------------------- | :------------------- | :------------------- | :------------------- |
| book_id              | Идентификатор книги  | INTEGER              | FOREIGN KEY          |
| category_id          | Идентификатор категории | INTEGER           | FOREIGN KEY          |

### 3. Практическая часть:

Код моего проекта разделен на 8 файлов:

- **ddl.sql** - создание таблицы
- **insert.sql** - вставка таблицы
- **crud.sql** - несложные crud запросы
- **queries.sql** - сложные и интересные запросы к базу данных
- **index.sql** - индексы для таблиц
- **view.sql** - рабочие представления 
- **procedure.sql** - хранимые процедуры
- **trigger.sql** - триггеры

Я реализовал проект в порядке следующих шагов:  
**1. Создать схему:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/1-1.png)  
**Результат:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/1-2.png)  
**2. Создать таблицы соответственно физической модели:**
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/2-1.png)  
**Результат:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/2-2.png)  
*Аналогично для остальных таблиц.*  
**3. Наполнить созданную базу данными, \~10 записей в каждой таблице:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/3-1.png)  
**Результат:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/3-2.png)  
**4. Написать несколько INSERT, SELECT, UPDATE, DELETE запросов:**  
**Запрос 1:** Вставка в таблицу issues.  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/4-1-1.png)  
**Результат:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/4-1-2.png)  
**Запрос 2:** Вставка в таблицу fines.  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/4-2-1.png)  
**Результат:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/4-2-2.png)  
**Запрос 3:** Вставка в таблицу categories.  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/4-3-1.png)  
**Результат:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/4-3-2.png)  
**Запрос 4:** Получить таблиц выдач, в которых книга вернулась.  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/4-4-1.png)  
**Результат:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/4-4-2.png)  
**Запрос 5:** Автор и свои книги.  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/4-5-1.png)  
**Результат:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/4-5-2.png)  **Запрос 6, 7, 8:** UPDATE.  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/4-678.png)  
**Запрос 9, 10:** UPDATE.  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/4-910.png)  
**5. Написать осмысленные SELECT-запросы:**  
**Запрос 1:** Найти всех издателей, у которых есть более 1 книги в базе данных.  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/5-1-1.png)  
**Результат:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/5-1-2.png)  
**Запрос 2:** Использовать функцию rank(), чтобы присвоить каждой книге рейтинг по количеству копий.  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/5-2-1.png)  
**Результат:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/5-2-2.png)  
**Запрос 3:** Найти количество взятых книг по категориям.  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/5-3-1.png)  
**Результат:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/5-3-2.png)  
**Запрос 4:** Рассчитать общую сумму штрафа для каждого читателя.  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/5-4-1.png)  
**Результат:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/5-4-2.png)  
**Запрос 5:** Использовать функцию dense_rank(), чтобы присвоить ранг каждому издателю по количеству его книг в базе данных.  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/5-5-1.png)  
**Результат:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/5-5-2.png)  
**Запрос 5:** Ранжирование любимой категории для каждого читателя.  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/5-6-1.png)  
**Результат:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/5-6-2.png)  
**6. Создать индексы для таблиц:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/6.png)  
Так как book_id связана со многими сущностями, то для ускорения взаимодействия, Я выбрал это поле.  
**7. Создать представления:**  
**Представление 1 - v_reader:** получается скрытием номера телефона читателей.  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/7-1-1.png)  
**Результат:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/7-1-2.png)  
**Представление 2 - v_publisher:**  получается скрытием номера телефона издателей.  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/7-2-1.png)  
**Результат:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/7-2-2.png)  
**Представление 3 - v_reader_issue:** Список всех выдач каждого читателя.  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/7-3-1.png)  
**Результат:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/7-3-2.png)  
**Представление 4 - v_fines_info:** Таблица подробной информации о штрафах.
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/7-4-1.png)  
**Результат:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/7-4-2.png)  
**Представление 5 - v_publisher_cnt_books:** Статистика количества книг по издательствам.  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/7-5-1.png)  
**Результат:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/7-5-2.png)  
**Представление 6 - v_books_info:** Таблица подробной информации о книгах.
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/7-6-1.png)  
**Результат:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/7-6-2.png)  
**8. Создать хранимые процедуры:**  
**Процедура 1:** Вставка данных в таблицу readers.  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/8-1-1.png)  
**Вызов процедуры:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/8-1-2.png)  
**Проверка:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/8-1-3.png)  
**Результат:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/8-1-4.png)  
**Процедура 2:** Уведомляет сообщение на экране.  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/8-2-1.png)  
**Вызов процедуры:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/8-2-2.png)  
**Результат:**  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/8-1-3.png)  
**9. Создать триггеры:**  
**Триггер 1:**  
Создать функцию update_insert_issue() для обновления количества оставшихся книг в таблице books.  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/9-1-1.png)  
Создать триггер для вызова функции update_insert_issue() при изменении таблицы issues.  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/9-1-2.png)  
**Проверка:**  
Таблица *books* изначально:  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/9-1-3.png)  
Вставка в таблицу *issues*:  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/9-1-4.png)  
Таблица *books* после вставки:  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/9-1-5.png)  
**Вывод:** Количество оставшихся книг *book_id = 9* изменился - на единицу меньше, значит триггер сработал.  
**Триггер 2:**  
Создать функцию *update_return_book()* для вставки данных в таблицу *fines*.  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/9-2-1.png)  
Создать триггер для выполнения функции *update_return_book()* после обновления или вставки в таблицу *issues*:  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/9-2-2.png)  
Создать триггер для выполнения функции *update_return_book()* перед удалением данных из таблицы *issues*.  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/9-2-3.png)  
**Проверка:**  
Таблица *fines* перед обновлением:  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/9-2-4.png)  
Обновление в таблице *issues*:  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/9-2-5.png)  
Таблица *fines* после обновления: 
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/9-2-6.png)  
**Вывод:** Новая запись была добавлена в таблицу fines, значит триггер сработал.  
Удаление записи из таблицы *issues*:  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/9-2-7.png)  
Таблица *fines* после удаления:  
![](https://github.com/ngnhtrg/Library-Management-System/blob/master/pics/9-2-8.png)  
**Вывод:** Лишняя запись была удалена из таблицы fines, значит триггер сработал.  


## Окончательные выводы:
Нормальные формы и SCD действительно улучшает производительность и  удобства управления данными. Диаграмма ER хорошо иллюстрирует логическую структуру баз данных. При выполнении проекта возникли проблемы со сложности взаимосвязи между таблицами. Допустим, при изменении одной записи нужно было обновлять другие таблицы тоже. Стоит отметить, что база данных для библиотеки имеет сложную структуру. Но самое главное, Я получил много удовольствий, и много полезных знаний.

## Ресурсы:
- https://app.diagrams.net/ - сайт для рисования таблиц
- https://www.postgresql.org/docs/ - Документация PostgreSQL
- https://www.postgresqltutorial.com/ - PostgreSQL Tutorial
- [Лекции по курсу "База данных" МФТИ](https://drive.google.com/drive/folders/174_vQYw2NZNfLc8f4flr-kc3T5EMyQlc)


