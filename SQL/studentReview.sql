/**************SQL语句查询复习*************/

/******* 单关系查询 *******/
/*找出所有教师所在的系名*/
select dept_name 
from instructor;

/*找出所有在Computer Science系并且工资超过70000美元的教师的姓名*/
select name
from instructor 
where dept_name = 'Comp. Sci.' and salary > 70000;

/************ 多关系查询 ****************/
/*找出所有教师的姓名，以及他们所在系的名称和系所在的建筑*/
select name, instructor.dept_name, building    /*这里的instructor是必须的*/
from instructor, department
where instructor.dept_name = department.dept_name;
/*理解：from -> where -> select, from 的操作=笛卡尔积*/

/*笛卡尔积:列出所有的匹配情况*/
select *
from instructor, department;

/*查询所有教师的id和姓名以及课程标识*/
select instructor.id,name,course_id  /*当属性只在一个表中出现时，可以不写前缀，否则，需要前缀标识*/
from instructor, teaches
where instructor.id = teaches.id;
/*只输出了教授课程的老师 —— 解决方法：外连接*/

/*找出Computer Science系的教师名和课程标识*/
select name, course_id
from instructor, teaches
where instructor.id = teaches.id and dept_name = 'Comp. Sci.';

/************ 自然链接 **************/
/*所有相同属性上的值都保证要相等*/
/*只考虑两个关系模式中出现的属性在取值上相等的元组对-》在共同属性上取值相同*/
/*对于大学中所有讲授课程的老师，找出他们的姓名以及所讲述课程标识*/
select name,course_id
from instructor natural join teaches;/*ID是共同属性*/

/*！！！！！列出教师的名字以及他们所讲授课程的名称*/
select name,title
from instructor natural join teaches natural join course;/*除了course_id相同，dept_name也是一个共同属性*/

select name,title 
from instructor natural join teaches, course
where teaches.course_id = course.course_id; /*正确*/

/*构造自然连接:使用join using()指定在哪些列上相等*/
select name,title
from (instructor natural join teaches) join course using (course_id); /*使用join using*/

/*更名运算 as*/
/*对于大学中所有讲授课程的老师，找出他们的姓名以及所讲述课程标识*/
select T.name, S.course_id
from instructor as T , teaches as S
where T.ID = S.ID;

/*自己对自己的笛卡尔积*/
/*找出满足下面条件的所有教师的姓名，他们的工资至少比Biology系某一个教师的工资要高*/
select distinct name /*自己与自己之间的比较*/
from instructor as T， instructor as S  /*别名机制*/
where T.salary > S.salary and S.dept_name = 'Biology';   /*存在大于即可*/

/*字符串运算*/
/*函数：upper(s) lower(s) trim(s) :去空格
模式匹配：like
%:匹配任意字符
_:匹配任意一个字符
\:转移字符 like 'ab \% cd%' escape '\'
*/

/*找出所在建筑名称中包含字串'Watson'的所有系名*/
select dept_name
from department
where building like '% Watson %';

/*排列元组显示次序 order by 默认升序*/
/*desc 降序
asc 升序
*/
select *
from instructor 
order by salary desc, name asc;

/*between & not nbetween*/
/*找出工资在90000和100000之间的教师的姓名*/
select name
from instructor 
where salary between 90000 and 100000;

/*查询Biology系教授了课程的所有教师的的姓名和他们所讲授的课程标识*/
select name,course_id
from instructor, teaches
where dept_name = 'Biology' and instructor.id = teaches.id;
/*可使用元组形式*/
select name,course_id
from instructor, teaches
where (instructor.id, dept_name) = (teaches.id, 'Biology');

/*集合运算
union ：并
intersect ： 交
except ： 差
*/
/*在2009年秋季学期开设的所有课程*/
select course_id
from section
where year = '2009' and semester = 'Fall';

/*在2010年春季学期开设的所有课程*/
select course_id
from section
where year = '2010' and semester = 'Spring';

/*union:在2009年秋季开课或者在2010年春季开课 或者两个学期都开课的所有课程*/
/*自动去重*/
(select course_id
from section
where year = '2009' and semester = 'Fall')
union   /*union all 保留重复*/
(select course_id
from section
where year = '2010' and semester = 'Spring');

/*intersect:同时开课*/
/*自动去重*/
(select course_id
from section
where year = '2009' and semester = 'Fall')
intersect /*自动去重 intersect all*/
(select course_id
from section
where year = '2010' and semester = 'Spring');

