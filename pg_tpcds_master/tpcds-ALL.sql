-- 
-- Legal Notice 
-- 
-- This document and associated source code (the "Work") is a part of a 
-- benchmark specification maintained by the TPC. 
-- 
-- The TPC reserves all right, title, and interest to the Work as provided 
-- under U.S. and international laws, including without limitation all patent 
-- and trademark rights therein. 
-- 
-- No Warranty 
-- 
-- 1.1 TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, THE INFORMATION 
--     CONTAINED HEREIN IS PROVIDED "AS IS" AND WITH ALL FAULTS, AND THE 
--     AUTHORS AND DEVELOPERS OF THE WORK HEREBY DISCLAIM ALL OTHER 
--     WARRANTIES AND CONDITIONS, EITHER EXPRESS, IMPLIED OR STATUTORY, 
--     INCLUDING, BUT NOT LIMITED TO, ANY (IF ANY) IMPLIED WARRANTIES, 
--     DUTIES OR CONDITIONS OF MERCHANTABILITY, OF FITNESS FOR A PARTICULAR 
--     PURPOSE, OF ACCURACY OR COMPLETENESS OF RESPONSES, OF RESULTS, OF 
--     WORKMANLIKE EFFORT, OF LACK OF VIRUSES, AND OF LACK OF NEGLIGENCE. 
--     ALSO, THERE IS NO WARRANTY OR CONDITION OF TITLE, QUIET ENJOYMENT, 
--     QUIET POSSESSION, CORRESPONDENCE TO DESCRIPTION OR NON-INFRINGEMENT 
--     WITH REGARD TO THE WORK. 
-- 1.2 IN NO EVENT WILL ANY AUTHOR OR DEVELOPER OF THE WORK BE LIABLE TO 
--     ANY OTHER PARTY FOR ANY DAMAGES, INCLUDING BUT NOT LIMITED TO THE 
--     COST OF PROCURING SUBSTITUTE GOODS OR SERVICES, LOST PROFITS, LOSS 
--     OF USE, LOSS OF DATA, OR ANY INCIDENTAL, CONSEQUENTIAL, DIRECT, 
--     INDIRECT, OR SPECIAL DAMAGES WHETHER UNDER CONTRACT, TORT, WARRANTY,
--     OR OTHERWISE, ARISING IN ANY WAY OUT OF THIS OR ANY OTHER AGREEMENT 
--     RELATING TO THE WORK, WHETHER OR NOT SUCH AUTHOR OR DEVELOPER HAD 
--     ADVANCE NOTICE OF THE POSSIBILITY OF SUCH DAMAGES. 
-- 
-- Contributors:
-- Gradient Systems
--

--creating schema
create table call_center
(
    cc_call_center_sk         integer               not null,
    cc_call_center_id         char(16)              not null,
    cc_rec_start_date         date                          ,
    cc_rec_end_date           date                          ,
    cc_closed_date_sk         integer                       ,
    cc_open_date_sk           integer                       ,
    cc_name                   varchar(50)                   ,
    cc_class                  varchar(50)                   ,
    cc_employees              integer                       ,
    cc_sq_ft                  integer                       ,
    cc_hours                  char(20)                      ,
    cc_manager                varchar(40)                   ,
    cc_mkt_id                 integer                       ,
    cc_mkt_class              char(50)                      ,
    cc_mkt_desc               varchar(100)                  ,
    cc_market_manager         varchar(40)                   ,
    cc_division               integer                       ,
    cc_division_name          varchar(50)                   ,
    cc_company                integer                       ,
    cc_company_name           char(50)                      ,
    cc_street_number          char(10)                      ,
    cc_street_name            varchar(60)                   ,
    cc_street_type            char(15)                      ,
    cc_suite_number           char(10)                      ,
    cc_city                   varchar(60)                   ,
    cc_county                 varchar(30)                   ,
    cc_state                  char(2)                       ,
    cc_zip                    char(10)                      ,
    cc_country                varchar(20)                   ,
    cc_gmt_offset             decimal(5,2)                  ,
    cc_tax_percentage         decimal(5,2)                  ,
    primary key (cc_call_center_sk)
);

create table catalog_page
(
    cp_catalog_page_sk        integer               not null,
    cp_catalog_page_id        char(16)              not null,
    cp_start_date_sk          integer                       ,
    cp_end_date_sk            integer                       ,
    cp_department             varchar(50)                   ,
    cp_catalog_number         integer                       ,
    cp_catalog_page_number    integer                       ,
    cp_description            varchar(100)                  ,
    cp_type                   varchar(100)                  ,
    primary key (cp_catalog_page_sk)
);

create table catalog_returns
(
    cr_returned_date_sk       integer                       ,
    cr_returned_time_sk       integer                       ,
    cr_item_sk                integer               not null,
    cr_refunded_customer_sk   integer                       ,
    cr_refunded_cdemo_sk      integer                       ,
    cr_refunded_hdemo_sk      integer                       ,
    cr_refunded_addr_sk       integer                       ,
    cr_returning_customer_sk  integer                       ,
    cr_returning_cdemo_sk     integer                       ,
    cr_returning_hdemo_sk     integer                       ,
    cr_returning_addr_sk      integer                       ,
    cr_call_center_sk         integer                       ,
    cr_catalog_page_sk        integer                       ,
    cr_ship_mode_sk           integer                       ,
    cr_warehouse_sk           integer                       ,
    cr_reason_sk              integer                       ,
    cr_order_number           integer               not null,
    cr_return_quantity        integer                       ,
    cr_return_amount          decimal(7,2)                  ,
    cr_return_tax             decimal(7,2)                  ,
    cr_return_amt_inc_tax     decimal(7,2)                  ,
    cr_fee                    decimal(7,2)                  ,
    cr_return_ship_cost       decimal(7,2)                  ,
    cr_refunded_cash          decimal(7,2)                  ,
    cr_reversed_charge        decimal(7,2)                  ,
    cr_store_credit           decimal(7,2)                  ,
    cr_net_loss               decimal(7,2)                  ,
    primary key (cr_item_sk, cr_order_number)
);

create table catalog_sales
(
    cs_sold_date_sk           integer                       ,
    cs_sold_time_sk           integer                       ,
    cs_ship_date_sk           integer                       ,
    cs_bill_customer_sk       integer                       ,
    cs_bill_cdemo_sk          integer                       ,
    cs_bill_hdemo_sk          integer                       ,
    cs_bill_addr_sk           integer                       ,
    cs_ship_customer_sk       integer                       ,
    cs_ship_cdemo_sk          integer                       ,
    cs_ship_hdemo_sk          integer                       ,
    cs_ship_addr_sk           integer                       ,
    cs_call_center_sk         integer                       ,
    cs_catalog_page_sk        integer                       ,
    cs_ship_mode_sk           integer                       ,
    cs_warehouse_sk           integer                       ,
    cs_item_sk                integer               not null,
    cs_promo_sk               integer                       ,
    cs_order_number           integer               not null,
    cs_quantity               integer                       ,
    cs_wholesale_cost         decimal(7,2)                  ,
    cs_list_price             decimal(7,2)                  ,
    cs_sales_price            decimal(7,2)                  ,
    cs_ext_discount_amt       decimal(7,2)                  ,
    cs_ext_sales_price        decimal(7,2)                  ,
    cs_ext_wholesale_cost     decimal(7,2)                  ,
    cs_ext_list_price         decimal(7,2)                  ,
    cs_ext_tax                decimal(7,2)                  ,
    cs_coupon_amt             decimal(7,2)                  ,
    cs_ext_ship_cost          decimal(7,2)                  ,
    cs_net_paid               decimal(7,2)                  ,
    cs_net_paid_inc_tax       decimal(7,2)                  ,
    cs_net_paid_inc_ship      decimal(7,2)                  ,
    cs_net_paid_inc_ship_tax  decimal(7,2)                  ,
    cs_net_profit             decimal(7,2)                  ,
    primary key (cs_item_sk, cs_order_number)
);

create table customer
(
    c_customer_sk             integer               not null,
    c_customer_id             char(16)              not null,
    c_current_cdemo_sk        integer                       ,
    c_current_hdemo_sk        integer                       ,
    c_current_addr_sk         integer                       ,
    c_first_shipto_date_sk    integer                       ,
    c_first_sales_date_sk     integer                       ,
    c_salutation              char(10)                      ,
    c_first_name              char(20)                      ,
    c_last_name               char(30)                      ,
    c_preferred_cust_flag     char(1)                       ,
    c_birth_day               integer                       ,
    c_birth_month             integer                       ,
    c_birth_year              integer                       ,
    c_birth_country           varchar(20)                   ,
    c_login                   char(13)                      ,
    c_email_address           char(50)                      ,
    c_last_review_date        char(10)                      ,
    primary key (c_customer_sk)
);

create table customer_address
(
    ca_address_sk             integer               not null,
    ca_address_id             char(16)              not null,
    ca_street_number          char(10)                      ,
    ca_street_name            varchar(60)                   ,
    ca_street_type            char(15)                      ,
    ca_suite_number           char(10)                      ,
    ca_city                   varchar(60)                   ,
    ca_county                 varchar(30)                   ,
    ca_state                  char(2)                       ,
    ca_zip                    char(10)                      ,
    ca_country                varchar(20)                   ,
    ca_gmt_offset             decimal(5,2)                  ,
    ca_location_type          char(20)                      ,
    primary key (ca_address_sk)
);

create table customer_demographics
(
    cd_demo_sk                integer               not null,
    cd_gender                 char(1)                       ,
    cd_marital_status         char(1)                       ,
    cd_education_status       char(20)                      ,
    cd_purchase_estimate      integer                       ,
    cd_credit_rating          char(10)                      ,
    cd_dep_count              integer                       ,
    cd_dep_employed_count     integer                       ,
    cd_dep_college_count      integer                       ,
    primary key (cd_demo_sk)
);

create table date_dim
(
    d_date_sk                 integer               not null,
    d_date_id                 char(16)              not null,
    d_date                    date                          ,
    d_month_seq               integer                       ,
    d_week_seq                integer                       ,
    d_quarter_seq             integer                       ,
    d_year                    integer                       ,
    d_dow                     integer                       ,
    d_moy                     integer                       ,
    d_dom                     integer                       ,
    d_qoy                     integer                       ,
    d_fy_year                 integer                       ,
    d_fy_quarter_seq          integer                       ,
    d_fy_week_seq             integer                       ,
    d_day_name                char(9)                       ,
    d_quarter_name            char(6)                       ,
    d_holiday                 char(1)                       ,
    d_weekend                 char(1)                       ,
    d_following_holiday       char(1)                       ,
    d_first_dom               integer                       ,
    d_last_dom                integer                       ,
    d_same_day_ly             integer                       ,
    d_same_day_lq             integer                       ,
    d_current_day             char(1)                       ,
    d_current_week            char(1)                       ,
    d_current_month           char(1)                       ,
    d_current_quarter         char(1)                       ,
    d_current_year            char(1)                       ,
    primary key (d_date_sk)
);

