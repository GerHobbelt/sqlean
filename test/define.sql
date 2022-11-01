-- Copyright (c) 2022 Anton Zhiyanov, MIT License
-- https://github.com/nalgeon/sqlean

.load dist/define

select define('sumn', '?1 * (?1 + 1) / 2');
select '01', sumn(0) = 0;
select '02', sumn(1) = 1;
select '03', sumn(2) = 1 + 2;
select '04', sumn(3) = 1 + 2 + 3;
select '05', sumn(4) = 1 + 2 + 3 + 4;
select '06', sumn(5) = 1 + 2 + 3 + 4 + 5;

select define('subxy', '?1 - ?2');
select '11', subxy(5, 1) = 4;
select define('subyx', '?2 - ?1');
select '12', subyx(5, 1) = -4;
select define('subnm', ':n - :m');
select '13', subnm(5, 1) = 4;
select define('subxx', '? - ?');
select '14', subxx(5, 1) = 4;

select define('randint', ':a + abs(random()) % (:b - :a + 1)');
select '21', randint(10, 20) >= 10 and randint(10, 20) <= 20;
select '22', randint(10, 20) >= 10 and randint(10, 20) <= 20;
select '23', randint(10, 20) >= 10 and randint(10, 20) <= 20;
select '24', randint(10, 20) >= 10 and randint(10, 20) <= 20;
select '25', randint(10, 20) >= 10 and randint(10, 20) <= 20;

create virtual table strcut using define((
  select
    substr(:str, 1, instr(:str, :sep) - 1) as left,
    :sep as separator,
    substr(:str, instr(:str, :sep) + 1) as right
));

select '31', (left, right) = ('one', 'two') from strcut('one;two', ';');

select '41', (type, body) = ('scalar', ':n - :m') from sqlean_define where name = 'subnm';
select '42', type = 'table' from sqlean_define where name = 'strcut';
select '43', count(*) = 6 from sqlean_define where type = 'scalar';
select '44', count(*) = 1 from sqlean_define where type = 'table';
select '45', count(*) = 1 from sqlite_master where type = 'table' and name = 'strcut';
select '46', count(*) = 7 from sqlean_define;

select undefine('subnm');
select '51', count(*) = 0 from sqlean_define where name = 'subnm';
select '52', count(*) = 6 from sqlean_define;
select undefine('strcut');
select '53', count(*) = 0 from sqlean_define where name = 'strcut';
select '54', count(*) = 0 from sqlite_master where type = 'table' and name = 'strcut';
select '55', count(*) = 5 from sqlean_define;

select define_free();

select '61', eval('select 42') = '42';
select '62', eval('select 1, 2, 3') = '1 2 3';
select '63', eval('select 1, 2, 3', ', ') = '1, 2, 3';
select '64', eval('select abs(-42)') = '42';
select '65', eval('select 10 + 32') = '42';
select '66', eval('select ''hello''') = 'hello';
select '67', eval('select null') = '';
select '68', eval('select 1; select 2; select 3;') = '1 2 3';

select '71', eval('create table tmp(value int)') is null;
select '72', count(*) = 1 from sqlite_master where type = 'table' and name = 'tmp';
select '73', eval('insert into tmp(value) values (1), (2), (3)') is null;
select '74', count(*) = 3 from tmp;
select '75', eval('select value from tmp') = '1 2 3';
select '76', eval('drop table tmp') is null;
select '77', count(*) = 0 from sqlite_master where type = 'table' and name = 'tmp';
