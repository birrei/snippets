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
### Dynamisches Inhaltsverzeichnis
Einfache Version für eine Überschriften-Ebene ... 

Quelle: https://www.gutefrage.net/frage/dynamisches-inhaltsverzeichnis-htmljavascript

Container für Inhaltsverzeichnis:
```
<ol id="table-of-contents"></ol>
```
Überschriften einsammeln, Inhaltsverzeichnis befüllen 
```
const tableOfContents = document.getElementById("table-of-contents");
const chapterTitles = document.getElementsByClassName("chapter-title");

for (const chapterTitle of chapterTitles) {
  const listEntry = document.createElement("li");
  const anchor = document.createElement("a");
  anchor.innerHTML = chapterTitle.innerHTML;
  anchor.href = "#" + chapterTitle.id;
  listEntry.appendChild(anchor);
  tableOfContents.appendChild(listEntry);
}
```

Das dazugehörige script-Element wird kurz vor dem schließenden body-Element hinzugefügt.