/*except:在2009年秋季开课但不在在2010年春季开课*/
(select course_id
from section
where year = '2009' and semester = 'Fall')
minus   /*oracle: except  /*自动去重 except all*/
(select course_id
from section
where year = '2010' and semester = 'Spring');

/*测试空值*/
/*unknown*/
select name 
from instructor
where salary is /*not*/ null;

/*聚集函数
avg() :数字集
min()
max()
sum() ：数字集
count()
*/

/*找出Computer Science系教师的平均工资*/
select avg(salary) as avg_salary/*rename*/
from instructor
where dept_name = 'Comp. Sci.';

/*找出在2010年春季学期教授一门课程的教师的总数*/
select count(distinct id) /*去重* all 默认保留重复/
from teaches
where year = '2010' and semester = 'Spring';

/*计算元组数*/
select count(*) /*不可使用discinct*/
from instructor;

/*分组聚集*/
/*group by:一组元组集上聚集*/
/*找出每个系的平均工资*/
select dept_name, avg(salary) as avg_salary
from instructor
group by (dept_name);

/*!!!!!找出每个系在2010年春季学期讲授一门课程的教师人数*/
select dept_name, count(distinct id) as instr_count   /*distinct*/
from instructor natural join teaches /*找出老师教课的信息*/
where year = '2010' and semester = 'Spring'
group by (dept_name);
/*！！！！注意：任何没有出现的group by中的属性只能出现在聚集函数的内部*/
/*error*/
select dept_name, id, avg(salary)
from instructor
group by dept_name/*,id*/;
/*原因：在一个分组上用不同的id，但只能输出一个id，无法确认输出哪个*/

/*having子句——对分组限定条件*/
/*找出教师平均工资超过42000美元的系*/
select dept_name, avg(salary) as avg_salary
from instructor
group by dept_name
having avg(salary) > 42000;   /*对分组限定条件*/
/*！！！！任何出现在having中但没有出现在聚集函数的属性必须在group by中*/

/*对于2009年教授的每个课程段，如果该课程段有至少2名学生选课，
找出选修课程段的所有学生的总学分的平均值*/
/*难！！！！！！！通过关系找表*/
select course_id, semester, year, sec_id, sum(tot_cred)  /*显示信息*/
from student natural join takes /*学生选课，并不需要与section进行连接*/
where year = '2009'
group by semester, year, course_id, sec_id/*每个课程段*/
having sum(distinct id) >= 2;  /*至少两名学生选课*/

/*3.8 嵌套子查询*/
/*3.8.1集合成员资格*/
/*找出在2009年秋季和2010年春季学期同时开设的所有课程*/
(select course_id
from section
where year ='2009' and semester = 'Fall')
intersect
(select course_id
from section
where year ='2010' and semester = 'Spring');



/*嵌套子查询*/
select distinct course_id
from section
where semester = 'Fall' and year = 2009 and
    course_id in (select course_id 
                  from section 
                  where semester = 'Spring' and year = 2010);

/*不在 not in*/
select distinct course_id
from section
where semester = 'Fall' and year = 2009 and
    course_id not in (select course_id 
                  from section 
                  where semester = 'Spring' and year = 2010);

/*测试成员资格——查找既不叫“”也不叫‘’*/
select distinct name
from instructor
where name not in ('Mozart', 'Einstein');

/*找出不同的学生人数，他们选修了ID为10101的教师所讲授的课程段*/
select count(distinct ID) 
from takes
where (course_id, sec_id, semester, year) in 
        (select course_id,sec_id, semester, year
         from teaches
          where teaches.id = 10101); /*子查询中的id可独享*/
          
          
/*3.8.2 集合的比较*/
/*找出满足下面条件的所有教师的姓名，他们的工资至少比Biology系某一个教师的工资要高*/
select name, salary
from instructor
where salary > some (select salary /*需要some*/
                from instructor
                where dept_name = 'Biology');


/*至少，存在
> some:至少比某一个要大
< some
<= some
>= some
= some
<>some :不等价于not in
*/

/* 全部
< all
<= all
>= all
= all ：不等价于in
<> all :等价于not in,全都不等
*/

/*找出平均工资最高的系*/
select dept_name
from instructor
group by dept_name
where avg(salary) >= all (select avg(salary)/*不对，对分组限制要用having*/
                        from instructor
                        group by dept_name);
                        
                        
