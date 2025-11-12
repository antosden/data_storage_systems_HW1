# data_storage_systems_HW1
 Системы хранения и обработки данных - ДЗ1 - Науки о данных

# Реализация таблиц в PostgreSQL
1. Приведение исходных таблиц к от 1НФ к 3НФ    
 1.1. Приведение к 1НФ

   customer - находится в 1НФ: все атрибуты в таблице атомарные, все сохраняемые данные на пересечении столбцов и строк содержат только скалярные значения.

   transaction - не находится в 1НФ: есть одноимённые столбцы product_size с разным наполнением и типами данных, что нарушает критерий атомарности. Скорректируем столбцы следующим образом: product_scale и product_size
   
   <img width="769" height="415" alt="изображение" src="https://github.com/user-attachments/assets/5ec48fd7-4958-4092-bbf5-65001d757895" />   

 1.2. Приведение к 2НФ

  customer - находится в 2НФ: приведена к 1НФ, есть первичный ключ customer_id, от которого зависят все остальные поля
  
  transaction - не находится в 2НФ: приведена к 1НФ в шаге 1.1, есть первичный ключ transaction_id, однако есть поля, которые не зависят от него напрямую: product_size, standard_cost. Необходимо выделить отдельную таблицу product.
  Рассмотрим поля:
   - product_id
   - product_line
   - product_class
   - product_scale
   - product_size
   - standard_cost
  
  Были найдены записи product_id = 0, при котором поля brand, product_line, product_class, product_scale, standard_cost пусты, а у product_size 197 уникальных значения. Скорее всего это ошибочные данные, тк в остальных случаях все поля заполнены. Нормализация будет проведена без учёта данных 197 записей.

 <img width="1161" height="706" alt="изображение" src="https://github.com/user-attachments/assets/a4f8e9f9-3192-4cd3-aa0d-b080a96f1e2b" />

 Среди вышеперечисленных полей нет возможности выбрать первичный ключ, тк по всем ним присутствуют дубликаты. Поэтому выделим составной первичный ключ [product_id,	brand,	product_line,	product_class,	product_scale]

 <img width="1162" height="524" alt="изображение" src="https://github.com/user-attachments/assets/aeae6fce-60b7-4629-aef9-99fe74c054b6" />

 <img width="1032" height="645" alt="изображение" src="https://github.com/user-attachments/assets/73ab181a-fcf5-46cd-9700-45e04672f4c6" />



 1.3. Приведение к 3НФ:

  customer - не находится в 3НФ: приведена к 2НФ, однако присутствуют транзитивные зависимости:
  От поля product_id зависят
  
  
