/*LAB Luis*/
use sakila; 

/*  Q1  */

DROP PROCEDURE IF EXISTS rent_action;
delimiter //
create procedure rent_action ()
begin
  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = "Action"
  group by first_name, last_name, email;
end;
//
delimiter ;

call rent_action();
-- Output looks nice

/*  Q2  */
DROP PROCEDURE IF EXISTS rent_category;
delimiter //
create procedure rent_category (in categorypar varchar(15))
begin
  select first_name, last_name, email
  from customer
  join rental on customer.customer_id = rental.customer_id
  join inventory on rental.inventory_id = inventory.inventory_id
  join film on film.film_id = inventory.film_id
  join film_category on film_category.film_id = film.film_id
  join category on category.category_id = film_category.category_id
  where category.name = categorypar
  group by first_name, last_name, email;
end;
//
delimiter ;
-- Copy the category you want to check action, animation, children, classics, music
call rent_category("animation");
-- Automatic output generated 

/*  Q3  */
#Building the query before the store procedure. 
select category.name, count(*) as counter from film 
join film_category  on film_category.film_id = film.film_id
join category on category.category_id = film_category.category_id
group by category.name
having counter >=60 ;

#Now we create the store procedure with the validated query
DROP PROCEDURE IF EXISTS releases_category;
delimiter //
create procedure releases_category (in numberpar int)
begin
select category.name, count(*) as counter from film 
join film_category  on film_category.film_id = film.film_id
join category on category.category_id = film_category.category_id
group by category.name
having counter >=numberpar ;
end;
//
delimiter ;
-- please enter the minimum of releases per category
call releases_category(50);
