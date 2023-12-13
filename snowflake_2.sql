---alternative syntax, same performance
select coalesce(A.dim_1, B.dim_1)  as dimension_1
    ,coalesce(A.dim_2, B.dim_2)    as dimension_2
    ,coalesce(meas_1, 0)           as measure_1
    ,coalesce(meas_2, 0)           as measure_2
    
from (select distinct A.dimension_1   as dim_1
        ,C.correct_dimension_2      as dim_2
        ,sum(A.measure_1)           as meas_1
    from A A
    left join (select distinct dimension_1,correct_dimension_2 
                from  MAP) C
        on A.dimension_1 = C.dimension_1
    group by 1, 2
) A

full join (select distinct B.dimension_1   as dim_1
                ,C.correct_dimension_2      as dim_2
                ,sum(B.measure_2)           as meas_2
            from B B
            left join (select distinct dimension_1,correct_dimension_2 
                        from  MAP) C
                on B.dimension_1 = C.dimension_1
            group by 1, 2
) B

on A.dim_1 = B.dim_1
and A.dim_2 = B.dim_2;