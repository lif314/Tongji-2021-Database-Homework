/**************SQL����ѯ��ϰ*************/

/******* ����ϵ��ѯ *******/
/*�ҳ����н�ʦ���ڵ�ϵ��*/
select dept_name 
from instructor;

/*�ҳ�������Computer Scienceϵ���ҹ��ʳ���70000��Ԫ�Ľ�ʦ������*/
select name
from instructor 
where dept_name = 'Comp. Sci.' and salary > 70000;

/************ ���ϵ��ѯ ****************/
/*�ҳ����н�ʦ���������Լ���������ϵ�����ƺ�ϵ���ڵĽ���*/
select name, instructor.dept_name, building    /*�����instructor�Ǳ����*/
from instructor, department
where instructor.dept_name = department.dept_name;
/*��⣺from -> where -> select, from �Ĳ���=�ѿ�����*/

/*�ѿ�����:�г����е�ƥ�����*/
select *
from instructor, department;

/*��ѯ���н�ʦ��id�������Լ��γ̱�ʶ*/
select instructor.id,name,course_id  /*������ֻ��һ�����г���ʱ�����Բ�дǰ׺��������Ҫǰ׺��ʶ*/
from instructor, teaches
where instructor.id = teaches.id;
/*ֻ����˽��ڿγ̵���ʦ ���� ���������������*/

/*�ҳ�Computer Scienceϵ�Ľ�ʦ���Ϳγ̱�ʶ*/
select name, course_id
from instructor, teaches
where instructor.id = teaches.id and dept_name = 'Comp. Sci.';

/************ ��Ȼ���� **************/
/*������ͬ�����ϵ�ֵ����֤Ҫ���*/
/*ֻ����������ϵģʽ�г��ֵ�������ȡֵ����ȵ�Ԫ���-���ڹ�ͬ������ȡֵ��ͬ*/
/*���ڴ�ѧ�����н��ڿγ̵���ʦ���ҳ����ǵ������Լ��������γ̱�ʶ*/
select name,course_id
from instructor natural join teaches;/*ID�ǹ�ͬ����*/

/*�����������г���ʦ�������Լ����������ڿγ̵�����*/
select name,title
from instructor natural join teaches natural join course;/*����course_id��ͬ��dept_nameҲ��һ����ͬ����*/

select name,title 
from instructor natural join teaches, course
where teaches.course_id = course.course_id; /*��ȷ*/

/*������Ȼ����:ʹ��join using()ָ������Щ�������*/
select name,title
from (instructor natural join teaches) join course using (course_id); /*ʹ��join using*/

/*�������� as*/
/*���ڴ�ѧ�����н��ڿγ̵���ʦ���ҳ����ǵ������Լ��������γ̱�ʶ*/
select T.name, S.course_id
from instructor as T , teaches as S
where T.ID = S.ID;

/*�Լ����Լ��ĵѿ�����*/
/*�ҳ������������������н�ʦ�����������ǵĹ������ٱ�Biologyϵĳһ����ʦ�Ĺ���Ҫ��*/
select distinct name /*�Լ����Լ�֮��ıȽ�*/
from instructor as T�� instructor as S  /*��������*/
where T.salary > S.salary and S.dept_name = 'Biology';   /*���ڴ��ڼ���*/

/*�ַ�������*/
/*������upper(s) lower(s) trim(s) :ȥ�ո�
ģʽƥ�䣺like
%:ƥ�������ַ�
_:ƥ������һ���ַ�
\:ת���ַ� like 'ab \% cd%' escape '\'
*/

/*�ҳ����ڽ��������а����ִ�'Watson'������ϵ��*/
select dept_name
from department
where building like '% Watson %';

/*����Ԫ����ʾ���� order by Ĭ������*/
/*desc ����
asc ����
*/
select *
from instructor 
order by salary desc, name asc;

/*between & not nbetween*/
/*�ҳ�������90000��100000֮��Ľ�ʦ������*/
select name
from instructor 
where salary between 90000 and 100000;

