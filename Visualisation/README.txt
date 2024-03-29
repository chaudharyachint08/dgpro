'Home Page for visualization site'
http://tatiyants.com/postgres-query-plan-visualization/

'To check if JSON object is valid'
https://jsonlint.com/

'Where Visualisation Works'
http://tatiyants.com/pev/#/plans/new



'Query'
EXPLAIN (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT JSON) select
	l_returnflag,
	l_linestatus,
	sum(l_quantity) as sum_qty,
	sum(l_extendedprice) as sum_base_price,
	sum(l_extendedprice * (1 - l_discount)) as sum_disc_price,
	sum(l_extendedprice * (1 - l_discount) * (1 + l_tax)) as sum_charge,
	avg(l_quantity) as avg_qty,
	avg(l_extendedprice) as avg_price,
	avg(l_discount) as avg_disc,
	count(*) as count_order
    from
    	lineitem
    where
    	l_shipdate between date '1992-01-02' and date '1996-01-08' --SEL_1
    	--l_shipdate <= date '1998-12-01' - interval '82' day
    group by
    	l_returnflag,
    	l_linestatus
    order by
    	l_returnflag,
    	l_linestatus

		
'Plan to Visualize'
[
    {
      "Plan": {
        "Node Type": "Aggregate",
        "Strategy": "Sorted",
        "Partial Mode": "Finalize",
        "Parallel Aware": false,
        "Startup Cost": 209508.93,
        "Total Cost": 209511.0,
        "Plan Rows": 6,
        "Plan Width": 236,
        "Actual Startup Time": 2283.894,
        "Actual Total Time": 2283.928,
        "Actual Rows": 4,
        "Actual Loops": 1,
        "Output": [
          "l_returnflag",
          "l_linestatus",
          "sum(l_quantity)",
          "sum(l_extendedprice)",
          "sum((l_extendedprice * ('1'::numeric - l_discount)))",
          "sum(((l_extendedprice * ('1'::numeric - l_discount)) * ('1'::numeric + l_tax)))",
          "avg(l_quantity)",
          "avg(l_extendedprice)",
          "avg(l_discount)",
          "count(*)"
        ],
        "Group Key": [
          "lineitem.l_returnflag",
          "lineitem.l_linestatus"
        ],
        "Shared Hit Blocks": 912,
        "Shared Read Blocks": 37058,
        "Shared Dirtied Blocks": 0,
        "Shared Written Blocks": 0,
        "Local Hit Blocks": 0,
        "Local Read Blocks": 0,
        "Local Dirtied Blocks": 0,
        "Local Written Blocks": 0,
        "Temp Read Blocks": 0,
        "Temp Written Blocks": 0,
        "Plans": [
          {
            "Node Type": "Gather Merge",
            "Parent Relationship": "Outer",
            "Parallel Aware": false,
            "Startup Cost": 209508.93,
            "Total Cost": 209510.33,
            "Plan Rows": 12,
            "Plan Width": 236,
            "Actual Startup Time": 2283.865,
            "Actual Total Time": 2300.292,
            "Actual Rows": 12,
            "Actual Loops": 1,
            "Output": [
              "l_returnflag",
              "l_linestatus",
              "(PARTIAL sum(l_quantity))",
              "(PARTIAL sum(l_extendedprice))",
              "(PARTIAL sum((l_extendedprice * ('1'::numeric - l_discount))))",
              "(PARTIAL sum(((l_extendedprice * ('1'::numeric - l_discount)) * ('1'::numeric + l_tax))))",
              "(PARTIAL avg(l_quantity))",
              "(PARTIAL avg(l_extendedprice))",
              "(PARTIAL avg(l_discount))",
              "(PARTIAL count(*))"
            ],
            "Workers Planned": 2,
            "Workers Launched": 2,
            "Shared Hit Blocks": 2805,
            "Shared Read Blocks": 109718,
            "Shared Dirtied Blocks": 0,
            "Shared Written Blocks": 0,
            "Local Hit Blocks": 0,
            "Local Read Blocks": 0,
            "Local Dirtied Blocks": 0,
            "Local Written Blocks": 0,
            "Temp Read Blocks": 0,
            "Temp Written Blocks": 0,
            "Plans": [
              {
                "Node Type": "Sort",
                "Parent Relationship": "Outer",
                "Parallel Aware": false,
                "Startup Cost": 208508.91,
                "Total Cost": 208508.92,
                "Plan Rows": 6,
                "Plan Width": 236,
                "Actual Startup Time": 2238.441,
                "Actual Total Time": 2238.442,
                "Actual Rows": 4,
                "Actual Loops": 3,
                "Output": [
                  "l_returnflag",
                  "l_linestatus",
                  "(PARTIAL sum(l_quantity))",
                  "(PARTIAL sum(l_extendedprice))",
                  "(PARTIAL sum((l_extendedprice * ('1'::numeric - l_discount))))",
                  "(PARTIAL sum(((l_extendedprice * ('1'::numeric - l_discount)) * ('1'::numeric + l_tax))))",
                  "(PARTIAL avg(l_quantity))",
                  "(PARTIAL avg(l_extendedprice))",
                  "(PARTIAL avg(l_discount))",
                  "(PARTIAL count(*))"
                ],
                "Sort Key": [
                  "lineitem.l_returnflag",
                  "lineitem.l_linestatus"
                ],
                "Sort Method": "quicksort",
                "Sort Space Used": 27,
                "Sort Space Type": "Memory",
                "Workers": [
                  {
                    "Worker Number": 0,
                    "Actual Startup Time": 2220.7,
                    "Actual Total Time": 2220.7,
                    "Actual Rows": 4,
                    "Actual Loops": 1,
                    "Shared Hit Blocks": 910,
                    "Shared Read Blocks": 35668,
                    "Shared Dirtied Blocks": 0,
                    "Shared Written Blocks": 0,
                    "Local Hit Blocks": 0,
                    "Local Read Blocks": 0,
                    "Local Dirtied Blocks": 0,
                    "Local Written Blocks": 0,
                    "Temp Read Blocks": 0,
                    "Temp Written Blocks": 0
                  },
                  {
                    "Worker Number": 1,
                    "Actual Startup Time": 2212.423,
                    "Actual Total Time": 2212.423,
                    "Actual Rows": 4,
                    "Actual Loops": 1,
                    "Shared Hit Blocks": 983,
                    "Shared Read Blocks": 36992,
                    "Shared Dirtied Blocks": 0,
                    "Shared Written Blocks": 0,
                    "Local Hit Blocks": 0,
                    "Local Read Blocks": 0,
                    "Local Dirtied Blocks": 0,
                    "Local Written Blocks": 0,
                    "Temp Read Blocks": 0,
                    "Temp Written Blocks": 0
                  }
                ],
                "Shared Hit Blocks": 2805,
                "Shared Read Blocks": 109718,
                "Shared Dirtied Blocks": 0,
                "Shared Written Blocks": 0,
                "Local Hit Blocks": 0,
                "Local Read Blocks": 0,
                "Local Dirtied Blocks": 0,
                "Local Written Blocks": 0,
                "Temp Read Blocks": 0,
                "Temp Written Blocks": 0,
                "Plans": [
                  {
                    "Node Type": "Aggregate",
                    "Strategy": "Hashed",
                    "Partial Mode": "Partial",
                    "Parent Relationship": "Outer",
                    "Parallel Aware": false,
                    "Startup Cost": 208508.66,
                    "Total Cost": 208508.83,
                    "Plan Rows": 6,
                    "Plan Width": 236,
                    "Actual Startup Time": 2238.383,
                    "Actual Total Time": 2238.396,
                    "Actual Rows": 4,
                    "Actual Loops": 3,
                    "Output": [
                      "l_returnflag",
                      "l_linestatus",
                      "PARTIAL sum(l_quantity)",
                      "PARTIAL sum(l_extendedprice)",
                      "PARTIAL sum((l_extendedprice * ('1'::numeric - l_discount)))",
                      "PARTIAL sum(((l_extendedprice * ('1'::numeric - l_discount)) * ('1'::numeric + l_tax)))",
                      "PARTIAL avg(l_quantity)",
                      "PARTIAL avg(l_extendedprice)",
                      "PARTIAL avg(l_discount)",
                      "PARTIAL count(*)"
                    ],
                    "Group Key": [
                      "lineitem.l_returnflag",
                      "lineitem.l_linestatus"
                    ],
                    "Shared Hit Blocks": 2785,
                    "Shared Read Blocks": 109718,
                    "Shared Dirtied Blocks": 0,
                    "Shared Written Blocks": 0,
                    "Local Hit Blocks": 0,
                    "Local Read Blocks": 0,
                    "Local Dirtied Blocks": 0,
                    "Local Written Blocks": 0,
                    "Temp Read Blocks": 0,
                    "Temp Written Blocks": 0,
                    "Workers": [
                      {
                        "Worker Number": 0,
                        "Actual Startup Time": 2220.628,
                        "Actual Total Time": 2220.643,
                        "Actual Rows": 4,
                        "Actual Loops": 1,
                        "Shared Hit Blocks": 900,
                        "Shared Read Blocks": 35668,
                        "Shared Dirtied Blocks": 0,
                        "Shared Written Blocks": 0,
                        "Local Hit Blocks": 0,
                        "Local Read Blocks": 0,
                        "Local Dirtied Blocks": 0,
                        "Local Written Blocks": 0,
                        "Temp Read Blocks": 0,
                        "Temp Written Blocks": 0
                      },
                      {
                        "Worker Number": 1,
                        "Actual Startup Time": 2212.362,
                        "Actual Total Time": 2212.374,
                        "Actual Rows": 4,
                        "Actual Loops": 1,
                        "Shared Hit Blocks": 973,
                        "Shared Read Blocks": 36992,
                        "Shared Dirtied Blocks": 0,
                        "Shared Written Blocks": 0,
                        "Local Hit Blocks": 0,
                        "Local Read Blocks": 0,
                        "Local Dirtied Blocks": 0,
                        "Local Written Blocks": 0,
                        "Temp Read Blocks": 0,
                        "Temp Written Blocks": 0
                      }
                    ],
                    "Plans": [
                      {
                        "Node Type": "Seq Scan",
                        "Parent Relationship": "Outer",
                        "Parallel Aware": true,
                        "Relation Name": "lineitem",
                        "Schema": "public",
                        "Alias": "lineitem",
                        "Startup Cost": 0.0,
                        "Total Cost": 150012.46,
                        "Plan Rows": 1462405,
                        "Plan Width": 25,
                        "Actual Startup Time": 0.225,
                        "Actual Total Time": 721.688,
                        "Actual Rows": 1169732,
                        "Actual Loops": 3,
                        "Output": [
                          "l_orderkey",
                          "l_partkey",
                          "l_suppkey",
                          "l_linenumber",
                          "l_quantity",
                          "l_extendedprice",
                          "l_discount",
                          "l_tax",
                          "l_returnflag",
                          "l_linestatus",
                          "l_shipdate",
                          "l_commitdate",
                          "l_receiptdate",
                          "l_shipinstruct",
                          "l_shipmode",
                          "l_comment"
                        ],
                        "Filter": "((lineitem.l_shipdate >= '1992-01-02'::date) AND (lineitem.l_shipdate <= '1996-01-08'::date))",
                        "Rows Removed by Filter": 830673,
                        "Shared Hit Blocks": 2785,
                        "Shared Read Blocks": 109718,
                        "Shared Dirtied Blocks": 0,
                        "Shared Written Blocks": 0,
                        "Local Hit Blocks": 0,
                        "Local Read Blocks": 0,
                        "Local Dirtied Blocks": 0,
                        "Local Written Blocks": 0,
                        "Temp Read Blocks": 0,
                        "Temp Written Blocks": 0,
                        "Workers": [
                          {
                            "Worker Number": 0,
                            "Actual Startup Time": 0.178,
                            "Actual Total Time": 715.802,
                            "Actual Rows": 1141965,
                            "Actual Loops": 1,
                            "Shared Hit Blocks": 900,
                            "Shared Read Blocks": 35668,
                            "Shared Dirtied Blocks": 0,
                            "Shared Written Blocks": 0,
                            "Local Hit Blocks": 0,
                            "Local Read Blocks": 0,
                            "Local Dirtied Blocks": 0,
                            "Local Written Blocks": 0,
                            "Temp Read Blocks": 0,
                            "Temp Written Blocks": 0
                          },
                          {
                            "Worker Number": 1,
                            "Actual Startup Time": 0.174,
                            "Actual Total Time": 717.907,
                            "Actual Rows": 1182897,
                            "Actual Loops": 1,
                            "Shared Hit Blocks": 973,
                            "Shared Read Blocks": 36992,
                            "Shared Dirtied Blocks": 0,
                            "Shared Written Blocks": 0,
                            "Local Hit Blocks": 0,
                            "Local Read Blocks": 0,
                            "Local Dirtied Blocks": 0,
                            "Local Written Blocks": 0,
                            "Temp Read Blocks": 0,
                            "Temp Written Blocks": 0
                          }
                        ]
                      }
                    ]
                  }
                ]
              }
            ]
          }
        ]
      },
      "Planning Time": 1.399,
      "Triggers": [],
      "Execution Time": 2300.512
    }
  ]
