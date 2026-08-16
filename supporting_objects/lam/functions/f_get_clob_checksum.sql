CREATE OR REPLACE FUNCTION f_get_clob_checksum (
    p_clob IN CLOB,
    p_algo IN INTEGER DEFAULT DBMS_CRYPTO.HASH_SH256 -- Default to SHA-256
) RETURN VARCHAR2 IS
    v_blob          BLOB;
    v_dest_offset   INTEGER := 1;
    v_src_offset    INTEGER := 1;
    v_lang_context  INTEGER := DBMS_LOB.DEFAULT_LANG_CTX;
    v_warning       INTEGER;
    v_hash          RAW(32);
BEGIN
    IF p_clob IS NULL OR DBMS_LOB.GETLENGTH(p_clob) = 0 THEN
        RETURN NULL;
    END IF;

    -- Create a temporary BLOB
    DBMS_LOB.CREATETEMPORARY(v_blob, TRUE);

    -- Convert CLOB to BLOB using database character set
    DBMS_LOB.CONVERTTOBLOB(
        dest_lob     => v_blob,
        src_clob     => p_clob,
        amount       => DBMS_LOB.LOBMAXSIZE,
        dest_offset  => v_dest_offset,
        src_offset   => v_src_offset,
        blob_csid    => DBMS_LOB.DEFAULT_CSID,
        lang_context => v_lang_context,
        warning      => v_warning
    );

    -- Compute the hash
    v_hash := DBMS_CRYPTO.HASH(v_blob, p_algo);

    -- Free temporary BLOB
    DBMS_LOB.FREETEMPORARY(v_blob);

    -- Return lower or uppercase hexadecimal string
    RETURN LOWER(RAWTOHEX(v_hash));
END;
/
