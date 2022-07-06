---LE REPORT ACCOUNT ACQUISITION----
select count(distinct cust_id), count(foracid), business_unit, segm_desc from  LE_REPORT_ACCOUNT_DETIALS
where segm_desc in ('SME', 'MASS', 'AFFLUENT')
and ACCT_OPN_DATE <= '31/jul/2021'
and business_unit in ('LAGOS AND WEST', 'NORTH', 'SOUTH')
and SCHM_TYPE IN ('ODA', 'SBA','TDA')
group by business_unit, segm_desc;

---LE REPORT REVENUE, NRFF, NII----

SELECT SUM(NET_REVENUE) REVENUE, sum(NRFF) NRFF, BUSINESS_UNIT, SEGM_DESC FROM 
(SELECT A.CUST_id, A.FORACID, b.nrff, B.NET_REVENUE, B.AS_OF_DATE, A.BUSINESS_UNIT, A.SEGM_DESC FROM LE_REPORT_ACCOUNT_DETIALS A
LEFT JOIN report.d_ofsaa8_account_view@exadata_lnk B
ON A.FORACID = B.ACCOUNT_NUMBER
where A.segm_desc in ('SME', 'MASS', 'AFFLUENT')
and A.business_unit in ('LAGOS AND WEST', 'NORTH', 'SOUTH')
AND B.AS_OF_DATE BETWEEN '01/JAN/2021' AND '31/jul/2021')
GROUP BY BUSINESS_UNIT, SEGM_DESC;

---LE REPORT LAD----
SELECT SUM(FAC_GRANT_AMT) LAD,BUSINESS_UNIT, SEGM_DESC FROM 
(SELECT A.foracid, b.FAC_GRANT_AMT, B.FAC_GRANT_DATE, A.BUSINESS_UNIT, A.SEGM_DESC FROM LE_REPORT_ACCOUNT_DETIALS A
LEFT JOIN report.d_acct_balances_tbl@exadata_lnk B
ON A.foracid = B.operating_acct
where A.segm_desc in ('SME', 'MASS', 'AFFLUENT')
and A.business_unit in ('LAGOS AND WEST', 'NORTH', 'SOUTH')
AND B.FAC_GRANT_DATE BETWEEN '01/JAN/2019' AND '31/dec/2019')
GROUP BY BUSINESS_UNIT, SEGM_DESC;


---LE REPORT CASA -----
SELECT SUM(balance) CASA, return_date, BUSINESS_UNIT, SEGM_DESC FROM 
(SELECT A.CUST_id, A.FORACID, b.balance, B.return_date, A.BUSINESS_UNIT, A.SEGM_DESC FROM LE_REPORT_ACCOUNT_DETIALS A
LEFT JOIN REPORT.MIS_BAL_TBL_ONE_MNTH@exadata_lnk  B
ON A.FORACID = B.FORACID
where A.segm_desc in ('SME', 'MASS', 'AFFLUENT')
and A.business_unit in ('LAGOS AND WEST', 'NORTH', 'SOUTH')
AND B.RETURN_DATE IN ('31/DEC/2018','31/DEC/2019','31/DEC/2020', '31/jul/2021'))
GROUP BY return_date, BUSINESS_UNIT, SEGM_DESC