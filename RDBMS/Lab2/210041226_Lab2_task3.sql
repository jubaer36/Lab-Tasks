CREATE OR REPLACE TRIGGER new_customer_bill_initialize
AFTER INSERT ON customer
FOR EACH ROW
BEGIN
    INSERT INTO bill (SSN, Month, Year, amount)
    VALUES (:NEW.SSN, TO_CHAR(SYSDATE, 'MM'), TO_CHAR(SYSDATE, 'YYYY'), 0);
END;
/

CREATE OR REPLACE TRIGGER update_bill
AFTER INSERT ON phonecall
FOR EACH ROW
DECLARE
    pps NUMBER;
    conn_fee NUMBER;
    call_cost NUMBER;
BEGIN
    SELECT p.PricePerSecond, p.ConnectionFee
    INTO pps, conn_fee
    FROM pricingplan p, customer c
    WHERE c.SSN = :NEW.SSN 
      AND c.Plan = p.Code;

    call_cost := conn_fee + (pps * :NEW.Seconds);

    UPDATE bill
    SET amount = amount + call_cost
    WHERE SSN = :NEW.SSN 
    AND Month = TO_NUMBER(TO_CHAR(SYSDATE, 'MM')) 
    AND Year = TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY'));
END;
/
