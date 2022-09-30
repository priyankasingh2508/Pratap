# Define the database connection to be used for this model.
connection: "google_playstore"

# include all the views
include: "/views/**/*.view"





view: sales {
  derived_table: {
    sql: select "1" as transaction_id,  date("2020-06-06") as date,  "6" as product_id,  "65" as salesperson_id,  "17" as customer_id,  "6" as office_id,  5 as hours,  9740 as sales,  "Florida" as transaction_state, union all
        select "2" as transaction_id,  date("2021-07-30") as date,  "2" as product_id,  "30" as salesperson_id,  "8" as customer_id,  "4" as office_id,  62 as hours,  98146 as sales,  "Iowa" as transaction_state, union all
        select "3" as transaction_id,  date("2021-01-05") as date,  "5" as product_id,  "15" as salesperson_id,  "5" as customer_id,  "3" as office_id,  3 as hours,  4899 as sales,  "New York" as transaction_state, union all
        select "4" as transaction_id,  date("2020-08-19") as date,  "8" as product_id,  "2" as salesperson_id,  "19" as customer_id,  "2" as office_id,  5 as hours,  6625 as sales,  "Utah" as transaction_state, union all
        select "5" as transaction_id,  date("2020-02-27") as date,  "8" as product_id,  "48" as salesperson_id,  "18" as customer_id,  "10" as office_id,  3 as hours,  3975 as sales,  "Alabama" as transaction_state, union all
        select "6" as transaction_id,  date("2021-06-24") as date,  "3" as product_id,  "20" as salesperson_id,  "1" as customer_id,  "3" as office_id,  19 as hours,  36176 as sales,  "Missouri" as transaction_state, union all
        select "7" as transaction_id,  date("2021-10-23") as date,  "5" as product_id,  "13" as salesperson_id,  "3" as customer_id,  "3" as office_id,  53 as hours,  86549 as sales,  "New York" as transaction_state, union all
        select "8" as transaction_id,  date("2020-01-21") as date,  "5" as product_id,  "63" as salesperson_id,  "16" as customer_id,  "1" as office_id,  15 as hours,  24495 as sales,  "California" as transaction_state, union all
        select "9" as transaction_id,  date("2021-09-18") as date,  "11" as product_id,  "73" as salesperson_id,  "17" as customer_id,  "1" as office_id,  52 as hours,  63284 as sales,  "New York" as transaction_state, union all
        select "10" as transaction_id,  date("2020-10-16") as date,  "11" as product_id,  "99" as salesperson_id,  "1" as customer_id,  "9" as office_id,  95 as hours,  115615 as sales,  "California" as transaction_state;;
  }

  drill_fields: [transaction_date,transaction_date,is_expensive,total_sales]


  dimension: transaction_id {
    type: string
    sql: ${TABLE}.transaction_id ;;
    view_label: "sales"
  }
  dimension: office_id {
    type: string
    sql: ${TABLE}.office_id ;;
    view_label: "sales"
  }

  dimension: transaction_date {
    type:  date
    sql: ${TABLE}.date ;;
    label: "Sales Date - Purchased"
  }

  dimension_group: transaction_date_group {
    type: time
    timeframes: [date, week, month, year, raw]
    datatype: date
    sql: ${transaction_date} ;;
    view_label: "sales"
  }

  dimension: sales {
    type:  number
    sql: ${TABLE}.sales ;;
    view_label: "sales"
  }

  dimension: is_expensive {
    type: yesno
    sql: ${TABLE}.sales > 25000 ;;
    description: "A sale is expensive when the total sales amount is greater than $25,000"
    view_label: "sales"
  }

  dimension: sales_groups {
    type:  bin
    sql: ${TABLE}.sales ;;
    style: integer
    bins: [0, 100000, 200000, 300000]
  }

  dimension: state {
    sql: ${TABLE}.transaction_state ;;
    type:  string
    group_label: "Location"
    group_item_label: "Sale State"
    map_layer_name: us_states
  }

  dimension: state_groupings {
    type:  string
    case: {
      when: {
        sql:  ${TABLE}.transaction_state in ("Florida", "Alabama", "Missouri");;
        label: "Southern States"
      }
      when: {
        sql: ${TABLE}.transaction_state in ("California") ;;
        label: "West Coast"
      }
      else: "Other States"
    }
    group_label: "Location"
  }

  measure: count {
    type:  count
    view_label: "sales"
  }

  measure: total_sales {
    type: sum
    sql: ${TABLE}.sales ;;
    value_format_name: thousands
    view_label: "sales"
  }

  measure: average_sales {
    type:  average
    sql: ${TABLE}.sales ;;
    value_format_name: thousands
    view_label: "sales"
  }

  measure: list_of_transactions {
    type:  list
    list_field: transaction_id
    view_label: "sales"
  }

  measure: nonaggregate_sales {
    type:  number
    sql: ${TABLE}.sales ;;
    view_label: "sales"
  }

  measure: percent_of_total_sales {
    type: percent_of_total
    sql:  ${total_sales};;
    view_label: "sales"

  }

}

