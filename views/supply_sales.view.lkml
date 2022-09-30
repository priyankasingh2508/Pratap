# The name of this view in Looker is "Supply Sales"
view: supply_sales {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `Priyanka_Data.SupplySales`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called " Total Cost " in Explore.

  dimension: _total_cost_ {
    type: number
    sql: ${TABLE}._Total_Cost_ ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total__total_cost_ {
    type: sum
    sql: ${_total_cost_} ;;
  }

  measure: average__total_cost_ {
    type: average
    sql: ${_total_cost_} ;;
  }

  dimension: _unit_cost_ {
    type: number
    sql: ${TABLE}._Unit_Cost_ ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country ;;
  }

  dimension: discount {
    type: number
    sql: ${TABLE}.discount ;;
  }

  dimension: discounted_price {
    type: number
    sql: ${TABLE}.Discounted_Price ;;
  }

  dimension: item {
    type: string
    sql: ${TABLE}.Item ;;
  }

  dimension: item_type {
    type: string
    sql: ${TABLE}.Item_type ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: order {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.OrderDate ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.Region ;;
  }

  dimension: rep {
    type: string
    sql: ${TABLE}.Rep ;;
  }

  dimension: units {
    type: number
    sql: ${TABLE}.Units ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
