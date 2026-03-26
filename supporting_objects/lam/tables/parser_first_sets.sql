CREATE TABLE parser_first_sets (
    symbol   VARCHAR2(100),
    token    VARCHAR2(100)
);

alter table parser_first_sets add unique ( symbol, token)
/
