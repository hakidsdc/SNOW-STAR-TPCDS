MATCH(d:date_dim{d_moy:12, d_year:2001})<-[:ON_Date]-(ss:store_sales) WITH d, ss MATCH(i:item{i_manager_id:36})<-[:OF_Item]-(ss:store_sales)
WITH i, d, ss RETURN i.i_brand_id as brand_id, i.i_brand as brand, Sum(ss.ss_ext_sales_price) as ext_price        order by ext_price DESC, i.i_brand_id  LIMIT 100;
