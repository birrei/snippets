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