view: product {
  derived_table: {
    sql:  select "1" as product_id,  "Back Truck" as product_name,  "Medium" as product_category,  1238 as product_hourly_price, union all
      select "2" as product_id,  "Bulldozer" as product_name,  "Medium" as product_category,  1583 as product_hourly_price, union all
      select "3" as product_id,  "Compactor" as product_name,  "Light" as product_category,  1904 as product_hourly_price, union all
      select "4" as product_id,  "Crawler" as product_name,  "Light" as product_category,  1735 as product_hourly_price, union all
      select "5" as product_id,  "Dragline" as product_name,  "Light" as product_category,  1633 as product_hourly_price, union all
      select "6" as product_id,  "Dump Truck" as product_name,  "Heavy" as product_category,  1948 as product_hourly_price, union all
      select "7" as product_id,  "Excavator" as product_name,  "Heavy" as product_category,  1979 as product_hourly_price, union all
      select "8" as product_id,  "Grader" as product_name,  "Heavy" as product_category,  1325 as product_hourly_price, union all
      select "9" as product_id,  "Scraper" as product_name,  "Heavy" as product_category,  1894 as product_hourly_price, union all
      select "10" as product_id,  "Skid-Steer" as product_name,  "Medium" as product_category,  1506 as product_hourly_price, union all
      select "11" as product_id,  "Trencher" as product_name,  "Medium" as product_category,  1217 as product_hourly_price;;
  }

  dimension: product_id {
    type:  string
    sql: ${TABLE}.product_id ;;
    view_label: "product"
  }

  dimension: product_name {
    type: string
    sql: ${TABLE}.product_name ;;
    view_label: "product"
  }

  dimension: product_hourly_price {
    type: string
    value_format_name: usd_0
    sql: ${TABLE}.product_hourly_price ;;
    view_label: "product"
  }

  measure: count {
    type:  count
    view_label: "product"
  }


}



view: office {
  derived_table: {
    sql:  select "1" as office_id,  "New York City" as office_name,  "10009" as office_zipcode,  "1" as head_salesperson_id, union all
      select "2" as office_id,  "Dallas" as office_name,  "75001" as office_zipcode,  "2" as head_salesperson_id, union all
      select "3" as office_id,  "Houston" as office_name,  "77001" as office_zipcode,  "3" as head_salesperson_id, union all
      select "4" as office_id,  "Detroit" as office_name,  "48127" as office_zipcode,  "4" as head_salesperson_id, union all
      select "5" as office_id,  "Miami" as office_name,  "33101" as office_zipcode,  "5" as head_salesperson_id, union all
      select "6" as office_id,  "Orlando" as office_name,  "32789" as office_zipcode,  "6" as head_salesperson_id, union all
      select "7" as office_id,  "Seattle" as office_name,  "98101" as office_zipcode,  "7" as head_salesperson_id, union all
      select "8" as office_id,  "San Francisco" as office_name,  "94016" as office_zipcode,  "8" as head_salesperson_id, union all
      select "9" as office_id,  "Los Angeles" as office_name,  "90005" as office_zipcode,  "9" as head_salesperson_id, union all
      select "10" as office_id,  "Austin" as office_name,  "73301" as office_zipcode,  "10" as head_salesperson_id
      ;;
  }

  dimension: office_id {
    type:  string
    sql:  ${TABLE}.office_id ;;
    view_label: "office"
  }

  dimension: office_name {
    type:  string
    sql:  ${TABLE}.office_name ;;
    view_label: "office"
  }

  dimension: office_zip_code {
    type: zipcode
    sql: ${TABLE}.office_zipcode ;;
    view_label: "office"
  }

  measure: count {
    type:  count
    view_label: "office"
  }

}
