-------- LAD----------

select bu_code, segment_desc, sum(lad) lad from
(select b.foracid, c.bu_code, b.segment_desc, sum(a.CUR_BOOK_BAL) Lad from report.d_ofsaa8_account_view@exadata_lnk  a, FBN_SEGMENT_HIST_Mnth b, 
report.d_business_units_dim@exadata_lnk c, report.d_acct_details_tbl@exadata_lnk d
where a.account_number = b.foracid
and a.desk_code = c.desk_code
and b.foracid = d.foracid
and as_of_date ='31/jan/2022'
and schm_type = 'LAA' 
group by b.foracid, b.segment_desc, c.bu_code)
where bu_code in ('4', '5', '6')
group by bu_code, segment_desc




--------REVENUE---------
select bu_code, segment_desc, sum(nr) NR from
(select b.foracid, c.bu_code, b.segment_desc, sum(a.net_revenue) NR from report.d_ofsaa8_account_view@exadata_lnk  a, FBN_SEGMENT_HIST_Mnth b, 
report.d_business_units_dim@exadata_lnk c, report.d_acct_details_tbl@exadata_lnk d
where a.account_number = b.foracid
and a.desk_code = c.desk_code
and b.foracid = d.foracid
and as_of_date ='31/jan/2022'
and schm_type <> 'LAA' 
group by b.foracid, b.segment_desc, c.bu_code)
where bu_code in ('4', '5', '6')
group by bu_code, segment_desc




-------DEPOSIT --------

select bu_code, segment_desc, sum(balance) balance from
(select b.foracid, bu_code, b.segment_desc, sum(a.balance) balance from REPORT.MIS_BAL_TBL_ONE_MNTH@exadata_lnk a, FBN_SEGMENT_HIST_Mnth b,
report.d_acct_details_tbl@exadata_lnk c
where a.foracid = b.foracid
and return_date ='31/jan/2022' 
and schm_type <> 'LAA'
group by bu_code, b.segment_desc, b.foracid)
where bu_code in ('4', '5', '6')
group by bu_code, segment_desc














