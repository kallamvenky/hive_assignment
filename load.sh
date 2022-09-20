aws s3 cp s3://kallaproject/sales_order_data.csv .



hive -e 'create table if not exists sales_order_csv(
ORDERNUMBER int,
QUANTITYORDERED int,
PRICEEACH double,
ORDERLINENUMBER int,
SALES double,
STATUS string,
QTR_ID int,
MONTH_ID int,
YEAR_ID int,
PRODUCTLINE string,
MSRP int,
PRODUCTCODE int,
PHONE string,
CITY string,
STATE string,
POSTALCODE string,
COUNTRY string,
TERRITORY string,
CONTACTLASTNAME string,
CONTACTFIRSTNAME string,
DEALSIZE string
)

row format serde "org.apache.hadoop.hive.serde2.OpenCSVSerde"
with serdeproperties (
    "separatorChar" = ",",
    "quoteChar" = "\"",
"escapeChar" = "\\"
    )
stored as textfile
tblproperties ("skip.header.line.count" = "1")'

hive -e 'describe sales_order_csv'
hive -e "load data local inpath 'sales_order_data.csv' overwrite into table sales_order_csv"
set hive.cli.print.header = true
hive -e 'select * from sales_order_csv limit 3'

hive -e 'create table sales_order_orc
(
ORDERNUMBER int,
QUANTITYORDERED int,
PRICEEACH float,
ORDERLINENUMBER int,
SALES float,
STATUS string,
QTR_ID int,
MONTH_ID int,
YEAR_ID int,
PRODUCTLINE string,
MSRP int,
PRODUCTCODE string,
PHONE string,
CITY string,
STATE string,
POSTALCODE string,
COUNTRY string,
TERRITORY string,
CONTACTLASTNAME string,
CONTACTFIRSTNAME string,
DEALSIZE string
)
stored as orc'

hive -e 'insert overwrite table sales_order_orc select * from sales_order_csv'

