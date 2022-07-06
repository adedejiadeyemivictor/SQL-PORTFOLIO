select count(DISTINCT A.cust_id) Customer_count, count(DISTINCT A.foracid) account_count, sum(net_revenue) revenue, to_char(as_of_date, 'yyyy') year  
from report.d_acct_details_tbl@exadata_lnk a, report.d_ofsaa8_account_view@exadata_lnk b, report.d_CUST_details_tbl@exadata_lnk C
where a.foracid = b.account_number
AND A.CUST_ID = C.CUST_ID
and as_of_date between '01/jan/2020' and '31/dec/2021'
and segment_desc like '%AFFLU%'
AND TO_CHAR(DATE_OF_BIRTH, 'YYYY') BETWEEN '1986' AND '2003'
GROUP BY to_char(as_of_date, 'yyyy')



