SELECT i_brand_id              brand_id, 
               i_brand                 brand, 
               i_manufact_id, 
               i_manufact, 
               Sum(ss_ext_sales_price) ext_price
               
FROM   store_sales, 
customer,
date_dim,
       item,
       store
WHERE  ss_item_sk = i_item_sk 
AND d_date_sk = ss_sold_date_sk 
 AND d_moy = 12 
       AND d_year = 1998 
AND ss_customer_sk=c_customer_sk
AND s_store_sk=ss_store_sk
       AND i_manager_id = 38 
AND Substr(s_zip, 1, 5)<>Substr(ca_zip, 1, 5)  
        
GROUP  BY i_brand, 
          i_brand_id, 
          i_manufact_id, 
          i_manufact 
ORDER  BY ext_price DESC, 
          i_brand, 
          i_brand_id, 
          i_manufact_id, 
          i_manufact          
LIMIT 100; 
