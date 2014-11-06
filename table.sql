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



  alter user postgres with password 'admin'
