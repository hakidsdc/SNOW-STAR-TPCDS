MATCH(d:date_dim{ d_moy : 12, d_year : 1998})<-[:ON_Date]-(ss:store_sales) WITH d, ss MATCH(i:item{i_manager_id:1})<-[:OF_Item]-(ss:store_sales)
WITH i, d, ss RETURN d.d_year, i.i_category_id, i.i_category, Sum(ss.ss_ext_sales_price)
ORDER  BY Sum(ss.ss_ext_sales_price) DESC, d.d_year, i.i_category_id, i.i_category LIMIT 100;