select dept_name
from instructor
group by dept_name
having avg(salary) >= all (select avg(salary)/*having!!!1*/
                        from instructor
                        group by dept_name);


/*3.8.3 空关系测试—— 测试一个子查询结果中是否存在元组*/
/*exists 非空为true*/
/*找出在2009年秋季和2010年春季学期同时开设的所有课程*/
select course_id /*oracle中省略as*/
from section as S
where year = '2009' and semester = 'Fall' and 
        exists (select course_id
                from section as T
                where year = '2010' and semester = 'Spring'
                          and S.course_id = T.course_id); /*这是必要的！！！*/
/*相关子查询：内层查询可以使用外层查询的变量 —— 作用域规则*/
/*’同时‘：S.course_id = T.course_id必须在子查询中声明，作用域规则不能在外层查询中使用子查询中的变量*/
/*not exists: 测试不存在元组中, 空为true*/

/*关系A包含关系B ——> not exists (B except A)*/
/*B-A为空，在B中不在A中为空，则A包含B*/
/*找出选修了Biology系开设的所有课程的学生*/
/*两个关系：
A——S.ID选修的所有课程；
B——Biology开设的所有课程
A包含B*/

/*找出Biology开设的所有课程的集合*/
select course_id
from course 
where dept_name = 'Biology';

/*找出S.ID选修的所有课程*/
select course_id
from student natural join takes;

select S.ID, S.name
from student as S
where not exists (( select course_id
                    from course 
                    where dept_name  = 'Biology')/*生物系所有课程*/
                    except
                   (select T.course_id
                    from takes as T
                    where S.ID = T.ID));
/*oracle失败？？*/

/*3.8.4 重复元组存在性测试*/
/*unique <= 1—测试一个子查询的结果是否存在重复元组*/
/*找出所有在2009年最多开设一次的课程 ——> 0或1*/
select T.course_id
from course T 
where unique (select R.course_id  /*oracle不支持*/
              from section R
              where R。year = 2009 and T.course_id = R.course_id);
/*返回course_id是否唯一？重复*/

/*等价*/
select T.course_id 
from course T    /*需要内外重命名标识作用域*/
where 1 >= (select count(R.course_id)
            from section R
            where year = 2009 and T.course_id = R.course_id);

/*not unique >1:测试是否存在重复元组*/
/*找出所有在2009年最少开设两次的课程*/
select T.course_id
from course T 
where not unique (select R.course_id  /*oracle不支持*/
              from section R
              where R。year = 2009 and T.course_id = R.course_id);

/*3.8.5 from子句中的查询*/
/*找出系平均工资超过42000美元的那些系中的教师的平均工资(==系的平均工资)*/
/*找到系的平均工资*/
select dept_name, avg_salary
from (select dept_name, avg(salary) avg_salary
     from instructor
     group by dept_name)    /* 先按照系进行分组 */
where avg_salary > 42000;

/*找出所有系中工资总额最大的系——having无能为力 ——> 优先考虑嵌套子查询*/
select dept_name, total_salary
from (select dept_name, sum(salary) total_salary
      from instructor
      group by dept_name) d
where total_salary <=  d.total_salary;

select max(tot_salary)
from (select dept_name, sum(salary) tot_salary
      from instructor
      group by dept_name); /*dept_total(dept_name,tot_salary);*/

/*from只能用lateral访问外层变量*/
/*找出每位教师的姓名，工资和系的平均工资*/
select name, salary, avg_salary/*未明确定义列*/
from instructor I1, lateral(select avg(salary) avg_salary
                            from instructor I2
                            where I2.dept_name = I1.dept_name);

/*3.8.6 with子句 —— 创建临时关系*/
/*找出具有最大预算的系*/
with max_budget(value) as
    (select max(budget)
    from department)
select budget
from department, max_budget
where department.budget = max_budget.value;

/*oracle在子查询中允许对关系rename，但允许对属性rename*/

/*查出所有工资总额大于所有系平均工资总额的系*/
with dept_total(dept_name, value) as /*定义两个临时关系*/
        (select dept_name, sum(salary)
        from instructor
        group by dept_name,
        dept_total_avg(value) as
        (select avg(value)
        from dept_total)
select dept_name
from dept_total, dept_total_avg
where dept_total.value >= dept_total_avg.value;

/*3.8.7 标量子查询：返回单个值*/
/*所有系的教师数*/
select dept_name,
    (select count(*) /*只返回单个值*/
    from instructor
    where department.dept_name = instructor.dept_name)
from department;








