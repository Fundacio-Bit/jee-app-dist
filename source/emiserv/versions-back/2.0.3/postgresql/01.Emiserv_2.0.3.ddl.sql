-- #36
CREATE TABLE ems_config_group (code character varying(128) NOT NULL, parent_code character varying(128), position SMALLINT NOT NULL, description_key character varying(512) NOT NULL);
ALTER TABLE ems_config_group ADD PRIMARY KEY (code);

CREATE TABLE ems_config_type (code character varying(128) NOT NULL, value character varying(2048));
ALTER TABLE ems_config_type ADD PRIMARY KEY (code);

CREATE TABLE ems_config (key character varying(256) NOT NULL, value character varying(2048), description_key character varying(2048), group_code character varying(128) NOT NULL, position SMALLINT NOT NULL, source_property character varying(16) NOT NULL, requereix_reinici BOOLEAN DEFAULT FALSE, type_code character varying(128), lastmodifiedby character varying(64), lastmodifieddate TIMESTAMP WITHOUT TIME ZONE);
ALTER TABLE ems_config ADD PRIMARY KEY (key);
ALTER TABLE ems_config ADD CONSTRAINT ems_config_group_fk FOREIGN KEY (group_code) REFERENCES ems_config_group (code);
