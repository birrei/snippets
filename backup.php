<?php
//Tragen Sie hier Ihre Datenbankinformationen ein und den Namen der Backup-Datei
$mysqlDatabaseName ='Datenbankname';
$mysqlUserName ='Benutzername';
$mysqlPassword ='Passwort';
$mysqlHostName ='dbxxx.hosting-data.io';
$mysqlExportPath ='Ihr-gewünschter-Dateiname.sql';

//Bei den folgenden Punkten bitte keine Änderung durchführen
//Export der Datenbank und Ausgabe des Status
$command='mysqldump --opt -h' .$mysqlHostName .' -u' .$mysqlUserName .' -p' .$mysqlPassword .' ' .$mysqlDatabaseName .' > ' .$mysqlExportPath;
exec($command,$output,$worked);
switch($worked){
  case 0:
      echo 'Die Datenbank <b>' .$mysqlDatabaseName .'</b> wurde erfolgreich im folgenden Pfad abgelegt '.getcwd().'/' .$mysqlExportPath .'</b>';
  break;
  case 1:
      echo 'Es ist ein Fehler aufgetreten beim Exportieren von <b>' .$mysqlDatabaseName .'</b> zu '.getcwd().'/' .$mysqlExportPath .'</b>';
  break;
  case 2:
      echo 'Es ist ein Fehler beim Exportieren aufgetreten, bitte prüfen Sie die folgenden Angaben: <br/><br/><table><tr><td>MySQL Database Name:</td><td><b>' .$mysqlDatabaseName .'</b></td></tr><tr><td>MySQL User Name:</td><td><b>' .$mysqlUserName .'</b></td></tr><tr><td>MySQL Password:</td><td><b>NOTSHOWN</b></td></tr><tr><td>MySQL Host Name:</td><td><b>' .$mysqlHostName .'</b></td></tr></table>';
  break;
}

// Quelle: https://www.ionos.de/hilfe/hosting/sichern-und-wiederherstellen-von-mysqlmariadb-datenbanken-mit-php/
?>