create table household_demographics
(
    hd_demo_sk                integer               not null,
    hd_income_band_sk         integer                       ,
    hd_buy_potential          char(15)                      ,
    hd_dep_count              integer                       ,
    hd_vehicle_count          integer                       ,
    primary key (hd_demo_sk)
);

create table income_band
(
    ib_income_band_sk         integer               not null,
    ib_lower_bound            integer                       ,
    ib_upper_bound            integer                       ,
    primary key (ib_income_band_sk)
);

create table inventory
(
    inv_date_sk               integer               not null,
    inv_item_sk               integer               not null,
    inv_warehouse_sk          integer               not null,
    inv_quantity_on_hand      integer                       ,
    primary key (inv_date_sk, inv_item_sk, inv_warehouse_sk)
);

create table item
(
    i_item_sk                 integer               not null,
    i_item_id                 char(16)              not null,
    i_rec_start_date          date                          ,
    i_rec_end_date            date                          ,
    i_item_desc               varchar(200)                  ,
    i_current_price           decimal(7,2)                  ,
    i_wholesale_cost          decimal(7,2)                  ,
    i_brand_id                integer                       ,
    i_brand                   char(50)                      ,
    i_class_id                integer                       ,
    i_class                   char(50)                      ,
    i_category_id             integer                       ,
    i_category                char(50)                      ,
    i_manufact_id             integer                       ,
    i_manufact                char(50)                      ,
    i_size                    char(20)                      ,
    i_formulation             char(20)                      ,
    i_color                   char(20)                      ,
    i_units                   char(10)                      ,
    i_container               char(10)                      ,
    i_manager_id              integer                       ,
    i_product_name            char(50)                      ,
    primary key (i_item_sk)
);

create table promotion
(
    p_promo_sk                integer               not null,
    p_promo_id                char(16)              not null,
    p_start_date_sk           integer                       ,
    p_end_date_sk             integer                       ,
    p_item_sk                 integer                       ,
    p_cost                    decimal(15,2)                 ,
    p_response_target         integer                       ,
    p_promo_name              char(50)                      ,
    p_channel_dmail           char(1)                       ,
    p_channel_email           char(1)                       ,
    p_channel_catalog         char(1)                       ,
    p_channel_tv              char(1)                       ,
    p_channel_radio           char(1)                       ,
    p_channel_press           char(1)                       ,
    p_channel_event           char(1)                       ,
    p_channel_demo            char(1)                       ,
    p_channel_details         varchar(100)                  ,
    p_purpose                 char(15)                      ,
    p_discount_active         char(1)                       ,
    primary key (p_promo_sk)
);

create table reason
(
    r_reason_sk               integer               not null,
    r_reason_id               char(16)              not null,
    r_reason_desc             char(100)                     ,
    primary key (r_reason_sk)
);

create table ship_mode
(
    sm_ship_mode_sk           integer               not null,
    sm_ship_mode_id           char(16)              not null,
    sm_type                   char(30)                      ,
    sm_code                   char(10)                      ,
    sm_carrier                char(20)                      ,
    sm_contract               char(20)                      ,
    primary key (sm_ship_mode_sk)
);

create table store
(
    s_store_sk                integer               not null,
    s_store_id                char(16)              not null,
    s_rec_start_date          date                          ,
    s_rec_end_date            date                          ,
    s_closed_date_sk          integer                       ,
    s_store_name              varchar(50)                   ,
    s_number_employees        integer                       ,
    s_floor_space             integer                       ,
    s_hours                   char(20)                      ,
    s_manager                 varchar(40)                   ,
    s_market_id               integer                       ,
    s_geography_class         varchar(100)                  ,
    s_market_desc             varchar(100)                  ,
    s_market_manager          varchar(40)                   ,
    s_division_id             integer                       ,
    s_division_name           varchar(50)                   ,
    s_company_id              integer                       ,
    s_company_name            varchar(50)                   ,
    s_street_number           varchar(10)                   ,
    s_street_name             varchar(60)                   ,
    s_street_type             char(15)                      ,
    s_suite_number            char(10)                      ,
    s_city                    varchar(60)                   ,
    s_county                  varchar(30)                   ,
    s_state                   char(2)                       ,
    s_zip                     char(10)                      ,
    s_country                 varchar(20)                   ,
    s_gmt_offset              decimal(5,2)                  ,
    s_tax_precentage          decimal(5,2)                  ,
    primary key (s_store_sk)
);

create table store_returns
(
    sr_returned_date_sk       integer                       ,
    sr_return_time_sk         integer                       ,
    sr_item_sk                integer               not null,
    sr_customer_sk            integer                       ,
    sr_cdemo_sk               integer                       ,
    sr_hdemo_sk               integer                       ,
    sr_addr_sk                integer                       ,
    sr_store_sk               integer                       ,
    sr_reason_sk              integer                       ,
    sr_ticket_number          integer               not null,
    sr_return_quantity        integer                       ,
    sr_return_amt             decimal(7,2)                  ,
    sr_return_tax             decimal(7,2)                  ,
    sr_return_amt_inc_tax     decimal(7,2)                  ,
    sr_fee                    decimal(7,2)                  ,
    sr_return_ship_cost       decimal(7,2)                  ,
    sr_refunded_cash          decimal(7,2)                  ,
    sr_reversed_charge        decimal(7,2)                  ,
    sr_store_credit           decimal(7,2)                  ,
    sr_net_loss               decimal(7,2)                  ,
    primary key (sr_item_sk, sr_ticket_number)
);

create table store_sales
(
    ss_sold_date_sk           integer                       ,
    ss_sold_time_sk           integer                       ,
    ss_item_sk                integer               not null,
    ss_customer_sk            integer                       ,
    ss_cdemo_sk               integer                       ,
    ss_hdemo_sk               integer                       ,
    ss_addr_sk                integer                       ,
    ss_store_sk               integer                       ,
    ss_promo_sk               integer                       ,
    ss_ticket_number          integer               not null,
    ss_quantity               integer                       ,
    ss_wholesale_cost         decimal(7,2)                  ,
    ss_list_price             decimal(7,2)                  ,
    ss_sales_price            decimal(7,2)                  ,
    ss_ext_discount_amt       decimal(7,2)                  ,
    ss_ext_sales_price        decimal(7,2)                  ,
    ss_ext_wholesale_cost     decimal(7,2)                  ,
    ss_ext_list_price         decimal(7,2)                  ,
    ss_ext_tax                decimal(7,2)                  ,
    ss_coupon_amt             decimal(7,2)                  ,
    ss_net_paid               decimal(7,2)                  ,
    ss_net_paid_inc_tax       decimal(7,2)                  ,
    ss_net_profit             decimal(7,2)                  ,
    primary key (ss_item_sk, ss_ticket_number)
);

create table time_dim
(
    t_time_sk                 integer               not null,
    t_time_id                 char(16)              not null,
    t_time                    integer                       ,
    t_hour                    integer                       ,
    t_minute                  integer                       ,
    t_second                  integer                       ,
    t_am_pm                   char(2)                       ,
    t_shift                   char(20)                      ,
    t_sub_shift               char(20)                      ,
    t_meal_time               char(20)                      ,
    primary key (t_time_sk)
);

create table warehouse
(
    w_warehouse_sk            integer               not null,
    w_warehouse_id            char(16)              not null,
    w_warehouse_name          varchar(20)                   ,
    w_warehouse_sq_ft         integer                       ,
    w_street_number           char(10)                      ,
    w_street_name             varchar(60)                   ,
    w_street_type             char(15)                      ,
    w_suite_number            char(10)                      ,
    w_city                    varchar(60)                   ,
    w_county                  varchar(30)                   ,
    w_state                   char(2)                       ,
    w_zip                     char(10)                      ,
    w_country                 varchar(20)                   ,
    w_gmt_offset              decimal(5,2)                  ,
    primary key (w_warehouse_sk)
);

create table web_page
(
    wp_web_page_sk            integer               not null,
    wp_web_page_id            char(16)              not null,
    wp_rec_start_date         date                          ,
    wp_rec_end_date           date                          ,
    wp_creation_date_sk       integer                       ,
    wp_access_date_sk         integer                       ,
    wp_autogen_flag           char(1)                       ,
    wp_customer_sk            integer                       ,
    wp_url                    varchar(100)                  ,
    wp_type                   char(50)                      ,
    wp_char_count             integer                       ,
    wp_link_count             integer                       ,
    wp_image_count            integer                       ,
    wp_max_ad_count           integer                       ,
    primary key (wp_web_page_sk)
);

create table web_returns
(
    wr_returned_date_sk       integer                       ,
    wr_returned_time_sk       integer                       ,
    wr_item_sk                integer               not null,
    wr_refunded_customer_sk   integer                       ,
    wr_refunded_cdemo_sk      integer                       ,
    wr_refunded_hdemo_sk      integer                       ,
    wr_refunded_addr_sk       integer                       ,
    wr_returning_customer_sk  integer                       ,
    wr_returning_cdemo_sk     integer                       ,
    wr_returning_hdemo_sk     integer                       ,
    wr_returning_addr_sk      integer                       ,
    wr_web_page_sk            integer                       ,
    wr_reason_sk              integer                       ,
    wr_order_number           integer               not null,
    wr_return_quantity        integer                       ,
    wr_return_amt             decimal(7,2)                  ,
    wr_return_tax             decimal(7,2)                  ,
    wr_return_amt_inc_tax     decimal(7,2)                  ,
    wr_fee                    decimal(7,2)                  ,
    wr_return_ship_cost       decimal(7,2)                  ,
    wr_refunded_cash          decimal(7,2)                  ,
    wr_reversed_charge        decimal(7,2)                  ,
    wr_account_credit         decimal(7,2)                  ,
    wr_net_loss               decimal(7,2)                  ,
    primary key (wr_item_sk, wr_order_number)
);

