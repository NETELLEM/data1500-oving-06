
-- Hobbyhuset database script for PostgreSQL (Extended Version)
-- Adds new columns and NULL values to illustrate specific SQL concepts.

-- Først, kjør det originale hobbyhuset.sql skriptet for å opprette og fylle databasen.
-- Deretter, kjør dette skriptet for å utvide modellen.

-- Legg til en 'Bonus'-kolonne i Ansatt-tabellen
ALTER TABLE Ansatt ADD COLUMN Bonus DECIMAL(8,2);

-- Legg til en 'Telefon'-kolonne i Kunde-tabellen
ALTER TABLE Kunde ADD COLUMN Telefon VARCHAR(20);

-- Legg til en 'ErBetalt' BOOLEAN-kolonne i Ordre-tabellen for å illustrere tre-verdi logikk
ALTER TABLE Ordre ADD COLUMN ErBetalt BOOLEAN;

-- Oppdater noen rader for å inkludere NULL og non-NULL verdier
UPDATE Ansatt SET Bonus = 10000.00 WHERE AnsNr IN (1, 3, 7);
UPDATE Ansatt SET Bonus = 5000.00 WHERE AnsNr IN (2, 8);

UPDATE Kunde SET Telefon = '91234567' WHERE KNr IN (5009, 5082, 5122);
UPDATE Kunde SET Telefon = '41234567' WHERE KNr IN (5129, 5042);

-- Oppdater ErBetalt-kolonnen for å illustrere tre-verdi logikk
UPDATE Ordre SET ErBetalt = TRUE WHERE BetaltDato IS NOT NULL;
UPDATE Ordre SET ErBetalt = FALSE WHERE BetaltDato IS NULL AND SendtDato IS NOT NULL;
UPDATE Ordre SET ErBetalt = NULL WHERE OrdreNr % 10 = 0;