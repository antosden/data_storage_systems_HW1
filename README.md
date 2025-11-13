# data_storage_systems_HW1
 Системы хранения и обработки данных - ДЗ1 - Науки о данных

# Реализация таблиц в PostgreSQL
1. Продумать структуру базы данных и отрисовать в редакторе.

  Изначальная структура таблиц представлена следующим образом:

  <img width="620" height="543" alt="изображение" src="https://github.com/user-attachments/assets/0b338e6e-114e-4887-b577-a155f16e2a91" />

  По ключам transaction.customer_id и customer.customer_id можно установить связь соответственно N - 1: у одного клиента может быть множество заказов.
  Типы данных и критерий not null были проставлены в соответствии с наполнением таблиц в исходном файле.

  Структура БД после приведения исходных таблиц к 3НФ (подробнее в шаге 2): 

  <img width="685" height="283" alt="изображение" src="https://github.com/user-attachments/assets/7bd24d6d-d1ae-439b-825f-fcd5f882d079" />

   
2. Приведение исходных таблиц к от 1НФ к 3НФ    
 2.1. Приведение к 1НФ

   customer - находится в 1НФ: все атрибуты в таблице атомарные, все сохраняемые данные на пересечении столбцов и строк содержат только скалярные значения.

   transaction - не находится в 1НФ: есть одноимённые столбцы product_size с разным наполнением и типами данных, что нарушает критерий атомарности. Скорректируем столбцы следующим образом: product_scale и product_size
   
   <img width="769" height="415" alt="изображение" src="https://github.com/user-attachments/assets/5ec48fd7-4958-4092-bbf5-65001d757895" />   

   Таблицы в 1НФ в dbdiagram:

   <img width="634" height="608" alt="изображение" src="https://github.com/user-attachments/assets/34fa5e29-2dd3-4899-8d94-6cdd93649f6e" />


 2.2. Приведение к 2НФ

  customer - находится в 2НФ: приведена к 1НФ, есть первичный ключ customer_id, от которого зависят все остальные поля
  
  transaction - не находится в 2НФ: приведена к 1НФ в шаге 2.1, есть первичный ключ transaction_id, однако есть поля, которые не зависят от него напрямую.
  Рассмотрим поля, которые можно вынести в таблицу product:
   - product_id
   - brand
   - product_line
   - product_class
   - product_scale
   - product_size
   - standard_cost
  
  Среди вышеперечисленных полей нет возможности выбрать первичный ключ, тк по всем ним присутствуют дубликаты. 
  Причем были найдены записи product_id = 0, при котором поля brand, product_line, product_class, product_scale, standard_cost пусты, а у product_size 197 уникальных значения. 
 <img width="1161" height="706" alt="изображение" src="https://github.com/user-attachments/assets/a4f8e9f9-3192-4cd3-aa0d-b080a96f1e2b" />

 Поэтому выбираем составной первичный ключ, то есть такой набор полей, которому будет соответствовать один результат

 <img width="1162" height="524" alt="изображение" src="https://github.com/user-attachments/assets/aeae6fce-60b7-4629-aef9-99fe74c054b6" />

 <img width="1032" height="645" alt="изображение" src="https://github.com/user-attachments/assets/73ab181a-fcf5-46cd-9700-45e04672f4c6" />

 При анализе полей было выявлено, что уникальное значение поля будет выдавать комбинация [product_id, product_size]. Проверка: в with отобраны поля для декомпозиции в таблицу product, сгруппированы по предполагаемому составному первичному ключу [product_id, product_size], и посчитано количество строк count. Результат отсортирован по count по убыванию
 
 <img width="499" height="764" alt="изображение" src="https://github.com/user-attachments/assets/05fadf06-096f-45f6-95fe-38bcaa3bb196" />

 Для сравнения: результат при [product_id, product_class]

 <img width="466" height="578" alt="изображение" src="https://github.com/user-attachments/assets/0e43d44b-5c3e-4786-abfa-34bd2888ec64" />

 Результат декомпозиции в dbdiagram. Таблицы приведена к 2НФ:

 <img width="1041" height="659" alt="изображение" src="https://github.com/user-attachments/assets/6f86d521-cb76-4855-918c-4fb895618b50" />



 2.3. Приведение к 3НФ:

  customer - не находится в 3НФ: приведена к 2НФ, однако присутствуют транзитивные зависимости:
  
  Поля адреса: customer_id -> address -> postcode -> state -> country - вынесем в таблицу address
  Поля работы: customer_id -> job_title -> job_industry_category - вынесем в таблицу job

  transaction, product - находится в 3НФ: приведена к 2НФ в шаге 2.2., отсутствуют транзитивные зависимости

  Итоговая структура БД:

  <img width="685" height="283" alt="изображение" src="https://github.com/user-attachments/assets/7bd24d6d-d1ae-439b-825f-fcd5f882d079" />


 Обоснование отношений между таблицами (установлены согласно исходным данным):
 - product.[product_id, product_size] - transaction.[product_id, product_size] связь 1 - N: в рамках одной транзации может быть только один продукт. А продукт может быть во множестве транзакций.
 - transaction.customer_id - customer.customer_id связь N - 1: в рамках одной транзакции может быть один клиент. А у клиента может быть множество транзакций
 - customer.address_id - address.address_id связь N - 1: у клиента может быть только один адрес, в то время как по одному адресу может быть зарегистрировано множество клиентов
 - customer.job_id = job.job_id связь N - 1: у клиента может быть только одна должность, в то время как одна должность может быть у множества клиентов

  
  
  
