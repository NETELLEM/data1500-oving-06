# Besvarelse: Avansert SQL

## Oppgave 1: Window Functions

### Del 1: Forklar SQL-spørringene

1.  **Spørring:**
    ```sql
    SELECT
        Fornavn,
        Etternavn,
        Årslønn,
        RANK() OVER (ORDER BY Årslønn DESC) AS Lønnsrangering
    FROM Ansatt;
    ```
    **Forklaring:** 
    *  Spørringen henter Fornavn, Etternavn og Årslønn fra Ansatt-tabellen, og legger til en ny kolonne som rangerer ansatte etter lønn — høyest lønn får rang 1 som Lønnsrangering

2.  **Spørring:**
    ```sql
    SELECT
        V.Betegnelse,
        K.Navn AS Kategori,
        V.Pris,
        AVG(V.Pris) OVER (PARTITION BY K.Navn) AS GjennomsnittsprisForKategori
    FROM Vare V
    JOIN Kategori K ON V.KatNr = K.KatNr;
    ```
    **Forklaring:**
    *   Spørringen henter Betegnelse, Kategori-navn og Pris ved å joine Vare og Kategori. For hver vare beregnes også gjennomsnittsprisen for alle varer i samme kategori ved hjelp av AVG() OVER (PARTITION BY K.Navn) — uten å redusere antall rader.

### Del 2: Lag SQL-spørringer

1.  **Rangering av varer per kategori:**
    ```sql
    SELECT
    V.Betegnelse,
    K.Navn AS Kategori,
    V.Pris,
    RANK() OVER (
        PARTITION BY K.Navn      
        ORDER BY V.Pris DESC     
    ) AS RangIPKategori
    FROM Vare V
    JOIN Kategori K ON V.KatNr = K.KatNr;
    ```

2.  **Løpende sum av ordrebeløp:**
    ```sql
    SELECT
    OrdreNr,
    Ordredato,
    Beløp,
    SUM(Beløp) OVER (
        ORDER BY OrdreNr         -- Løp gjennom i rekkefølge
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS LøpendeTotalSum
    FROM Ordre;
    ```

3.  **Prosentandel av kategoriprisen:**
    ```sql
    SELECT
    V.Betegnelse,
    K.Navn AS Kategori,
    V.Pris,
    ROUND(
        V.Pris * 100.0 / SUM(V.Pris) OVER (PARTITION BY K.Navn),
        2
    ) AS ProsentAvKategori
    FROM Vare V
    JOIN Kategori K ON V.KatNr = K.KatNr;
    ```

---

## Oppgave 2: Common Table Expressions (CTEs)

### Del 1: Forklar SQL-spørringen

1.  **Spørring:**
    ```sql
    WITH KunderPerPoststed AS (
        SELECT PostNr, COUNT(*) AS AntallKunder
        FROM Kunde
        GROUP BY PostNr
    )
    SELECT P.Poststed, KPP.AntallKunder
    FROM Poststed P
    JOIN KunderPerPoststed KPP ON P.PostNr = KPP.PostNr
    WHERE KPP.AntallKunder > 5
    ORDER BY KPP.AntallKunder DESC;
    ```
    **Forklaring:**
    *   Først teller vi opp hvor mange kunder som bor på hvert postnummer. Deretter henter vi poststednavnet, filtrerer bort steder med 5 eller færre kunder, og sorterer slik at stedene med flest kunder kommer øverst.

### Del 2: Lag SQL-spørringer

1.  **Ansatte med over gjennomsnittslønn:**
    ```sql
    WITH Gjennomsnittlønn AS (
    SELECT AVG(Årslønn) AS Gjennomsnittslønn
    FROM Ansatt
    )
    
    SELECT
        A.Fornavn,
        A.Etternavn,
        A.Årslønn,
        G.Gjennomsnittslønn,
        A.Årslønn - G.Gjennomsnittslønn AS KrOver
    FROM Ansatt A
    JOIN GjennomsnittlønnCTE G
        ON A.Årslønn > G.Gjennomsnittslønn
    ORDER BY A.Årslønn DESC;
    ```

2.  **Kategorier med flest varer:**
    ```sql
    WITH AntallVarerPerKategori AS (
    SELECT
        KatNr,
        COUNT(*) AS AntallVarer
    FROM Vare
    GROUP BY KatNr
    ),
    
    MaksCTE AS (
        SELECT MAX(AntallVarer) AS MaksAntall
        FROM AntallVarerPerKategori
    )
    
    SELECT
        K.Navn AS Kategori,
        AVK.AntallVarer
    FROM Kategori K
    JOIN AntallVarerPerKategori AVK ON K.KatNr = AVK.KatNr
    JOIN MaksCTE M ON AVK.AntallVarer = M.MaksAntall
    ORDER BY AVK.AntallVarer DESC;
    ```

3.  **Rekursiv CTE - Hierarki av ansatte:**
    ```sql
    -- Skriv din SQL-spørring her (inkluder gjerne ALTER TABLE og testdata)
    ```

---

## Oppgave 3: Avanserte Subqueries

### Del 1: Forklar SQL-spørringene

1.  **Spørring (Correlated Subquery):**
    ```sql
    SELECT V.Betegnelse, V.Pris
    FROM Vare V
    WHERE V.Pris > (
        SELECT AVG(Pris)
        FROM Vare
        WHERE KatNr = V.KatNr
    );
    ```
    **Forklaring:**
    *   *... Skriv din forklaring her ...*

2.  **Spørring (Subquery i `FROM`):**
    ```sql
    SELECT Kategori, Gjennomsnittspris
    FROM (
        SELECT K.Navn AS Kategori, AVG(V.Pris) AS Gjennomsnittspris
        FROM Vare V
        JOIN Kategori K ON V.KatNr = K.KatNr
        GROUP BY K.Navn
    ) AS KategoriPriser
    WHERE Gjennomsnittspris > 100;
    ```
    **Forklaring:**
    *   *... Skriv din forklaring her ...*

### Del 2: Lag SQL-spørringer

1.  **Kunder som har bestilt en spesifikk vare:**
    ```sql
    -- Skriv din SQL-spørring her
    ```

2.  **`EXISTS` - Kategorier med dyre varer:**
    ```sql
    -- Skriv din SQL-spørring her
    ```

3.  **Varer dyrere enn gjennomsnittet:**
    ```sql
    -- Skriv din SQL-spørring her
    ```
