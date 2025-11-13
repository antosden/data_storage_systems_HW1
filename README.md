# data_storage_systems_HW1
 Системы хранения и обработки данных - ДЗ1 - Науки о данных

# Реализация таблиц в PostgreSQL
1. Приведение исходных таблиц к от 1НФ к 3НФ    
 1.1. Приведение к 1НФ

   customer - находится в 1НФ: все атрибуты в таблице атомарные, все сохраняемые данные на пересечении столбцов и строк содержат только скалярные значения.

   transaction - не находится в 1НФ: есть одноимённые столбцы product_size с разным наполнением и типами данных, что нарушает критерий атомарности. Скорректируем столбцы следующим образом: product_scale и product_size
   
   <img width="769" height="415" alt="изображение" src="https://github.com/user-attachments/assets/5ec48fd7-4958-4092-bbf5-65001d757895" />   

   Таблицы в 1НФ в dbdiagram:

   <img width="634" height="608" alt="изображение" src="https://github.com/user-attachments/assets/34fa5e29-2dd3-4899-8d94-6cdd93649f6e" />


 1.2. Приведение к 2НФ

  customer - находится в 2НФ: приведена к 1НФ, есть первичный ключ customer_id, от которого зависят все остальные поля
  
  transaction - не находится в 2НФ: приведена к 1НФ в шаге 1.1, есть первичный ключ transaction_id, однако есть поля, которые не зависят от него напрямую: product_size, standard_cost. Необходимо выделить отдельную таблицу product.
  Рассмотрим поля:
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

 Необходимо выбрать составной первичный ключ, то есть такой набор полей, которому будет соответствовать один результат

 <img width="1162" height="524" alt="изображение" src="https://github.com/user-attachments/assets/aeae6fce-60b7-4629-aef9-99fe74c054b6" />

 <img width="1032" height="645" alt="изображение" src="https://github.com/user-attachments/assets/73ab181a-fcf5-46cd-9700-45e04672f4c6" />

 При анализе полей было выявлено, что уникальное значение поля будет выдавать комбинация [product_id, product_size]. Проверка: в with отобраны поля для декомпозиции в таблицу product, сгруппированы по предполагаемому составному первичному ключу [product_id, product_size], и посчитано количество строк count. Результат отсортирован по count по убыванию
 
 <img width="499" height="764" alt="изображение" src="https://github.com/user-attachments/assets/05fadf06-096f-45f6-95fe-38bcaa3bb196" />

 Для сравнения: результат при [product_id, product_class]

 <img width="466" height="578" alt="изображение" src="https://github.com/user-attachments/assets/0e43d44b-5c3e-4786-abfa-34bd2888ec64" />

 Результат декомпозиции transaction в dbdiagram:

 <img width="694" height="431" alt="изображение" src="https://github.com/user-attachments/assets/3e8ddf43-c6a3-476d-9a49-6349f679a61b" />



 1.3. Приведение к 3НФ:

  customer - не находится в 3НФ: приведена к 2НФ, однако присутствуют транзитивные зависимости:
  От поля product_id зависят
  
  