/*��ѯBiologyϵ�����˿γ̵����н�ʦ�ĵ����������������ڵĿγ̱�ʶ*/
select name,course_id
from instructor, teaches
where dept_name = 'Biology' and instructor.id = teaches.id;
/*��ʹ��Ԫ����ʽ*/
select name,course_id
from instructor, teaches
where (instructor.id, dept_name) = (teaches.id, 'Biology');

/*��������
union ����
intersect �� ��
except �� ��
*/
/*��2009���＾ѧ�ڿ�������пγ�*/
select course_id
from section
where year = '2009' and semester = 'Fall';

/*��2010�괺��ѧ�ڿ�������пγ�*/
select course_id
from section
where year = '2010' and semester = 'Spring';

/*union:��2009���＾���λ�����2010�괺������ ��������ѧ�ڶ����ε����пγ�*/
/*�Զ�ȥ��*/
(select course_id
from section
where year = '2009' and semester = 'Fall')
union   /*union all �����ظ�*/
(select course_id
from section
where year = '2010' and semester = 'Spring');

/*intersect:ͬʱ����*/
/*�Զ�ȥ��*/
(select course_id
from section
where year = '2009' and semester = 'Fall')
intersect /*�Զ�ȥ�� intersect all*/
(select course_id
from section
where year = '2010' and semester = 'Spring');

/*except:��2009���＾���ε�������2010�괺������*/
(select course_id
from section
where year = '2009' and semester = 'Fall')
minus   /*oracle: except  /*�Զ�ȥ�� except all*/
(select course_id
from section
where year = '2010' and semester = 'Spring');

/*���Կ�ֵ*/
/*unknown*/
select name 
from instructor
where salary is /*not*/ null;

/*�ۼ�����
avg() :���ּ�
min()
max()
sum() �����ּ�
count()
*/

/*�ҳ�Computer Scienceϵ��ʦ��ƽ������*/
select avg(salary) as avg_salary/*rename*/
from instructor
where dept_name = 'Comp. Sci.';

/*�ҳ���2010�괺��ѧ�ڽ���һ�ſγ̵Ľ�ʦ������*/
select count(distinct id) /*ȥ��* all Ĭ�ϱ����ظ�/
from teaches
where year = '2010' and semester = 'Spring';

/*����Ԫ����*/
select count(*) /*����ʹ��discinct*/
from instructor;

/*����ۼ�*/
/*group by:һ��Ԫ�鼯�Ͼۼ�*/
/*�ҳ�ÿ��ϵ��ƽ������*/
select dept_name, avg(salary) as avg_salary
from instructor
group by (dept_name);

/*!!!!!�ҳ�ÿ��ϵ��2010�괺��ѧ�ڽ���һ�ſγ̵Ľ�ʦ����*/
select dept_name, count(distinct id) as instr_count   /*distinct*/
from instructor natural join teaches /*�ҳ���ʦ�̿ε���Ϣ*/
where year = '2010' and semester = 'Spring'
group by (dept_name);
/*��������ע�⣺�κ�û�г��ֵ�group by�е�����ֻ�ܳ����ھۼ��������ڲ�*/
/*error*/
select dept_name, id, avg(salary)
from instructor
group by dept_name/*,id*/;
/*ԭ����һ���������ò�ͬ��id����ֻ�����һ��id���޷�ȷ������ĸ�*/

/*having�Ӿ䡪���Է����޶�����*/
/*�ҳ���ʦƽ�����ʳ���42000��Ԫ��ϵ*/
select dept_name, avg(salary) as avg_salary
from instructor
group by dept_name
having avg(salary) > 42000;   /*�Է����޶�����*/
/*���������κγ�����having�е�û�г����ھۼ����������Ա�����group by��*/

