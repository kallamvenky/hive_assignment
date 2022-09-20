# A: Calculate total sales per year
hive -e 'select distinct STATUS from sales_order_orc'
: "result:
Cancelled
Disputed
In Process
On Hold
Resolved
Shipped

Here parameter is not clear to find what is total sales,
because as per my knowledge total sales are total number of delivery goods
but delivery distinct is not available so taking shipped as total sales parameter"

hive -e "select YEAR_ID, count(*) as sale from sales_order_orc where STATUS='Shipped' group by YEAR_ID"
# B: Find a product for which maximum orders were placed
: "
Here we’re are taking all distincts into consideration because we’re speaking all orders placed,
it doesn’t matter weather it’s cancelled or hold or shipped after placing"

hive -e 'select PRODUCTLINE, count(*) as orders from sales_order_orc group by PRODUCTLINE order by orders desc'

#C: Calculate the total sales for each quarter
hive -e "select QTR_ID, count(*) as sale from sales_order_orc where STATUS='Shipped' group by QTR_ID"

#D: In which quarter sales was minimum
hive -e "select QTR_ID, count(*) as sale from sales_order_orc where STATUS='Shipped'  group by QTR_ID order by sale limit 1"

#E: In which country sales was maximum and in which country sales was minimum
    #-a> which country sales was maximum
hive -e "select COUNTRY, count(*) as sale from sales_order_orc where STATUS='Shipped' group by COUNTRY order by sale desc limit 1"

    #-b> which country sales was minimum
hive -e "select COUNTRY, count(*) as sale from sales_order_orc where STATUS='Shipped' group by COUNTRY order by sale limit 1"

#F: Calculate quarterly sales for each city
hive -e "select CITY, QTR_ID, count(*) as sale from sales_order_orc where STATUS='Shipped' group by CITY,QTR_ID order by sale desc"

#G: Find a month for each year in which maximum number of quantities were sold
hive -e "select * from (select *, Row_number() over(partition by a.YEAR_ID order by
a.ORDERS desc) as rwnum from (select YEAR_ID, MONTH_ID ,sum(QUANTITYORDERED) as ORDERS from
sales_order_orc group by YEAR_ID, MONTH_ID order by YEAR_ID, MONTH_ID, ORDERS) a) b where b.rwnum=1"
