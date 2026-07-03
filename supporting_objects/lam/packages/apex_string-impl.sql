create or replace package body apex_string as

    function split (
        p_str in clob,
        p_sep in varchar2 default ','
    ) return apex_t_varchar2
    is
        l_result      apex_t_varchar2 := apex_t_varchar2();
        l_pos         pls_integer := 1;
        l_next_pos    pls_integer;
        l_sep_len     pls_integer := length(p_sep);
        l_clob_len    pls_integer;
    begin
        if p_str is null then
            return l_result;
        end if;

        if p_sep is null then
            l_result.extend;
            l_result(1) := dbms_lob.substr(p_str, 4000, 1);
            return l_result;
        end if;

        l_clob_len := dbms_lob.getlength(p_str);

        loop
            l_next_pos := dbms_lob.instr(
                              lob_loc => p_str,
                              pattern => p_sep,
                              offset  => l_pos,
                              nth     => 1);

            l_result.extend;

            if l_next_pos = 0 then
                l_result(l_result.count) :=
                    dbms_lob.substr(
                        p_str,
                        least(4000, l_clob_len - l_pos + 1),
                        l_pos);
                exit;
            else
                l_result(l_result.count) :=
                    dbms_lob.substr(
                        p_str,
                        least(4000, l_next_pos - l_pos),
                        l_pos);

                l_pos := l_next_pos + l_sep_len;
            end if;
        end loop;

        return l_result;

    end split;

end apex_string;
/
