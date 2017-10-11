DROP TABLE IF EXISTS bounties;

CREATE TABLE  bounties (
  --Primary Key makes table? unique and allows foreign key to connect
  --Usually on ID numbers.
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  species VARCHAR(255),
  bounty_value INT4,
  last_known_location VARCHAR(255)
);
