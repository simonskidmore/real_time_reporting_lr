-- Table: rt_stats

-- DROP TABLE rt_stats;

CREATE TABLE rt_stats
(
  office character varying,
  team character varying,
  appn_type character varying,
  hour integer,
  appn_count integer,
  units real,
  modate date
)
WITH (
  OIDS=FALSE
);
ALTER TABLE rt_stats
  OWNER TO postgres;
  
  
-- Table: rt_stats

-- DROP TABLE rt_stats;
  
  CREATE TABLE resource
(
  office character varying,
  team character varying,
  resource real
)
WITH (
  OIDS=FALSE
);
ALTER TABLE resource
  OWNER TO postgres;

  alter user postgres with password 'admin'
