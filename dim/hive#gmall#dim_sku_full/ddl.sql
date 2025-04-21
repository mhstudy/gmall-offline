CREATE EXTERNAL TABLE dim_sku_full
(
    `id`                   STRING COMMENT 'SKU_ID',
    `price`                DECIMAL(16, 2) COMMENT '商品价格',
    `sku_name`             STRING COMMENT '商品名称',
    `sku_desc`             STRING COMMENT '商品描述',
    `weight`               DECIMAL(16, 2) COMMENT '重量',
    `is_sale`              BOOLEAN COMMENT '是否在售',
    `spu_id`               STRING COMMENT 'SPU编号',
    `spu_name`             STRING COMMENT 'SPU名称',
    `category3_id`         STRING COMMENT '三级品类ID',
    `category3_name`       STRING COMMENT '三级品类名称',
    `category2_id`         STRING COMMENT '二级品类id',
    `category2_name`       STRING COMMENT '二级品类名称',
    `category1_id`         STRING COMMENT '一级品类ID',
    `category1_name`       STRING COMMENT '一级品类名称',
    `tm_id`                  STRING COMMENT '品牌ID',
    `tm_name`               STRING COMMENT '品牌名称',
    `sku_attr_values`      ARRAY<STRUCT<attr_id :STRING,
        value_id :STRING,
        attr_name :STRING,
        value_name:STRING>> COMMENT '平台属性',
    `sku_sale_attr_values` ARRAY<STRUCT<sale_attr_id :STRING,
        sale_attr_value_id :STRING,
        sale_attr_name :STRING,
        sale_attr_value_name:STRING>> COMMENT '销售属性',
    `create_time`          STRING COMMENT '创建时间'
) COMMENT '商品维度表'
    PARTITIONED BY (`dt` STRING)
    STORED AS ORC
    LOCATION '/warehouse/gmall/dim/dim_sku_full/'
    TBLPROPERTIES ('orc.compress' = 'snappy');
