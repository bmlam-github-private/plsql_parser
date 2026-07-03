create or replace package  apex_string as

    function split (
        p_str in clob,
        p_sep in varchar2 default ','
    ) return apex_t_varchar2
    ;
end;
/
