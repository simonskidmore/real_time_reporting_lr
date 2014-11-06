-- Table: rt_stats

-- DROP TABLE rt_stats;

CREATE TABLE rt_stats
(
  office character varying,
  team character varying,
  appn_type character varying,
  hour integer,
  appn_count integer
)
WITH (
  OIDS=FALSE
);
ALTER TABLE rt_stats
  OWNER TO postgres;
