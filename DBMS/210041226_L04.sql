
SELECT DISTINCT customer_city FROM customer WHERE customer_city LIKE '%d%f%';

SELECT customer_name , customer_city FROM customer WHERE customer_name IN (
    SELECT DISTINCT customer_name FROM borrower WHERE customer_name NOT IN (
        SELECT DISTINCT customer_name FROM depositor)
);

select * from customer where customer_name in (
    select customer_name from depositor) or customer_name in (
        select customer_name from borrower
);

select sum(assets) from branch;

select count(a.account_number), b.branch_city from branch b,account a
    where b.branch_name = a.branch_name
    group by b.branch_city ;

select customer_name , account_number from account natural join depositor
     where account.balance =(
        select max(balance)from account
    );



select avg(account.balance) , branch.branch_name from branch,account
    where branch.branch_name = account.branch_name
        group by branch.branch_name 
        order by avg(account.balance) desc;

select customer_city , count(*)
from customer
    where customer_name in (select customer_name from depositor)
    and customer_name in (select customer_name from borrower)
    group by customer_city;

select branch_name , avg(loan.amount)
from loan 
where branch_name not like '%Horse%'
group by branch_name;

select *
from customer
natural join depositor
natural join account
natural join branch
where customer_city = branch_city;

select branch_name , total_balance , assets
from branch where total_balance > (
    select avg(total_balance)
    from(
        select branch_name , sum(account.balance) as total_balance
        from account 
        group by branch_name
    )
);

SELECT DISTINCT branch.branch_name
FROM branch
WHERE (
    SELECT SUM(account.balance)
    FROM account, depositor, customer
    WHERE account.account_number = depositor.account_number
    AND depositor.customer_name = customer.customer_name
    AND branch.branch_name = account.branch_name
) > (
    SELECT SUM(loan.amount)
    FROM loan, borrower, customer
    WHERE loan.loan_number = borrower.loan_number
    AND borrower.customer_name = customer.customer_name
    AND branch.branch_name = loan.branch_name
)
GROUP BY branch.branch_name;


select distinct B.customer_name from
(select depositor.customer_name, sum(balance) as total_balance from depositor, account
where depositor.account_number = account.account_number
group by depositor.customer_name) B,
(select customer_name, amount from borrower, loan
where borrower.loan_number = loan.loan_number) L
where B.customer_name = L.customer_name and B.total_balance >= L.amount;

select B.customer_name, sum(balance) as balance, sum(amount) as loan_amount from
(select customer_name, balance, branch_name from depositor, account
where depositor.account_number = account.account_number) B,
(select customer_name, amount, branch_name from borrower, loan
where borrower.loan_number = loan.loan_number) L,
customer Cs, branch Br
where B.customer_name = L.customer_name and B.customer_name = Cs.customer_name and (B.branch_name = Br.branch_name or L.branch_name = Br.branch_name) and not Cs.customer_city = Br.branch_city
group by B.customer_name;

select distinct c.customer_name
from customer c, depositor d, account a, borrower b, loan l
where
(c.customer_name = d.customer_name and d.account_number = a.account_number and
a.branch_name = (select branch_name from branch where assets = (select max(assets) from branch))) 
or
(c.customer_name = b.customer_name and b.loan_number = l.loan_number and
l.branch_name = (select branch_name from branch where assets = (select max(assets) from branch)));\


