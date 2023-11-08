use colegio2807;

DELIMITER $$
drop procedure if exists probarLoop $$
create procedure probarLoop(in limite integer)
label:BEGIN
declare val int;
declare result text;
set val = 1;
set result = '';
loop_label: LOOP
if val  > limite then
leave loop_label;
end if;
set result = concat(result,val,',');
set val = val + 1;
iterate loop_label;
end loop;
select result;

end $$
delimiter ;