create table web_sales
(
    ws_sold_date_sk           integer                       ,
    ws_sold_time_sk           integer                       ,
    ws_ship_date_sk           integer                       ,
    ws_item_sk                integer               not null,
    ws_bill_customer_sk       integer                       ,
    ws_bill_cdemo_sk          integer                       ,
    ws_bill_hdemo_sk          integer                       ,
    ws_bill_addr_sk           integer                       ,
    ws_ship_customer_sk       integer                       ,
    ws_ship_cdemo_sk          integer                       ,
    ws_ship_hdemo_sk          integer                       ,
    ws_ship_addr_sk           integer                       ,
    ws_web_page_sk            integer                       ,
    ws_web_site_sk            integer                       ,
    ws_ship_mode_sk           integer                       ,
    ws_warehouse_sk           integer                       ,
    ws_promo_sk               integer                       ,
    ws_order_number           integer               not null,
    ws_quantity               integer                       ,
    ws_wholesale_cost         decimal(7,2)                  ,
    ws_list_price             decimal(7,2)                  ,
    ws_sales_price            decimal(7,2)                  ,
    ws_ext_discount_amt       decimal(7,2)                  ,
    ws_ext_sales_price        decimal(7,2)                  ,
    ws_ext_wholesale_cost     decimal(7,2)                  ,
    ws_ext_list_price         decimal(7,2)                  ,
    ws_ext_tax                decimal(7,2)                  ,
    ws_coupon_amt             decimal(7,2)                  ,
    ws_ext_ship_cost          decimal(7,2)                  ,
    ws_net_paid               decimal(7,2)                  ,
    ws_net_paid_inc_tax       decimal(7,2)                  ,
    ws_net_paid_inc_ship      decimal(7,2)                  ,
    ws_net_paid_inc_ship_tax  decimal(7,2)                  ,
    ws_net_profit             decimal(7,2)                  ,
    primary key (ws_item_sk, ws_order_number)
);

create table web_site
(
    web_site_sk               integer               not null,
    web_site_id               char(16)              not null,
    web_rec_start_date        date                          ,
    web_rec_end_date          date                          ,
    web_name                  varchar(50)                   ,
    web_open_date_sk          integer                       ,
    web_close_date_sk         integer                       ,
    web_class                 varchar(50)                   ,
    web_manager               varchar(40)                   ,
    web_mkt_id                integer                       ,
    web_mkt_class             varchar(50)                   ,
    web_mkt_desc              varchar(100)                  ,
    web_market_manager        varchar(40)                   ,
    web_company_id            integer                       ,
    web_company_name          char(50)                      ,
    web_street_number         char(10)                      ,
    web_street_name           varchar(60)                   ,
    web_street_type           char(15)                      ,
    web_suite_number          char(10)                      ,
    web_city                  varchar(60)                   ,
    web_county                varchar(30)                   ,
    web_state                 char(2)                       ,
    web_zip                   char(10)                      ,
    web_country               varchar(20)                   ,
    web_gmt_offset            decimal(5,2)                  ,
    web_tax_percentage        decimal(5,2)                  ,
    primary key (web_site_sk)
);

create table dbgen_version
(
    dv_version                varchar(16)                   ,
    dv_create_date            date                          ,
    dv_create_time            time                          ,
    dv_cmdline_args           varchar(200)                  
);


----Copying data
COPY call_center FROM 'C:\\ACHINT\\shubhi\\dbproject\\dss2\\tpcds1\\call_center.csv' USING DELIMITERS '|' WITH NULL AS 'NULL' encoding 'windows-1251';
COPY catalog_page FROM 'C:\\ACHINT\\shubhi\\dbproject\\dss2\\tpcds1\\catalog_page.csv' USING DELIMITERS '|' WITH NULL AS 'NULL' encoding 'windows-1251';
COPY catalog_returns FROM 'C:\\ACHINT\\shubhi\\dbproject\\dss2\\tpcds1\\catalog_returns.csv' USING DELIMITERS '|' WITH NULL AS 'NULL' encoding 'windows-1251';
COPY catalog_sales FROM 'C:\\ACHINT\\shubhi\\dbproject\\dss2\\tpcds1\\catalog_sales.csv' USING DELIMITERS '|' WITH NULL AS 'NULL' encoding 'windows-1251';
COPY customer FROM 'C:\\ACHINT\\shubhi\\dbproject\\dss2\\tpcds1\\customer.csv' USING DELIMITERS '|' WITH NULL AS 'NULL' encoding 'windows-1251';
COPY customer_address FROM 'C:\\ACHINT\\shubhi\\dbproject\\dss2\\tpcds1\\customer_address.csv' USING DELIMITERS '|' WITH NULL AS 'NULL' encoding 'windows-1251';
COPY customer_demographics FROM 'C:\\ACHINT\\shubhi\\dbproject\\dss2\\tpcds1\\customer_demographics.csv' USING DELIMITERS '|' WITH NULL AS 'NULL' encoding 'windows-1251';
COPY date_dim FROM 'C:\\ACHINT\\shubhi\\dbproject\\dss2\\tpcds1\\date_dim.csv' USING DELIMITERS '|' WITH NULL AS 'NULL' encoding 'windows-1251';
COPY dbgen_version FROM 'C:\\ACHINT\\shubhi\\dbproject\\dss2\\tpcds1\\dbgen_version.csv' USING DELIMITERS '|' WITH NULL AS 'NULL' encoding 'windows-1251';
COPY household_demographics FROM 'C:\\ACHINT\\shubhi\\dbproject\\dss2\\tpcds1\\household_demographics.csv' USING DELIMITERS '|' WITH NULL AS 'NULL' encoding 'windows-1251';
COPY income_band FROM 'C:\\ACHINT\\shubhi\\dbproject\\dss2\\tpcds1\\income_band.csv' USING DELIMITERS '|' WITH NULL AS 'NULL' encoding 'windows-1251';
COPY inventory FROM 'C:\\ACHINT\\shubhi\\dbproject\\dss2\\tpcds1\\inventory.csv' USING DELIMITERS '|' WITH NULL AS 'NULL' encoding 'windows-1251';
COPY item FROM 'C:\\ACHINT\\shubhi\\dbproject\\dss2\\tpcds1\\item.csv' USING DELIMITERS '|' WITH NULL AS 'NULL' encoding 'windows-1251';
COPY promotion FROM 'C:\\ACHINT\\shubhi\\dbproject\\dss2\\tpcds1\\promotion.csv' USING DELIMITERS '|' WITH NULL AS 'NULL' encoding 'windows-1251';
COPY reason FROM 'C:\\ACHINT\\shubhi\\dbproject\\dss2\\tpcds1\\reason.csv' USING DELIMITERS '|' WITH NULL AS 'NULL' encoding 'windows-1251';
COPY ship_mode FROM 'C:\\ACHINT\\shubhi\\dbproject\\dss2\\tpcds1\\ship_mode.csv' USING DELIMITERS '|' WITH NULL AS 'NULL' encoding 'windows-1251';
COPY store FROM 'C:\\ACHINT\\shubhi\\dbproject\\dss2\\tpcds1\\store.csv' USING DELIMITERS '|' WITH NULL AS 'NULL' encoding 'windows-1251';
COPY store_returns FROM 'C:\\ACHINT\\shubhi\\dbproject\\dss2\\tpcds1\\store_returns.csv' USING DELIMITERS '|' WITH NULL AS 'NULL' encoding 'windows-1251';
COPY store_sales FROM 'C:\\ACHINT\\shubhi\\dbproject\\dss2\\tpcds1\\store_sales.csv' USING DELIMITERS '|' WITH NULL AS 'NULL' encoding 'windows-1251';
COPY time_dim FROM 'C:\\ACHINT\\shubhi\\dbproject\\dss2\\tpcds1\\time_dim.csv' USING DELIMITERS '|' WITH NULL AS 'NULL' encoding 'windows-1251';
COPY warehouse FROM 'C:\\ACHINT\\shubhi\\dbproject\\dss2\\tpcds1\\warehouse.csv' USING DELIMITERS '|' WITH NULL AS 'NULL' encoding 'windows-1251';
COPY web_page FROM 'C:\\ACHINT\\shubhi\\dbproject\\dss2\\tpcds1\\web_page.csv' USING DELIMITERS '|' WITH NULL AS 'NULL' encoding 'windows-1251';
COPY web_returns FROM 'C:\\ACHINT\\shubhi\\dbproject\\dss2\\tpcds1\\web_returns.csv' USING DELIMITERS '|' WITH NULL AS 'NULL' encoding 'windows-1251';
COPY web_sales FROM 'C:\\ACHINT\\shubhi\\dbproject\\dss2\\tpcds1\\web_sales.csv' USING DELIMITERS '|' WITH NULL AS 'NULL' encoding 'windows-1251';
COPY web_site FROM 'C:\\ACHINT\\shubhi\\dbproject\\dss2\\tpcds1\\web_site.csv' USING DELIMITERS '|' WITH NULL AS 'NULL' encoding 'windows-1251';


--deleting Tables from DBMS (NEEDED TO RE-START FOR A TABLE, IF SOMETHING GOES WRONG)
drop table call_center ;
drop table catalog_page ;
drop table catalog_returns ;
drop table catalog_sales ;
drop table customer ;
drop table customer_address ;
drop table customer_demographics ;
drop table date_dim ;
drop table dbgen_version ;
drop table household_demographics ;
drop table income_band ;
drop table inventory ;
drop table item ;
drop table promotion ;
drop table reason ;
drop table ship_mode ;
drop table store ;
drop table store_returns ;
drop table store_sales ;
drop table time_dim ;
drop table warehouse ;
drop table web_page ;
drop table web_returns ;
drop table web_sales ;
drop table web_site ;


