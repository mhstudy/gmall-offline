DROP TABLE IF EXISTS ods_log_inc;
CREATE EXTERNAL TABLE ods_log_inc
(
    `common` STRUCT<ar :STRING,
        ba :STRING,
        ch :STRING,
        is_new :STRING,
        md :STRING,
        mid :STRING,
        os :STRING,
        sid :STRING,
        uid :STRING,
        vc :STRING> COMMENT '公共信息',
    `page` STRUCT<during_time :STRING,
        item :STRING,
        item_type :STRING,
        last_page_id :STRING,
        page_id :STRING,
        from_pos_id :STRING,
        from_pos_seq :STRING,
        refer_id :STRING> COMMENT '页面信息',
    `actions` ARRAY<STRUCT<action_id:STRING,
        item:STRING,
        item_type:STRING,
        ts:BIGINT>> COMMENT '动作信息',
    `displays` ARRAY<STRUCT<display_type :STRING,
        item :STRING,
        item_type :STRING,
        `pos_seq` :STRING,
        pos_id :STRING>> COMMENT '曝光信息',
    `start` STRUCT<entry :STRING,
        first_open :BIGINT,
        loading_time :BIGINT,
        open_ad_id :BIGINT,
        open_ad_ms :BIGINT,
        open_ad_skip_ms :BIGINT> COMMENT '启动信息',
    `err` STRUCT<error_code:BIGINT,
            msg:STRING> COMMENT '错误信息',
    `ts` BIGINT  COMMENT '时间戳'
) COMMENT '活动信息表'
    PARTITIONED BY (`dt` STRING)
    ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.JsonSerDe'
LOCATION '/warehouse/gmall/ods/ods_log_inc/'
TBLPROPERTIES ('compression.codec'='org.apache.hadoop.io.compress.GzipCodec');