/*����2009����ڵ�ÿ���γ̶Σ�����ÿγ̶�������2��ѧ��ѡ�Σ�
�ҳ�ѡ�޿γ̶ε�����ѧ������ѧ�ֵ�ƽ��ֵ*/
/*�ѣ�������������ͨ����ϵ�ұ�*/
select course_id, semester, year, sec_id, sum(tot_cred)  /*��ʾ��Ϣ*/
from student natural join takes /*ѧ��ѡ�Σ�������Ҫ��section��������*/
where year = '2009'
group by semester, year, course_id, sec_id/*ÿ���γ̶�*/
having sum(distinct id) >= 2;  /*��������ѧ��ѡ��*/

/*3.8 Ƕ���Ӳ�ѯ*/
/*3.8.1���ϳ�Ա�ʸ�*/
/*�ҳ���2009���＾��2010�괺��ѧ��ͬʱ��������пγ�*/
(select course_id
from section
where year ='2009' and semester = 'Fall')
intersect
(select course_id
from section
where year ='2010' and semester = 'Spring');



/*Ƕ���Ӳ�ѯ*/
select distinct course_id
from section
where semester = 'Fall' and year = 2009 and
    course_id in (select course_id 
                  from section 
                  where semester = 'Spring' and year = 2010);

/*���� not in*/
select distinct course_id
from section
where semester = 'Fall' and year = 2009 and
    course_id not in (select course_id 
                  from section 
                  where semester = 'Spring' and year = 2010);

/*���Գ�Ա�ʸ񡪡����ҼȲ��С���Ҳ���С���*/
select distinct name
from instructor
where name not in ('Mozart', 'Einstein');

/*�ҳ���ͬ��ѧ������������ѡ����IDΪ10101�Ľ�ʦ�����ڵĿγ̶�*/
select count(distinct ID) 
from takes
where (course_id, sec_id, semester, year) in 
        (select course_id,sec_id, semester, year
         from teaches
          where teaches.id = 10101); /*�Ӳ�ѯ�е�id�ɶ���*/
          
          
/*3.8.2 ���ϵıȽ�*/
/*�ҳ������������������н�ʦ�����������ǵĹ������ٱ�Biologyϵĳһ����ʦ�Ĺ���Ҫ��*/
select name, salary
from instructor
where salary > some (select salary /*��Ҫsome*/
                from instructor
                where dept_name = 'Biology');


/*���٣�����
> some:���ٱ�ĳһ��Ҫ��
< some
<= some
>= some
= some
<>some :���ȼ���not in
*/

/* ȫ��
< all
<= all
>= all
= all �����ȼ���in
<> all :�ȼ���not in,ȫ������
*/

/*�ҳ�ƽ��������ߵ�ϵ*/
select dept_name
from instructor
group by dept_name
where avg(salary) >= all (select avg(salary)/*���ԣ��Է�������Ҫ��having*/
                        from instructor
                        group by dept_name);
                        
                        
select dept_name
from instructor
group by dept_name
having avg(salary) >= all (select avg(salary)/*having!!!1*/
                        from instructor
                        group by dept_name);


/*3.8.3 �չ�ϵ���ԡ��� ����һ���Ӳ�ѯ������Ƿ����Ԫ��*/
/*exists �ǿ�Ϊtrue*/
/*�ҳ���2009���＾��2010�괺��ѧ��ͬʱ��������пγ�*/
select course_id /*oracle��ʡ��as*/
from section as S
where year = '2009' and semester = 'Fall' and 
        exists (select course_id
                from section as T
                where year = '2010' and semester = 'Spring'
                          and S.course_id = T.course_id); /*���Ǳ�Ҫ�ģ�����*/
/*����Ӳ�ѯ���ڲ��ѯ����ʹ������ѯ�ı��� ���� ���������*/
/*��ͬʱ����S.course_id = T.course_id�������Ӳ�ѯ�������������������������ѯ��ʹ���Ӳ�ѯ�еı���*/
/*not exists: ���Բ�����Ԫ����, ��Ϊtrue*/

/*��ϵA������ϵB ����> not exists (B except A)*/
/*B-AΪ�գ���B�в���A��Ϊ�գ���A����B*/
/*�ҳ�ѡ����Biologyϵ��������пγ̵�ѧ��*/
/*������ϵ��
A����S.IDѡ�޵����пγ̣�
B����Biology��������пγ�
A����B*/

