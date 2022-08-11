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