/******* 1. Info ***********/

    --- mysql Version anzeigen  
    select version();

    -- alle Tabellen anzeigen 
    show tables;

    --- alle views anzeigen 
    SELECT *
    FROM information_schema.TABLES 
    WHERE TABLE_TYPE LIKE 'VIEW'; 

    --- sql für views löschen  
    SELECT CONCAT('DROP VIEW IF EXISTS ', TABLE_NAME, ';') as cmd  
    FROM information_schema.TABLES 
    WHERE TABLE_TYPE LIKE 'VIEW'; 


    /* Objekt Infos */ 

    DESCRIBE verlag  /* Spalten einer Tabelle / View  */
    
    SHOW COLUMNS FROM verlag; /* Spalten einer Tabelle / View  */
   
    SHOW CREATE TABLE verlag  /*Tabellendef anzeigen */

    SHOW CREATE view v_sammlung  /* View Def anzeigen */

    /* Spalten-Info, z.B. Fremdschlüssel  */
    select * 
    from INFORMATION_SCHEMA.KEY_COLUMN_USAGE
    where 1=1
    and table_name='musikstueck'



/******* 2. DDL ***********/

    -- unique key erstellen
    ALTER TABLE satz_schwierigkeitsgrad
    ADD CONSTRAINT uc_satz_schwierigkeitsgrad 
    UNIQUE (SatzID, SchwierigkeitsgradID, InstrumentID)
    ;


    -- foreign key erstellen  
    ALTER TABLE satz_schwierigkeitsgrad 
    ADD  FOREIGN KEY (SatzID) 
    REFERENCES satz(ID) 
    ON DELETE RESTRICT ON UPDATE RESTRICT
    ;


    /***** constraint löschen -- MariaDB:  ******/
    ALTER TABLE satz DROP CONSTRAINT satz_ibfk_4; -- indizies, foreign-keys 

    /***** constraint löschen -- MySQL 5.7. ******/
    -- s.a. https://stackoverflow.com/questions/14122031/how-to-remove-constraints-from-my-mysql-table

    ALTER TABLE `table_name` DROP FOREIGN KEY `id_name_fk`;
    ALTER TABLE `table_name` DROP INDEX  `id_name_fk`;


    /***** spalte ergänzen ******/
    
    ALTER TABLE `lookup_type` ADD `Bemerkung` VARCHAR(100) NULL ; 

    ALTER TABLE `erprobt` ADD `Jahr` YEAR; -- https://mariadb.com/kb/en/year-data-type/   

    ALTER TABLE sammlung ADD ts_insert datetime DEFAULT CURRENT_TIMESTAMP; 
   
    ALTER TABLE sammlung ADD ts_update datetime ON UPDATE CURRENT_TIMESTAMP; 
   

    /***** spalte datentyp ändern ******/
    ALTER TABLE schwierigkeitsgrad CHANGE `ID` `ID` INT NOT NULL ; 

    /** Spalte vergrößern *****/
    ALTER TABLE `satz` CHANGE `Orchesterbesetzung` `Orchesterbesetzung` varchar(250); 

    /***** spalte löschen ******/
    ALTER TABLE my_table DROP IF EXISTS my_column;

   
    /** nachträglich AUTO_INCREMENT hinzufügen (+ löschen und wiederanlegen fk) *****/

    ALTER TABLE satz_erprobt DROP FOREIGN KEY `satz_erprobt_ibfk_2`;

    ALTER TABLE  erprobt CHANGE `ID` `ID` INT NOT NULL AUTO_INCREMENT; 
 
    ALTER TABLE satz_erprobt 
    ADD  FOREIGN KEY (ErprobtID) 
    REFERENCES erprobt(ID) 
    ON DELETE RESTRICT ON UPDATE RESTRICT
    ;

/** Spalte mit unique key und FK soll nachträglich von NOT NULL auf NULL geändert werden   *****/

    -- 1) gegeben : 
        /*
        CREATE TABLE `schueler_schwierigkeitsgrad` (
        `ID` int(11) NOT NULL AUTO_INCREMENT,
        `SchuelerID` int(11) NOT NULL,
        `SchwierigkeitsgradID` int(10) unsigned NOT NULL,
        `InstrumentID` int(11) NOT NULL,
        PRIMARY KEY (`ID`),
        UNIQUE KEY `uc_schueler_schwierigkeitsgrad` (`SchuelerID`,`SchwierigkeitsgradID`,`InstrumentID`),
        KEY `SchwierigkeitsgradID` (`SchwierigkeitsgradID`),
        KEY `InstrumentID` (`InstrumentID`),
        CONSTRAINT `schueler_schwierigkeitsgrad_fkey_InstrumentID` FOREIGN KEY (`InstrumentID`) REFERENCES `instrument` (`ID`),
        CONSTRAINT `schueler_schwierigkeitsgrad_fkey_SchuelerID` FOREIGN KEY (`SchuelerID`) REFERENCES `schueler` (`ID`),
        CONSTRAINT `schueler_schwierigkeitsgrad_fkey_SchwierigkeitsgradID` FOREIGN KEY (`SchwierigkeitsgradID`) REFERENCES `schwierigkeitsgrad` (`ID`)
        ) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci</td>
        */



    /* 2) Ziel: Spalte SchwierigkeitsgradID soll NULL erlauben */


            -- fk containt löschen 
        ALTER TABLE schueler_schwierigkeitsgrad 
        DROP CONSTRAINT schueler_schwierigkeitsgrad_fkey_SchwierigkeitsgradID; 
           -- MySQL 5.7: DROP FOReIGN KEY schueler_schwierigkeitsgrad_fkey_SchwierigkeitsgradID;

        ALTER TABLE  schueler_schwierigkeitsgrad  CHANGE `SchwierigkeitsgradID` `SchwierigkeitsgradID` INT unsigned NULL;
        -- OK (es ist also scheinbar nicht notwendig, noch den KEY / UNIQUE KEY anzupassen )

        ALTER TABLE schueler_schwierigkeitsgrad 
        ADD CONSTRAINT `schueler_schwierigkeitsgrad_fkey_SchwierigkeitsgradID` 
        FOREIGN KEY (`SchwierigkeitsgradID`) REFERENCES `schwierigkeitsgrad` (`ID`)