-- foreign keys
alter table call_center add constraint cc_d1 foreign key  (cc_closed_date_sk) references date_dim (d_date_sk);
alter table call_center add constraint cc_d2 foreign key  (cc_open_date_sk) references date_dim (d_date_sk);
alter table catalog_page add constraint cp_d1 foreign key  (cp_end_date_sk) references date_dim (d_date_sk);
--alter table catalog_page add constraint cp_p foreign key  (cp_promo_id) references promotion (p_promo_sk);
alter table catalog_page add constraint cp_d2 foreign key  (cp_start_date_sk) references date_dim (d_date_sk);
alter table catalog_returns add constraint cr_cc foreign key  (cr_call_center_sk) references call_center (cc_call_center_sk);
alter table catalog_returns add constraint cr_cp foreign key  (cr_catalog_page_sk) references catalog_page (cp_catalog_page_sk);
alter table catalog_returns add constraint cr_i foreign key  (cr_item_sk) references item (i_item_sk);
alter table catalog_returns add constraint cr_r foreign key  (cr_reason_sk) references reason (r_reason_sk);
alter table catalog_returns add constraint cr_a1 foreign key  (cr_refunded_addr_sk) references customer_address (ca_address_sk);
alter table catalog_returns add constraint cr_cd1 foreign key  (cr_refunded_cdemo_sk) references customer_demographics (cd_demo_sk);
alter table catalog_returns add constraint cr_c1 foreign key  (cr_refunded_customer_sk) references customer (c_customer_sk);
alter table catalog_returns add constraint cr_hd1 foreign key  (cr_refunded_hdemo_sk) references household_demographics (hd_demo_sk);
alter table catalog_returns add constraint cr_d1 foreign key  (cr_returned_date_sk) references date_dim (d_date_sk);
alter table catalog_returns add constraint cr_i2 foreign key  (cr_returned_time_sk) references time_dim (t_time_sk);
alter table catalog_returns add constraint cr_a2 foreign key  (cr_returning_addr_sk) references customer_address (ca_address_sk);
alter table catalog_returns add constraint cr_cd2 foreign key  (cr_returning_cdemo_sk) references customer_demographics (cd_demo_sk);
alter table catalog_returns add constraint cr_c2 foreign key  (cr_returning_customer_sk) references customer (c_customer_sk);
alter table catalog_returns add constraint cr_hd2 foreign key  (cr_returning_hdemo_sk) references household_demographics (hd_demo_sk);
--alter table catalog_returns add constraint cr_d2 foreign key  (cr_ship_date_sk) references date_dim (d_date_sk);
alter table catalog_returns add constraint cr_sm foreign key  (cr_ship_mode_sk) references ship_mode (sm_ship_mode_sk);
alter table catalog_returns add constraint cr_w2 foreign key  (cr_warehouse_sk) references warehouse (w_warehouse_sk);
alter table catalog_sales add constraint cs_b_a foreign key  (cs_bill_addr_sk) references customer_address (ca_address_sk);
alter table catalog_sales add constraint cs_b_cd foreign key  (cs_bill_cdemo_sk) references customer_demographics (cd_demo_sk);
alter table catalog_sales add constraint cs_b_c foreign key  (cs_bill_customer_sk) references customer (c_customer_sk);
alter table catalog_sales add constraint cs_b_hd foreign key  (cs_bill_hdemo_sk) references household_demographics (hd_demo_sk);
alter table catalog_sales add constraint cs_cc foreign key  (cs_call_center_sk) references call_center (cc_call_center_sk); 
alter table catalog_sales add constraint cs_cp foreign key  (cs_catalog_page_sk) references catalog_page (cp_catalog_page_sk);
alter table catalog_sales add constraint cs_i foreign key  (cs_item_sk) references item (i_item_sk);
alter table catalog_sales add constraint cs_p foreign key  (cs_promo_sk) references promotion (p_promo_sk);
alter table catalog_sales add constraint cs_s_a foreign key  (cs_ship_addr_sk) references customer_address (ca_address_sk);
alter table catalog_sales add constraint cs_s_cd foreign key  (cs_ship_cdemo_sk) references customer_demographics (cd_demo_sk);
alter table catalog_sales add constraint cs_s_c foreign key  (cs_ship_customer_sk) references customer (c_customer_sk);
alter table catalog_sales add constraint cs_d1 foreign key  (cs_ship_date_sk) references date_dim (d_date_sk);
alter table catalog_sales add constraint cs_s_hd foreign key  (cs_ship_hdemo_sk) references household_demographics (hd_demo_sk);
alter table catalog_sales add constraint cs_sm foreign key  (cs_ship_mode_sk) references ship_mode (sm_ship_mode_sk);
alter table catalog_sales add constraint cs_d2 foreign key  (cs_sold_date_sk) references date_dim (d_date_sk);
alter table catalog_sales add constraint cs_t foreign key  (cs_sold_time_sk) references time_dim (t_time_sk);
alter table catalog_sales add constraint cs_w foreign key  (cs_warehouse_sk) references warehouse (w_warehouse_sk);
alter table customer add constraint c_a foreign key  (c_current_addr_sk) references customer_address (ca_address_sk);
alter table customer add constraint c_cd foreign key  (c_current_cdemo_sk) references customer_demographics (cd_demo_sk);
alter table customer add constraint c_hd foreign key  (c_current_hdemo_sk) references household_demographics (hd_demo_sk);
alter table customer add constraint c_fsd foreign key  (c_first_sales_date_sk) references date_dim (d_date_sk);
alter table customer add constraint c_fsd2 foreign key  (c_first_shipto_date_sk) references date_dim (d_date_sk);
alter table household_demographics add constraint hd_ib foreign key  (hd_income_band_sk) references income_band (ib_income_band_sk); 
alter table inventory add constraint inv_d foreign key  (inv_date_sk) references date_dim (d_date_sk);
alter table inventory add constraint inv_i foreign key  (inv_item_sk) references item (i_item_sk);
alter table inventory add constraint inv_w foreign key  (inv_warehouse_sk) references warehouse (w_warehouse_sk);
alter table promotion add constraint p_end_date foreign key  (p_end_date_sk) references date_dim (d_date_sk);
alter table promotion add constraint p_i foreign key  (p_item_sk) references item (i_item_sk);
alter table promotion add constraint p_start_date foreign key  (p_start_date_sk) references date_dim (d_date_sk);
alter table store add constraint s_close_date foreign key  (s_closed_date_sk) references date_dim (d_date_sk);
alter table store_returns add constraint sr_a foreign key  (sr_addr_sk) references customer_address (ca_address_sk);
alter table store_returns add constraint sr_cd foreign key  (sr_cdemo_sk) references customer_demographics (cd_demo_sk);
alter table store_returns add constraint sr_c foreign key  (sr_customer_sk) references customer (c_customer_sk);
alter table store_returns add constraint sr_hd foreign key  (sr_hdemo_sk) references household_demographics (hd_demo_sk);
alter table store_returns add constraint sr_i foreign key  (sr_item_sk) references item (i_item_sk);
alter table store_returns add constraint sr_r foreign key  (sr_reason_sk) references reason (r_reason_sk);
alter table store_returns add constraint sr_ret_d foreign key  (sr_returned_date_sk) references date_dim (d_date_sk);
alter table store_returns add constraint sr_t foreign key  (sr_return_time_sk) references time_dim (t_time_sk);
alter table store_returns add constraint sr_s foreign key  (sr_store_sk) references store (s_store_sk);
alter table store_sales add constraint ss_a foreign key  (ss_addr_sk) references customer_address (ca_address_sk);
alter table store_sales add constraint ss_cd foreign key  (ss_cdemo_sk) references customer_demographics (cd_demo_sk);
alter table store_sales add constraint ss_c foreign key  (ss_customer_sk) references customer (c_customer_sk);
alter table store_sales add constraint ss_hd foreign key  (ss_hdemo_sk) references household_demographics (hd_demo_sk);
alter table store_sales add constraint ss_i foreign key  (ss_item_sk) references item (i_item_sk);
alter table store_sales add constraint ss_p foreign key  (ss_promo_sk) references promotion (p_promo_sk);
alter table store_sales add constraint ss_d foreign key  (ss_sold_date_sk) references date_dim (d_date_sk);
alter table store_sales add constraint ss_t foreign key  (ss_sold_time_sk) references time_dim (t_time_sk);
alter table store_sales add constraint ss_s foreign key  (ss_store_sk) references store (s_store_sk);
alter table web_page add constraint wp_ad foreign key  (wp_access_date_sk) references date_dim (d_date_sk);
alter table web_page add constraint wp_cd foreign key  (wp_creation_date_sk) references date_dim (d_date_sk);
alter table web_returns add constraint wr_i foreign key  (wr_item_sk) references item (i_item_sk);
alter table web_returns add constraint wr_r foreign key  (wr_reason_sk) references reason (r_reason_sk);
alter table web_returns add constraint wr_ref_a foreign key  (wr_refunded_addr_sk) references customer_address (ca_address_sk);
alter table web_returns add constraint wr_ref_cd foreign key  (wr_refunded_cdemo_sk) references customer_demographics (cd_demo_sk);
alter table web_returns add constraint wr_ref_c foreign key  (wr_refunded_customer_sk) references customer (c_customer_sk);
alter table web_returns add constraint wr_ref_hd foreign key  (wr_refunded_hdemo_sk) references household_demographics (hd_demo_sk);
alter table web_returns add constraint wr_ret_d foreign key  (wr_returned_date_sk) references date_dim (d_date_sk);
alter table web_returns add constraint wr_ret_t foreign key  (wr_returned_time_sk) references time_dim (t_time_sk);
alter table web_returns add constraint wr_ret_a foreign key  (wr_returning_addr_sk) references customer_address (ca_address_sk);
alter table web_returns add constraint wr_ret_cd1 foreign key  (wr_returning_cdemo_sk) references customer_demographics (cd_demo_sk);
alter table web_returns add constraint wr_ret_c foreign key  (wr_returning_customer_sk) references customer (c_customer_sk);
alter table web_returns add constraint wr_ret_cd2 foreign key  (wr_returning_hdemo_sk) references household_demographics (hd_demo_sk);
alter table web_returns add constraint wr_wp foreign key  (wr_web_page_sk) references web_page (wp_web_page_sk);
alter table web_sales add constraint ws_b_a foreign key  (ws_bill_addr_sk) references customer_address (ca_address_sk);
alter table web_sales add constraint ws_b_cd1 foreign key  (ws_bill_cdemo_sk) references customer_demographics (cd_demo_sk);
alter table web_sales add constraint ws_b_c foreign key  (ws_bill_customer_sk) references customer (c_customer_sk);
alter table web_sales add constraint ws_b_cd2 foreign key  (ws_bill_hdemo_sk) references household_demographics (hd_demo_sk);
alter table web_sales add constraint ws_i foreign key  (ws_item_sk) references item (i_item_sk);
alter table web_sales add constraint ws_p foreign key  (ws_promo_sk) references promotion (p_promo_sk);
alter table web_sales add constraint ws_s_a foreign key  (ws_ship_addr_sk) references customer_address (ca_address_sk);
alter table web_sales add constraint ws_s_cd foreign key  (ws_ship_cdemo_sk) references customer_demographics (cd_demo_sk);
alter table web_sales add constraint ws_s_c foreign key  (ws_ship_customer_sk) references customer (c_customer_sk);
alter table web_sales add constraint ws_s_d foreign key  (ws_ship_date_sk) references date_dim (d_date_sk);
alter table web_sales add constraint ws_s_hd foreign key  (ws_ship_hdemo_sk) references household_demographics (hd_demo_sk);
alter table web_sales add constraint ws_sm foreign key  (ws_ship_mode_sk) references ship_mode (sm_ship_mode_sk);
alter table web_sales add constraint ws_d2 foreign key  (ws_sold_date_sk) references date_dim (d_date_sk);
alter table web_sales add constraint ws_t foreign key  (ws_sold_time_sk) references time_dim (t_time_sk);
alter table web_sales add constraint ws_w2 foreign key  (ws_warehouse_sk) references warehouse (w_warehouse_sk);
alter table web_sales add constraint ws_wp foreign key  (ws_web_page_sk) references web_page (wp_web_page_sk);
alter table web_sales add constraint ws_ws foreign key  (ws_web_site_sk) references web_site (web_site_sk);
alter table web_site add constraint web_d1 foreign key  (web_close_date_sk) references date_dim (d_date_sk);
alter table web_site add constraint web_d2 foreign key  (web_open_date_sk) references date_dim (d_date_sk);


