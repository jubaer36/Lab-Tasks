select distinct branch.branch_name, tt.total_balance
from branch,(
        select branch_name , sum(account.balance) as total_balance
        from account 
        group by branch_name
    ) tt
     where tt.total_balance> (
    select avg(total_balance)
    from(
        select branch_name , sum(account.balance) as total_balance
        from account 
        group by branch_name
    )
    group by tt.total_balance,branch.branch_name
);
