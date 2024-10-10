### Select-Box: ausgewählten Text ausgeben  

```
<select id="Ansicht" name="Ansicht">
          <option value="Sammlung">Sammlung</option>      
          <option value="Musikstueck">Musikstück</option>
          <option value="Satz" selected>Satz</option>        
</select>

<script>
  var liste = document.getElementById("Ansicht");
  var text= liste.options[liste.selectedIndex].text;
  document.write(text); // im Besipiel Ausgabe "Satz" 
</script> 
```