--429 indexes build time around 8 minutes
CREATE INDEX INDX_call_center_cc_call_center_id ON call_center (cc_call_center_id);
CREATE INDEX INDX_call_center_cc_call_center_sk ON call_center (cc_call_center_sk);
CREATE INDEX INDX_call_center_cc_city ON call_center (cc_city);
CREATE INDEX INDX_call_center_cc_class ON call_center (cc_class);
CREATE INDEX INDX_call_center_cc_closed_date_sk ON call_center (cc_closed_date_sk);
CREATE INDEX INDX_call_center_cc_company ON call_center (cc_company);
CREATE INDEX INDX_call_center_cc_company_name ON call_center (cc_company_name);
CREATE INDEX INDX_call_center_cc_country ON call_center (cc_country);
CREATE INDEX INDX_call_center_cc_county ON call_center (cc_county);
CREATE INDEX INDX_call_center_cc_division ON call_center (cc_division);
CREATE INDEX INDX_call_center_cc_division_name ON call_center (cc_division_name);
CREATE INDEX INDX_call_center_cc_employees ON call_center (cc_employees);
CREATE INDEX INDX_call_center_cc_gmt_offset ON call_center (cc_gmt_offset);
CREATE INDEX INDX_call_center_cc_hours ON call_center (cc_hours);
CREATE INDEX INDX_call_center_cc_manager ON call_center (cc_manager);
CREATE INDEX INDX_call_center_cc_market_manager ON call_center (cc_market_manager);
CREATE INDEX INDX_call_center_cc_mkt_class ON call_center (cc_mkt_class);
CREATE INDEX INDX_call_center_cc_mkt_desc ON call_center (cc_mkt_desc);
CREATE INDEX INDX_call_center_cc_mkt_id ON call_center (cc_mkt_id);
CREATE INDEX INDX_call_center_cc_name ON call_center (cc_name);
CREATE INDEX INDX_call_center_cc_open_date_sk ON call_center (cc_open_date_sk);
CREATE INDEX INDX_call_center_cc_rec_end_date ON call_center (cc_rec_end_date);
CREATE INDEX INDX_call_center_cc_rec_start_date ON call_center (cc_rec_start_date);
CREATE INDEX INDX_call_center_cc_sq_ft ON call_center (cc_sq_ft);
CREATE INDEX INDX_call_center_cc_state ON call_center (cc_state);
CREATE INDEX INDX_call_center_cc_street_name ON call_center (cc_street_name);
CREATE INDEX INDX_call_center_cc_street_number ON call_center (cc_street_number);
CREATE INDEX INDX_call_center_cc_street_type ON call_center (cc_street_type);
CREATE INDEX INDX_call_center_cc_suite_number ON call_center (cc_suite_number);
CREATE INDEX INDX_call_center_cc_tax_percentage ON call_center (cc_tax_percentage);
CREATE INDEX INDX_call_center_cc_zip ON call_center (cc_zip);
CREATE INDEX INDX_catalog_page_cp_catalog_number ON catalog_page (cp_catalog_number);
CREATE INDEX INDX_catalog_page_cp_catalog_page_id ON catalog_page (cp_catalog_page_id);
CREATE INDEX INDX_catalog_page_cp_catalog_page_number ON catalog_page (cp_catalog_page_number);
CREATE INDEX INDX_catalog_page_cp_catalog_page_sk ON catalog_page (cp_catalog_page_sk);
CREATE INDEX INDX_catalog_page_cp_department ON catalog_page (cp_department);
CREATE INDEX INDX_catalog_page_cp_description ON catalog_page (cp_description);
CREATE INDEX INDX_catalog_page_cp_end_date_sk ON catalog_page (cp_end_date_sk);
CREATE INDEX INDX_catalog_page_cp_start_date_sk ON catalog_page (cp_start_date_sk);
CREATE INDEX INDX_catalog_page_cp_type ON catalog_page (cp_type);
CREATE INDEX INDX_catalog_returns_cr_call_center_sk ON catalog_returns (cr_call_center_sk);
CREATE INDEX INDX_catalog_returns_cr_catalog_page_sk ON catalog_returns (cr_catalog_page_sk);
CREATE INDEX INDX_catalog_returns_cr_fee ON catalog_returns (cr_fee);
CREATE INDEX INDX_catalog_returns_cr_item_sk ON catalog_returns (cr_item_sk);
CREATE INDEX INDX_catalog_returns_cr_net_loss ON catalog_returns (cr_net_loss);
CREATE INDEX INDX_catalog_returns_cr_order_number ON catalog_returns (cr_order_number);
CREATE INDEX INDX_catalog_returns_cr_reason_sk ON catalog_returns (cr_reason_sk);
CREATE INDEX INDX_catalog_returns_cr_refunded_addr_sk ON catalog_returns (cr_refunded_addr_sk);
CREATE INDEX INDX_catalog_returns_cr_refunded_cash ON catalog_returns (cr_refunded_cash);
CREATE INDEX INDX_catalog_returns_cr_refunded_cdemo_sk ON catalog_returns (cr_refunded_cdemo_sk);
CREATE INDEX INDX_catalog_returns_cr_refunded_customer_sk ON catalog_returns (cr_refunded_customer_sk);
CREATE INDEX INDX_catalog_returns_cr_refunded_hdemo_sk ON catalog_returns (cr_refunded_hdemo_sk);
CREATE INDEX INDX_catalog_returns_cr_return_amount ON catalog_returns (cr_return_amount);
CREATE INDEX INDX_catalog_returns_cr_return_amt_inc_tax ON catalog_returns (cr_return_amt_inc_tax);
CREATE INDEX INDX_catalog_returns_cr_return_quantity ON catalog_returns (cr_return_quantity);
CREATE INDEX INDX_catalog_returns_cr_return_ship_cost ON catalog_returns (cr_return_ship_cost);
CREATE INDEX INDX_catalog_returns_cr_return_tax ON catalog_returns (cr_return_tax);
CREATE INDEX INDX_catalog_returns_cr_returned_date_sk ON catalog_returns (cr_returned_date_sk);
CREATE INDEX INDX_catalog_returns_cr_returned_time_sk ON catalog_returns (cr_returned_time_sk);
CREATE INDEX INDX_catalog_returns_cr_returning_addr_sk ON catalog_returns (cr_returning_addr_sk);
CREATE INDEX INDX_catalog_returns_cr_returning_cdemo_sk ON catalog_returns (cr_returning_cdemo_sk);
CREATE INDEX INDX_catalog_returns_cr_returning_customer_sk ON catalog_returns (cr_returning_customer_sk);
CREATE INDEX INDX_catalog_returns_cr_returning_hdemo_sk ON catalog_returns (cr_returning_hdemo_sk);
CREATE INDEX INDX_catalog_returns_cr_reversed_charge ON catalog_returns (cr_reversed_charge);
CREATE INDEX INDX_catalog_returns_cr_ship_mode_sk ON catalog_returns (cr_ship_mode_sk);
CREATE INDEX INDX_catalog_returns_cr_store_credit ON catalog_returns (cr_store_credit);
CREATE INDEX INDX_catalog_returns_cr_warehouse_sk ON catalog_returns (cr_warehouse_sk);
CREATE INDEX INDX_catalog_sales_cs_bill_addr_sk ON catalog_sales (cs_bill_addr_sk);
CREATE INDEX INDX_catalog_sales_cs_bill_cdemo_sk ON catalog_sales (cs_bill_cdemo_sk);
CREATE INDEX INDX_catalog_sales_cs_bill_customer_sk ON catalog_sales (cs_bill_customer_sk);
CREATE INDEX INDX_catalog_sales_cs_bill_hdemo_sk ON catalog_sales (cs_bill_hdemo_sk);
CREATE INDEX INDX_catalog_sales_cs_call_center_sk ON catalog_sales (cs_call_center_sk);
CREATE INDEX INDX_catalog_sales_cs_catalog_page_sk ON catalog_sales (cs_catalog_page_sk);
CREATE INDEX INDX_catalog_sales_cs_coupon_amt ON catalog_sales (cs_coupon_amt);
CREATE INDEX INDX_catalog_sales_cs_ext_discount_amt ON catalog_sales (cs_ext_discount_amt);
CREATE INDEX INDX_catalog_sales_cs_ext_list_price ON catalog_sales (cs_ext_list_price);
CREATE INDEX INDX_catalog_sales_cs_ext_sales_price ON catalog_sales (cs_ext_sales_price);
CREATE INDEX INDX_catalog_sales_cs_ext_ship_cost ON catalog_sales (cs_ext_ship_cost);
CREATE INDEX INDX_catalog_sales_cs_ext_tax ON catalog_sales (cs_ext_tax);
CREATE INDEX INDX_catalog_sales_cs_ext_wholesale_cost ON catalog_sales (cs_ext_wholesale_cost);
CREATE INDEX INDX_catalog_sales_cs_item_sk ON catalog_sales (cs_item_sk);
CREATE INDEX INDX_catalog_sales_cs_list_price ON catalog_sales (cs_list_price);
CREATE INDEX INDX_catalog_sales_cs_net_paid ON catalog_sales (cs_net_paid);
CREATE INDEX INDX_catalog_sales_cs_net_paid_inc_ship ON catalog_sales (cs_net_paid_inc_ship);
CREATE INDEX INDX_catalog_sales_cs_net_paid_inc_ship_tax ON catalog_sales (cs_net_paid_inc_ship_tax);
CREATE INDEX INDX_catalog_sales_cs_net_paid_inc_tax ON catalog_sales (cs_net_paid_inc_tax);
CREATE INDEX INDX_catalog_sales_cs_net_profit ON catalog_sales (cs_net_profit);
CREATE INDEX INDX_catalog_sales_cs_order_number ON catalog_sales (cs_order_number);
CREATE INDEX INDX_catalog_sales_cs_promo_sk ON catalog_sales (cs_promo_sk);
CREATE INDEX INDX_catalog_sales_cs_quantity ON catalog_sales (cs_quantity);
CREATE INDEX INDX_catalog_sales_cs_sales_price ON catalog_sales (cs_sales_price);
CREATE INDEX INDX_catalog_sales_cs_ship_addr_sk ON catalog_sales (cs_ship_addr_sk);
CREATE INDEX INDX_catalog_sales_cs_ship_cdemo_sk ON catalog_sales (cs_ship_cdemo_sk);
CREATE INDEX INDX_catalog_sales_cs_ship_customer_sk ON catalog_sales (cs_ship_customer_sk);
CREATE INDEX INDX_catalog_sales_cs_ship_date_sk ON catalog_sales (cs_ship_date_sk);
CREATE INDEX INDX_catalog_sales_cs_ship_hdemo_sk ON catalog_sales (cs_ship_hdemo_sk);
CREATE INDEX INDX_catalog_sales_cs_ship_mode_sk ON catalog_sales (cs_ship_mode_sk);
CREATE INDEX INDX_catalog_sales_cs_sold_date_sk ON catalog_sales (cs_sold_date_sk);
CREATE INDEX INDX_catalog_sales_cs_sold_time_sk ON catalog_sales (cs_sold_time_sk);
CREATE INDEX INDX_catalog_sales_cs_warehouse_sk ON catalog_sales (cs_warehouse_sk);
CREATE INDEX INDX_catalog_sales_cs_wholesale_cost ON catalog_sales (cs_wholesale_cost);
CREATE INDEX INDX_customer_c_birth_country ON customer (c_birth_country);
CREATE INDEX INDX_customer_c_birth_day ON customer (c_birth_day);
CREATE INDEX INDX_customer_c_birth_month ON customer (c_birth_month);
CREATE INDEX INDX_customer_c_birth_year ON customer (c_birth_year);
CREATE INDEX INDX_customer_c_current_addr_sk ON customer (c_current_addr_sk);
CREATE INDEX INDX_customer_c_current_cdemo_sk ON customer (c_current_cdemo_sk);
CREATE INDEX INDX_customer_c_current_hdemo_sk ON customer (c_current_hdemo_sk);
CREATE INDEX INDX_customer_c_customer_id ON customer (c_customer_id);
CREATE INDEX INDX_customer_c_customer_sk ON customer (c_customer_sk);
CREATE INDEX INDX_customer_c_email_address ON customer (c_email_address);
CREATE INDEX INDX_customer_c_first_name ON customer (c_first_name);
CREATE INDEX INDX_customer_c_first_sales_date_sk ON customer (c_first_sales_date_sk);
CREATE INDEX INDX_customer_c_first_shipto_date_sk ON customer (c_first_shipto_date_sk);
CREATE INDEX INDX_customer_c_last_name ON customer (c_last_name);
CREATE INDEX INDX_customer_c_last_review_date ON customer (c_last_review_date);
CREATE INDEX INDX_customer_c_login ON customer (c_login);
CREATE INDEX INDX_customer_c_preferred_cust_flag ON customer (c_preferred_cust_flag);
CREATE INDEX INDX_customer_c_salutation ON customer (c_salutation);
CREATE INDEX INDX_customer_address_ca_address_id ON customer_address (ca_address_id);
CREATE INDEX INDX_customer_address_ca_address_sk ON customer_address (ca_address_sk);
CREATE INDEX INDX_customer_address_ca_city ON customer_address (ca_city);
CREATE INDEX INDX_customer_address_ca_country ON customer_address (ca_country);
CREATE INDEX INDX_customer_address_ca_county ON customer_address (ca_county);
CREATE INDEX INDX_customer_address_ca_gmt_offset ON customer_address (ca_gmt_offset);
CREATE INDEX INDX_customer_address_ca_location_type ON customer_address (ca_location_type);
CREATE INDEX INDX_customer_address_ca_state ON customer_address (ca_state);
CREATE INDEX INDX_customer_address_ca_street_name ON customer_address (ca_street_name);
CREATE INDEX INDX_customer_address_ca_street_number ON customer_address (ca_street_number);
CREATE INDEX INDX_customer_address_ca_street_type ON customer_address (ca_street_type);
CREATE INDEX INDX_customer_address_ca_suite_number ON customer_address (ca_suite_number);
CREATE INDEX INDX_customer_address_ca_zip ON customer_address (ca_zip);
CREATE INDEX INDX_customer_demographics_cd_credit_rating ON customer_demographics (cd_credit_rating);
CREATE INDEX INDX_customer_demographics_cd_demo_sk ON customer_demographics (cd_demo_sk);
CREATE INDEX INDX_customer_demographics_cd_dep_college_count ON customer_demographics (cd_dep_college_count);
CREATE INDEX INDX_customer_demographics_cd_dep_count ON customer_demographics (cd_dep_count);
CREATE INDEX INDX_customer_demographics_cd_dep_employed_count ON customer_demographics (cd_dep_employed_count);
CREATE INDEX INDX_customer_demographics_cd_education_status ON customer_demographics (cd_education_status);
CREATE INDEX INDX_customer_demographics_cd_gender ON customer_demographics (cd_gender);
CREATE INDEX INDX_customer_demographics_cd_marital_status ON customer_demographics (cd_marital_status);
CREATE INDEX INDX_customer_demographics_cd_purchase_estimate ON customer_demographics (cd_purchase_estimate);
CREATE INDEX INDX_date_dim_d_current_day ON date_dim (d_current_day);
CREATE INDEX INDX_date_dim_d_current_month ON date_dim (d_current_month);
CREATE INDEX INDX_date_dim_d_current_quarter ON date_dim (d_current_quarter);
CREATE INDEX INDX_date_dim_d_current_week ON date_dim (d_current_week);
CREATE INDEX INDX_date_dim_d_current_year ON date_dim (d_current_year);
CREATE INDEX INDX_date_dim_d_date ON date_dim (d_date);
CREATE INDEX INDX_date_dim_d_date_id ON date_dim (d_date_id);
CREATE INDEX INDX_date_dim_d_date_sk ON date_dim (d_date_sk);
CREATE INDEX INDX_date_dim_d_day_name ON date_dim (d_day_name);
CREATE INDEX INDX_date_dim_d_dom ON date_dim (d_dom);
CREATE INDEX INDX_date_dim_d_dow ON date_dim (d_dow);
CREATE INDEX INDX_date_dim_d_first_dom ON date_dim (d_first_dom);
CREATE INDEX INDX_date_dim_d_following_holiday ON date_dim (d_following_holiday);
CREATE INDEX INDX_date_dim_d_fy_quarter_seq ON date_dim (d_fy_quarter_seq);
CREATE INDEX INDX_date_dim_d_fy_week_seq ON date_dim (d_fy_week_seq);
CREATE INDEX INDX_date_dim_d_fy_year ON date_dim (d_fy_year);
CREATE INDEX INDX_date_dim_d_holiday ON date_dim (d_holiday);
CREATE INDEX INDX_date_dim_d_last_dom ON date_dim (d_last_dom);
CREATE INDEX INDX_date_dim_d_month_seq ON date_dim (d_month_seq);
CREATE INDEX INDX_date_dim_d_moy ON date_dim (d_moy);
CREATE INDEX INDX_date_dim_d_qoy ON date_dim (d_qoy);
CREATE INDEX INDX_date_dim_d_quarter_name ON date_dim (d_quarter_name);
CREATE INDEX INDX_date_dim_d_quarter_seq ON date_dim (d_quarter_seq);
CREATE INDEX INDX_date_dim_d_same_day_lq ON date_dim (d_same_day_lq);
CREATE INDEX INDX_date_dim_d_same_day_ly ON date_dim (d_same_day_ly);
CREATE INDEX INDX_date_dim_d_week_seq ON date_dim (d_week_seq);
CREATE INDEX INDX_date_dim_d_weekend ON date_dim (d_weekend);
CREATE INDEX INDX_date_dim_d_year ON date_dim (d_year);
CREATE INDEX INDX_dbgen_version_dv_cmdline_args ON dbgen_version (dv_cmdline_args);
CREATE INDEX INDX_dbgen_version_dv_create_date ON dbgen_version (dv_create_date);
CREATE INDEX INDX_dbgen_version_dv_create_time ON dbgen_version (dv_create_time);
CREATE INDEX INDX_dbgen_version_dv_version ON dbgen_version (dv_version);
CREATE INDEX INDX_household_demographics_hd_buy_potential ON household_demographics (hd_buy_potential);
CREATE INDEX INDX_household_demographics_hd_demo_sk ON household_demographics (hd_demo_sk);
CREATE INDEX INDX_household_demographics_hd_dep_count ON household_demographics (hd_dep_count);
CREATE INDEX INDX_household_demographics_hd_income_band_sk ON household_demographics (hd_income_band_sk);
CREATE INDEX INDX_household_demographics_hd_vehicle_count ON household_demographics (hd_vehicle_count);
CREATE INDEX INDX_income_band_ib_income_band_sk ON income_band (ib_income_band_sk);
CREATE INDEX INDX_income_band_ib_lower_bound ON income_band (ib_lower_bound);
CREATE INDEX INDX_income_band_ib_upper_bound ON income_band (ib_upper_bound);
CREATE INDEX INDX_inventory_inv_date_sk ON inventory (inv_date_sk);
CREATE INDEX INDX_inventory_inv_item_sk ON inventory (inv_item_sk);
CREATE INDEX INDX_inventory_inv_quantity_on_hand ON inventory (inv_quantity_on_hand);
CREATE INDEX INDX_inventory_inv_warehouse_sk ON inventory (inv_warehouse_sk);
CREATE INDEX INDX_item_i_brand ON item (i_brand);
CREATE INDEX INDX_item_i_brand_id ON item (i_brand_id);
CREATE INDEX INDX_item_i_category ON item (i_category);
CREATE INDEX INDX_item_i_category_id ON item (i_category_id);
CREATE INDEX INDX_item_i_class ON item (i_class);
CREATE INDEX INDX_item_i_class_id ON item (i_class_id);
CREATE INDEX INDX_item_i_color ON item (i_color);
CREATE INDEX INDX_item_i_container ON item (i_container);
CREATE INDEX INDX_item_i_current_price ON item (i_current_price);
CREATE INDEX INDX_item_i_formulation ON item (i_formulation);
CREATE INDEX INDX_item_i_item_desc ON item (i_item_desc);
CREATE INDEX INDX_item_i_item_id ON item (i_item_id);
CREATE INDEX INDX_item_i_item_sk ON item (i_item_sk);
CREATE INDEX INDX_item_i_manager_id ON item (i_manager_id);
CREATE INDEX INDX_item_i_manufact ON item (i_manufact);
CREATE INDEX INDX_item_i_manufact_id ON item (i_manufact_id);
CREATE INDEX INDX_item_i_product_name ON item (i_product_name);
CREATE INDEX INDX_item_i_rec_end_date ON item (i_rec_end_date);
CREATE INDEX INDX_item_i_rec_start_date ON item (i_rec_start_date);
CREATE INDEX INDX_item_i_size ON item (i_size);
CREATE INDEX INDX_item_i_units ON item (i_units);
CREATE INDEX INDX_item_i_wholesale_cost ON item (i_wholesale_cost);
CREATE INDEX INDX_promotion_p_channel_catalog ON promotion (p_channel_catalog);
CREATE INDEX INDX_promotion_p_channel_demo ON promotion (p_channel_demo);
CREATE INDEX INDX_promotion_p_channel_details ON promotion (p_channel_details);
CREATE INDEX INDX_promotion_p_channel_dmail ON promotion (p_channel_dmail);
CREATE INDEX INDX_promotion_p_channel_email ON promotion (p_channel_email);
CREATE INDEX INDX_promotion_p_channel_event ON promotion (p_channel_event);
CREATE INDEX INDX_promotion_p_channel_press ON promotion (p_channel_press);
CREATE INDEX INDX_promotion_p_channel_radio ON promotion (p_channel_radio);
CREATE INDEX INDX_promotion_p_channel_tv ON promotion (p_channel_tv);
CREATE INDEX INDX_promotion_p_cost ON promotion (p_cost);
CREATE INDEX INDX_promotion_p_discount_active ON promotion (p_discount_active);
CREATE INDEX INDX_promotion_p_end_date_sk ON promotion (p_end_date_sk);
CREATE INDEX INDX_promotion_p_item_sk ON promotion (p_item_sk);
CREATE INDEX INDX_promotion_p_promo_id ON promotion (p_promo_id);
CREATE INDEX INDX_promotion_p_promo_name ON promotion (p_promo_name);
CREATE INDEX INDX_promotion_p_promo_sk ON promotion (p_promo_sk);
CREATE INDEX INDX_promotion_p_purpose ON promotion (p_purpose);
CREATE INDEX INDX_promotion_p_response_target ON promotion (p_response_target);
CREATE INDEX INDX_promotion_p_start_date_sk ON promotion (p_start_date_sk);
CREATE INDEX INDX_reason_r_reason_desc ON reason (r_reason_desc);
CREATE INDEX INDX_reason_r_reason_id ON reason (r_reason_id);
CREATE INDEX INDX_reason_r_reason_sk ON reason (r_reason_sk);
CREATE INDEX INDX_ship_mode_sm_carrier ON ship_mode (sm_carrier);
CREATE INDEX INDX_ship_mode_sm_code ON ship_mode (sm_code);
CREATE INDEX INDX_ship_mode_sm_contract ON ship_mode (sm_contract);
CREATE INDEX INDX_ship_mode_sm_ship_mode_id ON ship_mode (sm_ship_mode_id);
CREATE INDEX INDX_ship_mode_sm_ship_mode_sk ON ship_mode (sm_ship_mode_sk);
CREATE INDEX INDX_ship_mode_sm_type ON ship_mode (sm_type);
CREATE INDEX INDX_store_s_city ON store (s_city);
CREATE INDEX INDX_store_s_closed_date_sk ON store (s_closed_date_sk);
CREATE INDEX INDX_store_s_company_id ON store (s_company_id);
CREATE INDEX INDX_store_s_company_name ON store (s_company_name);
CREATE INDEX INDX_store_s_country ON store (s_country);
CREATE INDEX INDX_store_s_county ON store (s_county);
CREATE INDEX INDX_store_s_division_id ON store (s_division_id);
CREATE INDEX INDX_store_s_division_name ON store (s_division_name);
CREATE INDEX INDX_store_s_floor_space ON store (s_floor_space);
CREATE INDEX INDX_store_s_geography_class ON store (s_geography_class);
CREATE INDEX INDX_store_s_gmt_offset ON store (s_gmt_offset);
CREATE INDEX INDX_store_s_hours ON store (s_hours);
CREATE INDEX INDX_store_s_manager ON store (s_manager);
CREATE INDEX INDX_store_s_market_desc ON store (s_market_desc);
CREATE INDEX INDX_store_s_market_id ON store (s_market_id);
CREATE INDEX INDX_store_s_market_manager ON store (s_market_manager);
CREATE INDEX INDX_store_s_number_employees ON store (s_number_employees);
CREATE INDEX INDX_store_s_rec_end_date ON store (s_rec_end_date);
CREATE INDEX INDX_store_s_rec_start_date ON store (s_rec_start_date);
CREATE INDEX INDX_store_s_state ON store (s_state);
CREATE INDEX INDX_store_s_store_id ON store (s_store_id);
CREATE INDEX INDX_store_s_store_name ON store (s_store_name);
CREATE INDEX INDX_store_s_store_sk ON store (s_store_sk);
CREATE INDEX INDX_store_s_street_name ON store (s_street_name);
CREATE INDEX INDX_store_s_street_number ON store (s_street_number);
CREATE INDEX INDX_store_s_street_type ON store (s_street_type);
CREATE INDEX INDX_store_s_suite_number ON store (s_suite_number);
CREATE INDEX INDX_store_s_tax_precentage ON store (s_tax_precentage);
CREATE INDEX INDX_store_s_zip ON store (s_zip);
CREATE INDEX INDX_store_returns_sr_addr_sk ON store_returns (sr_addr_sk);
CREATE INDEX INDX_store_returns_sr_cdemo_sk ON store_returns (sr_cdemo_sk);
CREATE INDEX INDX_store_returns_sr_customer_sk ON store_returns (sr_customer_sk);
CREATE INDEX INDX_store_returns_sr_fee ON store_returns (sr_fee);
CREATE INDEX INDX_store_returns_sr_hdemo_sk ON store_returns (sr_hdemo_sk);
CREATE INDEX INDX_store_returns_sr_item_sk ON store_returns (sr_item_sk);
CREATE INDEX INDX_store_returns_sr_net_loss ON store_returns (sr_net_loss);
CREATE INDEX INDX_store_returns_sr_reason_sk ON store_returns (sr_reason_sk);
CREATE INDEX INDX_store_returns_sr_refunded_cash ON store_returns (sr_refunded_cash);
CREATE INDEX INDX_store_returns_sr_return_amt ON store_returns (sr_return_amt);
CREATE INDEX INDX_store_returns_sr_return_amt_inc_tax ON store_returns (sr_return_amt_inc_tax);
CREATE INDEX INDX_store_returns_sr_return_quantity ON store_returns (sr_return_quantity);
CREATE INDEX INDX_store_returns_sr_return_ship_cost ON store_returns (sr_return_ship_cost);
CREATE INDEX INDX_store_returns_sr_return_tax ON store_returns (sr_return_tax);
CREATE INDEX INDX_store_returns_sr_return_time_sk ON store_returns (sr_return_time_sk);
CREATE INDEX INDX_store_returns_sr_returned_date_sk ON store_returns (sr_returned_date_sk);
CREATE INDEX INDX_store_returns_sr_reversed_charge ON store_returns (sr_reversed_charge);
CREATE INDEX INDX_store_returns_sr_store_credit ON store_returns (sr_store_credit);
CREATE INDEX INDX_store_returns_sr_store_sk ON store_returns (sr_store_sk);
CREATE INDEX INDX_store_returns_sr_ticket_number ON store_returns (sr_ticket_number);
CREATE INDEX INDX_store_sales_ss_addr_sk ON store_sales (ss_addr_sk);
CREATE INDEX INDX_store_sales_ss_cdemo_sk ON store_sales (ss_cdemo_sk);
CREATE INDEX INDX_store_sales_ss_coupon_amt ON store_sales (ss_coupon_amt);
CREATE INDEX INDX_store_sales_ss_customer_sk ON store_sales (ss_customer_sk);
CREATE INDEX INDX_store_sales_ss_ext_discount_amt ON store_sales (ss_ext_discount_amt);
CREATE INDEX INDX_store_sales_ss_ext_list_price ON store_sales (ss_ext_list_price);
CREATE INDEX INDX_store_sales_ss_ext_sales_price ON store_sales (ss_ext_sales_price);
CREATE INDEX INDX_store_sales_ss_ext_tax ON store_sales (ss_ext_tax);
CREATE INDEX INDX_store_sales_ss_ext_wholesale_cost ON store_sales (ss_ext_wholesale_cost);
CREATE INDEX INDX_store_sales_ss_hdemo_sk ON store_sales (ss_hdemo_sk);
CREATE INDEX INDX_store_sales_ss_item_sk ON store_sales (ss_item_sk);
CREATE INDEX INDX_store_sales_ss_list_price ON store_sales (ss_list_price);
CREATE INDEX INDX_store_sales_ss_net_paid ON store_sales (ss_net_paid);
CREATE INDEX INDX_store_sales_ss_net_paid_inc_tax ON store_sales (ss_net_paid_inc_tax);
CREATE INDEX INDX_store_sales_ss_net_profit ON store_sales (ss_net_profit);
CREATE INDEX INDX_store_sales_ss_promo_sk ON store_sales (ss_promo_sk);
CREATE INDEX INDX_store_sales_ss_quantity ON store_sales (ss_quantity);
CREATE INDEX INDX_store_sales_ss_sales_price ON store_sales (ss_sales_price);
CREATE INDEX INDX_store_sales_ss_sold_date_sk ON store_sales (ss_sold_date_sk);
CREATE INDEX INDX_store_sales_ss_sold_time_sk ON store_sales (ss_sold_time_sk);
CREATE INDEX INDX_store_sales_ss_store_sk ON store_sales (ss_store_sk);
CREATE INDEX INDX_store_sales_ss_ticket_number ON store_sales (ss_ticket_number);
CREATE INDEX INDX_store_sales_ss_wholesale_cost ON store_sales (ss_wholesale_cost);
CREATE INDEX INDX_time_dim_t_am_pm ON time_dim (t_am_pm);
CREATE INDEX INDX_time_dim_t_hour ON time_dim (t_hour);
CREATE INDEX INDX_time_dim_t_meal_time ON time_dim (t_meal_time);
CREATE INDEX INDX_time_dim_t_minute ON time_dim (t_minute);
CREATE INDEX INDX_time_dim_t_second ON time_dim (t_second);
CREATE INDEX INDX_time_dim_t_shift ON time_dim (t_shift);
CREATE INDEX INDX_time_dim_t_sub_shift ON time_dim (t_sub_shift);
CREATE INDEX INDX_time_dim_t_time ON time_dim (t_time);
CREATE INDEX INDX_time_dim_t_time_id ON time_dim (t_time_id);
CREATE INDEX INDX_time_dim_t_time_sk ON time_dim (t_time_sk);
CREATE INDEX INDX_warehouse_w_city ON warehouse (w_city);
CREATE INDEX INDX_warehouse_w_country ON warehouse (w_country);
CREATE INDEX INDX_warehouse_w_county ON warehouse (w_county);
CREATE INDEX INDX_warehouse_w_gmt_offset ON warehouse (w_gmt_offset);
CREATE INDEX INDX_warehouse_w_state ON warehouse (w_state);
CREATE INDEX INDX_warehouse_w_street_name ON warehouse (w_street_name);
CREATE INDEX INDX_warehouse_w_street_number ON warehouse (w_street_number);
CREATE INDEX INDX_warehouse_w_street_type ON warehouse (w_street_type);
CREATE INDEX INDX_warehouse_w_suite_number ON warehouse (w_suite_number);
CREATE INDEX INDX_warehouse_w_warehouse_id ON warehouse (w_warehouse_id);
CREATE INDEX INDX_warehouse_w_warehouse_name ON warehouse (w_warehouse_name);
CREATE INDEX INDX_warehouse_w_warehouse_sk ON warehouse (w_warehouse_sk);
CREATE INDEX INDX_warehouse_w_warehouse_sq_ft ON warehouse (w_warehouse_sq_ft);
CREATE INDEX INDX_warehouse_w_zip ON warehouse (w_zip);
CREATE INDEX INDX_web_page_wp_access_date_sk ON web_page (wp_access_date_sk);
CREATE INDEX INDX_web_page_wp_autogen_flag ON web_page (wp_autogen_flag);
CREATE INDEX INDX_web_page_wp_char_count ON web_page (wp_char_count);
CREATE INDEX INDX_web_page_wp_creation_date_sk ON web_page (wp_creation_date_sk);
CREATE INDEX INDX_web_page_wp_customer_sk ON web_page (wp_customer_sk);
CREATE INDEX INDX_web_page_wp_image_count ON web_page (wp_image_count);
CREATE INDEX INDX_web_page_wp_link_count ON web_page (wp_link_count);
CREATE INDEX INDX_web_page_wp_max_ad_count ON web_page (wp_max_ad_count);
CREATE INDEX INDX_web_page_wp_rec_end_date ON web_page (wp_rec_end_date);
CREATE INDEX INDX_web_page_wp_rec_start_date ON web_page (wp_rec_start_date);
CREATE INDEX INDX_web_page_wp_type ON web_page (wp_type);
CREATE INDEX INDX_web_page_wp_url ON web_page (wp_url);
CREATE INDEX INDX_web_page_wp_web_page_id ON web_page (wp_web_page_id);
CREATE INDEX INDX_web_page_wp_web_page_sk ON web_page (wp_web_page_sk);
CREATE INDEX INDX_web_returns_wr_account_credit ON web_returns (wr_account_credit);
CREATE INDEX INDX_web_returns_wr_fee ON web_returns (wr_fee);
CREATE INDEX INDX_web_returns_wr_item_sk ON web_returns (wr_item_sk);
CREATE INDEX INDX_web_returns_wr_net_loss ON web_returns (wr_net_loss);
CREATE INDEX INDX_web_returns_wr_order_number ON web_returns (wr_order_number);
CREATE INDEX INDX_web_returns_wr_reason_sk ON web_returns (wr_reason_sk);
CREATE INDEX INDX_web_returns_wr_refunded_addr_sk ON web_returns (wr_refunded_addr_sk);
CREATE INDEX INDX_web_returns_wr_refunded_cash ON web_returns (wr_refunded_cash);
CREATE INDEX INDX_web_returns_wr_refunded_cdemo_sk ON web_returns (wr_refunded_cdemo_sk);
CREATE INDEX INDX_web_returns_wr_refunded_customer_sk ON web_returns (wr_refunded_customer_sk);
CREATE INDEX INDX_web_returns_wr_refunded_hdemo_sk ON web_returns (wr_refunded_hdemo_sk);
CREATE INDEX INDX_web_returns_wr_return_amt ON web_returns (wr_return_amt);
CREATE INDEX INDX_web_returns_wr_return_amt_inc_tax ON web_returns (wr_return_amt_inc_tax);
CREATE INDEX INDX_web_returns_wr_return_quantity ON web_returns (wr_return_quantity);
CREATE INDEX INDX_web_returns_wr_return_ship_cost ON web_returns (wr_return_ship_cost);
CREATE INDEX INDX_web_returns_wr_return_tax ON web_returns (wr_return_tax);
CREATE INDEX INDX_web_returns_wr_returned_date_sk ON web_returns (wr_returned_date_sk);
CREATE INDEX INDX_web_returns_wr_returned_time_sk ON web_returns (wr_returned_time_sk);
CREATE INDEX INDX_web_returns_wr_returning_addr_sk ON web_returns (wr_returning_addr_sk);
CREATE INDEX INDX_web_returns_wr_returning_cdemo_sk ON web_returns (wr_returning_cdemo_sk);
CREATE INDEX INDX_web_returns_wr_returning_customer_sk ON web_returns (wr_returning_customer_sk);
CREATE INDEX INDX_web_returns_wr_returning_hdemo_sk ON web_returns (wr_returning_hdemo_sk);
CREATE INDEX INDX_web_returns_wr_reversed_charge ON web_returns (wr_reversed_charge);
CREATE INDEX INDX_web_returns_wr_web_page_sk ON web_returns (wr_web_page_sk);
CREATE INDEX INDX_web_sales_ws_bill_addr_sk ON web_sales (ws_bill_addr_sk);
CREATE INDEX INDX_web_sales_ws_bill_cdemo_sk ON web_sales (ws_bill_cdemo_sk);
CREATE INDEX INDX_web_sales_ws_bill_customer_sk ON web_sales (ws_bill_customer_sk);
CREATE INDEX INDX_web_sales_ws_bill_hdemo_sk ON web_sales (ws_bill_hdemo_sk);
CREATE INDEX INDX_web_sales_ws_coupon_amt ON web_sales (ws_coupon_amt);
CREATE INDEX INDX_web_sales_ws_ext_discount_amt ON web_sales (ws_ext_discount_amt);
CREATE INDEX INDX_web_sales_ws_ext_list_price ON web_sales (ws_ext_list_price);
CREATE INDEX INDX_web_sales_ws_ext_sales_price ON web_sales (ws_ext_sales_price);
CREATE INDEX INDX_web_sales_ws_ext_ship_cost ON web_sales (ws_ext_ship_cost);
CREATE INDEX INDX_web_sales_ws_ext_tax ON web_sales (ws_ext_tax);
CREATE INDEX INDX_web_sales_ws_ext_wholesale_cost ON web_sales (ws_ext_wholesale_cost);
CREATE INDEX INDX_web_sales_ws_item_sk ON web_sales (ws_item_sk);
CREATE INDEX INDX_web_sales_ws_list_price ON web_sales (ws_list_price);
CREATE INDEX INDX_web_sales_ws_net_paid ON web_sales (ws_net_paid);
CREATE INDEX INDX_web_sales_ws_net_paid_inc_ship ON web_sales (ws_net_paid_inc_ship);
CREATE INDEX INDX_web_sales_ws_net_paid_inc_ship_tax ON web_sales (ws_net_paid_inc_ship_tax);
CREATE INDEX INDX_web_sales_ws_net_paid_inc_tax ON web_sales (ws_net_paid_inc_tax);
CREATE INDEX INDX_web_sales_ws_net_profit ON web_sales (ws_net_profit);
CREATE INDEX INDX_web_sales_ws_order_number ON web_sales (ws_order_number);
CREATE INDEX INDX_web_sales_ws_promo_sk ON web_sales (ws_promo_sk);
CREATE INDEX INDX_web_sales_ws_quantity ON web_sales (ws_quantity);
CREATE INDEX INDX_web_sales_ws_sales_price ON web_sales (ws_sales_price);
CREATE INDEX INDX_web_sales_ws_ship_addr_sk ON web_sales (ws_ship_addr_sk);
CREATE INDEX INDX_web_sales_ws_ship_cdemo_sk ON web_sales (ws_ship_cdemo_sk);
CREATE INDEX INDX_web_sales_ws_ship_customer_sk ON web_sales (ws_ship_customer_sk);
CREATE INDEX INDX_web_sales_ws_ship_date_sk ON web_sales (ws_ship_date_sk);
CREATE INDEX INDX_web_sales_ws_ship_hdemo_sk ON web_sales (ws_ship_hdemo_sk);
CREATE INDEX INDX_web_sales_ws_ship_mode_sk ON web_sales (ws_ship_mode_sk);
CREATE INDEX INDX_web_sales_ws_sold_date_sk ON web_sales (ws_sold_date_sk);
CREATE INDEX INDX_web_sales_ws_sold_time_sk ON web_sales (ws_sold_time_sk);
CREATE INDEX INDX_web_sales_ws_warehouse_sk ON web_sales (ws_warehouse_sk);
CREATE INDEX INDX_web_sales_ws_web_page_sk ON web_sales (ws_web_page_sk);
CREATE INDEX INDX_web_sales_ws_web_site_sk ON web_sales (ws_web_site_sk);
CREATE INDEX INDX_web_sales_ws_wholesale_cost ON web_sales (ws_wholesale_cost);
CREATE INDEX INDX_web_site_web_city ON web_site (web_city);
CREATE INDEX INDX_web_site_web_class ON web_site (web_class);
CREATE INDEX INDX_web_site_web_close_date_sk ON web_site (web_close_date_sk);
CREATE INDEX INDX_web_site_web_company_id ON web_site (web_company_id);
CREATE INDEX INDX_web_site_web_company_name ON web_site (web_company_name);
CREATE INDEX INDX_web_site_web_country ON web_site (web_country);
CREATE INDEX INDX_web_site_web_county ON web_site (web_county);
CREATE INDEX INDX_web_site_web_gmt_offset ON web_site (web_gmt_offset);
CREATE INDEX INDX_web_site_web_manager ON web_site (web_manager);
CREATE INDEX INDX_web_site_web_market_manager ON web_site (web_market_manager);
CREATE INDEX INDX_web_site_web_mkt_class ON web_site (web_mkt_class);
CREATE INDEX INDX_web_site_web_mkt_desc ON web_site (web_mkt_desc);
CREATE INDEX INDX_web_site_web_mkt_id ON web_site (web_mkt_id);
CREATE INDEX INDX_web_site_web_name ON web_site (web_name);
CREATE INDEX INDX_web_site_web_open_date_sk ON web_site (web_open_date_sk);
CREATE INDEX INDX_web_site_web_rec_end_date ON web_site (web_rec_end_date);
CREATE INDEX INDX_web_site_web_rec_start_date ON web_site (web_rec_start_date);
CREATE INDEX INDX_web_site_web_site_id ON web_site (web_site_id);
CREATE INDEX INDX_web_site_web_site_sk ON web_site (web_site_sk);
CREATE INDEX INDX_web_site_web_state ON web_site (web_state);
CREATE INDEX INDX_web_site_web_street_name ON web_site (web_street_name);
CREATE INDEX INDX_web_site_web_street_number ON web_site (web_street_number);
CREATE INDEX INDX_web_site_web_street_type ON web_site (web_street_type);
CREATE INDEX INDX_web_site_web_suite_number ON web_site (web_suite_number);
CREATE INDEX INDX_web_site_web_tax_percentage ON web_site (web_tax_percentage);
CREATE INDEX INDX_web_site_web_zip ON web_site (web_zip);