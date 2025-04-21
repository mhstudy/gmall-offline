CREATE EXTERNAL TABLE dws_trade_user_sku_order_1d
(
    `user_id`                   STRING COMMENT '用户ID',
    `sku_id`                    STRING COMMENT 'SKU_ID',
    `sku_name`                  STRING COMMENT 'SKU名称',
    `category1_id`              STRING COMMENT '一级品类ID',
    `category1_name`            STRING COMMENT '一级品类名称',
    `category2_id`              STRING COMMENT '二级品类ID',
    `category2_name`            STRING COMMENT '二级品类名称',
    `category3_id`              STRING COMMENT '三级品类ID',
    `category3_name`            STRING COMMENT '三级品类名称',
    `tm_id`                      STRING COMMENT '品牌ID',
    `tm_name`                    STRING COMMENT '品牌名称',
    `order_count_1d`            BIGINT COMMENT '最近1日下单次数',
    `order_num_1d`              BIGINT COMMENT '最近1日下单件数',
    `order_original_amount_1d`  DECIMAL(16, 2) COMMENT '最近1日下单原始金额',
    `activity_reduce_amount_1d` DECIMAL(16, 2) COMMENT '最近1日活动优惠金额',
    `coupon_reduce_amount_1d`   DECIMAL(16, 2) COMMENT '最近1日优惠券优惠金额',
    `order_total_amount_1d`     DECIMAL(16, 2) COMMENT '最近1日下单最终金额'
) COMMENT '交易域用户商品粒度订单最近1日汇总表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dws/dws_trade_user_sku_order_1d'
    TBLPROPERTIES ('orc.compress' = 'snappy');
