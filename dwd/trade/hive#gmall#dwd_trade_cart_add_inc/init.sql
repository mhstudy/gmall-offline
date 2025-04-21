set hive.exec.dynamic.partition.mode=nonstrict;

insert overwrite table ${APP}.dwd_trade_cart_add_inc partition (dt)
select data.id,
       data.user_id,
       data.sku_id,
       date_format(data.create_time, 'yyyy-MM-dd') date_id,
       data.create_time,
       data.sku_num,
       date_format(data.create_time, 'yyyy-MM-dd')
from ${APP}.ods_cart_info_inc
where dt = '$do_date'
  and type = 'bootstrap-insert'
