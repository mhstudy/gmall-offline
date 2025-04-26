-- 首日加载脚本
set hive.exec.dynamic.partition.mode=nonstrict;
-- Hive的bug：对某些类型数据的处理可能会导致报错，关闭矢量化查询优化解决
set hive.vectorized.execution.enabled = false;
insert overwrite table dws_trade_user_sku_order_1d partition(dt)
select
    user_id,
    id,
    sku_name,
    category1_id,
    category1_name,
    category2_id,
    category2_name,
    category3_id,
    category3_name,
    tm_id,
    tm_name,
    order_count_1d,
    order_num_1d,
    order_original_amount_1d,
    activity_reduce_amount_1d,
    coupon_reduce_amount_1d,
    order_total_amount_1d,
    dt
from
(
    select
        dt,
        user_id,
        sku_id,
        count(*) order_count_1d,
        sum(sku_num) order_num_1d,
        sum(split_original_amount) order_original_amount_1d,
        sum(nvl(split_activity_amount,0.0)) activity_reduce_amount_1d,
        sum(nvl(split_coupon_amount,0.0)) coupon_reduce_amount_1d,
        sum(split_total_amount) order_total_amount_1d
    from dwd_trade_order_detail_inc
    group by dt,user_id,sku_id
)od
left join
(
    select
        id,
        sku_name,
        category1_id,
        category1_name,
        category2_id,
        category2_name,
        category3_id,
        category3_name,
        tm_id,
        tm_name
    from dim_sku_full
    where dt='2022-06-08'
)sku
on od.sku_id=sku.id;
-- 矢量化查询优化可以一定程度上提升执行效率，不会触发前述Bug时，应打开
set hive.vectorized.execution.enabled = true;



-- 每日加载脚本
set hive.vectorized.execution.enabled = false;
insert overwrite table dws_trade_user_sku_order_1d partition(dt='2022-06-09')
select
    user_id,
    id,
    sku_name,
    category1_id,
    category1_name,
    category2_id,
    category2_name,
    category3_id,
    category3_name,
    tm_id,
    tm_name,
    order_count,
    order_num,
    order_original_amount,
    activity_reduce_amount,
    coupon_reduce_amount,
    order_total_amount
from
(
    select
        user_id,
        sku_id,
        count(*) order_count,
        sum(sku_num) order_num,
        sum(split_original_amount) order_original_amount,
        sum(nvl(split_activity_amount,0)) activity_reduce_amount,
        sum(nvl(split_coupon_amount,0)) coupon_reduce_amount,
        sum(split_total_amount) order_total_amount
    from dwd_trade_order_detail_inc
    where dt='2022-06-09'
    group by user_id,sku_id
)od
left join
(
    select
        id,
        sku_name,
        category1_id,
        category1_name,
        category2_id,
        category2_name,
        category3_id,
        category3_name,
        tm_id,
        tm_name
    from dim_sku_full
    where dt='2022-06-09'
)sku
on od.sku_id=sku.id;
set hive.vectorized.execution.enabled = true;