/*�ҳ�Biology��������пγ̵ļ���*/
select course_id
from course 
where dept_name = 'Biology';

/*�ҳ�S.IDѡ�޵����пγ�*/
select course_id
from student natural join takes;

select S.ID, S.name
from student as S
where not exists (( select course_id
                    from course 
                    where dept_name  = 'Biology')/*����ϵ���пγ�*/
                    except
                   (select T.course_id
                    from takes as T
                    where S.ID = T.ID));
/*oracleʧ�ܣ���*/

/*3.8.4 �ظ�Ԫ������Բ���*/
/*unique <= 1������һ���Ӳ�ѯ�Ľ���Ƿ�����ظ�Ԫ��*/
/*�ҳ�������2009����࿪��һ�εĿγ� ����> 0��1*/
select T.course_id
from course T 
where unique (select R.course_id  /*oracle��֧��*/
              from section R
              where R��year = 2009 and T.course_id = R.course_id);
/*����course_id�Ƿ�Ψһ���ظ�*/

/*�ȼ�*/
select T.course_id 
from course T    /*��Ҫ������������ʶ������*/
where 1 >= (select count(R.course_id)
            from section R
            where year = 2009 and T.course_id = R.course_id);

/*not unique >1:�����Ƿ�����ظ�Ԫ��*/
/*�ҳ�������2009�����ٿ������εĿγ�*/
select T.course_id
from course T 
where not unique (select R.course_id  /*oracle��֧��*/
              from section R
              where R��year = 2009 and T.course_id = R.course_id);

/*3.8.5 from�Ӿ��еĲ�ѯ*/
/*�ҳ�ϵƽ�����ʳ���42000��Ԫ����Щϵ�еĽ�ʦ��ƽ������(==ϵ��ƽ������)*/
/*�ҵ�ϵ��ƽ������*/
select dept_name, avg_salary
from (select dept_name, avg(salary) avg_salary
     from instructor
     group by dept_name)    /* �Ȱ���ϵ���з��� */
where avg_salary > 42000;

/*�ҳ�����ϵ�й����ܶ�����ϵ����having����Ϊ�� ����> ���ȿ���Ƕ���Ӳ�ѯ*/
select dept_name, total_salary
from (select dept_name, sum(salary) total_salary
      from instructor
      group by dept_name) d
where total_salary <=  d.total_salary;

select max(tot_salary)
from (select dept_name, sum(salary) tot_salary
      from instructor
      group by dept_name); /*dept_total(dept_name,tot_salary);*/

/*fromֻ����lateral����������*/
/*�ҳ�ÿλ��ʦ�����������ʺ�ϵ��ƽ������*/
select name, salary, avg_salary/*δ��ȷ������*/
from instructor I1, lateral(select avg(salary) avg_salary
                            from instructor I2
                            where I2.dept_name = I1.dept_name);

/*3.8.6 with�Ӿ� ���� ������ʱ��ϵ*/
/*�ҳ��������Ԥ���ϵ*/
with max_budget(value) as
    (select max(budget)
    from department)
select budget
from department, max_budget
where department.budget = max_budget.value;

/*oracle���Ӳ�ѯ������Թ�ϵrename�������������rename*/

/*������й����ܶ��������ϵƽ�������ܶ��ϵ*/
with dept_total(dept_name, value) as /*����������ʱ��ϵ*/
        (select dept_name, sum(salary)
        from instructor
        group by dept_name,
        dept_total_avg(value) as
        (select avg(value)
        from dept_total)
select dept_name
from dept_total, dept_total_avg
where dept_total.value >= dept_total_avg.value;

/*3.8.7 �����Ӳ�ѯ�����ص���ֵ*/
/*����ϵ�Ľ�ʦ��*/
select dept_name,
    (select count(*) /*ֻ���ص���ֵ*/
    from instructor
    where department.dept_name = instructor.dept_name)
from department;








