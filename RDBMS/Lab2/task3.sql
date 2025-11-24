create or replace TRIGGER new_customer_bill_initialize
after insert on customer
for each row 
begin 
insert into bill (SSN, Month, Year, amount) VALUES
(:new.SSN, TO_CHAR(SYSDATE, 'MM'), TO_CHAR(SYSDATE, 'YYYY'), 0);
end;
/

create or replace TRIGGER update_customer_bill 
after insert on phonecall
for each row
DECLARE 
    billAmount NUMBER;
    conFee NUMBER;
    pps NUMBER;
    totalTime NUMBER;

begin
    select ConnectionFee , PricePerSecond into conFee , pps from pricingplan where 
    customer.SSN = :new.SSN AND pricingplan.Code = customer.Plan;
    totalTime:= :new.Seconds;
    billAmount := totalTime*pps + conFee;
    update bill
    set amount = amount + billAmount
    where bill.SSN = :new.SSN 
    and Month = TO_NUMBER(TO_CHAR(SYSDATE , 'MM')) and
    and Year = TO_NUMBER(TO_CHAR(SYSDATE , 'YYYY'));
end;
/
