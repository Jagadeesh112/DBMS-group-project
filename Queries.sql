use insurance;

/* 		Query 1		 */
select * from  VEHICLE v inner join CUSTOMER c on v.Cust_id=c.Cust_id where c.Cust_id in ( select x.Cust_id from CLAIM x where x.Claim_Status = 'pending');

/* 		Query 2		 */
select * from CUSTOMER c1 where c1.Cust_id in (select p.Cust_id from PREMIUM_PAYMENT p where (p.Premium_Payment_Amount > (select sum(CAST(Cust_Id as unsigned)) from CUSTOMER)));

/* 		Query 3		 */

select * from INSURANCE_COMPANY where Company_Name in (select OFFICE.Company_Name from OFFICE group by Company_Name having count(distinct (Address))>1 and Company_Name in (select DEPARTMENT.Company_Name from PRODUCT , DEPARTMENT where DEPARTMENT.Company_Name = PRODUCT.Company_Name group by DEPARTMENT.Company_Name having count(distinct (Product_Number)) > count(distinct (Department_Name))));

/* 		Query 4		 */

select * from CUSTOMER where Cust_id in (select Cust_id from INCIDENT_REPORT where Cust_id in (select Cust_id from VEHICLE group by Cust_id having count(Cust_id) > 1) and Cust_id not in (select Cust_id from PREMIUM_PAYMENT));

/* 		Query 5		 */

select * from VEHICLE as v, PREMIUM_PAYMENT as p where v.Cust_id = p.Cust_id and p.Premium_Payment_Amount > v.Vehicle_Number;

/* 		Query 6		 */

select Cust_Id, Cust_FName, Cust_LName, Cust_DOB, Cust_Gender, Cust_Address, Cust_MOB_Number, Cust_Email, Cust_Passport_Number, Cust_Marital_Status, Cust_PPS_Number
    from CUSTOMER
    where Cust_id in (
		select distinct (cl.Cust_id)
		from CLAIM as cl, CLAIM_SETTLEMENT as cs, COVERAGE as co 
        where cl.Claim_Amount > cs.Claim_Settlement_id + cs.Vehicle_id + cl.Claim_id + cl.Cust_id and cl.Claim_Amount < Coverage_Amount );
