-- #17
alter  sequence if exists hibernate_sequence rename TO ems_hibernate_sequence;
ALTER TABLE ems_usuari DROP COLUMN if exists nom;
ALTER TABLE ems_usuari DROP COLUMN if exists nif;
ALTER TABLE ems_usuari DROP COLUMN if exists email;
ALTER TABLE ems_usuari DROP COLUMN if exists inicialitzat;

